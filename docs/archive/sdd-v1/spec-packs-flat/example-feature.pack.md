# Generated Spec Pack

- Feature: `example-feature`
- Source manifest: `docs/specs-support/examples/example-feature/spec-pack.manifest.yaml`
- Source package: `docs/specs-support/examples/example-feature/`
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
- `docs/sdd/standards/backend-process-architecture.md`
- `docs/sdd/standards/frontend-screen-architecture.md`
- `docs/sdd/standards/database-change-rules.md`
- `docs/sdd/standards/module-patterns/search.md`
- `docs/sdd/standards/module-patterns/csv.md`
- `docs/sdd/standards/security-validation-and-logging.md`

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

## Standard Summary: search.md

- Use this file when changing a search screen, search endpoint, count endpoint, or related DTO family.
- Match the surrounding search/count split and keep row and count behavior aligned.
- search and count impact documented in `02-design.md`
- verification that list and count behavior stay consistent
- Do not collapse count logic into the list path unless the touched module family already does so.

## Standard Summary: csv.md

- Use this file when adding or changing CSV import or export behavior.
- Reuse the shared CSV family first, then keep feature-specific CSV behavior in a dedicated package only when the flow is not generic.
- CSV module choice documented in `02-design.md`
- CSV-specific verification in `09-test-cases.md`
- Do not invent a new CSV flow while an equivalent shared CSV pattern already exists nearby.

## Standard Summary: security-validation-and-logging.md

- Use this file when a change touches authentication, authorization, validation, request handling, or error logging.
- Preserve the shared security and validation flow unless the feature package explicitly changes it.
- security and validation impact documented in the feature package
- non-obvious error handling reflected in `06-edge-cases.md` and tests
- Do not weaken token, auth, tenant isolation, or error-routing behavior without an ADR and explicit approval.

## Feature Summary

- Title: `SPPM00061 expired-file filter with search and export parity`
- Source: `README.md`
- Source: `docs/specs-support/examples/example-feature/01-requirements.md`
- Source: `docs/specs-support/examples/example-feature/02-design.md`
- Source: `docs/specs-support/examples/example-feature/03-data-model.md`
- Source: `docs/specs-support/examples/example-feature/04-api-contract.md`
- Source: `docs/specs-support/examples/example-feature/05-behavior.md`
- Source: `docs/specs-support/examples/example-feature/06-edge-cases.md`
- Source: `docs/specs-support/examples/example-feature/07-tasks.md`
- Source: `docs/specs-support/examples/example-feature/08-acceptance-criteria.md`
- Source: `docs/specs-support/examples/example-feature/09-test-cases.md`

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchAllRecProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061CSVExportProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061SearchWebService.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061SearchRecCntWebService.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061CSVExportWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchAllRecProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.html`
- Dominant module/style note: Reuse the current search-family split for count, list, and export; preserve `StringBuilder` SQL assembly style; reuse the existing screen component and shared CSV export flow instead of creating a new export-specific path.
- New tables/source families/screen structure in scope: `no`

## Related Code References

- Start implementation and review from the source-base anchors above.
- Compare sibling flows in the same module family before changing existing search, count, detail, update, delete, import, export, or download behavior.
- Existing implementation evidence: `n/a`

## Scope Guardrails

- README scope and out-of-scope notes: `docs/specs-support/examples/example-feature/README.md`
- add an `expiredOnly` filter to the `SPPM00061` search screen
- apply the same filter to search count, search list, and CSV export paths
- preserve saved-condition restore behavior for the new filter
- document the request-contract change and screen behavior
- new tables or durable audit records
- changes to attachment delete or download flows
- asynchronous export or background jobs
- permission model changes
- Design non-changes: `docs/specs-support/examples/example-feature/02-design.md`
- No new table or audit row
- No change to attachment delete, save, or download flows
- No asynchronous export path

## Traceability Snapshot

- Table content kept in source: `docs/specs-support/examples/example-feature/README.md`

## Requirements Snapshot

- Users on `SPPM00061` cannot isolate expired attachment records before exporting or reviewing them, which causes manual filtering and easy mismatches between on-screen review and CSV output.
- add an `expiredOnly` search condition to `SPPM00061`
- apply the same condition to search count, search list, and CSV export
- preserve current saved-condition restore behavior
- document the request-contract change and expected screen behavior
- new database tables
- attachment lifecycle changes outside search and export
- asynchronous processing

## Design Snapshot

- Approach: extend the existing `SPPM00061` search request with an `expiredOnly` flag, apply the same condition to count, list, and CSV export paths, and keep the screen and saved-condition flow aligned.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`
- `SPPM00061` search returns mixed active and expired attachment rows.
- Users can export the same mixed result set to CSV.
- The current repository does not show a full-path example package for a search and export parity change with SDD2+ companion artifacts.
- The search screen offers an `expiredOnly` filter that defaults to `false`.
- Search count, search list, and CSV export use the same expired-only predicate.
- Saved conditions restore the filter consistently.

## Data Contract Notes

- The feature reuses the current attachment search data model and expiry-related fields already returned by the `SPPM00061` search family.
- No new durable table, column, or file shape is introduced.
- `expiredOnly = false` returns the existing mixed result set.
- `expiredOnly = true` returns only rows whose expiry date is before the current business date.
- Rows with no expiry date remain visible only when `expiredOnly = false`.
- The feature may extend the existing saved-condition payload to remember the `expiredOnly` flag.
- No new persistence family is introduced by this example.

## API Contract Notes

- `contracts/openapi.yaml`
- `contracts/schemas/sppm00061-search-request.schema.json`
- `contracts/schemas/sppm00061-search-response.schema.json`
- Compatibility class: `additive`
- Affected consumers: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.ts`, the existing `SPPM00061` search webservices, and the shared CSV export flow that reuses the search request
- Add `expiredOnly` as an optional boolean field on the existing search request.
- Omitted or null values behave as `false`.
- The response shape does not require a new top-level contract object.

## Behavior Notes

- 1. User opens `SPPM00061`.
- 2. The screen restores saved conditions, including `expiredOnly` when one was saved.
- 3. User turns on the `expiredOnly` filter and runs search.
- 4. Search count and result list show only expired attachment rows.
- 5. User exports the result set through the shared CSV export flow.
- 6. Export uses the same `expiredOnly` condition as the on-screen search.
- The new filter defaults to `false`.
- Zero-result behavior stays the same as the current screen.

## Edge Cases

- If older saved conditions do not contain `expiredOnly`, restore it as `false`.
- If a corrupted saved condition contains a non-boolean value, reject it through the existing validation path and do not silently guess.
- A row is considered expired only when its expiry date is before the current business date.
- A row expiring on the current business date remains visible when `expiredOnly = false` and excluded when the business rule still treats it as active.
- Rows with no expiry date are not treated as expired.
- Any change to the expired-only predicate must be applied to search count, search list, and CSV export in the same branch.

## Task Notes

- Table content kept in source: `docs/specs-support/examples/example-feature/07-tasks.md`

## Acceptance Notes

- Table content kept in source: `docs/specs-support/examples/example-feature/08-acceptance-criteria.md`

## Test Notes

- Table content kept in source: `docs/specs-support/examples/example-feature/09-test-cases.md`

## Risk Notes

- Table content kept in source: `docs/specs-support/examples/example-feature/13-risk-log.md`

## Decision Notes

- Table content kept in source: `docs/specs-support/examples/example-feature/14-decision-notes.md`

## Locked Contracts

- `docs/specs-support/examples/example-feature/contracts/openapi.yaml`
- `docs/specs-support/examples/example-feature/contracts/schemas/sppm00061-search-request.schema.json`
- `docs/specs-support/examples/example-feature/contracts/schemas/sppm00061-search-response.schema.json`

## Assumptions

- The example package documents an approved change pattern and does not claim that the feature is implemented in production code.
- Existing expiry-related fields already exist in the `SPPM00061` search family; the example focuses on the new filter and parity rules.

## Open Questions

- None.

## Legacy Bridge References

- `agent/START_HERE.md`

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
