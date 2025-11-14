-- ============================================================================
-- TIDARO PLATFORM CONSOLIDATED DATABASE SCHEMA
-- Version: 2.0
-- Description: This is the complete, optimized, and consolidated database schema for the Tidaro platform.
-- This script is the master version, created by merging all SQL files and removing duplicates.
-- Architecture: Follows Clean Architecture and DRY principles.
-- ============================================================================

-- ============================================================================
-- SECTION 0: EXTENSIONS
-- Enables required PostgreSQL extensions.
-- ============================================================================
CREATE SCHEMA IF NOT EXISTS extensions;
COMMENT ON SCHEMA extensions IS 'Schema for PostgreSQL extensions';

CREATE EXTENSION IF NOT EXISTS "pg_cron" WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "postgis" WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "pg_trgm" WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA extensions;


-- ============================================================================
-- SECTION 1: CUSTOM TYPES
-- Defines ENUM types used throughout the application.
-- ============================================================================
-- STATES
CREATE TYPE public.booking_status_enum AS ENUM ('pending', 'confirmed', 'in_progress', 'completed', 'cancelled');
CREATE TYPE public.payment_status_enum AS ENUM ('pending', 'paid', 'failed', 'refunded');
CREATE TYPE public.professional_status_enum AS ENUM ('available', 'on_job', 'offline', 'on_break');
-- Minimized job and bid statuses for DRY design
CREATE TYPE public.job_status_enum AS ENUM ('draft', 'open', 'booked', 'in_progress', 'completed', 'cancelled');
CREATE TYPE public.bid_status_enum AS ENUM ('pending', 'accepted', 'rejected');
CREATE TYPE public.verification_status_enum AS ENUM ('pending', 'verified', 'rejected', 'expired');

CREATE TYPE public.document_type_enum AS ENUM ('cin', 'cine', 'reference_letter', 'background_check');
CREATE TYPE public.message_type_enum AS ENUM ('text', 'image', 'file', 'system');
CREATE TYPE public.service_category_enum AS ENUM ('regular_cleaning', 'deep_cleaning', 'move_in_out', 'move_in_out_cleaning', 'post_construction', 'commercial', 'specialized', 'standard_cleaning', 'residential', 'one_time_cleaning', 'office_cleaning', 'laundry_services');
CREATE TYPE public.user_role_enum AS ENUM ('admin', 'moderator', 'client_consumer', 'client_provider');


-- ============================================================================
-- SECTION 2: TABLES
-- Defines the core data structures of the application.
-- ============================================================================

-- IAM (Identity & Access Management)
CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT,
    avatar_url TEXT,
    phone_number TEXT,
    email TEXT UNIQUE,
    address_text TEXT,
    city TEXT DEFAULT 'Casablanca',
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    -- Geography point for efficient geo queries
    location geography(Point, 4326) GENERATED ALWAYS AS (
      CASE
        WHEN latitude IS NOT NULL AND longitude IS NOT NULL
        THEN ST_SetSRID(ST_MakePoint(longitude::double precision, latitude::double precision), 4326)::geography
        ELSE NULL
      END
    ) STORED,
    role public.user_role_enum DEFAULT 'client_consumer'::public.user_role_enum NOT NULL,
    professional_status public.professional_status_enum DEFAULT 'offline'::public.professional_status_enum NOT NULL,
    verification_status public.verification_status_enum DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE public.profiles IS 'Stores basic profile information for users.';

-- Professionals (generic provider profiles)
CREATE TABLE public.professional_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE UNIQUE,
  years_experience INTEGER DEFAULT 0,
  service_types public.service_category_enum[] DEFAULT '{}',
  hourly_rate_mad DECIMAL(10,2),
  service_radius_km INTEGER DEFAULT 10,
  bio TEXT,
  id_document_url TEXT,
  id_document_type TEXT,
  total_jobs_completed INTEGER DEFAULT 0,
  average_rating DECIMAL(3,2) DEFAULT 0.00,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
COMMENT ON TABLE public.professional_profiles IS 'Stores detailed profile information for service providers (generic).';

CREATE TABLE public.services (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    name_fr TEXT,
    name_ar TEXT,
    description TEXT,
    base_price NUMERIC(10, 2) NOT NULL,
    suggested_price_mad DECIMAL(10,2),
    estimated_duration_minutes INTEGER,
    category public.service_category_enum NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE public.services IS 'Defines the types and basic information of services offered.';

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
COMMENT ON TABLE public.addresses IS 'Manages user address information.';

CREATE TABLE public.bookings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    service_id UUID REFERENCES public.services(id) ON DELETE CASCADE NOT NULL,
    scheduled_date TIMESTAMPTZ NOT NULL,
    status public.booking_status_enum NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    payment_status public.payment_status_enum NOT NULL,
    address_id UUID REFERENCES public.addresses(id) ON DELETE RESTRICT NOT NULL,
    notes TEXT,
    professional_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ,
    cancelled_at TIMESTAMPTZ,
    rescheduled_from TIMESTAMPTZ
);
COMMENT ON TABLE public.bookings IS 'Stores customer service booking information.';

CREATE TABLE public.jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  service_id UUID REFERENCES public.services(id),
  title TEXT NOT NULL,
  description TEXT,
  service_type public.service_category_enum NOT NULL,
  address_text TEXT NOT NULL,
  latitude DECIMAL(10,8),
  longitude DECIMAL(11,8),
  -- Geography point for efficient geo queries
  location geography(Point, 4326) GENERATED ALWAYS AS (
    CASE
      WHEN latitude IS NOT NULL AND longitude IS NOT NULL
      THEN ST_SetSRID(ST_MakePoint(longitude::double precision, latitude::double precision), 4326)::geography
      ELSE NULL
    END
  ) STORED,
  number_of_rooms INTEGER,
  number_of_bathrooms INTEGER,
  preferred_date DATE,
  preferred_time_start TIME,
  estimated_duration_hours DECIMAL(4,2) DEFAULT 2.0,
  budget_min_mad DECIMAL(10,2),
  budget_max_mad DECIMAL(10,2),
  status public.job_status_enum DEFAULT 'draft',
  accepted_bid_id UUID,
  assigned_provider_id UUID REFERENCES public.profiles(id),
  special_instructions TEXT,
  posted_at TIMESTAMP WITH TIME ZONE,
  scheduled_start TIMESTAMP WITH TIME ZONE,
  completed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
COMMENT ON TABLE public.jobs IS 'Stores job requests posted by customers for services.';

CREATE TABLE public.bids (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID REFERENCES public.jobs(id) ON DELETE CASCADE,
  provider_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  amount_mad DECIMAL(10,2) NOT NULL,
  message TEXT,
  estimated_duration_hours DECIMAL(4,2),
  status public.bid_status_enum DEFAULT 'pending',
  expires_at TIMESTAMP WITH TIME ZONE DEFAULT (NOW() + INTERVAL '24 hours'),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(job_id, provider_id)
);
COMMENT ON TABLE public.bids IS 'Stores bids from providers for jobs.';

-- Communication
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
COMMENT ON TABLE public.messages IS 'Stores message content between users.';

-- Generic chat channels for job- or booking-scoped conversations
CREATE TABLE public.chat_channels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID REFERENCES public.jobs(id) ON DELETE CASCADE,
  booking_id UUID REFERENCES public.bookings(id) ON DELETE CASCADE,
  client_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  provider_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
COMMENT ON TABLE public.chat_channels IS 'Stores chat channel information (job or booking scoped) between client and provider.';

-- Route all chat messages through the generic messages table using channel_id
-- Add channel_id to messages for channel-scoped conversations
ALTER TABLE public.messages
  ADD COLUMN IF NOT EXISTS channel_id UUID REFERENCES public.chat_channels(id) ON DELETE CASCADE;

-- Payments & Reviews
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
COMMENT ON TABLE public.payments IS 'Manages payment information.';

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
COMMENT ON TABLE public.reviews IS 'Stores reviews and rating information for services.';

-- Provider Specific
CREATE TABLE public.provider_services (
    provider_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    service_id UUID REFERENCES public.services(id) ON DELETE CASCADE NOT NULL,
    hourly_rate NUMERIC(10, 2),
    PRIMARY KEY (provider_id, service_id)
);
COMMENT ON TABLE public.provider_services IS 'Maps which services are offered by which providers.';

CREATE TABLE public.availability_slots (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    provider_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    day_of_week INTEGER NOT NULL CHECK (day_of_week >= 0 AND day_of_week <= 6),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE public.availability_slots IS 'Defines the available time slots for providers.';

CREATE TABLE public.blocked_periods (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    reason TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE public.blocked_periods IS 'Sets periods when a provider is unavailable.';

-- Miscellaneous
CREATE TABLE public.service_addons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    service_id UUID REFERENCES public.services(id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE public.service_addons IS 'Contains information about add-on services that can be added to a primary service.';

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
COMMENT ON TABLE public.verification_documents IS 'Stores documents for user identity and qualification verification.';

CREATE TABLE public.audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    action TEXT NOT NULL,
    entity_type TEXT,
    entity_id UUID,
    details JSONB,
    user_agent TEXT,
    ip_address INET,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
COMMENT ON TABLE public.audit_logs IS 'Records audit logs for major activities within the system.';


-- ============================================================================
-- SECTION 3: INDEXES
-- Creates indexes to optimize database query performance.
-- ============================================================================
CREATE INDEX idx_profiles_role ON public.profiles (role);
CREATE INDEX idx_profiles_created_at ON public.profiles (created_at DESC);
CREATE INDEX idx_profiles_full_name_trgm ON public.profiles USING gin (full_name gin_trgm_ops);
CREATE INDEX idx_profiles_phone_trgm ON public.profiles USING gin (phone_number gin_trgm_ops);
CREATE UNIQUE INDEX IF NOT EXISTS profiles_email_key ON public.profiles(email);

CREATE INDEX idx_addresses_profile_id ON public.addresses (profile_id);
CREATE INDEX idx_addresses_city ON public.addresses (city);
CREATE INDEX idx_addresses_zip_code ON public.addresses (zip_code);

CREATE INDEX idx_services_category ON public.services (category);
CREATE INDEX idx_services_is_active ON public.services (is_active);

-- Geo indexes for fast proximity queries
CREATE INDEX IF NOT EXISTS idx_profiles_location_gist ON public.profiles USING gist (location);
CREATE INDEX IF NOT EXISTS idx_jobs_location_gist ON public.jobs USING gist (location);

CREATE INDEX idx_bookings_customer_id ON public.bookings (customer_id);
CREATE INDEX idx_bookings_professional_id ON public.bookings (professional_id);
CREATE INDEX idx_bookings_service_id ON public.bookings (service_id);
CREATE INDEX idx_bookings_status ON public.bookings (status);
CREATE INDEX idx_bookings_scheduled_date ON public.bookings (scheduled_date);

CREATE INDEX idx_jobs_status ON public.jobs(status);
CREATE INDEX idx_jobs_service_type ON public.jobs(service_type);
CREATE INDEX idx_jobs_client_id ON public.jobs(client_id);

CREATE INDEX IF NOT EXISTS idx_chat_channels_job_id ON public.chat_channels(job_id);
CREATE INDEX IF NOT EXISTS idx_chat_channels_booking_id ON public.chat_channels(booking_id);
CREATE INDEX IF NOT EXISTS idx_messages_channel_id ON public.messages(channel_id);
CREATE INDEX idx_bids_provider_id ON public.bids(provider_id);

-- Prevent duplicate chat channels per scope/participants
CREATE UNIQUE INDEX IF NOT EXISTS uq_chat_channel_job_participants
  ON public.chat_channels(job_id, client_id, provider_id)
  WHERE job_id IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS uq_chat_channel_booking_participants
  ON public.chat_channels(booking_id, client_id, provider_id)
  WHERE booking_id IS NOT NULL;

CREATE INDEX idx_professional_profiles_user_id ON public.professional_profiles(user_id);

CREATE INDEX idx_reviews_reviewer_id ON public.reviews (reviewer_id);
CREATE INDEX idx_reviews_reviewee_id ON public.reviews (reviewee_id);

CREATE INDEX idx_payments_booking_id ON public.payments (booking_id);
CREATE INDEX idx_payments_status ON public.payments (status);

CREATE INDEX idx_messages_sender_id ON public.messages (sender_id);
CREATE INDEX idx_messages_receiver_id ON public.messages (receiver_id);
CREATE INDEX idx_messages_booking_id ON public.messages (booking_id);

CREATE INDEX idx_verification_documents_profile_id ON public.verification_documents (profile_id);
CREATE INDEX idx_verification_documents_status ON public.verification_documents (status);


-- ============================================================================
-- SECTION 4: VIEWS
-- Creates views to facilitate data retrieval.
-- ============================================================================
CREATE OR REPLACE VIEW public.active_bookings_view AS
SELECT b.*, p.full_name AS customer_name, s.name AS service_name
FROM bookings b
JOIN profiles p ON b.customer_id = p.id
JOIN services s ON b.service_id = s.id
WHERE b.status = ANY (ARRAY['pending'::booking_status_enum, 'confirmed'::booking_status_enum, 'in_progress'::booking_status_enum]);

CREATE OR REPLACE VIEW public.completed_bookings_view AS
SELECT b.*, p.full_name AS customer_name, s.name AS service_name
FROM bookings b
JOIN profiles p ON b.customer_id = p.id
JOIN services s ON b.service_id = s.id
WHERE b.status = 'completed'::booking_status_enum;

CREATE OR REPLACE VIEW public.professional_performance_view AS
SELECT p.id AS professional_id, p.full_name AS professional_name, count(b.id) AS total_completed_bookings, avg(r.rating) AS average_rating, sum(b.total_price) AS total_revenue_generated
FROM profiles p
LEFT JOIN bookings b ON p.id = b.professional_id AND b.status = 'completed'::booking_status_enum
LEFT JOIN reviews r ON b.id = r.booking_id
WHERE p.role = 'client_provider'::user_role_enum
GROUP BY p.id, p.full_name;

CREATE OR REPLACE VIEW public.v_kyc_queue AS
SELECT
  vd.id AS verification_id, vd.profile_id, p.full_name, p.phone_number, p.role, vd.document_type, vd.file_url, vd.status, vd.upload_date, vd.verification_date, vd.notes
FROM public.verification_documents vd
JOIN public.profiles p ON p.id = vd.profile_id
WHERE vd.status = 'pending'::public.verification_status_enum
ORDER BY vd.upload_date ASC;

CREATE OR REPLACE VIEW public.v_admin_metrics_daily AS
WITH 
  roles AS (SELECT COUNT(*) FILTER (WHERE role = 'client_provider') AS total_providers, COUNT(*) FILTER (WHERE role = 'client_consumer') AS total_clients, COUNT(*) FILTER (WHERE role IN ('admin','moderator')) AS total_staff FROM public.profiles),
  kyc AS (SELECT COUNT(*) FILTER (WHERE status = 'pending') AS kyc_pending, COUNT(*) FILTER (WHERE status = 'verified') AS kyc_verified_total FROM public.verification_documents),
  bookings AS (SELECT COUNT(*) FILTER (WHERE status IN ('pending','confirmed','in_progress')) AS open_bookings, COUNT(*) FILTER (WHERE status = 'completed') AS completed_total, COUNT(*) FILTER (WHERE status = 'cancelled') AS cancelled_total, COUNT(*) FILTER (WHERE DATE(created_at) = CURRENT_DATE) AS bookings_today FROM public.bookings),
  ratings AS (SELECT COALESCE(AVG(rating), 0)::numeric(4,2) AS avg_rating, COUNT(*) AS ratings_total FROM public.reviews)
SELECT 
  roles.total_providers, roles.total_clients, roles.total_staff, kyc.kyc_pending, kyc.kyc_verified_total, bookings.open_bookings, bookings.completed_total, bookings.cancelled_total, bookings.bookings_today, ratings.avg_rating, ratings.ratings_total
FROM roles, kyc, bookings, ratings;

CREATE OR REPLACE VIEW public.v_admin_activity_feed AS
SELECT al.id, al.timestamp, al.user_id, p.full_name, al.action, al.entity_type, al.entity_id, al.details
FROM public.audit_logs al
LEFT JOIN public.profiles p ON p.id = al.user_id
ORDER BY al.timestamp DESC
LIMIT 200;

CREATE OR REPLACE VIEW public.v_admin_revenue_summary AS
WITH paid AS (SELECT COALESCE(SUM(amount), 0)::numeric AS total_revenue FROM public.payments WHERE status = 'paid'::public.payment_status_enum),
month_paid AS (SELECT COALESCE(SUM(amount), 0)::numeric AS monthly_revenue FROM public.payments WHERE status = 'paid'::public.payment_status_enum AND date_trunc('month', payment_date) = date_trunc('month', NOW()))
SELECT paid.total_revenue, month_paid.monthly_revenue
FROM paid, month_paid;

CREATE OR REPLACE VIEW public.v_admin_booking_stats AS
WITH s AS (SELECT COUNT(*) FILTER (WHERE status = 'pending') AS pending_count, COUNT(*) FILTER (WHERE status = 'confirmed') AS confirmed_count, COUNT(*) FILTER (WHERE status = 'in_progress') AS in_progress_count, COUNT(*) FILTER (WHERE status = 'completed') AS completed_count, COUNT(*) FILTER (WHERE status = 'cancelled') AS cancelled_count FROM public.bookings)
SELECT pending_count, confirmed_count, in_progress_count, completed_count, cancelled_count, CASE WHEN (completed_count + cancelled_count) > 0 THEN (completed_count::numeric / (completed_count + cancelled_count)) ELSE 0 END AS completion_rate, CASE WHEN (pending_count + confirmed_count) > 0 THEN (confirmed_count::numeric / (pending_count + confirmed_count)) ELSE 0 END AS confirmation_rate
FROM s;

CREATE OR REPLACE VIEW public.v_admin_revenue_rolling AS
WITH base AS (SELECT amount, payment_date FROM public.payments WHERE status = 'paid'::public.payment_status_enum),
win7 AS (SELECT COALESCE(SUM(amount), 0)::numeric AS revenue_7d FROM base WHERE payment_date >= NOW() - INTERVAL '7 days'),
win30 AS (SELECT COALESCE(SUM(amount), 0)::numeric AS revenue_30d FROM base WHERE payment_date >= NOW() - INTERVAL '30 days')
SELECT win7.revenue_7d, win30.revenue_30d
FROM win7, win30;

-- Materialized base view for open jobs (user-agnostic)
CREATE MATERIALIZED VIEW IF NOT EXISTS public.mv_open_jobs AS
SELECT j.* FROM public.jobs j WHERE j.status = 'open';

-- Unique index to allow CONCURRENT refresh
CREATE UNIQUE INDEX IF NOT EXISTS uq_mv_open_jobs_id ON public.mv_open_jobs(id);

-- Helper RPC to refresh materialized open jobs; call via scheduler (pg_cron) or manually
CREATE OR REPLACE FUNCTION public.fn_refresh_open_jobs() RETURNS void
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_open_jobs;
END;
$$;

-- Schedule: auto-refresh open jobs every minute (via pg_cron in 'extensions' schema)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_namespace WHERE nspname = 'extensions'
  ) THEN
    -- Create the schedule only if it does not already exist
    IF NOT EXISTS (
      SELECT 1 FROM extensions.cron.job WHERE jobname = 'refresh_open_jobs_every_minute'
    ) THEN
      PERFORM extensions.cron.schedule(
        'refresh_open_jobs_every_minute',
        '* * * * *',
        'SELECT public.fn_refresh_open_jobs();'
      );
    END IF;
  END IF;
END $$;

-- Pre-filtered provider feed: open jobs near the authenticated provider (reads from MV)
CREATE OR REPLACE VIEW public.v_provider_open_jobs_near_me AS
SELECT j.*
FROM public.mv_open_jobs j
JOIN public.professional_profiles pp ON pp.user_id = auth.uid()
JOIN public.profiles pr ON pr.id = pp.user_id
WHERE (pp.service_types IS NULL OR j.service_type = ANY(pp.service_types))
  AND (
    pr.location IS NULL OR j.location IS NULL
    OR ST_DWithin(pr.location, j.location, (pp.service_radius_km::double precision * 1000.0))
  );


-- ============================================================================
-- SECTION 5: FUNCTIONS & TRIGGERS
-- Defines functions and triggers for database automation and business logic.
-- ============================================================================
CREATE OR REPLACE FUNCTION public.update_updated_at_column() RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- RPC: Post a job with validations; returns new job id
CREATE OR REPLACE FUNCTION public.fn_post_job(
  p_service_id uuid,
  p_title text,
  p_description text,
  p_service_type public.service_category_enum,
  p_address_text text,
  p_latitude numeric,
  p_longitude numeric,
  p_number_of_rooms integer DEFAULT NULL,
  p_number_of_bathrooms integer DEFAULT NULL,
  p_preferred_date date DEFAULT NULL,
  p_preferred_time_start time DEFAULT NULL,
  p_estimated_duration_hours numeric DEFAULT 2.0,
  p_budget_min_mad numeric DEFAULT NULL,
  p_budget_max_mad numeric DEFAULT NULL
) RETURNS uuid
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_uid uuid := auth.uid();
  v_id uuid := gen_random_uuid();
  v_service_active boolean;
BEGIN
  IF v_uid IS NULL THEN RAISE EXCEPTION 'not_authenticated'; END IF;
  SELECT s.is_active INTO v_service_active FROM public.services s WHERE s.id = p_service_id;
  IF v_service_active IS DISTINCT FROM TRUE THEN RAISE EXCEPTION 'service_inactive_or_not_found'; END IF;
  IF p_budget_min_mad IS NOT NULL AND p_budget_max_mad IS NOT NULL AND p_budget_min_mad > p_budget_max_mad THEN
    RAISE EXCEPTION 'invalid_budget_range';
  END IF;

  INSERT INTO public.jobs (
    id, client_id, service_id, title, description, service_type, address_text,
    latitude, longitude, number_of_rooms, number_of_bathrooms,
    preferred_date, preferred_time_start, estimated_duration_hours,
    budget_min_mad, budget_max_mad, status, created_at, updated_at
  ) VALUES (
    v_id, v_uid, p_service_id, p_title, p_description, p_service_type, p_address_text,
    p_latitude, p_longitude, p_number_of_rooms, p_number_of_bathrooms,
    p_preferred_date, p_preferred_time_start, COALESCE(p_estimated_duration_hours, 2.0),
    p_budget_min_mad, p_budget_max_mad, 'open', NOW(), NOW()
  );

  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (v_uid, 'job_posted', 'job', v_id, jsonb_build_object('service_id', p_service_id, 'service_type', p_service_type));

  RETURN v_id;
END;
$$;

-- RPC: Create a booking from a booked job
CREATE OR REPLACE FUNCTION public.fn_create_booking_from_job(
  p_job_id uuid,
  p_address_id uuid,
  p_scheduled_at timestamptz,
  p_total_price numeric,
  p_payment_method text DEFAULT 'cash'
) RETURNS uuid
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_uid uuid := auth.uid();
  v_job RECORD;
  v_booking_id uuid := gen_random_uuid();
BEGIN
  SELECT * INTO v_job FROM public.jobs WHERE id = p_job_id FOR UPDATE;
  IF v_job.id IS NULL THEN RAISE EXCEPTION 'job_not_found'; END IF;
  IF v_job.client_id <> v_uid THEN RAISE EXCEPTION 'not_authorized'; END IF;
  IF v_job.status <> 'booked' THEN RAISE EXCEPTION 'job_not_booked'; END IF;

  INSERT INTO public.bookings (
    id, customer_id, service_id, scheduled_date, status, total_price, payment_status,
    address_id, notes, professional_id, created_at, updated_at
  ) VALUES (
    v_booking_id, v_job.client_id, v_job.service_id, p_scheduled_at, 'confirmed', p_total_price, 'pending',
    p_address_id, v_job.description, v_job.assigned_provider_id, NOW(), NOW()
  );

  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (v_uid, 'booking_created_from_job', 'booking', v_booking_id, jsonb_build_object('job_id', p_job_id));

  RETURN v_booking_id;
END;
$$;

-- RPC: Cancel a job with audit logging
CREATE OR REPLACE FUNCTION public.fn_cancel_job(
  p_job_id uuid,
  p_reason text DEFAULT NULL
) RETURNS void
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_uid uuid := auth.uid();
  v_job RECORD;
BEGIN
  SELECT * INTO v_job FROM public.jobs WHERE id = p_job_id FOR UPDATE;
  IF v_job.id IS NULL THEN RAISE EXCEPTION 'job_not_found'; END IF;
  IF v_job.client_id <> v_uid AND v_job.assigned_provider_id <> v_uid THEN RAISE EXCEPTION 'not_authorized'; END IF;
  IF v_job.status IN ('completed','cancelled') THEN RAISE EXCEPTION 'job_already_finalized'; END IF;

  UPDATE public.jobs SET status = 'cancelled', updated_at = NOW() WHERE id = p_job_id;

  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (v_uid, 'job_cancelled', 'job', p_job_id, jsonb_build_object('reason', p_reason));
END;
$$;

-- RPC: Post a bid with validations; returns new bid id
CREATE OR REPLACE FUNCTION public.fn_post_bid(
  p_job_id uuid,
  p_amount_mad numeric,
  p_message text DEFAULT NULL,
  p_estimated_duration_hours numeric DEFAULT NULL
) RETURNS uuid
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_uid uuid := auth.uid();
  v_job RECORD;
  v_bid_id uuid := gen_random_uuid();
  v_exists boolean;
  v_allowed boolean := false;
BEGIN
  IF v_uid IS NULL THEN RAISE EXCEPTION 'not_authenticated'; END IF;
  IF p_amount_mad IS NULL OR p_amount_mad <= 0 THEN RAISE EXCEPTION 'invalid_amount'; END IF;

  SELECT * INTO v_job FROM public.jobs WHERE id = p_job_id FOR UPDATE;
  IF v_job.id IS NULL THEN RAISE EXCEPTION 'job_not_found'; END IF;
  IF v_job.client_id = v_uid THEN RAISE EXCEPTION 'cannot_bid_on_own_job'; END IF;
  IF v_job.status <> 'open' THEN RAISE EXCEPTION 'job_not_open'; END IF;

  -- No duplicate pending/accepted bid from same provider
  SELECT EXISTS (
    SELECT 1 FROM public.bids b
    WHERE b.job_id = p_job_id AND b.provider_id = v_uid AND b.status IN ('pending','accepted')
  ) INTO v_exists;
  IF v_exists THEN RAISE EXCEPTION 'duplicate_active_bid'; END IF;

  -- Optional: enforce same discovery rules as provider feed (category + radius)
  PERFORM 1
  FROM public.professional_profiles pp
  JOIN public.profiles pr ON pr.id = pp.user_id
  WHERE pp.user_id = v_uid
    AND (pp.service_types IS NULL OR v_job.service_type = ANY(pp.service_types))
    AND (
      pr.location IS NULL OR v_job.location IS NULL
      OR ST_DWithin(pr.location, v_job.location, (pp.service_radius_km::double precision * 1000.0))
    );
  IF NOT FOUND THEN RAISE EXCEPTION 'job_not_within_radius_or_category'; END IF;

  INSERT INTO public.bids (
    id, job_id, provider_id, amount_mad, message, estimated_duration_hours, status, expires_at, created_at, updated_at
  ) VALUES (
    v_bid_id, p_job_id, v_uid, p_amount_mad, p_message, p_estimated_duration_hours, 'pending', (NOW() + INTERVAL '24 hours'), NOW(), NOW()
  );

  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (v_uid, 'bid_posted', 'bid', v_bid_id, jsonb_build_object('job_id', p_job_id, 'amount_mad', p_amount_mad));

  RETURN v_bid_id;
END;
$$;

-- Log job status changes to audit logs (realtime-friendly)
CREATE OR REPLACE FUNCTION public.fn_log_job_status_change() RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (auth.uid(), 'job_status_changed', 'job', NEW.id, jsonb_build_object('old_status', OLD.status, 'new_status', NEW.status));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Log bid creation
CREATE OR REPLACE FUNCTION public.fn_log_bid_created() RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (auth.uid(), 'bid_created', 'bid', NEW.id, jsonb_build_object('job_id', NEW.job_id, 'amount_mad', NEW.amount_mad));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Accept a bid: book the job, accept the bid, reject others, create chat channel
CREATE OR REPLACE FUNCTION public.fn_accept_bid(p_job_id uuid, p_bid_id uuid) RETURNS void
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_uid uuid := auth.uid();
  v_job RECORD;
  v_bid RECORD;
  v_channel_id uuid;
BEGIN
  SELECT * INTO v_job FROM public.jobs WHERE id = p_job_id FOR UPDATE;
  IF v_job.id IS NULL THEN RAISE EXCEPTION 'job_not_found'; END IF;
  IF v_job.client_id <> v_uid THEN RAISE EXCEPTION 'not_authorized'; END IF;
  IF v_job.status <> 'open' THEN RAISE EXCEPTION 'job_not_open'; END IF;

  SELECT * INTO v_bid FROM public.bids WHERE id = p_bid_id AND job_id = p_job_id FOR UPDATE;
  IF v_bid.id IS NULL THEN RAISE EXCEPTION 'bid_not_found'; END IF;

  -- Accept selected bid, reject others, book job
  UPDATE public.bids SET status = 'accepted' WHERE id = v_bid.id;
  UPDATE public.bids SET status = 'rejected' WHERE job_id = p_job_id AND id <> v_bid.id AND status = 'pending';
  UPDATE public.jobs
    SET status = 'booked', accepted_bid_id = v_bid.id, assigned_provider_id = v_bid.provider_id, updated_at = NOW()
    WHERE id = p_job_id;

  -- Ensure a chat channel exists between client and assigned provider for this job
  INSERT INTO public.chat_channels(id, job_id, booking_id, client_id, provider_id)
  SELECT gen_random_uuid(), p_job_id, NULL, v_job.client_id, v_bid.provider_id
  WHERE NOT EXISTS (
    SELECT 1 FROM public.chat_channels c WHERE c.job_id = p_job_id AND c.client_id = v_job.client_id AND c.provider_id = v_bid.provider_id
  );

  -- Audit log
  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (v_uid, 'bid_accepted', 'job', p_job_id, jsonb_build_object('bid_id', p_bid_id, 'provider_id', v_bid.provider_id));
END;
$$;

-- RPC: Accept a bid and immediately create a booking (single transaction)
CREATE OR REPLACE FUNCTION public.fn_accept_bid_and_create_booking(
  p_job_id uuid,
  p_bid_id uuid,
  p_address_id uuid,
  p_scheduled_at timestamptz,
  p_total_price numeric,
  p_payment_method text DEFAULT 'cash'
) RETURNS uuid
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_uid uuid := auth.uid();
  v_job RECORD;
  v_bid RECORD;
  v_booking_id uuid := gen_random_uuid();
BEGIN
  -- Lock job and bid rows for consistency
  SELECT * INTO v_job FROM public.jobs WHERE id = p_job_id FOR UPDATE;
  IF v_job.id IS NULL THEN RAISE EXCEPTION 'job_not_found'; END IF;
  IF v_job.client_id <> v_uid THEN RAISE EXCEPTION 'not_authorized'; END IF;
  IF v_job.status <> 'open' THEN RAISE EXCEPTION 'job_not_open'; END IF;

  SELECT * INTO v_bid FROM public.bids WHERE id = p_bid_id AND job_id = p_job_id FOR UPDATE;
  IF v_bid.id IS NULL THEN RAISE EXCEPTION 'bid_not_found'; END IF;

  -- Accept bid, reject others, book job
  UPDATE public.bids SET status = 'accepted' WHERE id = v_bid.id;
  UPDATE public.bids SET status = 'rejected' WHERE job_id = p_job_id AND id <> v_bid.id AND status = 'pending';
  UPDATE public.jobs
    SET status = 'booked', accepted_bid_id = v_bid.id, assigned_provider_id = v_bid.provider_id, updated_at = NOW()
    WHERE id = p_job_id;

  -- Ensure a chat channel exists
  INSERT INTO public.chat_channels(id, job_id, booking_id, client_id, provider_id)
  SELECT gen_random_uuid(), p_job_id, NULL, v_job.client_id, v_bid.provider_id
  WHERE NOT EXISTS (
    SELECT 1 FROM public.chat_channels c WHERE c.job_id = p_job_id AND c.client_id = v_job.client_id AND c.provider_id = v_bid.provider_id
  );

  -- Create a booking immediately
  INSERT INTO public.bookings (
    id, customer_id, service_id, scheduled_date, status, total_price, payment_status,
    address_id, notes, professional_id, created_at, updated_at
  ) VALUES (
    v_booking_id, v_job.client_id, v_job.service_id, p_scheduled_at, 'confirmed', p_total_price, 'pending',
    p_address_id, v_job.description, v_bid.provider_id, NOW(), NOW()
  );

  -- Audit logs
  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (v_uid, 'bid_accepted', 'job', p_job_id, jsonb_build_object('bid_id', p_bid_id, 'provider_id', v_bid.provider_id));

  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (v_uid, 'booking_created_from_job', 'booking', v_booking_id, jsonb_build_object('job_id', p_job_id));

  RETURN v_booking_id;
END;
$$;

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_addresses_updated_at BEFORE UPDATE ON public.addresses FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_services_updated_at BEFORE UPDATE ON public.services FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON public.bookings FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_reviews_updated_at BEFORE UPDATE ON public.reviews FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_availability_slots_updated_at BEFORE UPDATE ON public.availability_slots FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_blocked_periods_updated_at BEFORE UPDATE ON public.blocked_periods FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_audit_logs_updated_at BEFORE UPDATE ON public.audit_logs FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_messages_updated_at BEFORE UPDATE ON public.messages FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_verification_documents_updated_at BEFORE UPDATE ON public.verification_documents FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_professional_profiles_updated_at BEFORE UPDATE ON public.professional_profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_jobs_updated_at BEFORE UPDATE ON public.jobs FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
CREATE TRIGGER update_bids_updated_at BEFORE UPDATE ON public.bids FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Realtime-friendly logging triggers
CREATE TRIGGER log_job_status_change AFTER UPDATE OF status ON public.jobs
FOR EACH ROW WHEN (OLD.status IS DISTINCT FROM NEW.status)
EXECUTE FUNCTION public.fn_log_job_status_change();

CREATE TRIGGER log_bid_created AFTER INSERT ON public.bids
FOR EACH ROW EXECUTE FUNCTION public.fn_log_bid_created();

CREATE OR REPLACE FUNCTION public.is_admin(uid uuid) RETURNS boolean LANGUAGE sql STABLE AS $$
  SELECT EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = uid AND p.role IN ('admin'::public.user_role_enum, 'moderator'::public.user_role_enum));
$$;

CREATE OR REPLACE FUNCTION public.fn_admin_verify_kyc(p_verification_id uuid, p_decision text, p_note text DEFAULT NULL) RETURNS void LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE
  v_uid uuid := auth.uid();
  v_new_status public.verification_status_enum;
  v_row RECORD;
BEGIN
  IF NOT public.is_admin(v_uid) THEN RAISE EXCEPTION 'not_authorized'; END IF;
  IF p_decision NOT IN ('verified', 'rejected') THEN RAISE EXCEPTION 'invalid_decision %', p_decision; END IF;
  v_new_status := p_decision::public.verification_status_enum;
  UPDATE public.verification_documents vd SET status = v_new_status, verification_date = NOW(), notes = COALESCE(p_note, vd.notes) WHERE vd.id = p_verification_id;
  SELECT vd.*, p.full_name INTO v_row FROM public.verification_documents vd JOIN public.profiles p ON p.id = vd.profile_id WHERE vd.id = p_verification_id;
  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (v_uid, CASE WHEN v_new_status = 'verified' THEN 'kyc_verified' ELSE 'kyc_rejected' END, 'verification_document', p_verification_id, jsonb_build_object('profile_id', v_row.profile_id, 'full_name', v_row.full_name, 'new_status', v_new_status, 'note', p_note));
END;
$$;


-- ============================================================================
-- SECTION 6: ROW LEVEL SECURITY (RLS)
-- Sets up RLS policies for data access control.
-- ============================================================================
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public profiles are viewable by everyone." ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can insert their own profile." ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update own profile." ON public.profiles FOR UPDATE USING (auth.uid() = id);

ALTER TABLE public.professional_profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Professional profiles viewable by everyone" ON public.professional_profiles FOR SELECT USING (true);
CREATE POLICY "Providers can insert professional profile" ON public.professional_profiles FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "Providers can update professional profile" ON public.professional_profiles FOR UPDATE USING (user_id = auth.uid());

ALTER TABLE public.jobs ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Clients can view their jobs" ON public.jobs FOR SELECT USING (client_id = auth.uid());
-- Providers can view active jobs within radius and matching category
CREATE POLICY "Providers can view active jobs" ON public.jobs
FOR SELECT USING (
  status = 'open'
  AND EXISTS (
    SELECT 1
    FROM public.professional_profiles pp
    JOIN public.profiles pr ON pr.id = pp.user_id
    WHERE pp.user_id = auth.uid()
      AND (pp.service_types IS NULL OR public.jobs.service_type = ANY(pp.service_types))
      AND (
        pr.location IS NULL OR public.jobs.location IS NULL
        OR ST_DWithin(pr.location, public.jobs.location, (pp.service_radius_km::double precision * 1000.0))
      )
  )
);
CREATE POLICY "Clients can insert jobs" ON public.jobs FOR INSERT WITH CHECK (client_id = auth.uid());
CREATE POLICY "Clients can update their jobs" ON public.jobs FOR UPDATE USING (client_id = auth.uid());

ALTER TABLE public.bids ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Providers can view their bids" ON public.bids FOR SELECT USING (provider_id = auth.uid());
CREATE POLICY "Clients can view bids on their jobs" ON public.bids FOR SELECT USING (EXISTS (SELECT 1 FROM public.jobs WHERE id = job_id AND client_id = auth.uid()));
-- Providers can bid on open jobs they didn't post
CREATE POLICY "Providers can insert bids" ON public.bids
FOR INSERT WITH CHECK (
  provider_id = auth.uid()
  AND EXISTS (
    SELECT 1 FROM public.jobs j
    WHERE j.id = job_id AND j.status = 'open' AND j.client_id <> auth.uid()
  )
);
CREATE POLICY "Providers can update their bids" ON public.bids FOR UPDATE USING (provider_id = auth.uid());

ALTER TABLE public.chat_channels ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Participants can view chat channels" ON public.chat_channels FOR SELECT USING (client_id = auth.uid() OR provider_id = auth.uid());

-- Only the job client or assigned provider can create channel rows for a job
CREATE POLICY "Participants can create chat channels" ON public.chat_channels
FOR INSERT WITH CHECK (
  (
    job_id IS NOT NULL
    AND EXISTS (
      SELECT 1 FROM public.jobs j
      WHERE j.id = job_id
        AND public.chat_channels.client_id = j.client_id
        AND (
          -- Either the client creates it
          auth.uid() = j.client_id OR
          -- Or the assigned provider creates it
          auth.uid() = j.assigned_provider_id
        )
        AND public.chat_channels.provider_id = j.assigned_provider_id
    )
  ) OR (
    booking_id IS NOT NULL
    AND EXISTS (
      SELECT 1 FROM public.bookings b
      WHERE b.id = booking_id
        AND (
          auth.uid() = b.customer_id OR auth.uid() = b.professional_id
        )
    )
  )
);

-- Messages RLS: restrict channel-based messages to channel participants
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Participants can view channel messages" ON public.messages FOR SELECT USING (
  channel_id IS NULL OR EXISTS (
    SELECT 1 FROM public.chat_channels c WHERE c.id = channel_id AND (c.client_id = auth.uid() OR c.provider_id = auth.uid())
  )
);
CREATE POLICY "Participants can send channel messages" ON public.messages FOR INSERT WITH CHECK (
  sender_id = auth.uid() AND (
    channel_id IS NULL OR EXISTS (
      SELECT 1 FROM public.chat_channels c WHERE c.id = channel_id AND (c.client_id = auth.uid() OR c.provider_id = auth.uid())
    )
  )
);

ALTER TABLE public.verification_documents ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Admins can view all KYC documents" ON public.verification_documents FOR SELECT USING (public.is_admin(auth.uid()));
CREATE POLICY "Admins can update KYC documents" ON public.verification_documents FOR UPDATE USING (public.is_admin(auth.uid())) WITH CHECK (public.is_admin(auth.uid()));
CREATE POLICY "Users can view their own documents." ON public.verification_documents FOR SELECT USING (auth.uid() = profile_id);