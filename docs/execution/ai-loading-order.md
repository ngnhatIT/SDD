# AI Loading Order

## Default Order

1. `AGENTS.md`
2. `docs/spec-packs/<feature-id>/spec_pack.md` when the task is feature-scoped
3. this file
4. `docs/execution/task-routing.md` when task type is unclear or no header is given
5. `docs/governance/core-rules.md`
6. `docs/governance/minimal-context.md`
7. `docs/spec-packs/<feature-id>/reinforcement.md` for non-trivial work
8. only the relevant files under `docs/standards/`
9. the task-specific trace artifact under `docs/spec-packs/<feature-id>/`, such as `verification.md`, `review.md`, or `audit.md`, when resuming, reviewing, or closing

## Additional Reads By Risk

- read `docs/standards/api-rules.md` before changing API, DTO, response, file, or request shape
- read `docs/standards/db-rules.md` and `docs/standards/schema_database.yaml` before DB-related analysis or changes
- read `docs/standards/testing-rules.md` before final verification or review

## Repository Anchors

- backend Java: `src/main/java`
- shared backend infra: `src/main/java/jp/co/brycen/common`
- application backend: `src/main/java/jp/co/brycen/kikancen`
- frontend Angular: `src/main/webapp/angular`
- runtime resources: `src/main/resources`
- bundled web artifacts: `src/main/webapp/WEB-INF`
- DB schema authority: `docs/standards/schema_database.yaml`

## Rule

Do not reopen large archived surfaces by default. Use `docs/archive/sdd-v1/` only when the active pack and inspected code still leave a legacy gap.
