CREATE TABLE profiles (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    roles TEXT[] NOT NULL DEFAULT ARRAY['customer']::TEXT[],
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    display_name VARCHAR(255),
    avatar_url TEXT,
    phone_number VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    name VARCHAR(255) UNIQUE NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    permissions TEXT[],
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE chats (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  booking_id UUID, -- Optional: Link to a booking
  created_by UUID NOT NULL REFERENCES auth.users (id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE chat_members (
  chat_id UUID REFERENCES chats (id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users (id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('participant', 'moderator')),
  added_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (chat_id, user_id)
);

CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  chat_id UUID NOT NULL REFERENCES chats (id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES auth.users (id),
  content TEXT,
  attachment_url TEXT,
  message_type TEXT NOT NULL DEFAULT 'text' CHECK (message_type IN ('text', 'image', 'file', 'system')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  edited_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_messages_chat_id_created_at ON messages (chat_id, created_at);

CREATE TABLE message_flags (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  message_id UUID NOT NULL REFERENCES messages (id) ON DELETE CASCADE,
  flagged_by UUID NOT NULL REFERENCES auth.users (id),
  reason TEXT,
  status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'reviewing', 'closed')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE audit_log (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  chat_id UUID NOT NULL,
  actor_id UUID NOT NULL,
  action TEXT NOT NULL,
  payload JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE companies (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    domain VARCHAR(255),
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE contacts (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    user_id UUID REFERENCES profiles(user_id) ON DELETE SET NULL,
    company_id UUID REFERENCES companies(id) ON DELETE SET NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE ticket_options (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    type TEXT NOT NULL CHECK (type IN ('status', 'priority', 'category')),
    name VARCHAR(255) NOT NULL,
    color VARCHAR(7),
    UNIQUE (type, name)
);

CREATE TABLE tickets (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    subject VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    status_id UUID REFERENCES ticket_options(id),
    priority_id UUID REFERENCES ticket_options(id),
    category_id UUID REFERENCES ticket_options(id),
    user_id UUID REFERENCES profiles(user_id),
    agent_id UUID REFERENCES profiles(user_id),
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    content TEXT NOT NULL,
    user_id UUID REFERENCES profiles(user_id),
    ticket_id UUID REFERENCES tickets(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE settings (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    key VARCHAR(255) UNIQUE NOT NULL,
    value TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE jobs (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    queue VARCHAR(255) NOT NULL,
    payload JSONB NOT NULL,
    status TEXT NOT NULL DEFAULT 'available' CHECK (status IN ('available', 'reserved', 'failed')),
    attempts SMALLINT DEFAULT 0,
    reserved_at TIMESTAMPTZ,
    available_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    failed_at TIMESTAMPTZ,
    exception TEXT,
    connection TEXT
);
