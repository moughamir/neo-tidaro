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

CREATE TABLE services (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    name TEXT NOT NULL,
    description TEXT,
    base_price NUMERIC(10, 2),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE provider_availabilities (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    provider_id UUID NOT NULL REFERENCES profiles(user_id) ON DELETE CASCADE,
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    UNIQUE (provider_id, start_time, end_time)
);

CREATE TABLE bookings (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    customer_id UUID NOT NULL REFERENCES profiles(user_id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES profiles(user_id) ON DELETE CASCADE,
    service_id UUID NOT NULL REFERENCES services(id),
    booking_time_start TIMESTAMPTZ NOT NULL,
    booking_time_end TIMESTAMPTZ NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('requested', 'confirmed', 'completed', 'canceled_by_customer', 'canceled_by_provider')),
    total_price NUMERIC(10, 2),
    location_address TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    booking_id UUID UNIQUE NOT NULL REFERENCES bookings(id) ON DELETE CASCADE, -- Each booking can only have one review
    reviewer_id UUID NOT NULL REFERENCES profiles(user_id) ON DELETE CASCADE,
    reviewee_id UUID NOT NULL REFERENCES profiles(user_id) ON DELETE CASCADE,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE chats (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  booking_id UUID REFERENCES bookings(id) ON DELETE SET NULL,
  created_by UUID NOT NULL REFERENCES profiles(user_id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE chat_members (
  chat_id UUID REFERENCES chats (id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(user_id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('participant', 'moderator')),
  added_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (chat_id, user_id)
);

CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  chat_id UUID NOT NULL REFERENCES chats (id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES profiles(user_id) ON DELETE CASCADE,
  content TEXT,
  attachment_url TEXT,
  message_type TEXT NOT NULL DEFAULT 'text' CHECK (message_type IN ('text', 'image', 'file', 'system')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  edited_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX idx_messages_chat_id_created_at ON messages (chat_id, created_at);

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

CREATE TABLE activity_log (
    id UUID PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
    actor_id UUID REFERENCES profiles(user_id),
    action_type TEXT NOT NULL, -- e.g., 'message.flagged', 'user.login', 'booking.created'
    target_id UUID,
    target_table TEXT, -- e.g., 'messages', 'bookings'
    payload JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
