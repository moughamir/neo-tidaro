---
created_date: 07/09/2025
updated_date: 20/11/2025
---
# ADR: Canonical Domain Shape and Supabase Mapping Strategy

Date: 2025-09-07
Status: Accepted

## Context

The Neo-Tidaro workspace contains:

- Domain entities in `packages/shared/lib/domain/entities/` which model rich application concepts.
- UI-/feature-facing simple models in `packages/shared/lib/domain/models/`.
- A Supabase-backed database defined in `supabase/schemas/schema.sql`.

We observed divergence between domain structures and the database schema (naming, enums, and fields), and duplicate enum/model definitions across the domain layer.

## Decision

1. **Canonical domain**: The canonical domain model is the set of classes under `packages/shared/lib/domain/entities/`. These remain independent of persistence concerns and are optimized for app logic and Redux state shape.

2. **DTOs and mappers layer**:

   - Introduce DTOs and mappers under `packages/shared/lib/data/mappers/` that mirror the Supabase schema exactly (snake_case fields, SQL enums).
   - Convert between DTOs and domain entities/models explicitly.
   - Enums are mapped via dedicated functions that translate snake_case SQL values ⇄ camelCase domain enums.

3. **Single source of truth for enums**:

   - Keep the authoritative domain enum definitions in `packages/shared/lib/domain/enums/enums.dart`.
   - Avoid redefining the same enums in `packages/shared/lib/domain/models/*` going forward.

4. **Persistence vocabulary policy**:
   - Where SQL enum values differ from domain vocabulary (e.g., DB `paid` vs domain `completed`), we formalize the mapping in the mappers and keep domain vocabulary human-centric.
   - Only migrate SQL when the domain concept cannot be faithfully represented via mapping.

## Consequences

- The domain layer stays clean and does not leak persistence concerns (naming, snake_case, SQL-specific enums).
- All serialization/deserialization lives in one place, reducing duplication and drift.
- Some additional boilerplate is required for DTOs/mappers, but change is localized.

## Implementation Notes

- File: `packages/shared/lib/data/mappers/supabase_mappers.dart`
  - Provides enum mappers for `UserRole`, `BookingStatus`, `ServiceCategory`, `PaymentStatus`, `ProfessionalStatus`, `MessageType`, `DocumentType`, `VerificationStatus`.
  - Provides `SupabaseProfileDto` to map between `profiles` rows and the domain `Profile` (from `packages/shared/lib/domain/models/profile_models.dart`).
- Future DTOs: add DTOs for `bookings`, `addresses`, `services`, `messages`, etc., following the same pattern.

## Known Gaps and Next Steps

- `availability_slots`: DB uses full `TIMESTAMPTZ` ranges; domain uses `TimeOfDay` and `isAvailable`. Decide whether to extend SQL (add `is_available` and local time) or update domain to `DateTime` ranges and compute availability.
- `payments`: Domain expects `currency` and `refundAmount` not present in SQL. If required, extend SQL; otherwise, remove from domain or compute.
- `messages`: Moderation and media fields are domain-only. Add to SQL if moderation is required.
- `audit_logs`: Domain separates `previousValues/newValues`; DB has a single `details` JSONB. Either adapt domain to single blob or split SQL into two columns.
- Consolidate duplicate enums/models: refactor `packages/shared/lib/domain/models/*` to stop redefining enums available in `domain/enums`.

## Alternatives Considered

- Align domain classes strictly to SQL schema: rejected to keep domain independent from persistence.
- Use code generation for mappers: deferred for now to maintain control and clarity; revisit once the schema settles.

## References

- `supabase/schemas/schema.sql`
- `packages/shared/lib/domain/entities/entity.dart`
- `packages/shared/lib/domain/enums/enums.dart`
- `packages/core/lib/network/supabase_service.dart`
