# Backend Change Rules

## When To Use

Use these rules when backend code changes under `src/main/java`.

## How To Use

Apply the dominant backend module pattern, document the impact in the feature package, and keep shared concerns in the established backend path.

## Required Output

- backend impact documented in `02-design.md`
- backend process and web service anchor files named in `02-design.md`
- validation, contract, config, and rollback implications captured before coding

## Gate

Do not hide backend impact inside a frontend-only spec, and do not start backend implementation until the touched module family plus backend process and web service anchors are named or marked `n/a` in `02-design.md`.

## Rules

- follow the dominant existing module pattern for the touched area instead of renaming adjacent legacy code
- lock backend source-base anchors in `02-design.md` before implementation with separate entries for process and web service files
- document the impacted packages, DTOs, processes, services, and config in `02-design.md`
- mirror the package, execution flow, and naming pattern of the chosen anchor files unless the governing spec or ADR explicitly changes the pattern
- put validation, error handling, and shared contract changes in the spec before coding
- if a request or response contract changes, capture the change in both `01-requirements.md` and `02-design.md`
- if behavior depends on configuration or environment properties, name those files in the spec and note rollout impact
- for risky or cross-cutting backend design changes, add an ADR
- do not create a new backend source family for a behavior-only change unless the governing feature package explicitly marks it in scope
- keep webservice classes thin and process-centric instead of introducing controller, repository, or facade layers by preference
- keep request validation in the established backend validation path when the module family already uses it
- when the module family already extends `AbstractKikanSystemProcess`, keep validation and pre-check logic in `beforeProcessing(...)` and reserve `processing(...)` for the main business path
- when the family already accumulates validation through `addErrorDto(...)`, `checkMsgSize(...)`, and `ProcessCheckErrorException`, reuse that flow instead of adding ad-hoc runtime errors or raw message strings
- reuse existing `ValidateUtility` length, date, and required-field helpers before open-coding equivalent backend validation
- reuse `MasterCodeCheckProcess` for master existence checks and `MasterNameGetProcess` or the existing shared focus-out lookup process before writing feature-local validation or name-lookup SQL
- if the touched family already routes standard focus-out name lookup through `FocusOutGetNameProcess` or the shared request contract, do not create a feature-local replacement for the same lookup concern
- reuse the dominant backend null or empty helper for the touched family before open-coding null or empty checks; prefer `ValidateUtility.isEmpty(...)` unless the anchor family still intentionally standardizes `CheckNull(...)`
- reuse `ConstantValue.EMPTY_STRING` or an already-established family-owned empty-string constant instead of adding raw `""`
- reduce magic strings by reusing shared constants, function IDs, message IDs, and schema-backed identifiers before adding new literals
- normalize user-facing and validation messages through `ConstantMessageID` plus the existing message utility flow instead of introducing fresh raw English text when the family already uses the catalog
- keep tenant isolation tied to `accessInfo` rather than trusting raw request values
- preserve soft-delete and active-record filters when the touched table schema and nearby code expect them
- before changing SQL or row-selection logic for a table used by sibling flows, compare the same module family's `search`, `count`, `detail`, `register`, `update`, `delete`, `export`, `import`, and `csv` processes and preserve the expected filter or guard parity unless the governing spec changes it
- if a search query uses `LIKE`, follow the shared escaping pattern before binding user input
- mirror the touched family's DTO shape; bean-style getters and setters are common, so do not introduce records, Lombok, builders, or mixed public-field DTOs unless that family already owns them
- preserve the local prepared-statement index style from the anchor files instead of normalizing unrelated code to a different counter pattern
- for new or touched mutable bind flows that span branches, loops, batches, or helper calls, follow the repo-preferred `AtomicInteger` pattern instead of extending raw `index++` chains
- if a multipart, file-download, or non-standard transport path needs custom exception handling, keep the catch block limited to the family's existing `logSend(...)` or error-DTO path
- avoid adding new per-row queries or extra round trips where the touched family already uses a set-based SQL path and shared search or count flow
- before adding a backend constant, function id, or shared raw code literal, scan `ConstantValue.java`, `FuncID.java`, `ConstCcd.java`, and `ConstCcdDef.java` for an existing definition
- for `VMT050`-backed code values, use `ConstCcd` for `DATACD` and `ConstCcdDef` for `RCDKBN` instead of hardcoded literals
- when the touched behavior family already validates the same rule in frontend and backend, update or explicitly verify both layers instead of closing the change as backend-only
- when the touched module family splits `Search`, `SearchRecCnt`, `Detail`, `Update`, `Delete`, or exclusion-check processes, compare sibling flows before changing any one query or validation branch
- if the touched scope already intersects a stronger shared helper or process pattern, minimal-patch scope does not justify extending the weaker local duplicate
