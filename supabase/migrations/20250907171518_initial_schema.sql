create extension if not exists "postgis" with schema "public" version '3.3.7';

create type "public"."booking_status_enum" as enum ('pending', 'confirmed', 'assigned', 'in_progress', 'completed', 'cancelled', 'rescheduled');

create type "public"."professional_status_enum" as enum ('available', 'on_job', 'offline', 'on_break');

create type "public"."document_type_enum" as enum ('cin', 'cine', 'reference_letter', 'background_check');

create type "public"."message_type_enum" as enum ('text', 'image', 'file', 'system');

create type "public"."payment_status_enum" as enum ('pending', 'paid', 'failed', 'refunded');

create type "public"."service_category_enum" as enum ('regular_cleaning', 'deep_cleaning', 'move_in_out', 'post_construction', 'commercial', 'specialized', 'standard_cleaning', 'residential');

create type "public"."user_role_enum" as enum ('admin', 'moderator', 'client_consumer', 'client_provider');

create type "public"."verification_status_enum" as enum ('pending', 'verified', 'rejected', 'expired');

create table "public"."addresses" (
    "id" uuid not null default gen_random_uuid(),
    "profile_id" uuid,
    "street" text not null,
    "apartment" text,
    "city" text not null,
    "state" text not null,
    "zip_code" text not null,
    "instructions" text,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."audit_logs" (
    "id" uuid not null default gen_random_uuid(),
    "timestamp" timestamp with time zone default now(),
    "user_id" uuid,
    "action" text not null,
    "entity_type" text,
    "entity_id" uuid,
    "details" jsonb,
    "user_agent" text,
    "ip_address" inet,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."availability_slots" (
    "id" uuid not null default gen_random_uuid(),
    "provider_id" uuid not null,
    "start_time" timestamp with time zone not null,
    "end_time" timestamp with time zone not null,
    "day_of_week" integer not null,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."blocked_periods" (
    "id" uuid not null default gen_random_uuid(),
    "profile_id" uuid not null,
    "start_date" timestamp with time zone not null,
    "end_date" timestamp with time zone not null,
    "reason" text,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."bookings" (
    "id" uuid not null default gen_random_uuid(),
    "customer_id" uuid not null,
    "service_id" uuid not null,
    "scheduled_date" timestamp with time zone not null,
    "status" booking_status_enum not null,
    "total_price" numeric(10,2) not null,
    "payment_status" payment_status_enum not null,
    "address_id" uuid not null,
    "notes" text,
    "professional_id" uuid,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now(),
    "completed_at" timestamp with time zone,
    "cancelled_at" timestamp with time zone,
    "rescheduled_from" timestamp with time zone
);


create table "public"."messages" (
    "id" uuid not null default gen_random_uuid(),
    "sender_id" uuid not null,
    "receiver_id" uuid not null,
    "booking_id" uuid,
    "content" text not null,
    "timestamp" timestamp with time zone default now(),
    "is_read" boolean default false,
    "message_type" message_type_enum not null,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."payments" (
    "id" uuid not null default gen_random_uuid(),
    "booking_id" uuid not null,
    "amount" numeric(10,2) not null,
    "status" payment_status_enum not null,
    "payment_method" text not null,
    "transaction_id" text,
    "payment_date" timestamp with time zone default now(),
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."profiles" (
    "id" uuid not null,
    "full_name" text,
    "avatar_url" text,
    "phone_number" text,
    "role" user_role_enum not null default 'client_consumer'::user_role_enum,
    "professional_status" professional_status_enum not null default 'offline'::professional_status_enum,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."provider_services" (
    "provider_id" uuid not null,
    "service_id" uuid not null,
    "hourly_rate" numeric(10,2)
);


create table "public"."reviews" (
    "id" uuid not null default gen_random_uuid(),
    "booking_id" uuid not null,
    "reviewer_id" uuid not null,
    "reviewee_id" uuid not null,
    "rating" integer not null,
    "comment" text,
    "review_date" timestamp with time zone default now(),
    "is_verified_booking" boolean default false,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."service_addons" (
    "id" uuid not null default gen_random_uuid(),
    "service_id" uuid not null,
    "name" text not null,
    "description" text,
    "price" numeric(10,2) not null,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."services" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "description" text,
    "base_price" numeric(10,2) not null,
    "estimated_duration_minutes" integer,
    "category" service_category_enum not null,
    "is_active" boolean default true,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


create table "public"."verification_documents" (
    "id" uuid not null default gen_random_uuid(),
    "profile_id" uuid not null,
    "document_type" document_type_enum not null,
    "file_url" text not null,
    "status" verification_status_enum not null,
    "upload_date" timestamp with time zone default now(),
    "verification_date" timestamp with time zone,
    "notes" text,
    "created_at" timestamp with time zone default now(),
    "updated_at" timestamp with time zone default now()
);


CREATE UNIQUE INDEX addresses_pkey ON public.addresses USING btree (id);

CREATE UNIQUE INDEX audit_logs_pkey ON public.audit_logs USING btree (id);

CREATE UNIQUE INDEX availability_slots_pkey ON public.availability_slots USING btree (id);

CREATE UNIQUE INDEX blocked_periods_pkey ON public.blocked_periods USING btree (id);

CREATE UNIQUE INDEX bookings_pkey ON public.bookings USING btree (id);

CREATE INDEX idx_addresses_city ON public.addresses USING btree (city);

CREATE INDEX idx_addresses_profile_id ON public.addresses USING btree (profile_id);

CREATE INDEX idx_addresses_zip_code ON public.addresses USING btree (zip_code);

CREATE INDEX idx_audit_logs_action ON public.audit_logs USING btree (action);

CREATE INDEX idx_audit_logs_entity_id ON public.audit_logs USING btree (entity_id);

CREATE INDEX idx_audit_logs_entity_type ON public.audit_logs USING btree (entity_type);

CREATE INDEX idx_audit_logs_timestamp ON public.audit_logs USING btree ("timestamp" DESC);

CREATE INDEX idx_audit_logs_user_id ON public.audit_logs USING btree (user_id);

CREATE INDEX idx_availability_slots_day_of_week ON public.availability_slots USING btree (day_of_week);

CREATE INDEX idx_availability_slots_end_time ON public.availability_slots USING btree (end_time);

CREATE INDEX idx_availability_slots_provider_id ON public.availability_slots USING btree (provider_id);

CREATE INDEX idx_availability_slots_start_time ON public.availability_slots USING btree (start_time);

CREATE INDEX idx_blocked_periods_end_date ON public.blocked_periods USING btree (end_date);

CREATE INDEX idx_blocked_periods_profile_id ON public.blocked_periods USING btree (profile_id);

CREATE INDEX idx_blocked_periods_start_date ON public.blocked_periods USING btree (start_date);

CREATE INDEX idx_bookings_professional_id ON public.bookings USING btree (professional_id);

CREATE INDEX idx_bookings_created_at ON public.bookings USING btree (created_at DESC);

CREATE INDEX idx_bookings_customer_id ON public.bookings USING btree (customer_id);

CREATE INDEX idx_bookings_scheduled_date ON public.bookings USING btree (scheduled_date);

CREATE INDEX idx_bookings_service_id ON public.bookings USING btree (service_id);

CREATE INDEX idx_bookings_status ON public.bookings USING btree (status);

CREATE INDEX idx_messages_booking_id ON public.messages USING btree (booking_id);

CREATE INDEX idx_messages_is_read ON public.messages USING btree (is_read);

CREATE INDEX idx_messages_receiver_id ON public.messages USING btree (receiver_id);

CREATE INDEX idx_messages_sender_id ON public.messages USING btree (sender_id);

CREATE INDEX idx_messages_timestamp ON public.messages USING btree ("timestamp" DESC);

CREATE INDEX idx_payments_booking_id ON public.payments USING btree (booking_id);

CREATE INDEX idx_payments_payment_date ON public.payments USING btree (payment_date DESC);

CREATE INDEX idx_payments_status ON public.payments USING btree (status);

CREATE INDEX idx_profiles_created_at ON public.profiles USING btree (created_at DESC);

CREATE INDEX idx_profiles_role ON public.profiles USING btree (role);

CREATE INDEX idx_reviews_booking_id ON public.reviews USING btree (booking_id);

CREATE INDEX idx_reviews_review_date ON public.reviews USING btree (review_date DESC);

CREATE INDEX idx_reviews_reviewee_id ON public.reviews USING btree (reviewee_id);

CREATE INDEX idx_reviews_reviewer_id ON public.reviews USING btree (reviewer_id);

CREATE INDEX idx_service_addons_service_id ON public.service_addons USING btree (service_id);

CREATE INDEX idx_services_category ON public.services USING btree (category);

CREATE INDEX idx_services_is_active ON public.services USING btree (is_active);

CREATE INDEX idx_verification_documents_document_type ON public.verification_documents USING btree (document_type);

CREATE INDEX idx_verification_documents_profile_id ON public.verification_documents USING btree (profile_id);

CREATE INDEX idx_verification_documents_status ON public.verification_documents USING btree (status);

CREATE INDEX idx_verification_documents_upload_date ON public.verification_documents USING btree (upload_date DESC);

CREATE UNIQUE INDEX messages_pkey ON public.messages USING btree (id);

CREATE UNIQUE INDEX payments_booking_id_key ON public.payments USING btree (booking_id);

CREATE UNIQUE INDEX payments_pkey ON public.payments USING btree (id);

CREATE UNIQUE INDEX payments_transaction_id_key ON public.payments USING btree (transaction_id);

CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id);

CREATE UNIQUE INDEX provider_services_pkey ON public.provider_services USING btree (provider_id, service_id);

CREATE UNIQUE INDEX reviews_booking_id_key ON public.reviews USING btree (booking_id);

CREATE UNIQUE INDEX reviews_pkey ON public.reviews USING btree (id);

CREATE UNIQUE INDEX service_addons_pkey ON public.service_addons USING btree (id);

CREATE UNIQUE INDEX services_pkey ON public.services USING btree (id);

CREATE UNIQUE INDEX verification_documents_pkey ON public.verification_documents USING btree (id);

alter table "public"."addresses" add constraint "addresses_pkey" PRIMARY KEY using index "addresses_pkey";

alter table "public"."audit_logs" add constraint "audit_logs_pkey" PRIMARY KEY using index "audit_logs_pkey";

alter table "public"."availability_slots" add constraint "availability_slots_pkey" PRIMARY KEY using index "availability_slots_pkey";

alter table "public"."blocked_periods" add constraint "blocked_periods_pkey" PRIMARY KEY using index "blocked_periods_pkey";

alter table "public"."bookings" add constraint "bookings_pkey" PRIMARY KEY using index "bookings_pkey";

alter table "public"."messages" add constraint "messages_pkey" PRIMARY KEY using index "messages_pkey";

alter table "public"."payments" add constraint "payments_pkey" PRIMARY KEY using index "payments_pkey";

alter table "public"."profiles" add constraint "profiles_pkey" PRIMARY KEY using index "profiles_pkey";

alter table "public"."provider_services" add constraint "provider_services_pkey" PRIMARY KEY using index "provider_services_pkey";

alter table "public"."reviews" add constraint "reviews_pkey" PRIMARY KEY using index "reviews_pkey";

alter table "public"."service_addons" add constraint "service_addons_pkey" PRIMARY KEY using index "service_addons_pkey";

alter table "public"."services" add constraint "services_pkey" PRIMARY KEY using index "services_pkey";

alter table "public"."verification_documents" add constraint "verification_documents_pkey" PRIMARY KEY using index "verification_documents_pkey";

alter table "public"."addresses" add constraint "addresses_profile_id_fkey" FOREIGN KEY (profile_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."addresses" validate constraint "addresses_profile_id_fkey";

alter table "public"."audit_logs" add constraint "audit_logs_user_id_fkey" FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE SET NULL not valid;

alter table "public"."audit_logs" validate constraint "audit_logs_user_id_fkey";

alter table "public"."availability_slots" add constraint "availability_slots_day_of_week_check" CHECK (((day_of_week >= 0) AND (day_of_week <= 6))) not valid;

alter table "public"."availability_slots" validate constraint "availability_slots_day_of_week_check";

alter table "public"."availability_slots" add constraint "availability_slots_provider_id_fkey" FOREIGN KEY (provider_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."availability_slots" validate constraint "availability_slots_provider_id_fkey";

alter table "public"."blocked_periods" add constraint "blocked_periods_profile_id_fkey" FOREIGN KEY (profile_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."blocked_periods" validate constraint "blocked_periods_profile_id_fkey";

alter table "public"."bookings" add constraint "bookings_address_id_fkey" FOREIGN KEY (address_id) REFERENCES addresses(id) ON DELETE RESTRICT not valid;

alter table "public"."bookings" validate constraint "bookings_address_id_fkey";

alter table "public"."bookings" add constraint "bookings_professional_id_fkey" FOREIGN KEY (professional_id) REFERENCES profiles(id) ON DELETE SET NULL not valid;

alter table "public"."bookings" validate constraint "bookings_professional_id_fkey";

alter table "public"."bookings" add constraint "bookings_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."bookings" validate constraint "bookings_customer_id_fkey";

alter table "public"."bookings" add constraint "bookings_service_id_fkey" FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE not valid;

alter table "public"."bookings" validate constraint "bookings_service_id_fkey";

alter table "public"."messages" add constraint "messages_booking_id_fkey" FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE SET NULL not valid;

alter table "public"."messages" validate constraint "messages_booking_id_fkey";

alter table "public"."messages" add constraint "messages_receiver_id_fkey" FOREIGN KEY (receiver_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."messages" validate constraint "messages_receiver_id_fkey";

alter table "public"."messages" add constraint "messages_sender_id_fkey" FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."messages" validate constraint "messages_sender_id_fkey";

alter table "public"."payments" add constraint "payments_booking_id_fkey" FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE not valid;

alter table "public"."payments" validate constraint "payments_booking_id_fkey";

alter table "public"."payments" add constraint "payments_booking_id_key" UNIQUE using index "payments_booking_id_key";

alter table "public"."payments" add constraint "payments_transaction_id_key" UNIQUE using index "payments_transaction_id_key";

alter table "public"."profiles" add constraint "profiles_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profiles" validate constraint "profiles_id_fkey";

alter table "public"."provider_services" add constraint "provider_services_provider_id_fkey" FOREIGN KEY (provider_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."provider_services" validate constraint "provider_services_provider_id_fkey";

alter table "public"."provider_services" add constraint "provider_services_service_id_fkey" FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE not valid;

alter table "public"."provider_services" validate constraint "provider_services_service_id_fkey";

alter table "public"."reviews" add constraint "reviews_booking_id_fkey" FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE not valid;

alter table "public"."reviews" validate constraint "reviews_booking_id_fkey";

alter table "public"."reviews" add constraint "reviews_booking_id_key" UNIQUE using index "reviews_booking_id_key";

alter table "public"."reviews" add constraint "reviews_rating_check" CHECK (((rating >= 1) AND (rating <= 5))) not valid;

alter table "public"."reviews" validate constraint "reviews_rating_check";

alter table "public"."reviews" add constraint "reviews_reviewee_id_fkey" FOREIGN KEY (reviewee_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."reviews" validate constraint "reviews_reviewee_id_fkey";

alter table "public"."reviews" add constraint "reviews_reviewer_id_fkey" FOREIGN KEY (reviewer_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."reviews" validate constraint "reviews_reviewer_id_fkey";

alter table "public"."service_addons" add constraint "service_addons_service_id_fkey" FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE not valid;

alter table "public"."service_addons" validate constraint "service_addons_service_id_fkey";

alter table "public"."verification_documents" add constraint "verification_documents_profile_id_fkey" FOREIGN KEY (profile_id) REFERENCES profiles(id) ON DELETE CASCADE not valid;

alter table "public"."verification_documents" validate constraint "verification_documents_profile_id_fkey";

set check_function_bodies = off;

create or replace view "public"."active_bookings_view" as  SELECT b.id,
    b.customer_id,
    b.service_id,
    b.scheduled_date,
    b.status,
    b.total_price,
    b.payment_status,
    b.address_id,
    b.notes,
    b.professional_id,
    b.created_at,
    b.updated_at,
    b.completed_at,
    b.cancelled_at,
    b.rescheduled_from,
    p.full_name AS customer_name,
    s.name AS service_name
   FROM ((bookings b
     JOIN profiles p ON ((b.customer_id = p.id)))
     JOIN services s ON ((b.service_id = s.id)))
  WHERE (b.status = ANY (ARRAY['pending'::booking_status_enum, 'confirmed'::booking_status_enum, 'in_progress'::booking_status_enum]));


create or replace view "public"."professional_performance_view" as  SELECT p.id AS professional_id,
    p.full_name AS professional_name,
    count(b.id) AS total_completed_bookings,
    avg(r.rating) AS average_rating,
    sum(b.total_price) AS total_revenue_generated
   FROM ((profiles p
     LEFT JOIN bookings b ON (((p.id = b.professional_id) AND (b.status = 'completed'::booking_status_enum))))
     LEFT JOIN reviews r ON ((b.id = r.booking_id)))
  WHERE (p.role = 'client_provider'::user_role_enum)
  GROUP BY p.id, p.full_name;


create or replace view "public"."completed_bookings_view" as  SELECT b.id,
    b.customer_id,
    b.service_id,
    b.scheduled_date,
    b.status,
    b.total_price,
    b.payment_status,
    b.address_id,
    b.notes,
    b.professional_id,
    b.created_at,
    b.updated_at,
    b.completed_at,
    b.cancelled_at,
    b.rescheduled_from,
    p.full_name AS customer_name,
    s.name AS service_name
   FROM ((bookings b
     JOIN profiles p ON ((b.customer_id = p.id)))
     JOIN services s ON ((b.service_id = s.id)))
  WHERE (b.status = 'completed'::booking_status_enum);


CREATE OR REPLACE FUNCTION public.update_updated_at_column()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$function$
;

grant delete on table "public"."addresses" to "anon";

grant insert on table "public"."addresses" to "anon";

grant references on table "public"."addresses" to "anon";

grant select on table "public"."addresses" to "anon";

grant trigger on table "public"."addresses" to "anon";

grant truncate on table "public"."addresses" to "anon";

grant update on table "public"."addresses" to "anon";

grant delete on table "public"."addresses" to "authenticated";

grant insert on table "public"."addresses" to "authenticated";

grant references on table "public"."addresses" to "authenticated";

grant select on table "public"."addresses" to "authenticated";

grant trigger on table "public"."addresses" to "authenticated";

grant truncate on table "public"."addresses" to "authenticated";

grant update on table "public"."addresses" to "authenticated";

grant delete on table "public"."addresses" to "service_role";

grant insert on table "public"."addresses" to "service_role";

grant references on table "public"."addresses" to "service_role";

grant select on table "public"."addresses" to "service_role";

grant trigger on table "public"."addresses" to "service_role";

grant truncate on table "public"."addresses" to "service_role";

grant update on table "public"."addresses" to "service_role";

grant delete on table "public"."audit_logs" to "anon";

grant insert on table "public"."audit_logs" to "anon";

grant references on table "public"."audit_logs" to "anon";

grant select on table "public"."audit_logs" to "anon";

grant trigger on table "public"."audit_logs" to "anon";

grant truncate on table "public"."audit_logs" to "anon";

grant update on table "public"."audit_logs" to "anon";

grant delete on table "public"."audit_logs" to "authenticated";

grant insert on table "public"."audit_logs" to "authenticated";

grant references on table "public"."audit_logs" to "authenticated";

grant select on table "public"."audit_logs" to "authenticated";

grant trigger on table "public"."audit_logs" to "authenticated";

grant truncate on table "public"."audit_logs" to "authenticated";

grant update on table "public"."audit_logs" to "authenticated";

grant delete on table "public"."audit_logs" to "service_role";

grant insert on table "public"."audit_logs" to "service_role";

grant references on table "public"."audit_logs" to "service_role";

grant select on table "public"."audit_logs" to "service_role";

grant trigger on table "public"."audit_logs" to "service_role";

grant truncate on table "public"."audit_logs" to "service_role";

grant update on table "public"."audit_logs" to "service_role";

grant delete on table "public"."availability_slots" to "anon";

grant insert on table "public"."availability_slots" to "anon";

grant references on table "public"."availability_slots" to "anon";

grant select on table "public"."availability_slots" to "anon";

grant trigger on table "public"."availability_slots" to "anon";

grant truncate on table "public"."availability_slots" to "anon";

grant update on table "public"."availability_slots" to "anon";

grant delete on table "public"."availability_slots" to "authenticated";

grant insert on table "public"."availability_slots" to "authenticated";

grant references on table "public"."availability_slots" to "authenticated";

grant select on table "public"."availability_slots" to "authenticated";

grant trigger on table "public"."availability_slots" to "authenticated";

grant truncate on table "public"."availability_slots" to "authenticated";

grant update on table "public"."availability_slots" to "authenticated";

grant delete on table "public"."availability_slots" to "service_role";

grant insert on table "public"."availability_slots" to "service_role";

grant references on table "public"."availability_slots" to "service_role";

grant select on table "public"."availability_slots" to "service_role";

grant trigger on table "public"."availability_slots" to "service_role";

grant truncate on table "public"."availability_slots" to "service_role";

grant update on table "public"."availability_slots" to "service_role";

grant delete on table "public"."blocked_periods" to "anon";

grant insert on table "public"."blocked_periods" to "anon";

grant references on table "public"."blocked_periods" to "anon";

grant select on table "public"."blocked_periods" to "anon";

grant trigger on table "public"."blocked_periods" to "anon";

grant truncate on table "public"."blocked_periods" to "anon";

grant update on table "public"."blocked_periods" to "anon";

grant delete on table "public"."blocked_periods" to "authenticated";

grant insert on table "public"."blocked_periods" to "authenticated";

grant references on table "public"."blocked_periods" to "authenticated";

grant select on table "public"."blocked_periods" to "authenticated";

grant trigger on table "public"."blocked_periods" to "authenticated";

grant truncate on table "public"."blocked_periods" to "authenticated";

grant update on table "public"."blocked_periods" to "authenticated";

grant delete on table "public"."blocked_periods" to "service_role";

grant insert on table "public"."blocked_periods" to "service_role";

grant references on table "public"."blocked_periods" to "service_role";

grant select on table "public"."blocked_periods" to "service_role";

grant trigger on table "public"."blocked_periods" to "service_role";

grant truncate on table "public"."blocked_periods" to "service_role";

grant update on table "public"."blocked_periods" to "service_role";

grant delete on table "public"."bookings" to "anon";

grant insert on table "public"."bookings" to "anon";

grant references on table "public"."bookings" to "anon";

grant select on table "public"."bookings" to "anon";

grant trigger on table "public"."bookings" to "anon";

grant truncate on table "public"."bookings" to "anon";

grant update on table "public"."bookings" to "anon";

grant delete on table "public"."bookings" to "authenticated";

grant insert on table "public"."bookings" to "authenticated";

grant references on table "public"."bookings" to "authenticated";

grant select on table "public"."bookings" to "authenticated";

grant trigger on table "public"."bookings" to "authenticated";

grant truncate on table "public"."bookings" to "authenticated";

grant update on table "public"."bookings" to "authenticated";

grant delete on table "public"."bookings" to "service_role";

grant insert on table "public"."bookings" to "service_role";

grant references on table "public"."bookings" to "service_role";

grant select on table "public"."bookings" to "service_role";

grant trigger on table "public"."bookings" to "service_role";

grant truncate on table "public"."bookings" to "service_role";

grant update on table "public"."bookings" to "service_role";

grant delete on table "public"."messages" to "anon";

grant insert on table "public"."messages" to "anon";

grant references on table "public"."messages" to "anon";

grant select on table "public"."messages" to "anon";

grant trigger on table "public"."messages" to "anon";

grant truncate on table "public"."messages" to "anon";

grant update on table "public"."messages" to "anon";

grant delete on table "public"."messages" to "authenticated";

grant insert on table "public"."messages" to "authenticated";

grant references on table "public"."messages" to "authenticated";

grant select on table "public"."messages" to "authenticated";

grant trigger on table "public"."messages" to "authenticated";

grant truncate on table "public"."messages" to "authenticated";

grant update on table "public"."messages" to "authenticated";

grant delete on table "public"."messages" to "service_role";

grant insert on table "public"."messages" to "service_role";

grant references on table "public"."messages" to "service_role";

grant select on table "public"."messages" to "service_role";

grant trigger on table "public"."messages" to "service_role";

grant truncate on table "public"."messages" to "service_role";

grant update on table "public"."messages" to "service_role";

grant delete on table "public"."payments" to "anon";

grant insert on table "public"."payments" to "anon";

grant references on table "public"."payments" to "anon";

grant select on table "public"."payments" to "anon";

grant trigger on table "public"."payments" to "anon";

grant truncate on table "public"."payments" to "anon";

grant update on table "public"."payments" to "anon";

grant delete on table "public"."payments" to "authenticated";

grant insert on table "public"."payments" to "authenticated";

grant references on table "public"."payments" to "authenticated";

grant select on table "public"."payments" to "authenticated";

grant trigger on table "public"."payments" to "authenticated";

grant truncate on table "public"."payments" to "authenticated";

grant update on table "public"."payments" to "authenticated";

grant delete on table "public"."payments" to "service_role";

grant insert on table "public"."payments" to "service_role";

grant references on table "public"."payments" to "service_role";

grant select on table "public"."payments" to "service_role";

grant trigger on table "public"."payments" to "service_role";

grant truncate on table "public"."payments" to "service_role";

grant update on table "public"."payments" to "service_role";

grant delete on table "public"."profiles" to "anon";

grant insert on table "public"."profiles" to "anon";

grant references on table "public"."profiles" to "anon";

grant select on table "public"."profiles" to "anon";

grant trigger on table "public"."profiles" to "anon";

grant truncate on table "public"."profiles" to "anon";

grant update on table "public"."profiles" to "anon";

grant delete on table "public"."profiles" to "authenticated";

grant insert on table "public"."profiles" to "authenticated";

grant references on table "public"."profiles" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant trigger on table "public"."profiles" to "authenticated";

grant truncate on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant delete on table "public"."profiles" to "service_role";

grant insert on table "public"."profiles" to "service_role";

grant references on table "public"."profiles" to "service_role";

grant select on table "public"."profiles" to "service_role";

grant trigger on table "public"."profiles" to "service_role";

grant truncate on table "public"."profiles" to "service_role";

grant update on table "public"."profiles" to "service_role";

grant delete on table "public"."provider_services" to "anon";

grant insert on table "public"."provider_services" to "anon";

grant references on table "public"."provider_services" to "anon";

grant select on table "public"."provider_services" to "anon";

grant trigger on table "public"."provider_services" to "anon";

grant truncate on table "public"."provider_services" to "anon";

grant update on table "public"."provider_services" to "anon";

grant delete on table "public"."provider_services" to "authenticated";

grant insert on table "public"."provider_services" to "authenticated";

grant references on table "public"."provider_services" to "authenticated";

grant select on table "public"."provider_services" to "authenticated";

grant trigger on table "public"."provider_services" to "authenticated";

grant truncate on table "public"."provider_services" to "authenticated";

grant update on table "public"."provider_services" to "authenticated";

grant delete on table "public"."provider_services" to "service_role";

grant insert on table "public"."provider_services" to "service_role";

grant references on table "public"."provider_services" to "service_role";

grant select on table "public"."provider_services" to "service_role";

grant trigger on table "public"."provider_services" to "service_role";

grant truncate on table "public"."provider_services" to "service_role";

grant update on table "public"."provider_services" to "service_role";

grant delete on table "public"."reviews" to "anon";

grant insert on table "public"."reviews" to "anon";

grant references on table "public"."reviews" to "anon";

grant select on table "public"."reviews" to "anon";

grant trigger on table "public"."reviews" to "anon";

grant truncate on table "public"."reviews" to "anon";

grant update on table "public"."reviews" to "anon";

grant delete on table "public"."reviews" to "authenticated";

grant insert on table "public"."reviews" to "authenticated";

grant references on table "public"."reviews" to "authenticated";

grant select on table "public"."reviews" to "authenticated";

grant trigger on table "public"."reviews" to "authenticated";

grant truncate on table "public"."reviews" to "authenticated";

grant update on table "public"."reviews" to "authenticated";

grant delete on table "public"."reviews" to "service_role";

grant insert on table "public"."reviews" to "service_role";

grant references on table "public"."reviews" to "service_role";

grant select on table "public"."reviews" to "service_role";

grant trigger on table "public"."reviews" to "service_role";

grant truncate on table "public"."reviews" to "service_role";

grant update on table "public"."reviews" to "service_role";

grant delete on table "public"."service_addons" to "anon";

grant insert on table "public"."service_addons" to "anon";

grant references on table "public"."service_addons" to "anon";

grant select on table "public"."service_addons" to "anon";

grant trigger on table "public"."service_addons" to "anon";

grant truncate on table "public"."service_addons" to "anon";

grant update on table "public"."service_addons" to "anon";

grant delete on table "public"."service_addons" to "authenticated";

grant insert on table "public"."service_addons" to "authenticated";

grant references on table "public"."service_addons" to "authenticated";

grant select on table "public"."service_addons" to "authenticated";

grant trigger on table "public"."service_addons" to "authenticated";

grant truncate on table "public"."service_addons" to "authenticated";

grant update on table "public"."service_addons" to "authenticated";

grant delete on table "public"."service_addons" to "service_role";

grant insert on table "public"."service_addons" to "service_role";

grant references on table "public"."service_addons" to "service_role";

grant select on table "public"."service_addons" to "service_role";

grant trigger on table "public"."service_addons" to "service_role";

grant truncate on table "public"."service_addons" to "service_role";

grant update on table "public"."service_addons" to "service_role";

grant delete on table "public"."services" to "anon";

grant insert on table "public"."services" to "anon";

grant references on table "public"."services" to "anon";

grant select on table "public"."services" to "anon";

grant trigger on table "public"."services" to "anon";

grant truncate on table "public"."services" to "anon";

grant update on table "public"."services" to "anon";

grant delete on table "public"."services" to "authenticated";

grant insert on table "public"."services" to "authenticated";

grant references on table "public"."services" to "authenticated";

grant select on table "public"."services" to "authenticated";

grant trigger on table "public"."services" to "authenticated";

grant truncate on table "public"."services" to "authenticated";

grant update on table "public"."services" to "authenticated";

grant delete on table "public"."services" to "service_role";

grant insert on table "public"."services" to "service_role";

grant references on table "public"."services" to "service_role";

grant select on table "public"."services" to "service_role";

grant trigger on table "public"."services" to "service_role";

grant truncate on table "public"."services" to "service_role";

grant update on table "public"."services" to "service_role";

grant delete on table "public"."spatial_ref_sys" to "anon";

grant insert on table "public"."spatial_ref_sys" to "anon";

grant references on table "public"."spatial_ref_sys" to "anon";

grant select on table "public"."spatial_ref_sys" to "anon";

grant trigger on table "public"."spatial_ref_sys" to "anon";

grant truncate on table "public"."spatial_ref_sys" to "anon";

grant update on table "public"."spatial_ref_sys" to "anon";

grant delete on table "public"."spatial_ref_sys" to "authenticated";

grant insert on table "public"."spatial_ref_sys" to "authenticated";

grant references on table "public"."spatial_ref_sys" to "authenticated";

grant select on table "public"."spatial_ref_sys" to "authenticated";

grant trigger on table "public"."spatial_ref_sys" to "authenticated";

grant truncate on table "public"."spatial_ref_sys" to "authenticated";

grant update on table "public"."spatial_ref_sys" to "authenticated";

grant delete on table "public"."spatial_ref_sys" to "postgres";

grant insert on table "public"."spatial_ref_sys" to "postgres";

grant references on table "public"."spatial_ref_sys" to "postgres";

grant select on table "public"."spatial_ref_sys" to "postgres";

grant trigger on table "public"."spatial_ref_sys" to "postgres";

grant truncate on table "public"."spatial_ref_sys" to "postgres";

grant update on table "public"."spatial_ref_sys" to "postgres";

grant delete on table "public"."spatial_ref_sys" to "service_role";

grant insert on table "public"."spatial_ref_sys" to "service_role";

grant references on table "public"."spatial_ref_sys" to "service_role";

grant select on table "public"."spatial_ref_sys" to "service_role";

grant trigger on table "public"."spatial_ref_sys" to "service_role";

grant truncate on table "public"."spatial_ref_sys" to "service_role";

grant update on table "public"."spatial_ref_sys" to "service_role";

grant delete on table "public"."verification_documents" to "anon";

grant insert on table "public"."verification_documents" to "anon";

grant references on table "public"."verification_documents" to "anon";

grant select on table "public"."verification_documents" to "anon";

grant trigger on table "public"."verification_documents" to "anon";

grant truncate on table "public"."verification_documents" to "anon";

grant update on table "public"."verification_documents" to "anon";

grant delete on table "public"."verification_documents" to "authenticated";

grant insert on table "public"."verification_documents" to "authenticated";

grant references on table "public"."verification_documents" to "authenticated";

grant select on table "public"."verification_documents" to "authenticated";

grant trigger on table "public"."verification_documents" to "authenticated";

grant truncate on table "public"."verification_documents" to "authenticated";

grant update on table "public"."verification_documents" to "authenticated";

grant delete on table "public"."verification_documents" to "service_role";

grant insert on table "public"."verification_documents" to "service_role";

grant references on table "public"."verification_documents" to "service_role";

grant select on table "public"."verification_documents" to "service_role";

grant trigger on table "public"."verification_documents" to "service_role";

grant truncate on table "public"."verification_documents" to "service_role";

grant update on table "public"."verification_documents" to "service_role";

CREATE TRIGGER update_addresses_updated_at BEFORE UPDATE ON public.addresses FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_audit_logs_updated_at BEFORE UPDATE ON public.audit_logs FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_availability_slots_updated_at BEFORE UPDATE ON public.availability_slots FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_blocked_periods_updated_at BEFORE UPDATE ON public.blocked_periods FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON public.bookings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_messages_updated_at BEFORE UPDATE ON public.messages FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_reviews_updated_at BEFORE UPDATE ON public.reviews FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_service_addons_updated_at BEFORE UPDATE ON public.service_addons FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_services_updated_at BEFORE UPDATE ON public.services FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_verification_documents_updated_at BEFORE UPDATE ON public.verification_documents FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();