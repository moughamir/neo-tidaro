---
title: 02-workspace-structure
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# 2. Workspace Structure

This project is a multi-package Flutter/Dart monorepo managed with [Melos](https://melos.invertase.dev). Understanding its structure is crucial for efficient development and maintaining modularity.

## High-Level Overview

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

## Key Directories and Their Purpose

### `apps/`

This directory contains the actual deployable applications. Each subdirectory within `apps/` represents a distinct application.

*   **Minimal Entrypoints**: Applications in this directory are designed to be minimal. They primarily serve as entry points that compose features and UI from the shared `packages/`.
*   **No Business Logic**: Crucially, `apps/` should contain very little to no business logic. All core functionalities, services, and reusable UI components reside in the `packages/` directory.

	*Example: `apps/tidaro/` is the main mobile application for Tidaro.*

### `packages/`

This is the heart of the monorepo, containing independent, reusable feature modules and shared libraries. The philosophy here is **modularity first**.

*   **Independent Modules**: Each subdirectory under `packages/` is a self-contained Dart/Flutter package.
*   **Reusability**: These packages are designed to be reusable across different applications within the monorepo, or even in other projects if needed.
*   **Feature-Driven**: Many packages are feature-driven (e.g., `authentication`, `chat`, `gamification`), encapsulating all logic and UI related to that specific feature.
*   **Shared Components**: Other packages provide shared utilities, design tokens, or UI components (e.g., `theme`, `ui_components`, `utils`).

### Root Level Files

*   **`melos.yaml`**: This is the central configuration file for Melos. It defines the packages within the workspace and can include scripts and commands that operate across the entire monorepo.
*   **`pubspec.yaml`**: The root `pubspec.yaml` declares dependencies that are common across the entire workspace, or specific to Melos itself. Individual packages will have their own `pubspec.yaml` files for their specific dependencies.
*   **`scripts/`**: Contains various automation scripts, CI/CD helpers, and other utilities that support the development workflow.

## Philosophy: Keep `apps/` Lean

The core principle guiding this monorepo's structure is to keep the `apps/` directories as lean as possible. They should primarily handle wiring, dependency injection, and presentation, while all significant business logic, data models, and reusable UI components are encapsulated within the `packages/`.

This approach promotes:
*   **Modularity**: Features are self-contained and easier to manage.
*   **Reusability**: Code can be shared effortlessly across different applications.
*   **Maintainability**: Changes in one feature are less likely to impact unrelated parts of the application.
*   **Testability**: Individual packages can be tested in isolation.

---

**Next:** Learn how to create new packages in `03-creating-new-packages.md`.