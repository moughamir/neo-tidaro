---
title: 01-getting-started
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# 1. Getting Started with the Tidaro Monorepo

This guide will walk you through the initial setup of the Tidaro monorepo, bootstrapping the workspace, and running your first application.

## Prerequisites

Before you begin, ensure you have the following installed:

*   **Flutter SDK**: Make sure you have the latest stable version of the Flutter SDK installed and configured. You can find installation instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
*   **Melos**: This project uses Melos for monorepo management. Install it globally:

	```bash
    pnpm add -g @invertase/melos
    # or
    # dart pub global activate melos
    ```

## 1. Workspace Bootstrap

Once you have cloned the repository, navigate to the root directory of the monorepo. The first step is to bootstrap the workspace using Melos. This command will link all local packages and install their dependencies.

```bash
melos bootstrap
```

This command performs the following key actions:
*   Installs dependencies for all packages.
*   Links local packages together, resolving inter-package dependencies.
*   Generates necessary files for the workspace.

## 2. Running an Application

After bootstrapping, you can run any of the applications located in the `apps/` directory. For example, to run the main Tidaro mobile application:

1.  Navigate into the `apps/tidaro` directory:

	```bash
    cd apps/tidaro
    ```

2.  Run the Flutter application:

	```bash
    flutter run
    ```

This will build and launch the Tidaro application on your connected device or emulator.

---

**Next:** Proceed to `02-workspace-structure.md` to understand the layout of this monorepo.