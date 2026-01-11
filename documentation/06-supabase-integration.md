---
title: 06-supabase-integration
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# 6. Supabase Integration

Supabase serves as the primary backend for the Tidaro platform, providing authentication, real-time capabilities, and a PostgreSQL database. This guide provides an overview of how Supabase is integrated and key considerations for working with it.

## 1. Supabase as a Backend

Supabase is an open-source Firebase alternative that offers:

*   **PostgreSQL Database**: A robust and scalable relational database.
*   **Authentication**: User management, including email/password, magic links, and OAuth providers.
*   **Realtime**: WebSocket capabilities for instant data synchronization.
*   **Storage**: File storage for user-generated content.
*   **Edge Functions**: Serverless functions for custom backend logic.

In this project, Supabase is primarily used for:

*   **User Authentication**: Handling user sign-up, login, and session management.
*   **Data Storage**: Storing application data in the PostgreSQL database.
*   **Realtime Features**: Enabling real-time updates for features like chat (`packages/chat/`).

## 2. Integration within Packages

Backend interactions with Supabase are typically encapsulated within dedicated service layers or repositories located in the `packages/` directory. This ensures a clear separation of concerns and promotes testability.

For example, you might find Supabase client usage within:

*   `packages/authentication/`: For user authentication flows.
*   `packages/chat/`: For real-time messaging and data persistence.
*   `packages/shared/domain/`: For data models and repositories that interact with the database.

## 3. Security Considerations

**CRITICAL**: Never commit sensitive information, such as Supabase API keys or service role keys, directly into the codebase or version control.

*   **Environment Variables**: Always use environment variables to manage Supabase credentials. For Flutter applications, this typically involves using a package like `flutter_dotenv` or similar mechanisms to load keys at runtime.

	*   **Local Development**: Use a `.env` file (which should be in your `.gitignore`) for local development.
	*   **Production**: Configure your CI/CD pipeline to inject these environment variables securely during the build and deployment process.

*   **Row Level Security (RLS)**: Leverage Supabase's Row Level Security (RLS) policies on your PostgreSQL tables to control data access based on user roles and authentication status. This is crucial for securing your data and preventing unauthorized access.

*   **Client-Side vs. Server-Side**: Be mindful of what operations are performed client-side versus server-side. Sensitive operations should ideally be handled by Supabase Edge Functions or a secure backend service, rather than directly from the client application.

## 4. Database Migrations and Seeds

Database schema changes and initial data seeding are managed within the `supabase/` directory at the monorepo root:

*   **`supabase/migrations/`**: Contains SQL migration files that define changes to the database schema. These are typically managed using the Supabase CLI.
*   **`supabase/seeds/`**: Contains SQL files for seeding initial data into your database. This is useful for setting up development environments or populating lookup tables.

## 5. Local Development with Supabase

Neo-Tidaro uses the official Supabase CLI for local development. This runs the full stack (Postgres, Auth, Realtime, PostgREST, Storage, Studio, Kong) with the correct wiring and ports defined by `supabase/config.toml`.

### Prerequisites
- Install Supabase CLI: https://supabase.com/docs/guides/cli

### Common Commands
```bash
# From the repo root

# Start local stack
supabase start

# Show status and ports (API: 54321, DB: 54322, Studio: 54323)
supabase status

# Reset database and apply migrations from supabase/migrations
supabase db reset

# Seed data (example)
supabase db reset --seed supabase/seeds/01_initial_tidash_data.sql

# Stop the stack
supabase stop
```

### Notes
- We intentionally keep `docker-compose.yml` as a no-op to avoid drift from Supabase's official local stack and to prevent port/structure conflicts.
- If you temporarily need pgAdmin, connect it to the Supabase Postgres port (54322) while the stack is running, but do not commit custom compose files.

---

**Next:** Explore the project's approach to multi-language support in `07-internationalization.md`.