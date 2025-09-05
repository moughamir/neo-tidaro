# Contributing to Tidaro

First off, thank you for considering contributing to Tidaro! It's people like you that make Tidaro such a great tool.

This document provides a set of guidelines for contributing to the Tidaro workspace. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Code of Conduct

This project and everyone participating in it is governed by the [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [project-owner-email@example.com](mailto:project-owner-email@example.com).

## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report for Tidaro. Following these guidelines helps maintainers and the community understand your report, reproduce the behavior, and find related reports.

-   **Use a clear and descriptive title** for the issue to identify the problem.
-   **Describe the exact steps which reproduce the problem** in as many details as possible.
-   **Provide specific examples to demonstrate the steps.** Include links to files or GitHub projects, or copy/pasteable snippets, which you use in those examples.
-   **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
-   **Explain which behavior you expected to see instead and why.**

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for Tidaro, including completely new features and minor improvements to existing functionality.

-   **Use a clear and descriptive title** for the issue to identify the suggestion.
-   **Provide a step-by-step description of the suggested enhancement** in as many details as possible.
-   **Provide specific examples to demonstrate the steps.** Include copy/pasteable snippets which you use in those examples.
-   **Explain why this enhancement would be useful** to most Tidaro users.

### Pull Requests

The process described here has several goals:

-   Maintain Tidaro's quality
-   Fix problems that are important to users
-   Engage the community in working toward the best possible Tidaro
-   Enable a sustainable system for Tidaro's maintainers to review contributions

Please follow these steps to have your contribution considered by the maintainers:

1.  **Follow the coding conventions** described in the `GEMINI.md` file.
2.  **Ensure that your code passes all tests** by running `melos run test`.
3.  **Ensure that your code is properly formatted and analyzed** by running `melos run format` and `melos run analyze`.
4.  **After you submit your pull request, verify that all status checks are passing**.

## Styleguides

### Git Commit Messages

-   Use the present tense ("Add feature" not "Added feature").
-   Use the imperative mood ("Move cursor to..." not "Moves cursor to...").
-   Limit the first line to 72 characters or less.
-   Reference issues and pull requests liberally after the first line.

### Dart Styleguide

-   All Dart code must be formatted with `dart format`.
-   Follow the conventions described in the `GEMINI.md` file.
