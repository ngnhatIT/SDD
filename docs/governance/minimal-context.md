# Minimal Context

Load only what is needed for the next safe step.

## Default Baseline

1. `AGENTS.md`
2. `docs/spec-packs/<feature-id>/spec_pack.md` when the task is feature-scoped
3. `docs/execution/ai-loading-order.md`
4. `docs/governance/core-rules.md`

## Add These When Needed

- `docs/spec-packs/<feature-id>/reinforcement.md` for non-trivial work
- `docs/execution/task-routing.md` when task type is unclear
- `docs/execution/task-contracts.md` when deciding required outputs
- `docs/structure.md` when creating, validating, or closing a task folder
- `docs/standards/coding-rules.md` for code changes
- `docs/standards/api-rules.md` for API, DTO, response, or file-shape changes
- `docs/standards/db-rules.md` and `docs/standards/schema_database.yaml` for DB-related work
- `docs/standards/testing-rules.md` when planning or reviewing verification
- the task-specific trace artifact (`verification.md`, `review.md`, or `audit.md`) when resuming or closing work

## Deepening Triggers

Deepen immediately when:

- the task touches contracts, DB rules, auth, tenant behavior, or file shape
- the task spans multiple module families
- the correct local pattern is not obvious
- the request wording conflicts with the pack or code
- you are about to close the work out

## Guardrail

Minimal context is valid only when the next step is still defensible without guessing.
