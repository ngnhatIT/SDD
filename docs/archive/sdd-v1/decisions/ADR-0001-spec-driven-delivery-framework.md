# ADR-0001 Spec-Driven Delivery Framework

- Status: accepted
- Date: 2026-03-11
- Owners: repository maintainers
- Related specs: repository bootstrap

## Context

The repository is large, legacy-shaped, and split across Java backend code and Angular frontend code. Before this ADR, the tracked repo did not contain a real requirements-design-tasks-delivery chain, and most project knowledge lived in code or local-only notes.

That made change scope, review criteria, and handoff quality inconsistent.

## Decision

This repository adopts a spec-driven delivery workflow with these rules:

1. Requirements must exist before design.
2. Design must exist before implementation tasks.
3. Tasks must exist before coding starts.
4. Acceptance criteria and test cases must be written before coding starts.
5. Specs are the source of truth for implementation and review.
6. Architectural choices that affect multiple changes are recorded as ADRs.
7. Completed changes are traceable in `CHANGELOG.md`.

The tracked operating model lives under `docs/`.

## Consequences

- Every meaningful change now requires a change folder under `docs/specs/`.
- Pull requests are expected to link to the governing spec folder.
- Reviews can reject work that is not traceable to an approved spec.
- The repo gains more documentation files, but each one has a narrow, enforceable purpose.

## Follow-Up

- Future ADRs should refine the workflow rather than replacing it ad hoc.
- Legacy local notes should be migrated into tracked docs only when they add durable value.
