# Generated Spec Pack

- Feature: `fixture-valid-full-path`
- Source manifest: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/spec-pack.manifest.yaml`
- Source package: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/`
- Status: `ready-for-implementation`
- Purpose: agent execution and review aid; the feature package remains the governance source of truth

## Entry Points

- `AGENTS.md`

## Loading Context

- `docs/sdd/context/constitution.md`
- `docs/sdd/context/note.md`
- `docs/sdd/context/architecture-context.md`
- `docs/sdd/context/product-context.md`
- `docs/sdd/context/tech-context.md`

## Context Summary: constitution.md

- 1. Non-trivial changes MUST be governed by a feature package in `docs/specs/`.
- 2. Requirements, design, tasks, acceptance criteria, and test cases MUST exist before governed implementation starts.
- 3. Prompts MUST NOT override repository context, governance, or the governing feature package.
- 4. API, DTO, file, and durable data shape changes MUST update machine-readable contracts when the feature owns them.
- 5. Generated spec-packs MUST NOT replace the feature package as the approval or review source of truth.
- 6. Business logic changes MUST have verification tied to `TC-` items and recorded evidence.

## Context Summary: note.md

- Treating `README.md` at repo root as the operating source of truth. It is still boilerplate; use `AGENTS.md` and `docs/`.
- Implementing from prompt wording without reading the governing feature package and standards.
- Updating backend behavior without checking matching frontend transport flow, SQL criteria logic, and error routing.
- Changing SQL without documenting affected tables, rollback notes, and regression-sensitive cases in the feature package.
- Claiming automated coverage where only manual verification exists.
- Adding `e.printStackTrace()` in module code instead of using `logSend()` through the shared `ILogSender` chain.

## Context Summary: architecture-context.md

- Backend Java code: `src/main/java`
- Shared infrastructure: `src/main/java/jp/co/brycen/common`
- Application-specific backend code: `src/main/java/jp/co/brycen/kikancen`
- Frontend Angular app: `src/main/webapp/angular`
- Runtime resources and properties: `src/main/resources`
- Bundled web artifacts and libs: `src/main/webapp/WEB-INF`

## Context Summary: product-context.md

- `kikancen` is a legacy enterprise business application with a Java backend, Angular frontend, and SQL-heavy data flows. The repo has a modern SDD layer, but the application itself is still organized around long-lived screen, API, and data-handling patterns.
- screen behavior and validation changes
- backend process and webservice changes under `/webapi/*`
- SQL query, schema, transaction, and audit-flow changes
- CSV, Excel, PDF, and download/export behavior
- shared code-table, master-data, and permission-sensitive behavior

## Context Summary: tech-context.md

- Java 8 compilation target in `pom.xml`
- Maven WAR packaging
- Jersey / JAX-RS backend stack
- Angular 13 frontend scripts in `package.json`
- Log4j2 logging
- JUnit test dependencies for backend

## Relevant Standards

- `docs/sdd/standards/repository-context.md`

## Standard Summary: repository-context.md

- Use this file when scoping a change or locating the primary implementation area.
- Read it before design work on an unfamiliar module. Use it to identify the backend, frontend, resource, and deployment shape of the repository.
- correct module impact notes in `02-design.md`
- correct folder placement for new code and docs
- If the touched module family or runtime area is unclear, stop and resolve that before design approval.

## Feature Summary

- Title: `Full path validator fixture`
- Source: `README.md`
- Source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/01-requirements.md`
- Source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/02-design.md`
- Source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/03-data-model.md`
- Source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/04-api-contract.md`
- Source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/05-behavior.md`
- Source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/06-edge-cases.md`
- Source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/07-tasks.md`
- Source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/08-acceptance-criteria.md`
- Source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/09-test-cases.md`

## Source Base Anchors

- Backend process anchor files: `src/main/java/example/full/FixtureExportProcess.java`
- Backend webservice anchor files: `src/main/java/example/full/FixtureExportWebService.java`
- SQL anchor files: `src/main/resources/example/full/fixture-export.sql`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Reuse the current backend process plus webservice split and keep the fixture generated-pack content derived directly from the source package.
- New tables/source families/screen structure in scope: `yes` for one additive fixture audit table; `no` for new screen structure.

## Related Code References

- Start implementation and review from the source-base anchors above.
- Compare sibling flows in the same module family before changing existing search, count, detail, update, delete, import, export, or download behavior.
- Existing implementation evidence: `n/a`

## Scope Guardrails

- README scope and out-of-scope notes: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/README.md`
- One backend export endpoint
- One audit data model
- One generated spec-pack
- Additional screens
- Shared module refactors
- Design non-changes: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/02-design.md`
- No shared frontend changes
- No asynchronous job flow

## Traceability Snapshot

- Table content kept in source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/README.md`

## Requirements Snapshot

- The validator needs a small full-path package with contracts and a generated spec-pack.
- One export endpoint
- One audit record shape
- Shared refactors
- UI redesign
- Table content kept in source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/01-requirements.md`

## Design Snapshot

- Approach: define one compact full-path feature with explicit contracts and one generated spec-pack.
- Requirement links: `REQ-01`, `REQ-02`
- No fixture package exists for contract and spec-pack enforcement tests.
- A compact full-path fixture package exists with aligned prose, contracts, and generated pack.
- Backend: one process and one webservice family
- Frontend: none
- Database: one fixture audit entity
- Integrations: generated spec-pack for execution aid coverage

## Data Contract Notes

- Table content kept in source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/03-data-model.md`

## API Contract Notes

- Method: `POST`
- Path: `/webapi/fixture/export`
- Auth: existing authenticated session
- Table content kept in source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/04-api-contract.md`

## Behavior Notes

- A caller submits one fixture export request.
- The backend validates the request and returns a CSV stream.

## Edge Cases

- Invalid request payload returns `FIXTURE_INVALID_REQUEST`.
- Unexpected generation failure is out of scope for this fixture.

## Task Notes

- Table content kept in source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/07-tasks.md`

## Acceptance Notes

- Table content kept in source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/08-acceptance-criteria.md`

## Test Notes

- Table content kept in source: `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/09-test-cases.md`

## Locked Contracts

- `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/contracts/openapi.yaml`
- `docs/specs-support/fixtures/__sdd-validator-suite-fails-contract-reference/contracts/schemas/fixture-export-request.schema.json`

## Assumptions

- The fixture contract files are test-only artifacts.

## Open Questions

- None.

## Legacy Bridge References

- None

## Implementation Constraints

- Treat the feature package as authoritative if the generated pack and prose spec ever differ.
- Do not invent missing behavior, schema rules, error handling, or rollout logic.
- Use contracts for wire or data shape; use specs for scope, intent, rollout, and traceability.
- Preserve the dominant local module pattern instead of creating a new family by convenience.
- Load `agent/` only when canonical docs do not already answer the task.
- Identify and follow source-base anchors in the touched module family before editing backend, SQL, or frontend files.
- Keep SQL and Angular HTML formatting aligned with the named anchor files; do not reformat to a new style.
- Do not introduce new table definitions, new source families, or new screen structure unless the governing spec explicitly marks them in scope.
- Keep implementation within the documented in-scope, out-of-scope, and non-change boundaries.
- Stop and record conflicts or missing artifacts instead of guessing through them.
