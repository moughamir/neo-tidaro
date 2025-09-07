# GEMINI.md: AI Collaboration Guide

This document provides essential context for AI models and contributors working in this project. Adhering to these guidelines ensures consistency, modularity, and long-term maintainability.

## 1. Project Overview & Purpose

- **Primary Goal:**
  This repository is a **multi-package Flutter/Dart monorepo** managed with **Melos**. It enables modular development where apps, features, and core libraries coexist in a unified workspace.

The primary target is **Tidaro** — a housekeeping and service mediation platform designed for Morocco and scalable to global markets. The app is **mobile-first**, with emphasis on **multi-language accessibility** (Arabic, Tifinagh, Berber Latin, English, French).

## 2. Core Technologies & Stack

- **Languages:** Dart (latest stable supported by Flutter).
- **Frameworks & Runtimes:** Flutter for cross-platform (iOS, Android, Web).
- **Backend & Database:** Supabase/PostgreSQL (auth, realtime, data sync).
- **Monorepo Tooling:**

  - [`melos`](https://melos.invertase.dev) → workspace manager
  - `dart pub` → package dependencies

## 3. Workspace Structure

This project follows a **Melos workspace** layout.

```
.
├── apps/                 # App entrypoints
│   ├── tidaro/           # Main Tidaro mobile app
│   └── ...               # Future apps (admin, web, etc.)
│
├── packages/             # Shared and feature packages
│   ├── authentication/   # Auth flows (login, signup, magic links)
│   ├── chat/             # Messaging & chat features (Supabase realtime)
│   ├── gamification/     # Points, badges, rewards system
│   ├── onboarding/       # Onboarding flows and screens
│   ├── theme/            # Design tokens, theming system
│   ├── ui_components/    # Reusable Flutter widgets
│   └── utils/            # Core helpers, constants, and extensions
│
├── melos.yaml            # Melos workspace configuration
├── pubspec.yaml          # Root dependencies
└── scripts/              # Project automation & CI/CD helpers
```

**Philosophy:**

- `/apps` → Minimal entrypoints that compose features.
- `/packages` → Independent, reusable feature modules.
- No business logic inside `/apps`, only wiring and presentation.

## 4. Coding Conventions & Style Guide

- **Formatting:**

  - Use `dart format` (2-space indentation, trailing commas).
  - Must pass `flutter analyze`.

- **Naming Conventions:**

  - Variables, functions: `camelCase`
  - Classes, Widgets: `PascalCase`
  - Files: `snake_case.dart`

- **API & State Management:**

  - Supabase for backend interactions.
  - Keep networking, models, and services in `packages/`.
  - UI widgets consume these via dependency injection.

- **Error Handling:**

  - Always handle async errors (`try/catch`, `FutureBuilder`, `AsyncSnapshot`).
  - Use `Either/Result` patterns in shared packages where applicable.

## 5. Key Files & Entrypoints

- `apps/tidaro/lib/main.dart` → Main app entrypoint.
- `melos.yaml` → Defines packages and workspace graph.
- `pubspec.yaml` → Declares dependencies at the root level.
- `scripts/` → Contains automation, bootstrap, and CI/CD scripts.

## 6. Development & Testing Workflow

**Setup:**

1. Install Flutter SDK (latest stable).
2. Run `melos bootstrap` to link all packages.
3. Run an app with `flutter run` from `apps/tidaro/`.

**Testing:**

- Use `flutter test` for unit/widget tests.
- Each package should maintain its own `/test` directory.

**CI/CD:**

- Pipelines should include:

  - `melos bootstrap`
  - `flutter analyze`
  - `flutter test`

- Future: build/deploy to Android, iOS, Web.

## 7. AI Collaboration Guidelines

- **Modularity First:**

  - New features → new package under `/packages`.
  - Keep `/apps` lean, import only what’s needed.

- **Security:**

  - Do not commit secrets or Supabase keys.
  - Use `.env` and secure injection at runtime.

- **Dependencies:**

  - Add via `dart pub add <package>` inside the correct package.
  - Sync with `melos.yaml` if package graph changes.

- **Commits:**

  - Follow Conventional Commits:

    - `feat:` → new feature
    - `fix:` → bug fix
    - `chore:` → infra/tooling updates
    - `docs:` → documentation changes
