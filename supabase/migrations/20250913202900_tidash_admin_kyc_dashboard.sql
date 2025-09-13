-- TiDash Backoffice: KYC + Dashboard admin foundation
-- Created: 2025-09-13 20:29:00+01:00

-- Helper: fast admin/mod check
CREATE OR REPLACE FUNCTION public.is_admin(uid uuid)
RETURNS boolean
LANGUAGE sql
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.profiles p
    WHERE p.id = uid AND p.role IN ('admin'::public.user_role_enum, 'moderator'::public.user_role_enum)
  );
$$;

-- Policies to allow admins/moderators to review KYC documents
DO $$ BEGIN
  -- Enable RLS if not already
  PERFORM 1 FROM pg_tables WHERE schemaname='public' AND tablename='verification_documents';
  EXECUTE 'ALTER TABLE public.verification_documents ENABLE ROW LEVEL SECURITY';
EXCEPTION WHEN others THEN NULL; END $$;

-- SELECT for admins
CREATE POLICY IF NOT EXISTS "Admins can view all KYC documents"
ON public.verification_documents
FOR SELECT
USING ( public.is_admin(auth.uid()) );

-- UPDATE for admins
CREATE POLICY IF NOT EXISTS "Admins can update KYC documents"
ON public.verification_documents
FOR UPDATE
USING ( public.is_admin(auth.uid()) )
WITH CHECK ( public.is_admin(auth.uid()) );

-- View: KYC queue (pending KYC with user profile details)
CREATE OR REPLACE VIEW public.v_kyc_queue AS
SELECT
  vd.id AS verification_id,
  vd.profile_id,
  p.full_name,
  p.phone_number,
  p.role,
  vd.document_type,
  vd.file_url,
  vd.status,
  vd.upload_date,
  vd.verification_date,
  vd.notes
FROM public.verification_documents vd
JOIN public.profiles p ON p.id = vd.profile_id
WHERE vd.status = 'pending'::public.verification_status_enum
ORDER BY vd.upload_date ASC;

-- Function: Approve/Reject KYC with audit log
CREATE OR REPLACE FUNCTION public.fn_admin_verify_kyc(
  p_verification_id uuid,
  p_decision text,           -- 'verified' | 'rejected'
  p_note text DEFAULT NULL
) RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_uid uuid := auth.uid();
  v_new_status public.verification_status_enum;
  v_row RECORD;
BEGIN
  IF NOT public.is_admin(v_uid) THEN
    RAISE EXCEPTION 'not_authorized';
  END IF;

  IF p_decision NOT IN ('verified', 'rejected') THEN
    RAISE EXCEPTION 'invalid_decision %', p_decision;
  END IF;

  v_new_status := p_decision::public.verification_status_enum;

  UPDATE public.verification_documents vd
  SET status = v_new_status,
      verification_date = NOW(),
      notes = COALESCE(p_note, vd.notes)
  WHERE vd.id = p_verification_id;

  SELECT vd.*, p.full_name INTO v_row
  FROM public.verification_documents vd
  JOIN public.profiles p ON p.id = vd.profile_id
  WHERE vd.id = p_verification_id;

  INSERT INTO public.audit_logs (user_id, action, entity_type, entity_id, details)
  VALUES (
    v_uid,
    CASE WHEN v_new_status = 'verified' THEN 'kyc_verified' ELSE 'kyc_rejected' END,
    'verification_document',
    p_verification_id,
    jsonb_build_object(
      'profile_id', v_row.profile_id,
      'full_name', v_row.full_name,
      'new_status', v_new_status,
      'note', p_note
    )
  );
END;
$$;

-- View: Admin metrics (daily + totals)
-- Note: Uses simple aggregates on existing schema
CREATE OR REPLACE VIEW public.v_admin_metrics_daily AS
WITH 
  today AS (
    SELECT date_trunc('day', NOW()) AS d
  ),
  roles AS (
    SELECT 
      COUNT(*) FILTER (WHERE role = 'client_provider') AS total_providers,
      COUNT(*) FILTER (WHERE role = 'client_consumer') AS total_clients,
      COUNT(*) FILTER (WHERE role IN ('admin','moderator')) AS total_staff
    FROM public.profiles
  ),
  kyc AS (
    SELECT 
      COUNT(*) FILTER (WHERE status = 'pending') AS kyc_pending,
      COUNT(*) FILTER (WHERE status = 'verified') AS kyc_verified_total
    FROM public.verification_documents
  ),
  bookings AS (
    SELECT 
      COUNT(*) FILTER (WHERE status IN ('pending','confirmed','in_progress')) AS open_bookings,
      COUNT(*) FILTER (WHERE status = 'completed') AS completed_total,
      COUNT(*) FILTER (WHERE status = 'cancelled') AS cancelled_total,
      COUNT(*) FILTER (WHERE DATE(created_at) = CURRENT_DATE) AS bookings_today
    FROM public.bookings
  ),
  ratings AS (
    SELECT 
      COALESCE(AVG(rating), 0)::numeric(4,2) AS avg_rating,
      COUNT(*) AS ratings_total
    FROM public.reviews
  )
SELECT 
  roles.total_providers,
  roles.total_clients,
  roles.total_staff,
  kyc.kyc_pending,
  kyc.kyc_verified_total,
  bookings.open_bookings,
  bookings.completed_total,
  bookings.cancelled_total,
  bookings.bookings_today,
  ratings.avg_rating,
  ratings.ratings_total
FROM roles, kyc, bookings, ratings;

-- Activity feed (recent important events)
CREATE OR REPLACE VIEW public.v_admin_activity_feed AS
SELECT 
  al.id,
  al.timestamp,
  al.user_id,
  p.full_name,
  al.action,
  al.entity_type,
  al.entity_id,
  al.details
FROM public.audit_logs al
LEFT JOIN public.profiles p ON p.id = al.user_id
ORDER BY al.timestamp DESC
LIMIT 200;
