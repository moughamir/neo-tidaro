-- Housekeeping MVP Schema Extension for TiDaro Platform
-- Extends existing schema for housekeeping service booking with bidding system

-- NOTE: Use canonical public.service_category_enum defined in consolidated schema

-- NOTE: Use canonical public.job_status defined in consolidated schema

-- NOTE: Use canonical public.bid_status defined in consolidated schema

-- Extend existing profiles table with housekeeping fields
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS email TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS address_text TEXT;
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS city TEXT DEFAULT 'Casablanca';
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS latitude DECIMAL(10,8);
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS longitude DECIMAL(11,8);
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS verification_status verification_status_enum DEFAULT 'pending';

-- Make email unique if not already
CREATE UNIQUE INDEX IF NOT EXISTS profiles_email_key ON profiles(email);

-- Provider-specific profiles for housekeeping
CREATE TABLE housekeeping_provider_profiles (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE UNIQUE,
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

-- Extend existing services table with housekeeping multilingual support
ALTER TABLE services ADD COLUMN IF NOT EXISTS name_fr TEXT;
ALTER TABLE services ADD COLUMN IF NOT EXISTS name_ar TEXT;
ALTER TABLE services ADD COLUMN IF NOT EXISTS suggested_price_mad DECIMAL(10,2);

-- Job requests posted by clients for housekeeping services
CREATE TABLE housekeeping_jobs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  service_id UUID REFERENCES services(id),
  title TEXT NOT NULL,
  description TEXT,
  service_type public.service_category_enum NOT NULL,
  address_text TEXT NOT NULL,
  latitude DECIMAL(10,8),
  longitude DECIMAL(11,8),
  number_of_rooms INTEGER,
  number_of_bathrooms INTEGER,
  preferred_date DATE,
  preferred_time_start TIME,
  estimated_duration_hours DECIMAL(4,2) DEFAULT 2.0,
  budget_min_mad DECIMAL(10,2),
  budget_max_mad DECIMAL(10,2),
  status public.job_status DEFAULT 'draft',
  accepted_bid_id UUID,
  assigned_provider_id UUID REFERENCES profiles(id),
  special_instructions TEXT,
  posted_at TIMESTAMP WITH TIME ZONE,
  scheduled_start TIMESTAMP WITH TIME ZONE,
  completed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Bids submitted by providers (InDrive-style)
CREATE TABLE housekeeping_bids (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  job_id UUID REFERENCES housekeeping_jobs(id) ON DELETE CASCADE,
  provider_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  amount_mad DECIMAL(10,2) NOT NULL,
  message TEXT,
  estimated_duration_hours DECIMAL(4,2),
  status public.bid_status DEFAULT 'pending',
  expires_at TIMESTAMP WITH TIME ZONE DEFAULT (NOW() + INTERVAL '24 hours'),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(job_id, provider_id)
);

-- Chat channels for job communication  
CREATE TABLE housekeeping_chat_channels (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  job_id UUID REFERENCES housekeeping_jobs(id) ON DELETE CASCADE UNIQUE,
  client_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  provider_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Chat messages for housekeeping jobs
CREATE TABLE housekeeping_chat_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  channel_id UUID REFERENCES housekeeping_chat_channels(id) ON DELETE CASCADE,
  sender_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  message_text TEXT,
  message_type TEXT DEFAULT 'text',
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_housekeeping_jobs_status ON housekeeping_jobs(status);
CREATE INDEX idx_housekeeping_jobs_service_type ON housekeeping_jobs(service_type);
CREATE INDEX idx_housekeeping_jobs_client_id ON housekeeping_jobs(client_id);
CREATE INDEX idx_housekeeping_bids_job_id ON housekeeping_bids(job_id);
CREATE INDEX idx_housekeeping_bids_provider_id ON housekeeping_bids(provider_id);
CREATE INDEX idx_housekeeping_provider_profiles_user_id ON housekeeping_provider_profiles(user_id);

-- Row Level Security for new tables
ALTER TABLE housekeeping_provider_profiles ENABLE ROW LEVEL SECURITY; 
ALTER TABLE housekeeping_jobs ENABLE ROW LEVEL SECURITY;
ALTER TABLE housekeeping_bids ENABLE ROW LEVEL SECURITY;
ALTER TABLE housekeeping_chat_channels ENABLE ROW LEVEL SECURITY;
ALTER TABLE housekeeping_chat_messages ENABLE ROW LEVEL SECURITY;

-- RLS policies for housekeeping tables
CREATE POLICY "Housekeeping provider profiles viewable by everyone" ON housekeeping_provider_profiles FOR SELECT USING (true);
CREATE POLICY "Providers can insert housekeeping profile" ON housekeeping_provider_profiles FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "Providers can update housekeeping profile" ON housekeeping_provider_profiles FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "Clients can view their housekeeping jobs" ON housekeeping_jobs FOR SELECT USING (client_id = auth.uid());
CREATE POLICY "Providers can view active housekeeping jobs" ON housekeeping_jobs FOR SELECT USING (
  status IN ('posted', 'receiving_bids') AND EXISTS (
    SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('client_provider')
  )
);
CREATE POLICY "Clients can insert housekeeping jobs" ON housekeeping_jobs FOR INSERT WITH CHECK (client_id = auth.uid());
CREATE POLICY "Clients can update their housekeeping jobs" ON housekeeping_jobs FOR UPDATE USING (client_id = auth.uid());

CREATE POLICY "Providers can view their housekeeping bids" ON housekeeping_bids FOR SELECT USING (provider_id = auth.uid());
CREATE POLICY "Clients can view bids on their housekeeping jobs" ON housekeeping_bids FOR SELECT USING (
  EXISTS (SELECT 1 FROM housekeeping_jobs WHERE housekeeping_jobs.id = housekeeping_bids.job_id AND housekeeping_jobs.client_id = auth.uid())
);
CREATE POLICY "Providers can insert housekeeping bids" ON housekeeping_bids FOR INSERT WITH CHECK (provider_id = auth.uid());
CREATE POLICY "Providers can update their housekeeping bids" ON housekeeping_bids FOR UPDATE USING (provider_id = auth.uid());

CREATE POLICY "Job participants can view housekeeping chat" ON housekeeping_chat_channels FOR SELECT USING (
  client_id = auth.uid() OR provider_id = auth.uid()
);

CREATE POLICY "Job participants can view housekeeping messages" ON housekeeping_chat_messages FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM housekeeping_chat_channels WHERE id = channel_id 
    AND (client_id = auth.uid() OR provider_id = auth.uid())
  )
);

CREATE POLICY "Job participants can send housekeeping messages" ON housekeeping_chat_messages FOR INSERT WITH CHECK (
  sender_id = auth.uid() AND EXISTS (
    SELECT 1 FROM housekeeping_chat_channels WHERE id = channel_id 
    AND (client_id = auth.uid() OR provider_id = auth.uid())
  )
);
