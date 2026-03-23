# Audit: 2026-03-23-spmt00141-runtime-audit

- Status: completed with schema-authority mismatch reported
- Last Updated: 2026-03-23

## 1. Scope And Basis

- target scope: runtime investigation of `SPMT00141` across frontend, backend, and DB
- active rules or standards applied: `AGENTS.md`, `docs/execution/ai-loading-order.md`, `docs/execution/task-routing.md`, `docs/execution/task-contracts.md`, `docs/governance/core-rules.md`, `docs/governance/minimal-context.md`, `docs/standards/schema_database.yaml`
- inspected evidence:
  - Angular route, component, template, shared base component, webservice service, search-condition services
  - `SPMT00141` webservice/process families for init, search-count, search, check-link, detail, register, update, delete, main/sub classification
  - common processes directly affecting runtime behavior: `MasterCodeCheckProcess`, `MasterNameGetProcess`, `FocusOutGetNameProcess`, `MasterCheckExclusionProcess`, `AbstractProcess`, `DBAccessor`
  - schema authority excerpts for `tmt026_product` and `tmt209_searchdata`

## 2. Hard Stop Reported

- active schema authority and active runtime SQL disagree for `TMT026_PRODUCT`
- confirmed mismatches:
  - code validates `PRODUCTCD` and `PRODUCTCDHANDMADE` to length `10`, but schema authority declares both columns as `varchar(13)`
  - code search/detail/register/update read or write `STRKBN`, but the active `tmt026_product` schema section does not contain a `STRKBN` column
  - code validates `PRODUCTNM` to length `40`, but schema authority declares `PRODUCTNM varchar(100)`
- consequence:
  - the code-path investigation below is still valid as a reconstruction of what the application code currently attempts to do
  - DB compatibility against the active schema authority is not fully defensible for the conflicting columns above
  - DB conclusions are therefore split into:
    - confirmed SQL behavior constructed by the code
    - schema-authority compatibility limits

## 3. Confirmed End-To-End Owner Chain

- frontend entry point:
  - route `SPMT00141` in `src/main/webapp/angular/src/app/wms-routing.module.ts`
  - screen implementation in `src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts` and `.html`
  - initial invocation comes from `BaseComponent.ngOnInit()` -> `fnSetFormItemNm()` -> `fnInit(false)`
- backend entry points:
  - `Spmt00141Init`
  - `Spmt00141SearchCnt`
  - `Spmt00141Search`
  - `Spmt00141CheckLink`
  - `Spmt00141GetDetail`
  - `Spmt00141Register`
  - `Spmt00141Update`
  - `Spmt00141Delete`
  - `spmt001471MainClassification`
  - `spmt001471SubClassification`
- DB objects directly affecting behavior:
  - primary product source: `TMT026_PRODUCT`
  - detail side-table: `TAPR03_DELIVERYUNITPRICEPERFORMANCE`
  - search condition persistence: `TMT209_SEARCHDATA`
  - name resolution joins/lookups: `TMT042_GMAINCLASSIFICATION`, `TMT010_GSMALLCLASSIFICATION`, `TMT011_GSUBCLASSIFICATION`, `VMT050_ALL`, `TMT002_USER`, `TMT003_STORE`

## 4. Confirmed Runtime Behavior

### 4.1 Initial Load And Re-entry

- `fnInit()` calls `initProcess()`, `loadSearchConditions()`, list initialization, main/sub-classification loads, dropdown init, table-column setup, then disables the specification date control on first render
- backend `Spmt00141Init` is a no-op and returns an empty response
- saved search conditions are loaded from `TMT209_SEARCHDATA` by `screenID + CMPNYCD + USRCD`
- loaded conditions are applied back to the component through `Ultility.fnSetSearchValues`, which applies non-date controls first and date controls second
- after loading conditions, the screen replays router state only when returning from `SPMT00161AC` or `SPMT00151AC`
- return navigation restores `productCd` and optional main class into search state, then immediately runs search again

### 4.2 Search Flow

- clicking search validates only:
  - `productCodeSearch` max length `10`
  - `keywordSearch` max length `100`
- search request is built from `dtoSpmt00141SearchConditionDto`, not directly from raw UI bindings
- if a search product code exists, FE triggers `FocusOutGetName` first to resolve the product name
- `Spmt00141SearchCnt` and `Spmt00141Search` share the same query family; count only overrides the select field to `Count(*) as CNT`, while data search adds `LIMIT/OFFSET`
- hide-deleted behavior:
  - when `isDeleteDataHide == DELETE_FLG`, query adds `AND TMT026.DELFLG = ?`
  - when the radio is set to show deleted, the query removes that filter entirely
- search ordering is explicit:
  - numeric-looking `PRODUCTCD` first
  - then numeric sort on `CAST(PRODUCTCD AS UNSIGNED)`
  - then lexical `PRODUCTCD ASC`
- zero-result branch shows `MI000001`, clears the table body, and resets paging state

### 4.3 Detail Link Flow

- clicking a result row:
  - stores the hidden update timestamp
  - switches FE mode to update
  - prompts if current input differs from the hidden snapshot
  - calls `Spmt00141CheckLink`
- backend `Spmt00141CheckLink` only delegates to `MasterCheckExclusionProcess.checkExclusion(...)` and returns without populating `dataCnt`
- FE then evaluates `response.dataCnt !== 1`
  - because backend never sets `dataCnt`, the success path is effectively driven by absence of `fatalError`, not by a populated count
- on successful check-link, FE loads detail through `Spmt00141GetDetail`
- detail query reads `TMT026_PRODUCT` by `PRODUCTCD + CMPNYCD` without a `DELFLG` filter
- after detail load, FE always sets `isDisabledWhenAfterRegister = true`, regardless of the row’s `inspectionCompletedFld`
- effect:
  - `linkClick()` initially disables some controls only when `inspectionCompletedFld === "1"`
  - `fnPopulateDetailFromResponse()` then overwrites that state and keeps those controls disabled for every loaded detail row

### 4.4 Register / Update / Delete

- register:
  - validates required fields, conditional required fields, numeric/date formats, class-code existence, and duplicate-or-deleted `PRODUCTCD`
  - duplicate active product returns `ME000127`
  - existing deleted product returns `ME000054`
  - insert writes the screen fields into `TMT026_PRODUCT` and hardcodes many other columns to space/zero/date literals instead of relying on DB defaults
  - `GMIDCLASSCD2` and `GSMALLCLASSCD3` are both bound from the same request field `gMainClassRnmTypeA`
- update:
  - validates similarly to register
  - runs optimistic-lock check before update
  - `UPDATE TMT026_PRODUCT` uses `WHERE PRODUCTCD = ? AND CMPNYCD = ?`
  - `UPDDATETIME` is refreshed with `SYSDATE(6)`
  - `GMIDCLASSCD2` and `GSMALLCLASSCD3` are again both sourced from the same main-class request field
- delete:
  - runs the same exclusion check
  - performs soft delete only by updating `DELFLG`, `UPDUSRCD`, and `UPDPRG`
  - does not update `UPDDATETIME`

## 5. Hidden Runtime Rules And Edge Cases

- deleted product code cannot be searched by direct code input even when the radio says “show deleted”
  - reason:
    - FE blur lookup resolves product code through `FocusOutGetName` -> `MasterNameGetProcess.getName(...)`, which filters `DELFLG = active`
    - backend search validation also uses `MasterCodeCheckProcess.isProductExists(...)`, which checks `TMT026_PRODUCT` with `DELFLG = active`
  - effect:
    - a deleted code fails validation or name resolution before the broader search query can use the no-`DELFLG` branch
- check-link, update, and delete do not lock the row
  - `MasterCheckExclusionProcess.setQueryFields(..., isCheckLink=true)` omits `FOR UPDATE`
  - update/delete then run a second statement that also does not include `UPDDATETIME` in the `WHERE`
  - this leaves a race window between the exclusion check and the actual write
- missing-row path is weakly handled
  - `MasterCheckExclusionProcess.setResponse(...)` adds errors only if `rs.next()`
  - if the row does not exist, no exclusion error is added
  - update/delete do not check affected row count after `executeUpdate()`
  - therefore a missing-row edge case can fall through to apparent success with no actual mutation
- detail query can still read deleted data if called directly
  - the detail SQL has no `DELFLG` predicate
  - normal UI flow usually blocks deleted rows first by check-link fatal error
- search-condition persistence is replace-style, not merge-style
  - save to `TMT209_SEARCHDATA` first counts existing rows, deletes non-CSV rows for the same `screenID + cmpny + user`, then inserts the current conditions
  - delete from `TMT209_SEARCHDATA` removes either CSV or non-CSV controls depending on `isCSV`
- classification dropdown behavior is asymmetric
  - main-class list query has no `ORDER BY`
  - sub-class list query filters by `GSMALLCLASSCD3 = gmainClassCd1` and orders by `GSUBCLASSCD4`

## 6. DB-Layer Conclusions

### 6.1 SQL Behavior Confirmed From Code

- list/search source of truth in runtime SQL is `TMT026_PRODUCT`
- detail source of truth in runtime SQL is also `TMT026_PRODUCT`
- detail unit-price history is read from `TAPR03_DELIVERYUNITPRICEPERFORMANCE` and ordered by `LASTDELIVERYDATE DESC`
- FE search-condition state persistence uses `TMT209_SEARCHDATA`

### 6.2 Schema-Authority Compatibility Limits

- `docs/standards/schema_database.yaml` confirms for `tmt026_product`:
  - `PRODUCTCD varchar(13)`
  - `PRODUCTCDHANDMADE varchar(13)`
  - `PRODUCTNM varchar(100)`
  - `OBLIGATIONTOPURCHASE`
  - `STRKBN1`
  - `STRKBN2`
  - `STRKBN3`
  - `STRRSRV1`
  - `STRRSRV2`
  - `STRRSRV3`
  - `INSPECTIONCOMPLETEDFLD`
- the same authority section does not contain `STRKBN`
- no entry was found in the active schema authority for `TAPR03_DELIVERYUNITPRICEPERFORMANCE`

## 7. Tests And Evidence Gaps

- no direct active `src/test` reference to `SPMT00141` was found during repository search
- no active E2E or integration artifact was found that outranks the runtime code
- because of the schema mismatch, I cannot defend that the current SQL shape is deployable against the active schema authority without additional DB confirmation

## 8. Residual Risks And Confidence

- high confidence:
  - FE route/component ownership
  - backend webservice/process owner chain
  - search, detail, register, update, delete call chain and validation/write logic
  - `check-link` not setting `dataCnt`
  - deleted-code search being blocked by active-only validation/name resolution
  - missing `FOR UPDATE` and missing row-count checks on update/delete
- medium confidence:
  - UI disable-state implications after detail load, because they depend on the exact bound controls in the template but the component path is explicit
- low confidence:
  - DB compatibility of conflicting columns against the active schema authority
  - full operational behavior of the unit-price history source, because no authority entry for `TAPR03_DELIVERYUNITPRICEPERFORMANCE` was found
