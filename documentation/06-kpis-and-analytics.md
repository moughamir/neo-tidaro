---
title: 06-kpis-and-analytics
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# 06 - KPIs and Analytics

This guide documents the business KPIs for Tidaro, how they are computed from the database, and how to consume them in `apps/tidash/`.

See also: [[../GEMINI.md#Real-World Goal]] and [[../GEMINI.md#8-business-kpis]].

## Data Sources

Current schema lives in `supabase/migrations/20250106000000_initial_tidash_schema.sql` and includes:

- `public.bookings`
- `public.dashboard_metrics`
- `public.profiles`
- `public.activities`
- `public.notifications`

Future tables to enable additional KPIs:

- `reviews` / `surveys` (CSAT, NPS)
- `providers`, `providers_availability` (utilization, retention)
- `events.sessions` (time to book)
- `support_tickets` (support ticket rate)

## Analytics Views

A lightweight seed creates analytics views under `supabase/seeds/02_analytics_views.sql`.

- `public.v_kpi_bookings_daily`
  - Aggregates daily booking totals by status and revenue.

- `public.v_kpi_cancellation_rate_daily`
  - Computes daily cancellation rate = `cancelled_bookings / total_bookings * 100`.

- `public.v_kpi_fulfillment_rate_daily`
  - Computes daily fulfillment rate = `completed_bookings / confirmed_bookings * 100`.

- `public.v_kpi_revenue_daily`
  - Sums daily revenue.

- `public.v_kpi_metrics_summary`
  - High-level snapshot across the full dataset for header cards.

> Note: Additional KPIs in [[../GEMINI.md#8-business-kpis]] are stubbed with comments in the seed file and require future tables.

## Applying Seeds

Recommended approach with Supabase CLI (ensure Docker is running if using local stack):

```bash
# From repo root
supabase db reset   # WARNING: drops and recreates local db
# Or apply incrementally:
# supabase db push
```

Alternatively, run the seed manually in SQL editor:

1. Open `supabase/seeds/02_analytics_views.sql`
2. Execute the SQL in your Supabase project's SQL editor.

## Consuming in TiDash

In `apps/tidash/`, query these views via Supabase client:

- Daily charts: `v_kpi_bookings_daily`, `v_kpi_cancellation_rate_daily`, `v_kpi_fulfillment_rate_daily`, `v_kpi_revenue_daily`
- Header metrics: `v_kpi_metrics_summary`

Suggested DTOs:

- `DailyBookingsKpi { day: DateTime, total, confirmed, cancelled, completed, revenue }`
- `RatePoint { day: DateTime, valuePercent }`
- `KpiSummary { total, confirmed, cancelled, completed, revenue, cancellationRatePercent, fulfillmentRatePercent }`

### Example pseudo-code

```dart
final supabase = Supabase.instance.client;
final data = await supabase.from('v_kpi_metrics_summary').select().single();
// Map to KpiSummary DTO and feed Redux store/state
```

## Extensions Roadmap

- Add `events.sessions` table to compute Time to Book (TTB)
- Add `support_tickets` table for Support Ticket Rate
- Add `reviews` and `surveys` for CSAT and NPS
- Add `providers` and `providers_availability` for utilization and retention
- Create `analytics_daily` materialized tables for faster dashboards

## Security & Governance

- Views are read-only. Maintain RLS on base tables (`bookings`, etc.).
- Expose only required columns in views to minimize data leakage.
- For production, consider materialized views refreshed via Supabase Functions or cron.