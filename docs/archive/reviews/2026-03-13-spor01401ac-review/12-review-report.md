# SPOR01401AC Rule-Based Implementation Review

## Review scope

- Target functionality: `SPOR01401AC` as currently implemented in the repository.
- Review mode assumption: `review-from-rules`.
- Governing artifact status:
  - `docs/specs/SPOR01401AC/` does not exist.
  - no `SPOR01401AC` execution brief or generated spec-pack was found under `docs/spec-packs/`.
  - no feature-owned `contracts/` artifact was found for this functionality.
- Artifact path assumption:
  - because no canonical feature folder exists, this report is archived under `docs/archive/reviews/2026-03-13-spor01401ac-review/12-review-report.md` instead of staying in the active `docs/specs/` approval tree.
- Traceability note:
  - no canonical `REQ/DES/TASK/AC/TC` package exists for `SPOR01401AC`, so this review traces findings to code, schema, and related runtime artifacts only.

## Reviewed files

- `src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts`
- `src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.html`
- `src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.css`
- `src/main/webapp/angular/src/app/common/Const.ts`
- `src/main/webapp/angular/src/app/common/DisplayScreenId.ts`
- `src/main/webapp/angular/src/app/components/common/base/base.component.ts`
- `src/main/webapp/angular/src/app/services/common/search-condition-management.service.ts`
- `src/main/webapp/angular/src/app/services/common/ultility.service.ts`
- `src/main/webapp/angular/src/app/components/spor01501ac/spor01501ac.component.ts`
- `src/main/java/jp/co/brycen/kikancen/spor01401ac/constant/Spor01401acConstant.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401ac/dto/Spor01401acSearchConditionDto.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401ac/dto/Spor01401acSearchRowDto.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401ac/dto/Spor01401acUpdateConditionDto.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401ac/dto/Spor01401acUpdateRowDto.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401ac/process/Spor01401acBaseUpdateProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acsearch/dto/Spor01401acSearchRequest.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acsearch/dto/Spor01401acSearchResponse.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acsearch/process/Spor01401acSearchAllRecProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acsearch/process/Spor01401acSearchRecCntProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acsearch/process/Spor01401acSearchProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acsearch/webservice/Spor01401acSearchWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acsearch/webservice/Spor01401acSearchRecCntWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acgetdbvalue/dto/Spor01401acGetDbValueRequest.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acgetdbvalue/dto/Spor01401acGetDbValueResponse.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acgetdbvalue/process/Spor01401acGetDbValueProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acgetdbvalue/webservice/Spor01401acGetDbValueWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acupdate/dto/Spor01401acUpdateRequest.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acupdate/process/Spor01401acUpdateProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acupdate/webservice/Spor01401acUpdateWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acinit/process/Spor01401acInitProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor01401acinit/webservice/Spor01401acInitWebService.java`
- `anac_review.sql`

## Review basis / evidence used

- Repository governance and review context:
  - `AGENTS.md`
  - `docs/sdd/context/constitution.md`
  - `docs/sdd/context/note.md`
  - `docs/sdd/context/architecture-context.md`
  - `docs/sdd/context/product-context.md`
  - `docs/sdd/context/tech-context.md`
  - `docs/sdd/context/ai-loading-order.md`
  - `docs/sdd/context/task-profiles.md`
  - `docs/sdd/governance.md`
  - `docs/sdd/governance/01-when-a-spec-is-required.md`
  - `docs/sdd/governance/04-review-rules.md`
  - `docs/specs/README.md`
- Current implementation evidence:
  - Angular component/template/state handling.
  - JAX-RS request/response/process classes.
  - inline SQL in search/get-db-value/update processes.
  - schema definitions in `anac_review.sql`.
- Missing evidence explicitly noted:
  - no approved feature package.
  - no SPOR01401AC spec-pack.
  - no machine-readable contract artifact.
  - no module-specific automated tests found under `src/test` or Angular spec files.

## Current behavior summary

- The screen loads form labels through `BaseComponent`, loads saved search conditions from `TMT209`, then fetches store and dropdown/alarm master data through `Spor01401acGetDbValue` and `Tmt050AllKbnSearch`.
- Search submits a count request first and a row request second, using a shared condition DTO and separate count/list endpoints.
- Search results render one logical record across three table rows, allow row selection, support bulk reflection of expiration date/time, and allow update submission for selected rows.
- Update performs client-side row validation and warning generation, then backend validation, optimistic-lock style exclusion checking, and finally an `UPDATE` against `TAPR04_SCHEDULEDFORDELIVERYFILE`.
- The screen navigates to `SPOR01501AC` with restore state and can rebuild the previous search condition/result state on return.

## Observed behavior

- Search condition loading and persistence are implemented through `SearchConditionManagementService` and `TMT209` save/load/delete flows (`src/main/webapp/angular/src/app/services/common/search-condition-management.service.ts:42-147`).
- Initial store dropdown and alarm messages come from `Spor01401acGetDbValueProcess`, which loads:
  - login user main store from `TMT002_USER`
  - store list from `TMT003_STORE`
  - production area and production code dropdowns
  - alarm text for code groups `3091` and `3092`
  (`src/main/java/jp/co/brycen/kikancen/spor01401acgetdbvalue/process/Spor01401acGetDbValueProcess.java:36-197`).
- Search validation on button click checks only max length for text/select fields; date-format/range validation is primarily wired to date control blur/select events (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:456-562`, `:1314-1369`).
- Search request payload contains `storeCdSearch`, `sectionCdSearch`, `groupCdSearch`, order date range, status, order type, supplier, procurement item, estimated delivery range, procurement memo, change checkbox, and request type (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:471-486`, `:640-663`; `src/main/java/jp/co/brycen/kikancen/spor01401ac/dto/Spor01401acSearchConditionDto.java:5-146`).
- Backend search validates store/section/group master existence plus date range and format, then queries `TAPR04_SCHEDULEDFORDELIVERYFILE` joined with `TAOR70_ANACORDER`, `TMT026_PRODUCT`, `TMT023_PARTNER`, `TAMT026_PRODUCTAGREEMENT`, `TAMT030_SECTION`, `TAMT010_PRODUCTIONAREA`, `TAMT011_PRODUCTION`, and `VMT050_ALL` (`src/main/java/jp/co/brycen/kikancen/spor01401acsearch/process/Spor01401acSearchAllRecProcess.java:32-125`, `:128-462`).
- Count and list stay on the same SQL base process, with count using `COUNT(*) OVER()` and sum windows for WEB-EDI and supplier-change totals (`src/main/java/jp/co/brycen/kikancen/spor01401acsearch/process/Spor01401acSearchRecCntProcess.java:15-45`).
- Row update request sends selected rows only and includes order number, installment number, procurement code, delivery quantity, delivery schedule date, delivery category, expiration date/time, production area, origin, partner/store keys, update timestamp, and row index (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:1086-1099`; `src/main/java/jp/co/brycen/kikancen/spor01401ac/dto/Spor01401acUpdateRowDto.java:5-159`).
- Backend update validates selected rows, runs exclusion checking against `TAPR04_SCHEDULEDFORDELIVERYFILE`, recomputes alarm fields, and updates `DELIVERYQTY`, `DELIVERYSCHEDULEDATE`, `DELIVERYKBN`, `EXPIRATIONDATE`, `EXPIRATIONTIME`, `PRODUCTIONAREA`, `PRODUCTIONCD`, `PARTNERCONFIRMFLG`, `ALARMKBN`, `ALARM`, `UPDUSRCD`, `UPDDATETIME`, and `UPDPRG` (`src/main/java/jp/co/brycen/kikancen/spor01401acupdate/process/Spor01401acUpdateProcess.java:37-155`).
- Schema confirms:
  - `TAPR04.DELIVERYSCHEDULEDATE` and `TAPR04.EXPIRATIONDATE` are `date`
  - `TAPR04.DELIVERYQTY` is `decimal(10,2)`
  - `TAPR04.UPDDATETIME` is `timestamp(6)`
  (`anac_review.sql:2220-2261`).

## Inferred behavior

- Request type and order type are intended to be linked filters, because changing request type auto-forces order type to either regular or individual order (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:1683-1688`).
- `SPOR01501AC` is treated as the detail/edit continuation screen for the order slip selected from `SPOR01401AC`, because navigation passes `orderNo` plus a restore-state envelope and the detail screen routes back to `SPOR01401AC` with that state (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:1547-1673`; `src/main/webapp/angular/src/app/components/spor01501ac/spor01501ac.component.ts:619-645`).
- Alarm text stored in `TMT050_NAME`/`VMT050_ALL` is intended to be both user-facing warning text and persisted `ALARM` content, because frontend and backend both read the same master-driven messages (`Spor01401acGetDbValueProcess` and `Spor01401acBaseUpdateProcess`).

## Unknown / ambiguous behavior

- Whether clearing the screen should return to blank/default values or reload saved `TMT209` conditions. Current code reloads saved conditions after clear, but no approved behavior spec exists (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:735-740`).
- Whether clearing procurement item code is supposed to clear the supplier and procurement memo fields that can be auto-populated by procurement-item focus-out. The code behaves inconsistently depending on the path taken (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:1199-1213`, `:1220-1241`).
- Whether the exact 2-year alarm boundary should be `>` or `>=`. Frontend and backend disagree, and no governing artifact resolves the intent.
- Whether exposing all company stores in the store dropdown is correct for this screen. The code does not apply a visible per-user store filter beyond defaulting the initial store.
- Whether `Spor01401acInit` is intentionally retained as a dead endpoint or is incomplete legacy scaffolding. The endpoint exists but the Angular screen does not call it.

## Findings by severity

- `F-01 High` Client-side search validation messages can become stale and block valid searches because successful re-validation does not clear old messages.
- `F-02 High` Server-side update validation does not enforce numeric format/precision for planned delivery quantity and misclassifies non-numeric input.
- `F-03 Medium` Frontend and backend implement different 2-year alarm thresholds, so user warning state and persisted alarm state can diverge.
- `F-04 Medium` Bulk reflection of expiration date/time does not mark the screen dirty, so unsaved-change protection can be bypassed after mass edits.
- `F-05 Medium` Update API does not validate update date string format server-side before comparing or writing to `DATE` columns.

## Confirmed issues

- `F-01 High` Stale validation messages on search screen.
  - Evidence:
    - `fnFieldValidate()` delegates to `fnSetMessage(messages)` (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:511-562`).
    - `fnSetMessage()` uses `messages[field] || existingMessage`, which preserves an old non-empty message when new validation returns an empty string (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:568-604`).
  - Impact:
    - once a field has an error, later valid input can leave the old message in place and `btnSearchClick()` will still abort.
    - this is especially risky for date fields because search-button validation does not recompute them directly.

- `F-02 High` Backend quantity validation trusts client formatting and cannot distinguish invalid numeric input from zero/negative input.
  - Evidence:
    - frontend explicitly enforces positive decimal with max `8,2` (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:879-889`).
    - backend only checks blank and `> 0` using `parseDecimalSafe()` (`src/main/java/jp/co/brycen/kikancen/spor01401ac/process/Spor01401acBaseUpdateProcess.java:321-337`).
    - `parseDecimalSafe()` swallows parse failures and returns `0`, so the `catch (NumberFormatException)` branch in `validateDeliveryQty()` is effectively dead (`src/main/java/jp/co/brycen/kikancen/spor01401ac/process/Spor01401acBaseUpdateProcess.java:773-780`).
    - schema shows the persisted column is `decimal(10,2)` (`anac_review.sql:2228`).
  - Impact:
    - direct API callers are not protected by server-side precision/scale validation.
    - non-numeric payloads are misreported as a positive-number failure instead of a numeric-format failure.
    - over-precision/overflow behavior is left to JDBC/database coercion rules rather than controlled validation.

- `F-03 Medium` Alarm threshold mismatch between frontend warning logic and backend persisted alarm logic.
  - Evidence:
    - frontend raises the 2-year alarm when `expirationDate >= estimatedDeliveryDate + 2 years` (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:939-950`).
    - backend sets alarm `3091` only when `expirationDate.isAfter(twoYearsLater)` (`src/main/java/jp/co/brycen/kikancen/spor01401ac/process/Spor01401acBaseUpdateProcess.java:426-452`).
  - Impact:
    - a record exactly at the 2-year boundary shows a warning before update but may reload without a persisted alarm.
    - frontend warning flow and stored `ALARMKBN/ALARM` state can disagree.

- `F-04 Medium` Bulk reflect does not participate in dirty-state tracking.
  - Evidence:
    - individual row edits call `onDetailInputChange()` and set `isValuesChanged = true` (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:1539-1545`).
    - `btnReflectDate()` mutates selected rows directly but never sets `isValuesChanged` (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:1372-1425`).
    - unsaved-change confirmation for navigation relies on `fnCheckChange()` / `isValuesChanged` (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:1543-1565`).
  - Impact:
    - mass-applied changes can be lost without confirmation if the user navigates away before pressing update.

- `F-05 Medium` Backend update does not validate date format even though the API accepts raw strings and updates `DATE` columns.
  - Evidence:
    - backend update validation checks blank and date ordering/past-date logic but does not verify format for `estimatedDeliveryDate` or `expirationDate` (`src/main/java/jp/co/brycen/kikancen/spor01401ac/process/Spor01401acBaseUpdateProcess.java:309-365`).
    - schema shows both target columns are `DATE` fields (`anac_review.sql:2221`, `anac_review.sql:2237`).
  - Impact:
    - non-UI callers can submit malformed date strings.
    - runtime behavior then depends on deserialization/database coercion rather than explicit application validation.

## Suspicious areas needing confirmation

- Procurement-item focus-out side effects are inconsistent.
  - Invalid procurement-item lookup clears supplier and memo (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:1203-1213`), but clearing the procurement-item field only clears procurement-item state (`:1220-1241`).
  - This may leave stale supplier/memo filters after the visible procurement-item key is removed.

- Search button snapshots DTO state before asynchronous focus-out lookups finish.
  - `fnSaveSearchConditionsToDto()` runs before `fnGetNameWhenSearch()` (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:460-468`).
  - Any field that is auto-populated by focus-out response can lag behind the request DTO used for the search.

- `Clear` semantics may not match user expectation.
  - `fnClear()` wipes local state and then immediately reloads saved search conditions (`src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts:735-740`).
  - Without a spec, it is unclear whether this is intended or a UX defect.

- `Spor01401acInit` looks unused.
  - The endpoint, request/response, and constant exist, but the screen does not call it (`src/main/webapp/angular/src/app/common/Const.ts:2443`; `src/main/java/jp/co/brycen/kikancen/spor01401acinit/**`).

## Test coverage observations

- No backend test source tree was found under `src/test`.
- No Angular spec file for `SPOR01401AC` was found.
- No machine-readable contract artifact exists for request/response shape verification.
- The current implementation appears to rely on manual testing plus duplicated frontend/backend validation rather than automated coverage.
- Regression-sensitive areas with no visible automated coverage include:
  - search validation and count/list parity
  - row-level update validation
  - alarm boundary behavior
  - restore-state behavior between `SPOR01401AC` and `SPOR01501AC`

## Maintainability / risk observations

- `spor01401ac.component.ts` is a very large screen component with UI state, validation, navigation, request-building, and business rules combined in one class (`~1700` lines). This increases defect risk and makes frontend/backend rule drift more likely.
- Delivery/alarm rules are duplicated across Angular and Java. The confirmed boundary mismatch in `F-03` is direct evidence of that drift risk.
- The update payload shape is effectively contract-by-implementation only. There is no owned `contracts/` artifact or feature package documenting the authoritative request/response rules.
- Inline SQL is extensive and business-significant. Future fixes will affect UI, API, SQL, and durable data behavior together, not just a local screen method.

## Recommended next action

- Create a draft canonical feature package before remediation.
  - Reason: the runtime footprint is multi-layer (`Angular + JAX-RS + SQL + durable data`), so any behavioral fix is governed work and should not proceed from prompt-only intent.
- Prioritize remediation for `F-01` and `F-02` first, because they can block valid user actions or leave update validation dependent on client/DB behavior.
- When fixing, add at least:
  - one explicit validation test path for stale-message clearing
  - one explicit API-side validation path for invalid numeric/date payloads
  - one boundary test for the exact 2-year alarm condition
  - one navigation test path for bulk reflect unsaved changes

## Whether a draft feature package/spec should be created

- Yes.
- Rationale:
  - `SPOR01401AC` behavior spans frontend transport, backend validation/process flow, SQL selection/update logic, and persistent table updates.
  - The current repository governance treats that as governed work, not `no-spec`.
  - This review artifact can be used as the seed input for a reduced-path or full-path draft package, but it is not itself an approved feature package.
