# Generated Spec Pack

- Feature: `2026-03-11-example-customer-export`
- Source manifest: `docs/specs-support/examples/2026-03-11-example-customer-export/spec-pack.manifest.yaml`
- Source package: `docs/specs-support/examples/2026-03-11-example-customer-export/`
- Status: `done`
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
- `docs/sdd/standards/backend-process-architecture.md`
- `docs/sdd/standards/frontend-screen-architecture.md`
- `docs/sdd/standards/database-change-rules.md`
- `docs/sdd/standards/module-patterns/csv.md`

## Standard Summary: repository-context.md

- Use this file when scoping a change or locating the primary implementation area.
- Read it before design work on an unfamiliar module. Use it to identify the backend, frontend, resource, and deployment shape of the repository.
- correct module impact notes in `02-design.md`
- correct folder placement for new code and docs
- If the touched module family or runtime area is unclear, stop and resolve that before design approval.

## Standard Summary: backend-process-architecture.md

- Use this file during backend design and implementation.
- Model backend changes on the surrounding process, DTO, and web service structure before adding new abstractions.
- backend package, DTO, process, and web service impact recorded in `02-design.md`
- code that follows the established execution flow
- Do not inline cross-cutting lifecycle behavior into feature code when the shared base-process pattern already handles it.

## Standard Summary: frontend-screen-architecture.md

- Use this file during frontend design and screen implementation.
- Match the existing component, route, and shared-service structure of the touched screen family.
- changed components, services, routes, and shared state recorded in `02-design.md`
- user-facing behavior documented in `05-behavior.md`
- Do not introduce a new frontend structure or state pattern without updating the design and, if needed, an ADR.

## Standard Summary: database-change-rules.md

- Use these rules when the change affects SQL, schema, stored logic, data migration, or transactional behavior.
- Document the database impact before coding, verify unknown schema facts, and preserve the established SQL and transaction pattern of the touched module family.
- affected tables, queries, and rollback notes recorded in `02-design.md`
- SQL anchor files and dominant local SQL style note recorded in `02-design.md`
- test coverage for normal, failure, and regression-sensitive data scenarios

## Standard Summary: csv.md

- Use this file when adding or changing CSV import or export behavior.
- Reuse the shared CSV family first, then keep feature-specific CSV behavior in a dedicated package only when the flow is not generic.
- CSV module choice documented in `02-design.md`
- CSV-specific verification in `09-test-cases.md`
- Do not invent a new CSV flow while an equivalent shared CSV pattern already exists nearby.

## Feature Summary

- Title: `Example customer search CSV export with audit logging`
- Source: `README.md`
- Source: `docs/specs-support/examples/2026-03-11-example-customer-export/01-requirements.md`
- Source: `docs/specs-support/examples/2026-03-11-example-customer-export/02-design.md`
- Source: `docs/specs-support/examples/2026-03-11-example-customer-export/03-data-model.md`
- Source: `docs/specs-support/examples/2026-03-11-example-customer-export/04-api-contract.md`
- Source: `docs/specs-support/examples/2026-03-11-example-customer-export/05-behavior.md`
- Source: `docs/specs-support/examples/2026-03-11-example-customer-export/06-edge-cases.md`
- Source: `docs/specs-support/examples/2026-03-11-example-customer-export/07-tasks.md`
- Source: `docs/specs-support/examples/2026-03-11-example-customer-export/08-acceptance-criteria.md`
- Source: `docs/specs-support/examples/2026-03-11-example-customer-export/09-test-cases.md`

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/tmt220funcget/process/Tmt220FuncGetProcess.java`; `src/main/java/jp/co/brycen/kikancen/tsm030search/process/Tsm030SearchProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/spcm00011searchStore/webservice/Spcm00011SearchStoreWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/tmt220funcget/process/Tmt220FuncGetProcess.java`; `src/main/java/jp/co/brycen/kikancen/tsm030search/process/Tsm030SearchProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/spcm00021/spcm00021.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/spcm00021/spcm00021.component.html`
- Dominant module/style note: Reuse the current JAX-RS webservice plus process split, `StringBuilder` SQL assembly style, and Angular screen-family layout patterns from the chosen anchor files instead of inventing a new export-specific structure.
- New tables/source families/screen structure in scope: `yes` for one additive audit table; `no` for new backend source families and `no` for new screen structure.

## Related Code References

- Start implementation and review from the source-base anchors above.
- Compare sibling flows in the same module family before changing existing search, count, detail, update, delete, import, export, or download behavior.
- Existing implementation evidence: `docs/specs-support/examples/2026-03-11-example-customer-export/11-implementation-report.md`

## Scope Guardrails

- README scope and out-of-scope notes: `docs/specs-support/examples/2026-03-11-example-customer-export/README.md`
- Add a CSV export action to the customer search screen.
- Reuse the active screen filters and sort order for export.
- Enforce the same authorization and company isolation rules as on-screen search.
- Block exports above the configured row limit.
- Write an audit row for successful and failed export attempts.
- Async export jobs
- Scheduled exports
- Email delivery of exported files
- Design non-changes: `docs/specs-support/examples/2026-03-11-example-customer-export/02-design.md`
- Search result pagination behavior does not change.
- Customer master data is not updated.
- No asynchronous job or notification flow is introduced.

## Traceability Snapshot

- Table content kept in source: `docs/specs-support/examples/2026-03-11-example-customer-export/README.md`

## Requirements Snapshot

- Customer service users can search customer data on screen, but they cannot export the filtered result set without manual work. The repository also lacks a durable audit trail for customer data exports from this screen.
- Customer service staff
- Team leaders with export permission
- Compliance reviewers who inspect export history
- Export current customer search results to CSV from the search screen
- Reuse active filters and sort order
- Enforce permission and company isolation
- Record audit rows for export attempts

## Design Snapshot

- Add an export action to the customer search screen. The frontend submits the active filter payload to a dedicated export endpoint. The backend reuses the same criteria builder as the interactive search, checks the matching row count, generates the CSV when the result set is within limit, and writes an audit row for the attempt.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`, `REQ-05`, `REQ-06`
- Customer search is available only as an on-screen list.
- Users must manually copy data or request an extract.
- No export-specific audit trail exists for this screen.
- Authorized users can export the current filtered result set to CSV from the search screen.
- Exported rows match the same visibility rules as the interactive search.
- Over-limit requests are blocked before file generation.

## Data Contract Notes

- This feature does not change customer master data. It adds one audit table for export attempts.
- Table content kept in source: `docs/specs-support/examples/2026-03-11-example-customer-export/03-data-model.md`

## API Contract Notes

- Method: `POST`
- Path: `/webapi/customer-search/export-csv`
- Auth: existing authenticated session and export permission
- Table content kept in source: `docs/specs-support/examples/2026-03-11-example-customer-export/04-api-contract.md`

## Behavior Notes

- User is on the customer search screen.
- Search filters are available on screen.
- User has the export permission assigned for this screen.
- Table content kept in source: `docs/specs-support/examples/2026-03-11-example-customer-export/05-behavior.md`

## Edge Cases

- Table content kept in source: `docs/specs-support/examples/2026-03-11-example-customer-export/06-edge-cases.md`

## Task Notes

- Table content kept in source: `docs/specs-support/examples/2026-03-11-example-customer-export/07-tasks.md`

## Acceptance Notes

- Table content kept in source: `docs/specs-support/examples/2026-03-11-example-customer-export/08-acceptance-criteria.md`

## Test Notes

- Table content kept in source: `docs/specs-support/examples/2026-03-11-example-customer-export/09-test-cases.md`

## Locked Contracts

- `docs/specs-support/examples/2026-03-11-example-customer-export/contracts/openapi.yaml`
- `docs/specs-support/examples/2026-03-11-example-customer-export/contracts/schemas/customer-search-export-request.schema.json`
- `docs/specs-support/examples/2026-03-11-example-customer-export/contracts/schemas/customer-export-audit.schema.json`

## Assumptions

- OpenAPI is derived from 04-api-contract.md because this pilot is a documentation example, not a verified production endpoint implementation.
- JSON Schemas model request and audit data shape from 03-data-model.md and 04-api-contract.md, not database DDL extracted from code.

## Open Questions

- None. This package is intentionally complete as a reference example.

## Legacy Bridge References

- `agent/START_HERE.md`
- `agent/spec-pack/README.md`

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
