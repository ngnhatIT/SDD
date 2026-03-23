# Code Standards

## When To Use

Use this rule during implementation and code review.

## How To Use

Verify code changes against these standards before committing or approving.

## Required Output

- confirmation that no new `printStackTrace()`, raw SQL concatenation, or silent `.catch()` was introduced
- confirmation that audit columns, existence checks, and sibling-flow parity are maintained
- confirmation that touched code still matches the local family's DTO, transport, import, and comment patterns unless the approved design says otherwise
- confirmation that touched scope reused required shared helpers, constants, message catalogs, and base or common frontend patterns where repository evidence supports them
- confirmation that frontend and backend validation parity was checked when the behavior family owns both layers
- confirmation that touched files do not keep unused imports or redundant placeholder code
- confirmation that touched frontend structure and small-window layout still match repository-promoted sibling patterns where applicable
- confirmation that new or rewritten comments are English-only and minimal

## Gate

If a code change introduces a violation of these standards, the review fails until corrected.

## Standards

### Logging

- New or touched module code MUST NOT call `e.printStackTrace()`. Use `logSend(LogLevel.ERROR, ...)` through the shared `ILogSender` chain.

### Backend Validation And Shared Processes

- In module families that already extend `AbstractKikanSystemProcess`, validation and guard logic MUST stay in `beforeProcessing(...)` and main business logic MUST stay in `processing(...)`.
- Validation failures in those families MUST reuse `addErrorDto(...)`, `checkMsgSize(...)`, and `ProcessCheckErrorException` instead of ad-hoc runtime wrappers or raw English error strings.
- Reuse `ValidateUtility` helper methods and shared backend processes such as `MasterCodeCheckProcess`, `MasterNameGetProcess`, and the established focus-out lookup flow before introducing feature-local validation or name-lookup logic.

### SQL Safety

- SQL MUST stay aligned with the named SQL anchor files.
- In Java inline SQL families, prefer clause-by-clause `StringBuilder.append()` with uppercase SQL keywords and `?` placeholders.
- User values MUST NOT be string-concatenated into SQL.
- Do NOT introduce new long `+`-concatenated SQL fragments in new or touched Java SQL blocks.
- When touched legacy SQL blocks are already in scope and the named anchors or promoted family style support it, modernize the touched block toward the shared `StringBuilder.append()` format instead of extending the weaker local style.

### Audit Columns

- `INSERT` MUST set `ENTUSRCD`, `ENTDATETIME`, `ENTPRG`, `UPDUSRCD`, `UPDDATETIME`, `UPDPRG`. Use `SYSDATE(6)` for timestamp columns.
- `UPDATE` MUST set `UPDUSRCD`, `UPDDATETIME`, `UPDPRG`. Use `SYSDATE(6)` for `UPDDATETIME`.
- Logical `DELETE` MUST set `UPDUSRCD`, `UPDDATETIME`, `UPDPRG` alongside `DELFLG`.

### Mutation Guards

- `update`, `delete`, and `confirm` MUST verify row existence + `DELFLG` before mutation.
- Use `checkLink` / `checkDetail` when the family already owns them.
- Use `MasterCheckExclusionProcess.checkExclusion()` to unify existence checks and optimistic locking (`UPDDATETIME` matching).

### SQL Parameter Indexing

- Preserve the touched family's parameter-index pattern.
- Families that already use `AtomicInteger` should keep `AtomicInteger`.
- Families that already use `int index = ConstantValue.INDEX` or `ConstantValue.INDEX_1` should keep that style.
- Do NOT introduce ad-hoc raw counters such as `int index = 1; index++` in new code.

### Sibling Flow Parity

- When `SearchProcess` and `SearchRecCntProcess` coexist, their WHERE clauses MUST remain synchronized.

### Naming

- Backend packages use all-lowercase action suffixes.
- Preferred spelling: `register` (not `regist`).
- Screen code casing follows the approved screen definition.

### Error Handling

- WebService classes MUST NOT add custom `try-catch` around `executeProcess()` unless handling non-standard transport.
- Angular components MUST call backend via `WebService.callWs()`, `WebService.callSilentWs()`, or the shared file-upload or file-download helpers, never direct `$.ajax`, `HttpClient`, or `fetch`.
- The `.catch()` on the `callWs()` promise MAY be used for specific error routing (e.g., `ME000174` in focusout), but MUST NOT silently swallow errors with empty `catch(() => {})`.
- If a custom `.catch()` resolves the promise instead of rejecting it, it needs a code-comment rationale.
- Custom backend catch blocks for file upload, file download, or other non-standard transport MUST route through `logSend(...)` and the established error DTO or fatal-error path instead of exposing raw exception text.

### Frontend Debug Code

- Module code (backend and frontend) MUST NOT leave `console.log()` debug calls in committed code.
- Use structured logging on the backend (`logSend`) and remove all `console.log` from frontend components before merge.

### Local Shape Preservation

- Do not "clean up" a touched module family into a non-local pattern during unrelated work.
- Preserve the touched family's DTO shape, shared transport path, import boundaries, and approved comment style unless the spec explicitly authorizes a structural change.
- A repository-promoted shared helper or base-common pattern outranks a weaker file-local duplicate for the same concern inside the touched scope.

### Component Inheritance

- Feature screen components MUST extend `BaseComponent` and use its shared methods (`notifyConfirm`, `notifyError`, `fnClearMessage`, `validateFields`, `fnFocusOutCommon`).
- Do not duplicate these patterns in component-local code.
- When a touched screen materially changes a focus-out or master-name flow, prefer the existing base or common path (`fnFocusOutCommon` or the family wrapper that delegates to it or the shared request contract) instead of cloning a direct `callWs(Const.focusOutGetNameWs, ...)` block.

### Frontend Validation And Error Routing

- Prefer `BaseComponent.validateFields(...)` plus the touched family's `ValidateUltility` configuration for required, format, date, and length checks when sibling anchors already use that pattern.
- Field-level validation and backend field errors MUST stay bound to the existing message field or `Ultility.fnSetErrorMsg(...)` path and rendered through inline `.inputError` blocks when the family already uses that routing.
- `notifyError` and popup-style error display are for global blocking failures, shared modal outcomes, or fatal transport flows. They MUST NOT replace routine field-level validation in families that already render those errors inline.
- Backend `fatalError.controlID` handling is contract-sensitive. Preserve the family's field-level versus popup routing instead of collapsing all errors into one display style.

### Style And Comments

- Match the touched family's formatting, import ordering, line wrapping, and comment density.
- Do not bundle broad formatting churn, comment rewrites, or commented-out placeholder blocks into a behavior change.
- Remove unused imports from touched files before completion; do not leave obvious touched-scope import cleanup behind as optional work.
- Remove redundant variables, dead branches, and commented-out placeholder code inside the touched scope when it is safe to do so.
- Add comments only for non-obvious guard behavior, transport exceptions, concurrency handling, or contract-sensitive logic.
- Do not add narrator comments that simply restate the next line.
- Newly added or rewritten comments and Javadoc in touched scope MUST be English-only.
- Untouched legacy non-English comments may remain only when they are outside the touched scope; do not mass-rewrite unrelated files.

### Frontend Structure And Responsive Layout

- Mirror the touched screen family's component, DTO, service, helper, and table shape instead of inventing repository, facade, store, hook, model, or helper layers that sibling screens do not use.
- When sibling anchors already rely on `BaseComponent`, `SearchConditionManagementService`, `generateColumns(...)`, `fnGetColumnTableConfig()`, or `SubWindow`, touched screens MUST reuse that structure or record an approved exception.
- When frontend forms, search areas, or result filters are touched, verify smaller-window behavior against the named `.html` anchors before completion.
- Prefer the repository's live breakpoint-aware Bootstrap layout patterns, such as multi-breakpoint `col-*` classes, `col-auto` separators, and wrap-aware flex groups, over desktop-only splits when the touched family already supports them.
- Paired range fields such as FROM-TO inputs, date ranges, or code ranges MUST keep labels, separator, inline errors, and both inputs aligned or intentionally stacked without overlap on smaller windows.

### Abstractions And Imports

- Do not introduce new controller, repository, facade, store, hook, or adapter layers unless the approved design explicitly changes the touched family's structure.
- Shared services and common utilities MUST NOT import feature components outside explicit registries such as routing modules, Angular module declarations, or `common/SubWindow.ts`.

### Sub-Window Registry

- When a new modal sub-window screen is added, its component MUST be registered in `common/SubWindow.ts` with the corresponding `DisplayScreenID` entry.
- Do not import modal components ad-hoc from feature components.

### Validation Placement

- Backend process layer is the validation authority.
- Frontend may duplicate for UX; it MUST NOT be the sole check.
- When the touched behavior family already validates in both frontend and backend, new or changed behavior MUST check and update both layers or explicitly document the approved divergence.

### Search Lifecycle

- When a search family already uses `SearchConditionManagementService`, load required init data before `loadSearchConditions()` and keep save or load on the shared service.
- Search flows should preserve the repo pattern: clear stale notifications or field errors, validate, snapshot or save conditions, count first, list second, then rebuild body or pager state.
- If focus-out or field-level validation left an active error message, do not continue the search flow until the approved validation path clears or refreshes that error.
- Preserve zero-result clearing for table, pager, and related result flags where the screen family already uses it.

### DTO Convention

- DTO shape is family-based.
- Backend bean-style DTOs with getters and setters are common in live code.
- New DTOs MUST mirror the touched family's existing DTO shape unless the governing spec explicitly changes it.
- Do not invent records, Lombok DTOs, builders, or mixed public-field styles just to modernize one family.

### Contract Surface

- `fatalError` response shape (`errId`, `errMsg`, `controlID`) is contract surface that requires both-layer updates in the same branch.

### Constants

- Scan `ConstCcd.java`, `ConstantValue.java`, `ConstantMessageID.java`, `FuncID.java`, `Const.ts`, `ConstCcd.ts`, `ConstMessageID.ts` before adding any new shared literal.
- Reuse `ConstantValue.EMPTY_STRING`, `Const.EMPTY_STRING`, or an already-established family-owned equivalent instead of adding raw `""` in touched code.
- Reuse the dominant null or empty helper already established in the touched layer or family before open-coding null or length checks.
- Reduce magic strings by reusing existing constants, enums, screen IDs, control IDs, message IDs, and code definitions before introducing a new literal.
- Normalize user-facing and validation messages through `ConstantMessageID` or `ConstMessageID` plus the shared message lookup flow instead of adding fresh raw English text when the catalog path already exists.
- **Group/Data Code Mapping**: When using a Group Code (`GC_H*` from `ConstCcdDef`), the corresponding data values MUST strictly match its related Data Codes (`GC_D*` from `ConstCcd`). For example, `GC_H3091` must map to `GC_D3091_2YEARALARM` and NOT cross-pollinate with unrelated data codes.

### Test Gap Tracking

- Until automated test infrastructure exists, reviews MUST tag `[NO-AUTOMATED-TESTS]` in `12-review-report.md`.

### Grid Construction

- Data grids MUST use the shared `<app-table>` component (`common/table/table/table.component.ts`) with `[tableInfo]` binding.
- Do NOT build raw `<table>` HTML in screen component templates.
- In screen families that already use config-driven column setup, define columns through `fnGetColumnTableConfig()` and the shared `BaseComponent.generateColumns()` path with `Const.DataType.*` and `Const.Alignment.*` enums.
- When a touched table flow is still building `column['...']` objects manually and the sibling anchors already support the config-driven shared pattern, move the touched table to that shared pattern instead of extending the old builder.
- Column titles MUST come from `formItemNm[N]` (loaded from TMT340), not hardcoded strings.
- Call `fnBuildHeader()` once during `fnInit`; call `fnBuildBody()` every time data changes.
- Clear data: set `tableInfo['data'] = []` then call `fnBuildBody()`.

### Search Screen Lifecycle

- Pagination MUST use the shared `<wms-page>` component.
- The search lifecycle follows: validate -> store condition -> count via `SearchCntWs` -> fetch via `SearchWs` -> set `tableInfo['data']` -> `fnBuildBody()` -> `pager.makePager(totalCnt, pageNum)`.
- Page changes delegate to `fnPageChange($event)` which re-triggers the count+search flow.
- Clear operations MUST call `pager.clearPager()` and reset `tableInfo['data']` then `fnBuildBody()`.
- Zero-result handling MUST show `MI000001` info dialog.

### Column And Screen Constants

- Column name constants (`ColName`), ViewChild ref names (`ViewChild`), ControlID constants (`Constant`), and input key enums (`InputKey`) MUST be declared as exported `const` objects or enums at the top of the component file.
- Do NOT scatter inline string literals for column names, message field IDs, or block names in the component body.

### CSV Import

- CSV Import MUST use the shared `CsvImportComponent` (`common/csvimport/csvimport.component.ts`) opened via `SubWindow.fnOpenCSVSubWindow(modalService, CsvImportComponent, data)`.
- Caller `data` contract: `{ screenID: DisplayScreenID, screenName: formItemNm[0] }`.
- The backend import endpoint MUST be registered in `ApiEndpoints` as `${screenID}CSVImportWs`.
- Do NOT build custom file upload, pre-check, or import logic in screen components.
- The shared component handles: file validation (CSV extension check), pre-check with error or warning display, and final import with dynamic API endpoint.

### CSV Export

- CSV Export MUST use the shared `CsvExportComponent` (`common/csvexport/csvexport.component.ts`) opened via `SubWindow.fnOpenCSVSubWindow(modalService, CsvExportComponent, data)`.
- Caller `data` contract: `{ searchCondition, searchWebService, functionId, screenId, screenTitle }`.
- `searchCondition` MUST reuse the screen's `fnGetSearchRequest(0, 0)` with zero page parameters to retrieve all matching records.
- Do NOT build custom CSV column selection, file creation, or download logic in screen components.
- The shared component handles: column selection (drag-drop), header or quotation options, condition save or load via TMT209, server-side CSV creation via `spcm00061CsvCreateWs`, and base64 blob download.

### Shared UI And Integration Patterns

- **Master Code Focusout**: Rely on the shared base or common focus-out path first. Use `BaseComponent.fnFocusOutCommon(...)` when the touched family supports it, or the family's established `fnGetName(...)` wrapper when that wrapper is the approved bridge to the shared `Const.focusOutGetNameWs` contract. Do NOT implement new ad-hoc request assembly or direct webservice calls for standard master labels.
- **Classification Cascading**: Any screen featuring classification hierarchies (Main -> Mid -> Small -> Sub) MUST chain their clear events. When Main is cleared, it must clear Mid; Mid must clear Small; Small must clear Sub. Track previous values (`prevXxxSearch`) to avoid unnecessary clear cascades.
- **Dropdown List Initialization**: Dropdowns (`<select>`) bound to KBN data MUST initialize their lists via `Tmt050AllKbnSearchWs` passing all required `RCDKBNS` in a single request. Filter the response using `Ultility.fnFilterRCDKBN()`.
- **Radio Button KBN Groups**: Append default "ALL" records directly to the bound UI array (`new KBN(rcdkbn, '0', formItemNm[27], formItemNm[27])`) instead of hardcoding a separate static radio button in the HTML above the `*ngFor` loop.
- **Master Search Popups**: Always use `SubWindow.fnOpenSpcm10001CommonMaster(modalService, DisplayScreenID.XXX, null)` for displaying master lookup drawers (e.g., Store, Product, Main Classification).
- **PDF Generation**: Use `this.webService.callWebServiceForFileDownload(param, pdfDownloadWs, this.webService.FILE_TYPE_PDF)` coupled with `this.generateFileDownloadParam(response)`. This standardizes blob decoding and hidden-anchor download trigger behaviors.
