# Agent Operating Contract

This file is the root execution contract for AI agents in `kikancen`.

## Authority

1. `AGENTS.md`
2. `docs/execution/ai-loading-order.md`
3. `docs/governance/core-rules.md` and the other files in `docs/governance/`
4. `docs/execution/task-routing.md` and `docs/execution/task-contracts.md`
5. `docs/structure.md`
6. `docs/spec-packs/<feature-id>/spec_pack.md`
7. `docs/spec-packs/<feature-id>/reinforcement.md` for non-trivial work
8. relevant files in `docs/standards/`
9. the task-specific trace artifact under `docs/spec-packs/<feature-id>/`, such as `verification.md`, `review.md`, or `audit.md`
10. `docs/decisions/`
11. `docs/archive/sdd-v1/` only when active docs still leave a legacy implementation gap

No archived file outranks an active file.

## Required Read Order

1. `AGENTS.md`
2. `docs/spec-packs/<feature-id>/spec_pack.md` when the task is feature-scoped
3. `docs/execution/ai-loading-order.md`
4. `docs/execution/task-routing.md` when task type is unclear or no header is given
5. `docs/governance/core-rules.md`
6. `docs/governance/minimal-context.md`
7. `docs/spec-packs/<feature-id>/reinforcement.md` for non-trivial work
8. `docs/structure.md` when creating, validating, or closing a task folder
9. only the relevant files in `docs/standards/`
10. the task-specific trace artifact under `docs/spec-packs/<feature-id>/`, such as `verification.md`, `review.md`, or `audit.md`, when resuming, reviewing, or closing work

## Database Schema Authority

- `docs/standards/schema_database.yaml` is the single source of truth for database structure.
- If code, docs, or assumptions conflict with that file, stop and report the conflict.

## Optional Task Header

```md
Task Type: implement | fix | review | docs | audit | hotfix
Feature Pack: docs/spec-packs/<feature-id>/ | n/a
Standards: auto | docs/standards/<file>[, docs/standards/<file>...]
```

If the header is missing, route through `docs/execution/task-routing.md`.

## Core Rules

- `spec_pack.md` is the canonical feature artifact.
- `reinforcement.md` is mandatory for non-trivial work.
- a task-specific Markdown artifact is required before final closeout: `verification.md` for `implement`, `fix`, `docs`, and `hotfix`; `review.md` for `review`; `audit.md` for `audit`
- use `docs/structure.md` for task-folder naming and artifact placement
- run `python scripts/validate-task.py <task-folder> <task-type> [--non-trivial]` before final closeout when the task has a governed folder
- Do not guess unresolved behavior, contracts, schema rules, validation rules, or rollout behavior.
- Preserve approved API, DTO, file, DB, auth, tenant, and response contracts unless `spec_pack.md` explicitly changes them.
- Keep task artifacts grounded to `spec_pack.md`; use `verification.md` for acceptance coverage on change-making tasks and `review.md` or `audit.md` for findings-only traceability.
- Load the minimum context needed for the next safe step, then deepen only when risk or ambiguity requires it.
- Record assumptions, blockers, residual risks, and confidence in the relevant feature artifact, not only in chat.

## Hard Stops

- Stop if a non-trivial task has no usable `spec_pack.md`.
- Stop if non-trivial work has no `reinforcement.md`.
- Stop if the next step would change externally visible behavior without explicit approval in `spec_pack.md`.
- Stop if schema, code, standards, and the feature pack disagree.
- Stop if the task folder layout conflicts with `docs/structure.md`.
- Stop if you cannot identify the local module pattern or contract owner from active docs and inspected code.
- Stop when confidence is too low to defend the next change.

## Legacy

- The previous SDD framework, feature packages, flat spec packs, manuals, and shell tooling were archived under `docs/archive/sdd-v1/` and `scripts/archive/sdd-v1/`.
- Do not route normal work through the archived surface.
