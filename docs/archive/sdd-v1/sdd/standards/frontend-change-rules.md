# Frontend Change Rules

## When To Use

Use these rules when frontend code changes under `src/main/webapp/angular`.

## How To Use

Record the UI impact in the feature package, define user-visible behavior before coding, and verify the changed flows with explicit evidence.

## Required Output

- changed components, services, routes, templates, and shared constants documented in `02-design.md`
- frontend `.ts` and `.html` anchor files plus dominant screen-family style note recorded in `02-design.md`
- user-visible behavior covered in `05-behavior.md`, `08-acceptance-criteria.md`, and `09-test-cases.md`

## Gate

Do not change screen behavior without acceptance criteria, test cases, transport or error-handling notes, and named `.ts` plus `.html` source-base anchors for the touched screen family.

## Rules

- record impacted components, services, routes, templates, and shared constants in `02-design.md`
- lock source-base anchors in `02-design.md` for the touched `.ts` and `.html` files before implementation
- review HTML line-breaking, attribute wrapping, and indentation against the named `.html` anchor files, not against a generic preference
- write user-visible acceptance criteria before changing screens or flows
- include error states, empty states, and validation behavior in acceptance test cases
- prefer a compile check for meaningful frontend changes and record the evidence in `11-implementation-report.md`
- keep the spec focused on user behavior and data flow, not on cosmetic implementation detail
- if a frontend change depends on backend contract changes, trace both sides in the same change folder
- when the touched business rule or validation also exists in backend processing, keep frontend and backend behavior aligned or document the intentional divergence in the feature package and review evidence
- feature screens should extend `BaseComponent` and prefer its shared helpers for validation, notifications, focus-out handling, and table generation when the screen family already supports that path
- reuse `Const.EMPTY_STRING` or an already-established family-owned empty-string constant instead of adding raw `""`
- reuse `Ultility.isEmpty(...)` or the touched family's established `ValidateUltility` wrapper instead of open-coded null or empty checks
- reuse `DisplayScreenID` and existing shared services instead of hardcoded screen identifiers
- keep screen transport on `WebService.callWs(...)`, `callSilentWs(...)`, or the shared file-upload or file-download helpers; do not introduce `HttpClient`, `fetch`, or direct `$.ajax` in screen code
- mirror the touched screen family's component shape instead of inventing one-off store, facade, hook, or view-model layers
- mirror the touched screen family's folder, DTO, service, helper, and shared table shape instead of inventing repository, facade, store, model, or helper layers that sibling screens do not use
- before adding a frontend constant, message id, screen id, or shared raw code literal, scan `Const.ts`, `ConstMessageID.ts`, `DisplayScreenId.ts`, `ConstCcd.ts`, and `ConstCcdDef.ts` for an existing definition
- normalize user-facing and validation messages through `ConstMessageID` and the shared message lookup path instead of fresh raw English text when the screen family already uses catalog-driven messages
- for `VMT050`-backed code values, use `ConstCcd` for `DATACD` and `ConstCcdDef` for `RCDKBN` instead of hardcoded literals
- when the touched legacy screen family already splits search, result, and optional input areas into separate `card wms-card` blocks, preserve that block structure for behavior-only changes
- in legacy templates that already use `formItemNm[...]`, keep labels, section headers, and button captions bound through `formItemNm` instead of hardcoded text
- prefer `BaseComponent.validateFields(...)` plus `ValidateUltility` rules for required, format, date, and length checks when sibling screens already support that shared path
- keep field-level `.inputError` messages directly below the related input, select, textarea, or date component inside the same layout column or input group
- route field-level validation and backend field errors through the existing message field or `Ultility.fnSetErrorMsg(...)` when the family already uses that binding pattern
- reserve `notifyError` or popup-style error display for global blocking errors, modal outcomes, or shared fatal-error flows; do not use it as a substitute for routine field-level validation when the touched family already keeps those errors inline
- ensure `callWs(...)` flows guard `fatalError` and indexed response access before use
- do not add empty or silent `.catch(...)` blocks to user-visible transport flows; route the error through shared handling or leave an explicit reason when the surrounding flow already owns error display
- shared services and common helpers must not import feature components outside explicit registries such as routing modules or `common/SubWindow.ts`
- remove unused imports from touched files and do not copy stray legacy imports such as `import { event } from 'jquery'` into new files
- remove redundant code and commented-out placeholder blocks from the touched scope when safe instead of carrying them forward
- avoid redundant comments and commented-out placeholder blocks; add comments only for non-obvious error routing, compatibility, or guard behavior, and write new or rewritten comments in English only
- search screens that keep saved conditions usually load required init data such as dropdowns or store lists before calling `loadSearchConditions()`
- when the touched search family already uses `SearchConditionManagementService`, keep saved-condition load and save on that shared service instead of introducing a screen-local alternative
- search actions usually clear current notifications, validate inputs, snapshot search conditions into DTO or local state, and call the count endpoint before the list endpoint
- when field-level errors already exist from focus-out or prior validation, block the search flow until those errors are cleared or refreshed through the approved validation path
- when a search-result area already uses a header row with record count on the left and `wms-page` on the right, preserve that layout
- keep direct DOM manipulation aligned with the surrounding module if the touched area already uses it
- keep `.html` line-breaking, attribute wrapping, and indentation consistent with the nearest existing component in the same screen family
- avoid new per-row or repeated init-time webservice calls where the touched family already batches init data, dropdown data, or search results
- do not introduce a new component structure or screen family for a behavior-only change unless the governing spec explicitly requires a structural redesign and marks that scope in `02-design.md`
- do not trigger master-name focus-out webservice calls during `fnInit` or while hydrating saved conditions unless the governing spec explicitly requires that behavior
- for search actions, block the search flow when any existing field-level error message is present, including errors produced by prior focus-out validation
- when a touched focus-out or get-name flow already has a shared base-common path, prefer `BaseComponent.fnFocusOutCommon(...)` or the family's approved wrapper instead of cloning a direct `callWs(Const.focusOutGetNameWs, ...)` block
- treat existing direct `fnGetName(...)` wrappers as tolerated legacy only when they remain the approved bridge to the shared focus-out request contract; do not use them as precedent for new raw webservice clones
- when sibling screens in the same family already define tables through `fnGetColumnTableConfig()` and the shared config-driven column path, move the touched table flow to that pattern instead of extending manual `column['...']` builders
- when backend validation already exists for the touched behavior family, do not ship frontend changes without checking whether matching frontend validation or message mapping must also be updated
- if the touched scope already supports a stronger shared base-common helper, constant, or validation pattern, minimal-patch scope does not justify extending the weaker local duplicate
- when a touched screen includes form rows, search filters, or result filters, verify the layout on smaller windows against sibling `.html` anchors before completion
- when paired fields such as FROM-TO, date ranges, or code ranges are touched, keep the label, separator, both inputs, and inline `.inputError` blocks aligned or intentionally stacked using the repository's breakpoint-aware grid patterns where sibling anchors already support them
- do not extend desktop-only `col-md-*` range-field splits in touched layouts when the same family already uses more responsive multi-breakpoint columns or wrap-aware flex groups
