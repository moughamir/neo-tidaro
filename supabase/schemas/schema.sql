CREATE SCHEMA IF NOT EXISTS extensions;

-- Enable commonly used PostgreSQL extensions for Supabase

-- Provides functions to generate UUIDs (e.g., uuid_generate_v4())
-- Although gen_random_uuid() is built-in since PG 13, uuid-ossp is often useful.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA extensions;

-- Enables HTTP requests from PostgreSQL functions (used by Supabase Edge Functions)
CREATE EXTENSION IF NOT EXISTS "pg_net" SCHEMA extensions;

-- Provides a means to track execution statistics of all SQL statements executed by a server
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" SCHEMA extensions;

-- Enables scheduling of recurring tasks directly within the database
CREATE EXTENSION IF NOT EXISTS "pg_cron" SCHEMA extensions;

-- Enables geospatial objects and functions
CREATE EXTENSION IF NOT EXISTS "postgis" SCHEMA extensions;


-- Supabase Declarative Schema

-- Create ENUM types
CREATE TYPE public.user_role_enum AS ENUM (
    'admin',
    'moderator',
    'client_consumer',
    'client_provider'
);

CREATE TYPE public.service_category_enum AS ENUM (
    'regular_cleaning',
    'deep_cleaning',
    'move_in_out',
    'post_construction',
    'commercial',
    'specialized',
    'standard_cleaning',
    'residential'
);

CREATE TYPE public.booking_status_enum AS ENUM (
    'pending',
    'confirmed',
    'assigned',
    'in_progress',
    'completed',
    'cancelled',
    'rescheduled'
);

CREATE TYPE public.payment_status_enum AS ENUM (
    'pending',
    'paid',
    'failed',
    'refunded'
);

CREATE TYPE public.cleaner_status_enum AS ENUM (
    'available',
    'on_job',
    'offline',
    'on_break'
);

CREATE TYPE public.message_type_enum AS ENUM (
    'text',
    'image',
    'file',
    'system'
);

CREATE TYPE public.document_type_enum AS ENUM (
    'cin',
    'cine',
    'reference_letter',
    'background_check'
);

CREATE TYPE public.verification_status_enum AS ENUM (
    'pending',
    'verified',
    'rejected',
    'expired'
);


-- Create Tables

-- profiles table
CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT,
    avatar_url TEXT,
    phone_number TEXT,
    role public.user_role_enum DEFAULT 'client_consumer'::public.user_role_enum NOT NULL,
    cleaner_status public.cleaner_status_enum DEFAULT 'offline'::public.cleaner_status_enum NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- addresses table
CREATE TABLE public.addresses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    street TEXT NOT NULL,
    apartment TEXT,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip_code TEXT NOT NULL,
    instructions TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- services table
CREATE TABLE public.services (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    description TEXT,
    base_price NUMERIC(10, 2) NOT NULL,
    estimated_duration_minutes INTEGER,
    category public.service_category_enum NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- service_addons table
CREATE TABLE public.service_addons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    service_id UUID REFERENCES public.services(id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- provider_services table (Many-to-many for providers offering services)
CREATE TABLE public.provider_services (
    provider_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    service_id UUID REFERENCES public.services(id) ON DELETE CASCADE NOT NULL,
    hourly_rate NUMERIC(10, 2),
    PRIMARY KEY (provider_id, service_id)
);

-- bookings table
CREATE TABLE public.bookings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    service_id UUID REFERENCES public.services(id) ON DELETE CASCADE NOT NULL,
    scheduled_date TIMESTAMPTZ NOT NULL,
    status public.booking_status_enum NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    payment_status public.payment_status_enum NOT NULL,
    address_id UUID REFERENCES public.addresses(id) ON DELETE RESTRICT NOT NULL, -- RESTRICT to prevent deleting address if booking exists
    notes TEXT,
    cleaner_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL, -- SET NULL if cleaner is deleted
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ,
    cancelled_at TIMESTAMPTZ,
    rescheduled_from TIMESTAMPTZ
);

-- payments table
CREATE TABLE public.payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID REFERENCES public.bookings(id) ON DELETE CASCADE UNIQUE NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    status public.payment_status_enum NOT NULL,
    payment_method TEXT NOT NULL,
    transaction_id TEXT UNIQUE,
    payment_date TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- reviews table
CREATE TABLE public.reviews (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID REFERENCES public.bookings(id) ON DELETE CASCADE UNIQUE NOT NULL,
    reviewer_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    reviewee_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    review_date TIMESTAMPTZ DEFAULT NOW(),
    is_verified_booking BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- availability_slots table
CREATE TABLE public.availability_slots (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    provider_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    day_of_week INTEGER NOT NULL CHECK (day_of_week >= 0 AND day_of_week <= 6), -- 0 for Sunday, 6 for Saturday
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- blocked_periods table
CREATE TABLE public.blocked_periods (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    reason TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- audit_logs table
CREATE TABLE public.audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    action TEXT NOT NULL,
    entity_type TEXT,
    entity_id UUID,
    details JSONB,
    user_agent TEXT,
    ip_address INET, -- Using INET for IP addresses
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- messages table
CREATE TABLE public.messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    receiver_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    booking_id UUID REFERENCES public.bookings(id) ON DELETE SET NULL,
    content TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    is_read BOOLEAN DEFAULT FALSE,
    message_type public.message_type_enum NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- verification_documents table
CREATE TABLE public.verification_documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    document_type public.document_type_enum NOT NULL,
    file_url TEXT NOT NULL,
    status public.verification_status_enum NOT NULL,
    upload_date TIMESTAMPTZ DEFAULT NOW(),
    verification_date TIMESTAMPTZ,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);


-- Create Indexes

-- profiles indexes
CREATE INDEX idx_profiles_created_at ON public.profiles (created_at DESC);
CREATE INDEX idx_profiles_role ON public.profiles (role);

-- addresses indexes
CREATE INDEX idx_addresses_profile_id ON public.addresses (profile_id);
CREATE INDEX idx_addresses_city ON public.addresses (city);
CREATE INDEX idx_addresses_zip_code ON public.addresses (zip_code);

-- services indexes
CREATE INDEX idx_services_category ON public.services (category);
CREATE INDEX idx_services_is_active ON public.services (is_active);

-- service_addons indexes
CREATE INDEX idx_service_addons_service_id ON public.service_addons (service_id);

-- bookings indexes
CREATE INDEX idx_bookings_customer_id ON public.bookings (customer_id);
CREATE INDEX idx_bookings_service_id ON public.bookings (service_id);
CREATE INDEX idx_bookings_cleaner_id ON public.bookings (cleaner_id);
CREATE INDEX idx_bookings_scheduled_date ON public.bookings (scheduled_date);
CREATE INDEX idx_bookings_status ON public.bookings (status);
CREATE INDEX idx_bookings_created_at ON public.bookings (created_at DESC);

-- payments indexes
CREATE INDEX idx_payments_booking_id ON public.payments (booking_id);
CREATE INDEX idx_payments_status ON public.payments (status);
CREATE INDEX idx_payments_payment_date ON public.payments (payment_date DESC);

-- reviews indexes
CREATE INDEX idx_reviews_booking_id ON public.reviews (booking_id);
CREATE INDEX idx_reviews_reviewer_id ON public.reviews (reviewer_id);
CREATE INDEX idx_reviews_reviewee_id ON public.reviews (reviewee_id);
CREATE INDEX idx_reviews_review_date ON public.reviews (review_date DESC);

-- availability_slots indexes
CREATE INDEX idx_availability_slots_provider_id ON public.availability_slots (provider_id);
CREATE INDEX idx_availability_slots_start_time ON public.availability_slots (start_time);
CREATE INDEX idx_availability_slots_end_time ON public.availability_slots (end_time);
CREATE INDEX idx_availability_slots_day_of_week ON public.availability_slots (day_of_week);

-- blocked_periods indexes
CREATE INDEX idx_blocked_periods_profile_id ON public.blocked_periods (profile_id);
CREATE INDEX idx_blocked_periods_start_date ON public.blocked_periods (start_date);
CREATE INDEX idx_blocked_periods_end_date ON public.blocked_periods (end_date);

-- audit_logs indexes
CREATE INDEX idx_audit_logs_user_id ON public.audit_logs (user_id);
CREATE INDEX idx_audit_logs_timestamp ON public.audit_logs (timestamp DESC);
CREATE INDEX idx_audit_logs_action ON public.audit_logs (action);
CREATE INDEX idx_audit_logs_entity_type ON public.audit_logs (entity_type);
CREATE INDEX idx_audit_logs_entity_id ON public.audit_logs (entity_id);

-- messages indexes
CREATE INDEX idx_messages_sender_id ON public.messages (sender_id);
CREATE INDEX idx_messages_receiver_id ON public.messages (receiver_id);
CREATE INDEX idx_messages_booking_id ON public.messages (booking_id);
CREATE INDEX idx_messages_timestamp ON public.messages (timestamp DESC);
CREATE INDEX idx_messages_is_read ON public.messages (is_read);

-- verification_documents indexes
CREATE INDEX idx_verification_documents_profile_id ON public.verification_documents (profile_id);
CREATE INDEX idx_verification_documents_document_type ON public.verification_documents (document_type);
CREATE INDEX idx_verification_documents_status ON public.verification_documents (status);
CREATE INDEX idx_verification_documents_upload_date ON public.verification_documents (upload_date DESC);


-- Create Views

-- active_bookings_view: Shows bookings that are pending, confirmed, or in progress
CREATE VIEW public.active_bookings_view AS
SELECT
    b.*,
    p.full_name AS customer_name,
    s.name AS service_name
FROM
    public.bookings b
JOIN
    public.profiles p ON b.customer_id = p.id
JOIN
    public.services s ON b.service_id = s.id
WHERE
    b.status IN ('pending'::public.booking_status_enum, 'confirmed'::public.booking_status_enum, 'in_progress'::public.booking_status_enum);

-- completed_bookings_view: Shows only completed bookings
CREATE VIEW public.completed_bookings_view AS
SELECT
    b.*,
    p.full_name AS customer_name,
    s.name AS service_name
FROM
    public.bookings b
JOIN
    public.profiles p ON b.customer_id = p.id
JOIN
    public.services s ON b.service_id = s.id
WHERE
    b.status = 'completed'::public.booking_status_enum;

-- cleaner_performance_view: Aggregates data for cleaner performance
CREATE VIEW public.cleaner_performance_view AS
SELECT
    p.id AS cleaner_id,
    p.full_name AS cleaner_name,
    COUNT(b.id) AS total_completed_bookings,
    AVG(r.rating) AS average_rating,
    SUM(b.total_price) AS total_revenue_generated
FROM
    public.profiles p
LEFT JOIN
    public.bookings b ON p.id = b.cleaner_id AND b.status = 'completed'::public.booking_status_enum
LEFT JOIN
    public.reviews r ON b.id = r.booking_id
WHERE
    p.role = 'client_provider'::public.user_role_enum
GROUP BY
    p.id, p.full_name;


-- Create Triggers

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION public.update_updated_at_column() RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$
LANGUAGE plpgsql
SET search_path = '';

-- Apply trigger to tables with updated_at column
CREATE TRIGGER update_profiles_updated_at
BEFORE UPDATE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_addresses_updated_at
BEFORE UPDATE ON public.addresses
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_services_updated_at
BEFORE UPDATE ON public.services
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_service_addons_updated_at
BEFORE UPDATE ON public.service_addons
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_bookings_updated_at
BEFORE UPDATE ON public.bookings
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_payments_updated_at
BEFORE UPDATE ON public.payments
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_reviews_updated_at
BEFORE UPDATE ON public.reviews
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_availability_slots_updated_at
BEFORE UPDATE ON public.availability_slots
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_blocked_periods_updated_at
BEFORE UPDATE ON public.blocked_periods
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_audit_logs_updated_at
BEFORE UPDATE ON public.audit_logs
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_messages_updated_at
BEFORE UPDATE ON public.messages
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_verification_documents_updated_at
BEFORE UPDATE ON public.verification_documents
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();