-- ============================================================================
-- TIDARO STAGING ENVIRONMENT SCHEMA
-- Version: 2.0-staging
-- Description: Staging schema for pre-production testing with production-like settings
-- Architecture: Clean Architecture with DRY principles
-- ============================================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Staging configuration (production-like but with some debugging)
SET log_statement = 'mod';
SET log_min_duration_statement = 500;

-- ============================================================================
-- CORE DOMAIN TABLES (Same as production)
-- ============================================================================

-- Users table (extends Supabase auth.users)
CREATE TABLE public.users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL UNIQUE,
    phone_number TEXT,
    role TEXT NOT NULL CHECK (role IN ('client', 'professional', 'admin', 'moderator')) DEFAULT 'client',
    status TEXT NOT NULL CHECK (status IN ('active', 'inactive', 'suspended', 'pending')) DEFAULT 'pending',
    verification_status TEXT NOT NULL CHECK (verification_status IN ('unverified', 'pending', 'verified', 'rejected', 'expired')) DEFAULT 'unverified',
    kyc_level TEXT NOT NULL CHECK (kyc_level IN ('none', 'basic', 'enhanced', 'premium')) DEFAULT 'none',
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    -- Staging-specific field for test identification
    is_test_data BOOLEAN DEFAULT FALSE
);

-- User Profiles (polymorphic: client_profiles and professional_profiles)
CREATE TABLE public.user_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    profile_type TEXT NOT NULL CHECK (profile_type IN ('client', 'professional')),
    email TEXT NOT NULL,
    full_name TEXT,
    phone TEXT,
    is_public BOOLEAN DEFAULT FALSE,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, profile_type)
);

-- Client-specific profile data
CREATE TABLE public.client_profiles (
    user_profile_id UUID PRIMARY KEY REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    bio TEXT,
    date_of_birth DATE,
    gender TEXT CHECK (gender IN ('male', 'female', 'other', 'prefer_not_to_say')),
    occupation TEXT,
    emergency_contact JSONB,
    preferences JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Professional-specific profile data
CREATE TABLE public.professional_profiles (
    user_profile_id UUID PRIMARY KEY REFERENCES public.user_profiles(id) ON DELETE CASCADE,
    business_name TEXT,
    bio TEXT,
    years_of_experience INTEGER DEFAULT 0,
    hourly_rate DECIMAL(10,2),
    service_radius_km INTEGER DEFAULT 10,
    rating DECIMAL(3,2) DEFAULT 0.0 CHECK (rating >= 0 AND rating <= 5),
    total_reviews INTEGER DEFAULT 0,
    total_bookings INTEGER DEFAULT 0,
    response_time_minutes INTEGER DEFAULT 60,
    availability_status TEXT CHECK (availability_status IN ('available', 'busy', 'offline')) DEFAULT 'offline',
    skills TEXT[],
    certifications TEXT[],
    languages TEXT[],
    background_check_status TEXT CHECK (background_check_status IN ('not_required', 'pending', 'passed', 'failed')) DEFAULT 'not_required',
    insurance_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Addresses
CREATE TABLE public.addresses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    type TEXT NOT NULL CHECK (type IN ('home', 'work', 'other')),
    street_address TEXT NOT NULL,
    apartment_unit TEXT,
    city TEXT NOT NULL,
    state_province TEXT NOT NULL,
    postal_code TEXT NOT NULL,
    country TEXT NOT NULL DEFAULT 'US',
    location GEOGRAPHY(POINT, 4326),
    special_instructions TEXT,
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Services
CREATE TABLE public.services (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    professional_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    category TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2) NOT NULL,
    rate_type TEXT NOT NULL CHECK (rate_type IN ('hourly', 'fixed', 'per_item')) DEFAULT 'hourly',
    estimated_duration_minutes INTEGER,
    tasks TEXT[],
    requirements TEXT[],
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Bookings
CREATE TABLE public.bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    professional_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    service_id UUID NOT NULL REFERENCES public.services(id) ON DELETE CASCADE,
    address_id UUID NOT NULL REFERENCES public.addresses(id) ON DELETE CASCADE,
    status TEXT NOT NULL CHECK (status IN ('pending', 'confirmed', 'in_progress', 'completed', 'cancelled', 'rescheduled')) DEFAULT 'pending',
    scheduled_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    duration_minutes INTEGER NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    payment_status TEXT CHECK (payment_status IN ('pending', 'paid', 'refunded', 'failed')) DEFAULT 'pending',
    is_recurring BOOLEAN DEFAULT FALSE,
    recurrence_pattern JSONB,
    special_instructions TEXT,
    attachments TEXT[],
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Availability
CREATE TABLE public.availability (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    professional_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Time Slots
CREATE TABLE public.time_slots (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    availability_id UUID NOT NULL REFERENCES public.availability(id) ON DELETE CASCADE,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_booked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Payments
CREATE TABLE public.payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES public.bookings(id) ON DELETE CASCADE,
    payer_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    payee_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL,
    platform_fee DECIMAL(10,2) DEFAULT 0,
    payment_method TEXT NOT NULL CHECK (payment_method IN ('credit_card', 'debit_card', 'paypal', 'bank_transfer', 'cash')),
    status TEXT NOT NULL CHECK (status IN ('pending', 'processing', 'completed', 'failed', 'refunded', 'cancelled')) DEFAULT 'pending',
    transaction_id TEXT UNIQUE,
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Reviews
CREATE TABLE public.reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES public.bookings(id) ON DELETE CASCADE,
    reviewer_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    reviewee_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    overall_rating INTEGER NOT NULL CHECK (overall_rating >= 1 AND overall_rating <= 5),
    aspect_ratings JSONB,
    comment TEXT,
    images TEXT[],
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(booking_id, reviewer_id)
);

-- Communication - Chats
CREATE TABLE public.chats (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES public.bookings(id) ON DELETE CASCADE,
    created_by UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    last_message_at TIMESTAMPTZ,
    unread_count INTEGER DEFAULT 0,
    is_encrypted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    last_activity_at TIMESTAMPTZ DEFAULT NOW()
);

-- Chat Members
CREATE TABLE public.chat_members (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    chat_id UUID NOT NULL REFERENCES public.chats(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    role TEXT CHECK (role IN ('admin', 'member')) DEFAULT 'member',
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    last_read_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(chat_id, user_id)
);

-- Messages
CREATE TABLE public.messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    chat_id UUID NOT NULL REFERENCES public.chats(id) ON DELETE CASCADE,
    sender_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    message_type TEXT NOT NULL CHECK (message_type IN ('text', 'image', 'file', 'system')) DEFAULT 'text',
    content TEXT,
    attachment_url TEXT,
    status TEXT CHECK (status IN ('sent', 'delivered', 'read')) DEFAULT 'sent',
    deleted_at TIMESTAMPTZ,
    metadata JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- KYC Documents
CREATE TABLE public.kyc_documents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    document_type TEXT NOT NULL CHECK (document_type IN ('passport', 'drivers_license', 'national_id', 'utility_bill', 'bank_statement')),
    document_url TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'approved', 'rejected', 'expired')) DEFAULT 'pending',
    expiry_date DATE,
    verification_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Certifications
CREATE TABLE public.certifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    professional_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    issuing_organization TEXT NOT NULL,
    credential_id TEXT,
    issue_date DATE NOT NULL,
    expiry_date DATE,
    verification_url TEXT,
    document_url TEXT,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Notifications
CREATE TABLE public.notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    data JSONB,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- User Settings
CREATE TABLE public.user_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL UNIQUE REFERENCES public.users(id) ON DELETE CASCADE,
    notification_preferences JSONB DEFAULT '{}',
    privacy_settings JSONB DEFAULT '{}',
    app_preferences JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Jobs (background processing)
CREATE TABLE public.jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type TEXT NOT NULL,
    payload JSONB NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending', 'processing', 'completed', 'failed', 'retrying')) DEFAULT 'pending',
    attempts INTEGER DEFAULT 0,
    max_attempts INTEGER DEFAULT 3,
    scheduled_at TIMESTAMPTZ DEFAULT NOW(),
    started_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    error_message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Activity Logs
CREATE TABLE public.activity_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.users(id) ON DELETE SET NULL,
    action TEXT NOT NULL,
    resource_type TEXT,
    resource_id UUID,
    metadata JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- STAGING-SPECIFIC TABLES
-- ============================================================================

-- Test execution tracking
CREATE TABLE public.staging_test_runs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    test_suite TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('running', 'passed', 'failed', 'skipped')),
    start_time TIMESTAMPTZ DEFAULT NOW(),
    end_time TIMESTAMPTZ,
    results JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- INDEXES (Production-like with staging optimizations)
-- ============================================================================

-- Critical indexes
CREATE INDEX CONCURRENTLY idx_users_email ON public.users(email);
CREATE INDEX CONCURRENTLY idx_users_role_status ON public.users(role, status);
CREATE INDEX CONCURRENTLY idx_users_test_data ON public.users(is_test_data);

-- User profile indexes
CREATE INDEX CONCURRENTLY idx_user_profiles_user_id ON public.user_profiles(user_id);
CREATE INDEX CONCURRENTLY idx_user_profiles_type ON public.user_profiles(profile_type);

-- Professional profile indexes
CREATE INDEX CONCURRENTLY idx_professional_profiles_rating ON public.professional_profiles(rating);
CREATE INDEX CONCURRENTLY idx_professional_profiles_availability ON public.professional_profiles(availability_status);

-- Booking indexes
CREATE INDEX CONCURRENTLY idx_bookings_client_id ON public.bookings(client_id);
CREATE INDEX CONCURRENTLY idx_bookings_professional_id ON public.bookings(professional_id);
CREATE INDEX CONCURRENTLY idx_bookings_status ON public.bookings(status);
CREATE INDEX CONCURRENTLY idx_bookings_scheduled_date ON public.bookings(scheduled_date);

-- Service indexes
CREATE INDEX CONCURRENTLY idx_services_professional_id ON public.services(professional_id);
CREATE INDEX CONCURRENTLY idx_services_category ON public.services(category);
CREATE INDEX CONCURRENTLY idx_services_active ON public.services(is_active);

-- Payment indexes
CREATE INDEX CONCURRENTLY idx_payments_booking_id ON public.payments(booking_id);
CREATE INDEX CONCURRENTLY idx_payments_status ON public.payments(status);

-- Review indexes
CREATE INDEX CONCURRENTLY idx_reviews_reviewee_id ON public.reviews(reviewee_id);
CREATE INDEX CONCURRENTLY idx_reviews_rating ON public.reviews(overall_rating);

-- Communication indexes
CREATE INDEX CONCURRENTLY idx_chats_booking_id ON public.chats(booking_id);
CREATE INDEX CONCURRENTLY idx_messages_chat_id ON public.messages(chat_id);
CREATE INDEX CONCURRENTLY idx_chat_members_user_id ON public.chat_members(user_id);

-- Notification indexes
CREATE INDEX CONCURRENTLY idx_notifications_user_id ON public.notifications(user_id);
CREATE INDEX CONCURRENTLY idx_notifications_read ON public.notifications(is_read);

-- ============================================================================
-- TRIGGERS AND FUNCTIONS
-- ============================================================================

-- Updated timestamp trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply triggers to key tables
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_profiles_updated_at BEFORE UPDATE ON public.user_profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON public.bookings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Professional rating update function
CREATE OR REPLACE FUNCTION update_professional_rating()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.professional_profiles 
    SET 
        rating = (
            SELECT COALESCE(AVG(overall_rating), 0) 
            FROM public.reviews 
            WHERE reviewee_id = NEW.reviewee_id
        ),
        total_reviews = (
            SELECT COUNT(*) 
            FROM public.reviews 
            WHERE reviewee_id = NEW.reviewee_id
        )
    WHERE user_profile_id = (
        SELECT id FROM public.user_profiles 
        WHERE user_id = NEW.reviewee_id AND profile_type = 'professional'
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_professional_rating_trigger
    AFTER INSERT OR UPDATE ON public.reviews
    FOR EACH ROW
    EXECUTE FUNCTION update_professional_rating();

-- Chat activity update function
CREATE OR REPLACE FUNCTION update_chat_activity()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.chats 
    SET last_activity_at = NOW()
    WHERE id = NEW.chat_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_chat_activity_trigger
    AFTER INSERT ON public.messages
    FOR EACH ROW
    EXECUTE FUNCTION update_chat_activity();

-- ============================================================================
-- ROW LEVEL SECURITY (Production-like with test data access)
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.client_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.professional_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.services ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.chats ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;

-- Staging policies (production-like but with test data access)
CREATE POLICY "Users can view own data and test data" ON public.users FOR SELECT USING (
    auth.uid() = id OR is_test_data = true
);
CREATE POLICY "Users can update own data" ON public.users FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "View own and public profiles" ON public.user_profiles FOR SELECT USING (
    user_id = auth.uid() OR is_public = true OR 
    EXISTS (SELECT 1 FROM public.users WHERE id = user_id AND is_test_data = true)
);

CREATE POLICY "Users can manage own addresses" ON public.addresses FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "View active services" ON public.services FOR SELECT USING (is_active = true);
CREATE POLICY "Professionals can manage own services" ON public.services FOR ALL USING (auth.uid() = professional_id);

CREATE POLICY "Users can view own bookings" ON public.bookings FOR SELECT USING (
    auth.uid() = client_id OR auth.uid() = professional_id
);
CREATE POLICY "Users can create bookings as client" ON public.bookings FOR INSERT WITH CHECK (auth.uid() = client_id);
CREATE POLICY "Users can update own bookings" ON public.bookings FOR UPDATE USING (
    auth.uid() = client_id OR auth.uid() = professional_id
);

CREATE POLICY "Users can view own payments" ON public.payments FOR SELECT USING (
    auth.uid() = payer_id OR auth.uid() = payee_id
);

CREATE POLICY "Users can view reviews" ON public.reviews FOR SELECT USING (true);
CREATE POLICY "Users can create reviews for own bookings" ON public.reviews FOR INSERT WITH CHECK (
    auth.uid() = reviewer_id AND 
    EXISTS (SELECT 1 FROM public.bookings WHERE id = booking_id AND (client_id = auth.uid() OR professional_id = auth.uid()))
);

CREATE POLICY "Users can view chats they're members of" ON public.chats FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.chat_members WHERE chat_id = id AND user_id = auth.uid())
);

CREATE POLICY "Users can view own notifications" ON public.notifications FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update own notifications" ON public.notifications FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can manage own settings" ON public.user_settings FOR ALL USING (auth.uid() = user_id);

COMMENT ON DATABASE postgres IS 'TiDaro platform database - STAGING environment for pre-production testing';
