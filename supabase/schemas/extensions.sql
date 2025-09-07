-- Enable commonly used PostgreSQL extensions for Supabase

-- Provides functions to generate UUIDs (e.g., uuid_generate_v4())
-- Although gen_random_uuid() is built-in since PG 13, uuid-ossp is often useful.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enables HTTP requests from PostgreSQL functions (used by Supabase Edge Functions)
CREATE EXTENSION IF NOT EXISTS "pg_net";

-- Provides a means to track execution statistics of all SQL statements executed by a server
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";

-- Enables scheduling of recurring tasks directly within the database
CREATE EXTENSION IF NOT EXISTS "pg_cron";
