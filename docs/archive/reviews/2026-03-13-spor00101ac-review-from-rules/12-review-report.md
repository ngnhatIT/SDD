# SPOR00101AC Review Report (Implementation-First, No Canonical Feature Package)

## Review scope
- Target functionality: `SPOR00101AC` (発注依頼マスタ) as currently implemented.
- Review profile intent: `review-from-rules`.
- Constraint applied: review based on code/artifacts only, without relying on `spec_pack.md` or canonical feature package.
- Time of review: 2026-03-13.

## Reviewed files
- Backend webservices/processes/DTOs:
- `src/main/java/jp/co/brycen/kikancen/spor00101acsearch/webservice/Spor00101acSearchWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acsearch/webservice/Spor00101acSearchCntWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acsearch/process/Spor00101acSearchAllProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acsearch/process/Spor00101acSearchProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acsearch/process/Spor00101acSearchCntProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acinit/webservice/Spor00101acInitWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acinit/process/Spor00101acInitProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acgetdetail/webservice/Spor00101acGetDetailWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acgetdetail/process/Spor00101acGetDetailProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acchecklink/webservice/Spor00101acChecklinkWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acchecklink/process/Spor00101acChecklinkProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acregister/webservice/Spor00101acRegisterWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acregister/process/Spor00101acRegisterProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acupdate/webservice/Spor00101acUpdateWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acupdate/process/Spor00101acUpdateProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acdelete/webservice/Spor00101acDeleteWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acdelete/process/Spor00101acDeleteProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acsavesort/webservice/Spor00101acSaveSortWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acsavesort/process/Spor00101acSaveSortProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acgetproductagreement/webservice/Spor00101acGetProductAgreementWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101acgetproductagreement/process/Spor00101acGetProductAgreementProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101accsvimport/webservice/Spor00101acCsvImportWebService.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101accsvimport/process/Spor00101acCsvImportProcess.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101accsvimport/dto/Spor00101acCsvImportRowDto.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101ac/process/Spor00101acExclusionChecker.java`
- `src/main/java/jp/co/brycen/kikancen/spor00101ac/constant/Spor00101acConstant.java`
- Frontend:
- `src/main/webapp/angular/src/app/components/spor00101ac/spor00101ac.component.ts`
- `src/main/webapp/angular/src/app/components/spor00101ac/spor00101ac.component.html`
- `src/main/webapp/angular/src/app/common/Const.ts`
- `src/main/webapp/angular/src/app/common/DisplayScreenId.ts`
- `src/main/webapp/angular/src/app/wms-routing.module.ts`
- `src/main/webapp/angular/src/app/wms.module.ts`
- Data/config/reference:
- `anac.sql` (table dump evidence, limited confidence vs runtime DB)
- `AGENTS.md`
- `docs/sdd/context/*.md`, `docs/sdd/governance.md`
- `docs/sdd/standards/*.md` and `docs/sdd/standards/module-patterns/{search,csv}.md`

## Review basis / evidence used
- Current implementation in Java + Angular source code.
- DTO/request/response classes used as de-facto API contract.
- Route and constant mappings used by frontend transport.
- SQL construction inside process classes and one repository DB dump (`anac.sql`) as auxiliary data-shape evidence.
- Test artifacts: no `src/test` directory found for this module path; no SPOR00101AC-specific automated tests found.
- Canonical spec artifacts:
- No `docs/specs/<feature-id>/` folder found for `SPOR00101AC`.
- No `docs/spec-packs/*SPOR00101AC*` found.
- No execution brief for this feature found.

## Current behavior summary
- Screen route `SPOR00101AC` loads an Angular component with:
- Required search inputs: store, section, group, order classification.
- Optional filters: date range, supplier, product, hide flag.
- Search flow calls count API then list API.
- Detail edit flow uses check-link (optimistic lock pre-check), then get-detail, then update/delete/register APIs.
- Drag-drop + flags (`showHide`, `ccFlg`, `caFlg`) are persisted via bulk save-sort API.
- CSV import API exists for this feature (`Spor00101acCSVImport`) with insert/update or delete modes.
- Backend follows webservice -> process pattern and uses SQL-in-process with prepared parameters.

## Observed behavior
- Observed from code:
- API endpoints under `/webapi/kikancen/*`:
- `Spor00101acInit`, `Search`, `SearchCnt`, `CheckLink`, `GetDetail`, `Register`, `Update`, `Delete`, `SaveSort`, `GetProductAgreement`, `CSVImport`.
- Search date filter in backend uses containment logic:
- `COALESCE(ST, min) >= fromDate` and `COALESCE(ED, max) <= toDate` (`Spor00101acSearchAllProcess`).
- `showHide` filter only applied when request `showHide == "1"`; then SQL forces `T65.SHOWHIDE = "0"`.
- Detail retrieval (`GetDetail`) joins multiple master tables and returns audit metadata plus `upddatetime`.
- Register validates master existence, date/decimal formats, product agreement existence, overlap duplicate, then inserts with `DELETE_FLG='0'`, `DELETIONJUDGMENT='0'`.
- Update/Delete/SaveSort perform optimistic-lock checks using `UPDDATETIME`.
- Frontend maps backend string flags (`"0"/"1"`) to booleans for checkbox rendering and sends them back during bulk save.

## Inferred behavior
- Inferred from surrounding code:
- Business model likely treats `TAOR65` entries as manually maintainable rows with logical delete and edit lock semantics.
- `DELETIONJUDGMENT='1'` is likely integration-owned/non-deletable data (based on delete guard logic).
- Partner-specific agreement data influences detail delivery options (delivery type filtering by `DELIVERIES`).
- Pagination appears intentionally disabled for this screen path (`setLimit()` returns empty; pager usage commented in FE).

## Unknown / ambiguous behavior
- Unknown due missing governing feature package/spec:
- True business rule for search date logic (containment vs overlap) is not verifiable.
- True runtime table shape cannot be fully confirmed:
- `anac.sql` shows `KOTEI_TEKIYO_*` columns and PK shape different from code using `HAIGO_KOSEI_*`.
- It is unclear whether `anac.sql` reflects production schema for this module.
- Whether partner should be part of agreement validation contract during register/update cannot be proven from approved requirements.
- Expected fallback behavior for network/API errors in FE is ambiguous because many `.catch()` blocks are empty.

## Findings by severity
### High (P1)
1. Duplicate check during register ignores logical delete flag, can block valid re-insert.
- Evidence:
- `src/main/java/jp/co/brycen/kikancen/spor00101acregister/process/Spor00101acRegisterProcess.java:369-407`
- Query filters `DELETIONJUDGMENT='0'` and overlap dates, but does not filter `DELETE_FLG='0'`.
- Impact:
- Soft-deleted rows can still be counted as duplicates and prevent register.
- Classification: confirmed issue (observed directly from SQL conditions).

2. GetDetail agreement CTE does not filter `DELFLG`, unlike other flows.
- Evidence:
- `src/main/java/jp/co/brycen/kikancen/spor00101acgetdetail/process/Spor00101acGetDetailProcess.java:66-80`
- `TAMT026_PRODUCTAGREEMENT` CTE has date filters but no `DELFLG` predicate.
- Contrast:
- Search and get-product-agreement flows explicitly filter valid flag.
- Impact:
- Deleted agreement rows may be selected and shown in detail fields (delivery LT/count).
- Classification: confirmed issue.

### Medium (P2)
1. Register agreement existence check is not partner-scoped.
- Evidence:
- `src/main/java/jp/co/brycen/kikancen/spor00101acregister/process/Spor00101acRegisterProcess.java:418-444`
- Uses `CMPNYCD + PRODUCTCD + STORECD + date + DELFLG` only, no `PARTNERCD`.
- Related context:
- Partner is persisted and used in detail logic (`PARTNERCD` field, detail display/focus-out behavior).
- Impact:
- Validation can pass based on unrelated partner agreement for same product/store.
- Classification: confirmed issue in technical consistency; business correctness remains inferred.

2. Angular table `trackBy` key is `productCd` only.
- Evidence:
- `src/main/webapp/angular/src/app/components/spor00101ac/spor00101ac.component.ts:981-983`
- Impact:
- Rows sharing the same product code but different period/delivery can cause DOM reuse artifacts and wrong checkbox/edit state rendering.
- Classification: confirmed issue.

3. CSV row DTO mapping lacks column-length guard.
- Evidence:
- `src/main/java/jp/co/brycen/kikancen/spor00101accsvimport/dto/Spor00101acCsvImportRowDto.java:41-56`
- Direct `column.get(index++)` chain without bounds check.
- Impact:
- Short/malformed CSV rows can throw index exceptions before row-level error handling/logging.
- Classification: confirmed issue.

### Low (P3)
1. Dedicated GetProductAgreement API appears unused by SPOR00101AC frontend.
- Evidence:
- Const has endpoint constant, backend endpoint exists.
- No usage found in `spor00101ac.component.ts`.
- Impact:
- Dead path increases maintenance burden and divergence risk.
- Classification: suspicious pattern needing confirmation.

2. Multiple FE API catches swallow errors without user feedback.
- Evidence:
- Example around init/search/detail/register/update/delete calls with `.catch((err) => { });`
- Impact:
- Harder diagnosis, silent failure scenarios.
- Classification: suspicious pattern needing confirmation.

## Confirmed issues
- Register duplicate detection does not exclude logically deleted records.
- GetDetail agreement extraction can include logically deleted agreement records.
- Register agreement validation is not partner-scoped.
- Frontend `trackByProductCd` key is non-unique for multi-row product scenarios.
- CSV import DTO mapping is vulnerable to malformed row length.

## Suspicious areas needing confirmation
- Whether search date containment logic is intended by business.
- Whether GetProductAgreement endpoint should remain (dead-code suspicion).
- Whether silent FE catch behavior is accepted UX/error policy.
- Schema mismatch between repository SQL dump and runtime code column names.

## Test coverage observations
- No SPOR00101AC automated tests were found (`src/test` path absent).
- No module-level contract tests or API shape assertions found.
- Current evidence is implementation-only; regression risk is high for SQL/locking/date behavior.

## Maintainability / risk observations
- SQL logic and validation behavior are spread across many process classes with subtle differences (agreement filters, delete flags, date rules), increasing drift risk.
- Frontend component is large (~2000 lines), mixing search, detail edit, drag-drop, and validation concerns in one class.
- Error routing consistency is weak on network failures due silent catches.
- Missing canonical feature package means intent, scope boundary, and acceptance baseline are undocumented.

## Recommended next action
1. Fix confirmed P1/P2 defects first:
- Add `DELETE_FLG` predicate to register duplicate check.
- Add `DELFLG` predicate in GetDetail agreement CTE.
- Align register agreement check with partner dimension (or document explicit non-partner rule if intended).
- Change Angular `trackBy` key to stable composite key (`store+section+group+product+delivery+startDate`).
- Add safe CSV column-count guard before row mapping.
2. Add focused regression tests (or at least deterministic manual test cases) for:
- register duplicate with soft-deleted historical row,
- detail agreement selection vs deleted agreement,
- duplicate product rows rendering behavior in FE,
- malformed CSV row handling.
3. Resolve schema ambiguity by confirming runtime `TAOR65` DDL source-of-truth and align review/fixes to that schema.

## Whether a draft feature package/spec should be created
- Yes.
- Rationale:
- This module has confirmed behavior defects, no canonical governing package, and high regression risk.
- Minimum recommended artifact path assumption:
- `docs/specs/2026-03-13-spor00101ac-draft/` (reduced-path at minimum, expanded if contract/data behavior is changed).

## Assumption about review artifact path
- No suitable existing feature folder was found for `SPOR00101AC`.
- Therefore this review artifact is created at:
- `docs/archive/reviews/2026-03-13-spor00101ac-review-from-rules/12-review-report.md`
- This path is an operational review folder assumption, not an approved canonical feature package.
