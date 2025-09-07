-- 02_analytics_views.sql
-- Lightweight analytics views for TiDash KPIs
-- NOTE: Views are based on the initial schema in migrations/20250106000000_initial_tidash_schema.sql
-- Only safe, existing columns/tables are referenced. Extend as more tables land (reviews, sessions, support_tickets, providers).

-- Helper: bookings normalized to day
DROP VIEW IF EXISTS public.v_kpi_bookings_daily CASCADE;
CREATE VIEW public.v_kpi_bookings_daily AS
SELECT
  date_trunc('day', booking_date) AS day,
  COUNT(*)::bigint                           AS total_bookings,
  COUNT(*) FILTER (WHERE status = 'confirmed')::bigint AS confirmed_bookings,
  COUNT(*) FILTER (WHERE status = 'cancelled')::bigint AS cancelled_bookings,
  COUNT(*) FILTER (WHERE status = 'completed')::bigint AS completed_bookings,
  COALESCE(SUM(total_amount), 0)::numeric    AS revenue_total
FROM public.bookings
GROUP BY 1
ORDER BY 1;

-- Cancellation rate per day
DROP VIEW IF EXISTS public.v_kpi_cancellation_rate_daily CASCADE;
CREATE VIEW public.v_kpi_cancellation_rate_daily AS
SELECT
  day,
  cancelled_bookings,
  total_bookings,
  CASE WHEN total_bookings > 0
       THEN ROUND((cancelled_bookings::numeric / total_bookings::numeric) * 100, 2)
       ELSE 0
  END AS cancellation_rate_percent
FROM public.v_kpi_bookings_daily
ORDER BY day;

-- Fulfillment rate per day (completed over confirmed)
DROP VIEW IF EXISTS public.v_kpi_fulfillment_rate_daily CASCADE;
CREATE VIEW public.v_kpi_fulfillment_rate_daily AS
SELECT
  day,
  completed_bookings,
  NULLIF(confirmed_bookings, 0) AS confirmed_bookings,
  CASE WHEN confirmed_bookings > 0
       THEN ROUND((completed_bookings::numeric / confirmed_bookings::numeric) * 100, 2)
       ELSE 0
  END AS fulfillment_rate_percent
FROM public.v_kpi_bookings_daily
ORDER BY day;

-- Revenue per day
DROP VIEW IF EXISTS public.v_kpi_revenue_daily CASCADE;
CREATE VIEW public.v_kpi_revenue_daily AS
SELECT
  day,
  revenue_total
FROM public.v_kpi_bookings_daily
ORDER BY day;

-- Overall summary snapshot (to be used for header metrics)
DROP VIEW IF EXISTS public.v_kpi_metrics_summary CASCADE;
CREATE VIEW public.v_kpi_metrics_summary AS
WITH b AS (
  SELECT * FROM public.v_kpi_bookings_daily
),
agg AS (
  SELECT
    COALESCE(SUM(total_bookings), 0)::bigint    AS total_bookings,
    COALESCE(SUM(confirmed_bookings), 0)::bigint AS confirmed_bookings,
    COALESCE(SUM(cancelled_bookings), 0)::bigint AS cancelled_bookings,
    COALESCE(SUM(completed_bookings), 0)::bigint AS completed_bookings,
    COALESCE(SUM(revenue_total), 0)::numeric    AS revenue_total
  FROM b
)
SELECT
  total_bookings,
  confirmed_bookings,
  cancelled_bookings,
  completed_bookings,
  revenue_total,
  CASE WHEN total_bookings > 0
       THEN ROUND((cancelled_bookings::numeric / total_bookings::numeric) * 100, 2)
       ELSE 0 END AS cancellation_rate_percent,
  CASE WHEN confirmed_bookings > 0
       THEN ROUND((completed_bookings::numeric / confirmed_bookings::numeric) * 100, 2)
       ELSE 0 END AS fulfillment_rate_percent
FROM agg;

-- PLACEHOLDERS (to be implemented when respective tables exist):
-- 1) Time to Book (requires sessions table with session_start_at and bookings.confirmed_at)
-- 2) On-time Completion Rate (requires bookings.scheduled_end_at, bookings.completed_at)
-- 3) Provider Utilization/Retention (requires providers/profiles scheduling tables)
-- 4) CSAT/NPS (requires reviews/surveys tables)
-- 5) Support Ticket Rate (requires support_tickets table)
