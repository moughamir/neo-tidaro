-- ============================================================================
-- TIDARO COMPREHENSIVE DATABASE SCHEMA
-- Version: 1.0
-- Description: This script contains the complete, optimized, and merged
--              database schema for the Tidaro platform.
-- ============================================================================

-- Drop existing schemas for a clean setup
DROP SCHEMA IF EXISTS iam CASCADE;
DROP SCHEMA IF EXISTS crm CASCADE;
DROP SCHEMA IF EXISTS ticketing CASCADE;
DROP SCHEMA IF EXISTS billing CASCADE;
DROP SCHEMA IF EXISTS events CASCADE;
DROP SCHEMA IF EXISTS chat CASCADE;
DROP SCHEMA IF EXISTS app_meta CASCADE;
DROP SCHEMA IF EXISTS notifications CASCADE;

-- Create Schemas for Separation of Concerns
CREATE SCHEMA iam;
CREATE SCHEMA crm;
CREATE SCHEMA ticketing;
CREATE SCHEMA billing;
CREATE SCHEMA events;
CREATE SCHEMA chat;
CREATE SCHEMA app_meta;
CREATE SCHEMA notifications;

-- ============================================================================
-- EXTENSIONS
-- ============================================================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

-- ============================================================================
-- IAM (Identity & Access Management)
-- Manages users, authentication, roles, and permissions.
-- ============================================================================

-- Users table references Supabase's auth.users
CREATE TABLE iam.profiles (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    role TEXT NOT NULL CHECK (role IN ('customer', 'provider', 'moderator', 'admin')) DEFAULT 'customer',
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    display_name VARCHAR(255),
    avatar_url TEXT,
    phone_number VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE iam.profiles IS 'Stores public profile information for users, linked to Supabase auth.';

CREATE TABLE iam.roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE iam.roles IS 'Defines user roles for role-based access control (RBAC).';

CREATE TABLE iam.permissions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE iam.permissions IS 'Defines granular permissions for actions within the system.';

-- Junction tables for RBAC
CREATE TABLE iam.role_permissions (
    role_id INTEGER REFERENCES iam.roles(id) ON DELETE CASCADE,
    permission_id INTEGER REFERENCES iam.permissions(id) ON DELETE CASCADE,
    PRIMARY KEY (role_id, permission_id)
);

CREATE TABLE iam.user_roles (
    user_id UUID REFERENCES iam.profiles(user_id) ON DELETE CASCADE,
    role_id INTEGER REFERENCES iam.roles(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

-- Trigger to create a profile when a new user signs up in Supabase auth
CREATE OR REPLACE FUNCTION public.create_profile_for_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
  INSERT INTO iam.profiles (user_id, first_name, last_name, display_name, avatar_url, phone_number)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'first_name',
    NEW.raw_user_meta_data->>'last_name',
    NEW.raw_user_meta_data->>'display_name',
    NEW.raw_user_meta_data->>'avatar_url',
    NEW.phone
  );
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.create_profile_for_user();
COMMENT ON TRIGGER on_auth_user_created ON auth.users IS 'Automatically creates a user profile upon new user registration.';


-- ============================================================================
-- CHAT
-- Manages real-time messaging, moderation, and chat history.
-- ============================================================================

CREATE TABLE chat.chats (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  booking_id UUID, -- Optional: Link to a booking
  created_by UUID NOT NULL REFERENCES auth.users (id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE chat.chats IS 'Represents a single chat room or conversation.';

CREATE TABLE chat.chat_members (
  chat_id UUID REFERENCES chat.chats (id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users (id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('participant', 'moderator')),
  added_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (chat_id, user_id)
);
COMMENT ON TABLE chat.chat_members IS 'Manages participants and their roles within a chat.';

CREATE TABLE chat.messages (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  chat_id UUID NOT NULL REFERENCES chat.chats (id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES auth.users (id),
  content TEXT,
  attachment_url TEXT,
  message_type TEXT NOT NULL DEFAULT 'text' CHECK (message_type IN ('text', 'image', 'file', 'system')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  edited_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
COMMENT ON TABLE chat.messages IS 'Stores individual messages within a chat.';
CREATE INDEX idx_messages_chat_id_created_at ON chat.messages (chat_id, created_at);

-- Chat Moderation & Auditing
CREATE TABLE chat.message_flags (
  id BIGSERIAL PRIMARY KEY,
  message_id UUID NOT NULL REFERENCES chat.messages (id) ON DELETE CASCADE,
  flagged_by UUID NOT NULL REFERENCES auth.users (id),
  reason TEXT,
  status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'reviewing', 'closed')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE chat.message_flags IS 'Tracks user-reported messages for moderation.';

CREATE TABLE chat.audit_log (
  id BIGSERIAL PRIMARY KEY,
  chat_id UUID NOT NULL,
  actor_id UUID NOT NULL,
  action TEXT NOT NULL,
  payload JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE chat.audit_log IS 'Append-only log for all significant chat actions.';

-- RLS Policies for Chat
ALTER TABLE chat.chats ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat.chat_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat.message_flags ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Chat members can view their chats" ON chat.chats FOR SELECT
  USING (EXISTS (SELECT 1 FROM chat.chat_members WHERE chat_members.chat_id = chats.id AND chat_members.user_id = auth.uid()));

CREATE POLICY "Users can create chats" ON chat.chats FOR INSERT
  WITH CHECK (created_by = auth.uid());

CREATE POLICY "Members can view other members" ON chat.chat_members FOR SELECT
  USING (EXISTS (SELECT 1 FROM chat.chat_members m WHERE m.chat_id = chat_members.chat_id AND m.user_id = auth.uid()));

CREATE POLICY "Members can view messages in their chats" ON chat.messages FOR SELECT
  USING (EXISTS (SELECT 1 FROM chat.chat_members WHERE chat_members.chat_id = messages.chat_id AND chat_members.user_id = auth.uid()));

CREATE POLICY "Members can send messages" ON chat.messages FOR INSERT
  WITH CHECK (sender_id = auth.uid() AND EXISTS (SELECT 1 FROM chat.chat_members WHERE chat_members.chat_id = messages.chat_id AND chat_members.user_id = auth.uid()));

CREATE POLICY "Users can edit their own messages" ON chat.messages FOR UPDATE
  USING (sender_id = auth.uid());

-- ============================================================================
-- CRM (Customer Relationship Management)
-- Manages companies, contacts, and leads.
-- ============================================================================

CREATE TABLE crm.companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    domain VARCHAR(255),
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE crm.contacts (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES iam.profiles(user_id) ON DELETE SET NULL,
    company_id INTEGER REFERENCES crm.companies(id) ON DELETE SET NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

-- ============================================================================
-- TICKETING
-- Manages support tickets.
-- ============================================================================

CREATE TABLE ticketing.statuses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(7)
);

CREATE TABLE ticketing.priorities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(7)
);

CREATE TABLE ticketing.categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(7)
);

CREATE TABLE ticketing.tickets (
    id SERIAL PRIMARY KEY,
    subject VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    status_id INTEGER REFERENCES ticketing.statuses(id),
    priority_id INTEGER REFERENCES ticketing.priorities(id),
    category_id INTEGER REFERENCES ticketing.categories(id),
    user_id UUID REFERENCES iam.profiles(user_id),
    agent_id UUID REFERENCES iam.profiles(user_id),
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE ticketing.comments (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    user_id UUID REFERENCES iam.profiles(user_id),
    ticket_id INTEGER REFERENCES ticketing.tickets(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- APP_META
-- Manages application metadata, settings, and background jobs.
-- ============================================================================

CREATE TABLE app_meta.settings (
    id SERIAL PRIMARY KEY,
    key VARCHAR(255) UNIQUE NOT NULL,
    value TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE app_meta.jobs (
    id BIGSERIAL PRIMARY KEY,
    queue VARCHAR(255) NOT NULL,
    payload JSONB NOT NULL,
    attempts SMALLINT DEFAULT 0,
    reserved_at TIMESTAMPTZ,
    available_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE app_meta.failed_jobs (
    id BIGSERIAL PRIMARY KEY,
    connection TEXT,
    queue TEXT,
    payload JSONB,
    exception TEXT,
    failed_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Realtime for relevant tables
ALTER PUBLICATION supabase_realtime ADD TABLE chat.messages;
ALTER PUBLICATION supabase_realtime ADD TABLE iam.profiles;

