-- Admin Users search performance indexes
-- Date: 2025-09-13 22:38:00+01:00
-- Purpose: Speed up role filtering and ilike searches on full_name and phone_number

-- Ensure pg_trgm extension is available (use the standard 'extensions' schema per Supabase convention)
create schema if not exists extensions;
create extension if not exists pg_trgm with schema extensions;

-- Optional: enable if missing (most Supabase projects have it available already)
-- create extension if not exists btree_gin with schema extensions;

-- Create GIN trigram indexes for fast ilike on name and phone
create index if not exists idx_profiles_full_name_trgm
  on public.profiles using gin (full_name gin_trgm_ops);

create index if not exists idx_profiles_phone_trgm
  on public.profiles using gin (phone_number gin_trgm_ops);

-- Role filter is frequent; a regular btree index is appropriate
create index if not exists idx_profiles_role
  on public.profiles (role);

-- Optional composite index for combined filters (role + name search prefix)
-- Note: Trigram ops cannot be part of a composite in a meaningful way with ilike,
-- keep separate indexes and let the planner choose. If you commonly sort by created_at,
-- consider this index to help pagination performance:
create index if not exists idx_profiles_created_at
  on public.profiles (created_at desc);
