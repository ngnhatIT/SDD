# Code Structure Rules

## When To Use

Use this file during SDD review when validating whether backend, frontend, contract, and test code follow the dominant repository code shape.

## How To Use

1. Determine whether the touched implementation is screen-family backend, API-family backend, frontend screen, or shared common code.
2. Apply the matching mandatory code-shape rules.
3. Use recommended rules as the default approval target.
4. Treat legacy tolerated rules as compatibility constraints only.

## Required Output

- expected code shape for the touched family
- expected contract updates
- expected test shape
- explicit note when implementation deviates from the dominant local pattern

## Gate

If implementation changes the local family shape without spec-backed justification, the change should fail review.

## Mandatory Structure

### Backend Screen Family

- A JAX-RS web service class belongs in a `webservice/` folder and should delegate to a process class instead of embedding business logic.
- Request and response DTOs belong in a sibling `dto/` folder.
- Business logic belongs in a `process/` class that runs inside the shared process lifecycle.
- Shared screen constants, search-condition DTOs, and row DTOs may remain in the base screen package when the local module family already uses that pattern.
- Token checks, auth checks, transaction handling, retry, rollback, and shared logging must continue to flow through `AbstractProcess` and `AbstractKikanSystemProcess` unless the governing spec changes that behavior.
- DTO shape must mirror the touched family. Java bean-style DTOs with getters and setters are common in live backend code and should not be replaced by records, Lombok DTOs, or builder-only DTOs by assumption.
- Do not introduce controller, repository, or facade layers for a behavior-only backend change unless the touched family already owns that shape or the approved design explicitly opens it.

### Backend API Family

- API web services belong under `api/<api-code>/webservice/` and extend the shared API web service flow.
- API request and response DTOs belong under `api/<api-code>/dto/`.
- API business logic belongs under `api/<api-code>/process/`.
- API-local query constants or helper services may live under `api/<api-code>/service/` when that family already uses the pattern.
- API auth and transport-level error behavior must continue to flow through `AbstractAPIWebService` and `AbstractAPIProcess`.

### SQL And Validation Shape

- SQL should follow the dominant local inline Java style of the touched module family.
- Parameter binding is mandatory for user-controlled values.
- The existing index-counter pattern for many prepared-statement bindings is the normal local pattern where surrounding code already uses it.
- Mixed index-counter styles exist in live code. Preserve untouched legacy families during unrelated work, but repeated active search, delete, and API batch families make `AtomicInteger` the preferred style for new or touched mutable bind-counter flows that span branches, loops, or helper calls.
- Backend validation should reuse shared validation and message-ID driven error DTO patterns before introducing new validation styles.
- Frontend validation should stay aligned with shared message IDs and the shared validation utility pattern when the touched screen family already uses them.

### Frontend Screen Family

- New or changed screens should live under `components/<screen-code>/`.
- Most screens should continue to extend `BaseComponent` when the surrounding screen family does.
- Screens should identify themselves with `DisplayScreenID`.
- Requests to screen-style backend services should continue to include `accessInfo` from `LoginInfoService.getAccessInfo(...)`.
- Transport should continue to go through `services/common/webservice.service.ts` unless the feature explicitly introduces and justifies another transport path.
- The current shared transport service uses jQuery `$.ajax`; do not bypass it with `HttpClient`, `fetch`, or component-local `$.ajax` during unrelated work.
- Large stateful components are a normal local shape. Do not invent one-off store, hook, facade, or view-model layers unless the approved design explicitly changes the structure.
- Shared services and common utilities must remain component-agnostic outside explicit registries such as routing modules or `common/SubWindow.ts`.

### Contracts

- If a governed feature changes an HTTP, DTO, file, or durable data interface and the feature owns machine-readable contracts, prose and machine-readable contracts must change together.
- Feature-owned contracts belong beside the governing feature package under `docs/specs/<feature-id>/contracts/`.
- `contracts/openapi.yaml` and `contracts/schemas/*.json` are authoritative machine-readable shapes when present.

### Tests

- Verification must map back to `TC-` items in the governing feature package.
- Business logic, SQL behavior, validation, auth, and file-output changes must have at least one concrete verification path tied to acceptance criteria.
- Frontend transport changes must verify error routing and guarded response handling, not only the happy path.
- If automation is absent, the review record must explicitly say so instead of implying automated coverage.
- Do not claim backend or frontend unit coverage unless new test files actually exist; the current repo has no tracked backend `src/test` coverage and only trivial Angular `.spec.ts` coverage.

## Recommended Structure

### Backend

- Keep feature-specific code inside the touched local module family instead of introducing a cross-cutting abstraction during an unrelated change.
- Prefer `beforeProcessing(...)` plus `processing(...)` in screen-family processes when that module family already uses the `AbstractKikanSystemProcess` pattern.
- Prefer local constant classes and screen/base DTO reuse when the module family already centers its schema around them.
- For API export-style modules, keep snapshot, pagination, and response-envelope logic inside the API family rather than pushing it into unrelated shared code.
- Keep transport adapters thin. Custom file-upload or file-download handling is acceptable only when the touched family already uses it and still routes errors through the existing logging or error DTO path.

### Frontend

- Reuse `DisplayScreenID`, shared message services, auth services, and login-info state before adding new per-screen state mechanisms.
- Keep route registration, component declaration, and shared service wiring aligned with the current Angular shell structure.
- Guard `fatalError`, indexed response access, and optional fields before use.
- Keep screen-family services under `services/<family>/` only when they are truly family-owned and not common transport/state services.
- Reuse shared table, pager, modal, CSV import, and CSV export components before introducing custom UI plumbing.
- Match the touched family's formatting, import shape, and comment density instead of rewriting the file toward a generic Angular style.

### Tests

- Add the strongest practical evidence available for the touched area, even if the repository currently relies heavily on manual verification.
- Prefer compile or build evidence for meaningful frontend changes and package/test evidence for backend changes when environment permits.
- When backend automation is missing, review should still expect concrete normal-flow, failure-flow, and regression-sensitive test paths in `09-test-cases.md`.

## Legacy Tolerated Structure

- Direct DOM access in Angular exists in shared base code and may remain in surrounding legacy screens, but it should not be used to justify new arbitrary DOM-driven patterns elsewhere.
- jQuery-based AJAX transport exists in the shared frontend service and must be preserved for compatibility in touched screens unless a spec-backed migration is in scope.
- Very large Angular module and routing files are tolerated because they are the current shell, but they are not a reason to introduce new duplication casually.
- Inline SQL assembly with large `StringBuilder` blocks is common and tolerated, but unsafe string concatenation of user input is still not acceptable.
- Minimal automated test presence is current reality, not a waiver for omitting traceable verification.
- Mixed comment language, mixed DTO shapes, and mixed parameter-index patterns exist in live code. Treat them as family-scoped constraints, not as approval to invent a new global style inside one change.

## Structure Deviation Signals

- Web-service classes that add feature logic instead of delegating to process classes.
- Screen-family modules that skip request/response DTO updates while changing transport shape.
- API-family modules that bypass shared API auth or error-envelope behavior.
- Frontend screens that hardcode screen IDs or skip `accessInfo` in module families that normally require it.
- Frontend code that bypasses `services/common/webservice.service.ts` or adds feature-component imports to shared services or common helpers.
- New controller, repository, facade, store, or hook layers that do not exist in the touched family and are not called for in the approved design.
- New debug code, comment churn, or non-local DTO shape inside an existing module family.
- Features that change contracts without matching `contracts/` updates when the owning feature package already has machine-readable contracts.
- Changes that widen from one screen/module family to neighboring families without evidence in the governing feature package.

## Database rules

- `docs/sdd/context/schema_database.yaml` is the only schema authority for repository database structure.
- Review and implementation that touch SQL, tables, views, or durable fields must verify touched names, types, nullability, and audit columns against `schema_database.yaml`.
- Migration scripts and feature specs must stay aligned with `schema_database.yaml`.
- If code, spec, and `schema_database.yaml` disagree, stop and escalate instead of guessing.
