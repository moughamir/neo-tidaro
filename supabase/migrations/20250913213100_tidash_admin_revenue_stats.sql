-- TiDash Backoffice: Revenue & Statistics Views
-- Created: 2025-09-13 21:31:00+01:00

-- Revenue summary: total and current month
CREATE OR REPLACE VIEW public.v_admin_revenue_summary AS
WITH paid AS (
  SELECT
    COALESCE(SUM(amount), 0)::numeric AS total_revenue
  FROM public.payments
  WHERE status = 'paid'::public.payment_status_enum
),
month_paid AS (
  SELECT
    COALESCE(SUM(amount), 0)::numeric AS monthly_revenue
  FROM public.payments
  WHERE status = 'paid'::public.payment_status_enum
    AND date_trunc('month', payment_date) = date_trunc('month', NOW())
)
SELECT
  paid.total_revenue,
  month_paid.monthly_revenue
FROM paid, month_paid;

-- Booking statistics: counts and basic completion/confirmation rates
CREATE OR REPLACE VIEW public.v_admin_booking_stats AS
WITH s AS (
  SELECT
    COUNT(*) FILTER (WHERE status = 'pending')               AS pending_count,
    COUNT(*) FILTER (WHERE status = 'confirmed')             AS confirmed_count,
    COUNT(*) FILTER (WHERE status = 'in_progress')           AS in_progress_count,
    COUNT(*) FILTER (WHERE status = 'completed')             AS completed_count,
    COUNT(*) FILTER (WHERE status = 'cancelled')             AS cancelled_count
  FROM public.bookings
)
SELECT
  pending_count,
  confirmed_count,
  in_progress_count,
  completed_count,
  cancelled_count,
  CASE
    WHEN (completed_count + cancelled_count) = 0 THEN 0
    ELSE (completed_count::numeric / (completed_count + cancelled_count))
  END AS completion_rate,
  CASE
    WHEN (pending_count + confirmed_count) = 0 THEN 0
    ELSE (confirmed_count::numeric / (pending_count + confirmed_count))
  END AS confirmation_rate
FROM s;

-- Rolling revenue (last 7 and 30 days)
CREATE OR REPLACE VIEW public.v_admin_revenue_rolling AS
WITH base AS (
  SELECT amount, payment_date
  FROM public.payments
  WHERE status = 'paid'::public.payment_status_enum
),
win7 AS (
  SELECT COALESCE(SUM(amount), 0)::numeric AS revenue_7d
  FROM base
  WHERE payment_date >= NOW() - INTERVAL '7 days'
),
win30 AS (
  SELECT COALESCE(SUM(amount), 0)::numeric AS revenue_30d
  FROM base
  WHERE payment_date >= NOW() - INTERVAL '30 days'
)
SELECT win7.revenue_7d, win30.revenue_30d
FROM win7, win30;
