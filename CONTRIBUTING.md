---
title: CONTRIBUTING
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# Contributing Guide

Thank you for investing your time in Neo-Tidaro! Please follow this guide to keep contributions consistent and high quality.

## Git Flow Branching Model

We follow Git Flow with the following branches:

- `main`: production-ready code
- `develop`: integration branch for features
- `feature/*`: feature development branches (e.g., `feature/dashboard-grid`)
- `release/*`: release preparation branches (e.g., `release/v0.2.0`)
- `hotfix/*`: quick fixes from `main` (e.g., `hotfix/critical-crash`)

### Typical Workflow
1. Branch from `develop`:
   ```bash
   git checkout develop
   git pull
   git checkout -b feature/my-feature
   ```
2. Commit using Conventional Commits:
   - `feat(scope): ...`, `fix(scope): ...`, `docs: ...`, `refactor(scope): ...`
3. Keep branch up-to-date:
   ```bash
   git fetch origin
   git rebase origin/develop
   ```
4. Open a Pull Request into `develop`.
5. After approval, squash & merge.

### Release Workflow
- Create `release/x.y.z` from `develop`
- Stabilize, bump versions with `melos version`, update `CHANGELOG.md`
- Merge into `main` and `develop`, tag `vX.Y.Z`

## Development Standards

- State management: Redux (standard across apps). Avoid BLoC.
- Localization: Use `packages/languist` via `melos run gen:l10n`
- Architecture: Clean Architecture across packages (`core`, `shared`, `ui_kit`, `languist`)
- UI: Material 3 with neumorphism/glassy components from `ui_kit`

## Running Checks Locally
```bash
melos bootstrap
melos analyze
melos test
```

## Commit & PR Checklist
- [ ] Redux-based state changes are covered with unit tests or manual QA notes
- [ ] No hardcoded strings (use Languist)
- [ ] `melos analyze` and `melos test` pass locally
- [ ] UI changes include screenshots/GIFs
- [ ] Documentation updated if needed

## Code Review Guidelines
- Prefer small, focused PRs
- Confirm separation of concerns between packages
- Check i18n usage and error handling

## Issue Reporting
Use the issue templates under `.github/ISSUE_TEMPLATE/` for bugs and feature requests.