# AI Loading Order

Token efficiency is a rule. Start at the lowest load level that keeps the next step defensible.

## Load Levels

| Load Level | Read | Use When |
| --- | --- | --- |
| `minimal` | `AGENTS.md`, `docs/spec-packs/<feature-id>/spec_pack.md` when feature-scoped, this file, `docs/governance/core-rules.md` | first-pass triage, narrow `review`, narrow `audit`, minor text-only `docs` fixes |
| `extended` | `minimal` plus `docs/execution/task-routing.md` when the header is unclear, `docs/governance/minimal-context.md`, `docs/governance/minimal-quality.md` when validating artifact strength, `docs/execution/task-contracts.md`, `docs/spec-packs/<feature-id>/reinforcement.md` for non-trivial work, `docs/structure.md` when creating or validating a task folder, and only the touched standards, including `docs/standards/codebase-conformance-rules.md` for `implement`, `fix`, or code-shape `review` | default for `implement`, `fix`, `docs`, and `hotfix`; multi-file `review`; governed spec-pack authoring |
| `full` | `extended` plus the active task artifact (`verification.md`, `review.md`, or `audit.md`), related decisions, and targeted archived comparison only if active docs still leave a gap | framework changes, cross-module work, DB or API changes, ambiguous requests, or final closeout |

## Task Map

- `implement`, `fix`, `hotfix`: start at `extended`; move to `full` for framework, API, DB, or cross-module scope.
- `docs`: start at `minimal` for wording-only edits; use `extended` for governed doc work; use `full` for framework-rule changes.
- `review`: start at `minimal` for narrow diff review; use `extended` for multi-file or standards-heavy review; use `full` when findings depend on broader framework or contract rules.
- `audit`: start at `minimal` for narrow inspection; use `extended` for multi-surface audit; use `full` for repo-wide or governance audits.

## Additional Reads By Risk

- read `docs/standards/api-rules.md` before changing API, DTO, response, file, or request shape
- read `docs/standards/codebase-conformance-rules.md` before choosing naming, folder placement, abstraction, DTO shape, transport path, validation path, or SQL style
- read `docs/standards/db-rules.md` and `docs/standards/schema_database.yaml` before DB-related analysis or changes
- read `docs/standards/testing-rules.md` before final verification or review
- read `docs/templates/README.md` and the matching function-spec template before authoring or reviewing companion function specs
- read `docs/governance/traceability-policy.md` before authoring or reviewing function-spec traceability
- read `docs/decisions/README.md` and `docs/templates/adr.template.md` when the work introduces a reusable or cross-module design choice

## Repository Anchors

- backend Java: `src/main/java`
- shared backend infra: `src/main/java/jp/co/brycen/common`
- application backend: `src/main/java/jp/co/brycen/kikancen`
- frontend Angular: `src/main/webapp/angular`
- runtime resources: `src/main/resources`
- bundled web artifacts: `src/main/webapp/WEB-INF`
- DB schema authority: `docs/standards/schema_database.yaml`

## Rule

Do not reopen large archived surfaces by default. Use `docs/archive/sdd-v1/` only when the active pack, active docs, and inspected code still leave a legacy gap.
