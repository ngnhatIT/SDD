# Verification: FPKH5410HS

- Status: partial hybrid implementation
- Last Updated: 2026-03-24
- Originating Pack: `docs/spec-packs/FPKH5410HS/spec_pack.md`

## 1. Summary Of Changes

- normalized the governed pack filename from `spec-pack.md` to `spec_pack.md`
- added `reinforcement.md` so the task folder carries the required non-trivial reinforcement artifact
- added an `SPKH5410HS` Angular screen scaffold with:
  - screen id registration
  - route registration
  - module declaration
  - a component aligned to the existing Angular screen family via `BaseComponent`, `DisplayScreenID`, `fnInit`, and `fnDestroy`
  - `formItemNm` fallback labels so the screen still renders coherently when TMT340 labels are not yet grounded
  - local dialog, copy, clear, confirm, delete, drag-drop, and enable/disable behavior
- expanded the local dialog scaffold so it now supports local-only:
  - filter by `企画番号`, `企画名`, and registered-date range
  - seeded dialog rows across multiple pages
  - paging at 25 rows/page with a sliding numeric page window
  - detail/copy opening from whichever scaffold row is selected
- tightened the local scaffold behavior so it does not overstate unresolved contracts:
  - `表示` now refuses arbitrary plan-number detail loads and only opens local detail for the scaffolded sample row
  - `削除` now clears the local scaffold without triggering an extra clear-confirmation prompt after delete confirmation
- supplemented the active process with archive SDD v1 frontend parity rules to pull the screen back toward the legacy codebase shape instead of keeping a one-off standalone component
- added a read-only backend init surface for the screen:
  - `Spkh5410hsInitWebService`
  - `Spkh5410hsInitProcess`
  - `Spkh5410hsInitRequest`
  - `Spkh5410hsInitResponse`
- wired product-code additions and drag-drop imports in `SPKH5410HS` to the existing common `FocusOutGetName` backend for `TMT026_PRODUCT`
- kept save, update, delete, detail display, customer lookup, and schema-changing work blocked because the active pack and schema authority still do not ground those contracts

## 2. Acceptance Coverage

| AC | Coverage | Evidence |
| --- | --- | --- |
| AC-FPKH5410HS-1 | partial | screen opens in init mode with `自動採番`; `fnInit()` now also calls `Spkh5410hsInit`, but combo payload remains effectively empty because pack-level `VMT050_ALL` code mapping is still unresolved |
| AC-FPKH5410HS-2 | covered | `onPlanNoBlur()` restores `自動採番` when the field is left blank |
| AC-FPKH5410HS-3 | covered (local scaffold) | `openDisplay()` opens the local dialog scaffold when `企画番号` is still `自動採番` |
| AC-FPKH5410HS-4 | not covered | nonexistent-plan validation message still depends on the unresolved display/search backend contract, but `openDisplay()` now refuses arbitrary local detail loads instead of pretending any typed plan number exists |
| AC-FPKH5410HS-5 | not covered | no header/store/customer/target data is loaded from persisted coupon-plan tables |
| AC-FPKH5410HS-6 | not covered | stale-data handling depends on unresolved list/detail backend contract |
| AC-FPKH5410HS-7 | partial | dialog link can load a local sample plan into detail mode and show the delete trigger, but not real persisted data |
| AC-FPKH5410HS-8 | covered | `clearForm()` resets directly when there are no unsaved local changes |
| AC-FPKH5410HS-9 | covered | `clearForm()` shows a confirmation dialog when local unsaved changes exist |
| AC-FPKH5410HS-10 | covered | `onCouponTypeChange()` forces `クーポン発行 = なし` for `メッセージ` and disables the `あり` option in the template |
| AC-FPKH5410HS-11 | partial | FE enable/disable matrix is implemented locally through getters; no persisted validation or server-side guard exists |
| AC-FPKH5410HS-12 | covered | `onCustomerSegmentChange()` and related getters control member-code and member-filter sections locally |
| AC-FPKH5410HS-13 | partial | issue-target add/remove exists; product codes now validate through backend master lookup, but small-class lookup and DB soft delete are still not implemented |
| AC-FPKH5410HS-14 | partial | coupon-target add/remove exists; product codes now validate through backend master lookup, but small-class lookup and DB soft delete are still not implemented |
| AC-FPKH5410HS-15 | covered (hybrid) | `onDrop()` and `loadCodes()` split incoming text by newline, comma, or tab; product codes are resolved via backend lookup, while small-class codes still use local placeholder names |
| AC-FPKH5410HS-16 | partial | `confirmPlan()` assigns a local fake plan number and transitions the scaffold, but no save or `TMT140` update occurs |
| AC-FPKH5410HS-17 | not covered | stale-update blocking depends on unresolved persisted update contract |
| AC-FPKH5410HS-18 | covered (local) | `copyPlan()` resets only `企画番号` to `自動採番` and keeps the other fields on the local scaffold |
| AC-FPKH5410HS-19 | partial | `deletePlan()` now performs a single delete confirmation and then clears the local scaffold; DB delete scope and re-search behavior remain unresolved |
| AC-FPKH5410HS-20 | partial | dialog scaffold applies default registered-date values and surfaces the `25/page` limit, but no real sliding pager exists |
| AC-FPKH5410HS-21 | not covered | calendar popup behavior is not implemented; date input still uses native HTML date fields only |

Additional acceptance evidence from the latest scaffold pass:

- AC-FPKH5410HS-3: `searchDialog()` now applies local plan-number, plan-name, and registered-date filters inside the scaffold dialog.
- AC-FPKH5410HS-7: dialog link and dialog copy now operate on whichever local scaffold row is selected, not just a single hard-coded sample row.
- AC-FPKH5410HS-20: the scaffold dialog now pages local seed rows at 25 rows/page and renders a sliding numeric page window locally; backend count/search APIs remain unresolved, so the table row above still reflects pack-level contract limits.

## 3. Changed Code Paths

- Angular screen id: `src/main/webapp/angular/src/app/common/DisplayScreenId.ts`
- Angular service constants: `src/main/webapp/angular/src/app/common/Const.ts`
- Angular route: `src/main/webapp/angular/src/app/wms-routing.module.ts`
- Angular module declaration: `src/main/webapp/angular/src/app/wms.module.ts`
- Angular runtime component: `src/main/webapp/angular/src/app/components/spkh5410hs/spkh5410hs.component.ts`
- Angular runtime template: `src/main/webapp/angular/src/app/components/spkh5410hs/spkh5410hs.component.html`
- backend init request DTO: `src/main/java/jp/co/brycen/kikancen/spkh5410hsinit/dto/Spkh5410hsInitRequest.java`
- backend init response DTO: `src/main/java/jp/co/brycen/kikancen/spkh5410hsinit/dto/Spkh5410hsInitResponse.java`
- backend init process: `src/main/java/jp/co/brycen/kikancen/spkh5410hsinit/process/Spkh5410hsInitProcess.java`
- backend init webservice: `src/main/java/jp/co/brycen/kikancen/spkh5410hsinit/webservice/Spkh5410hsInitWebService.java`
- governed artifact updated: `docs/spec-packs/FPKH5410HS/reinforcement.md`
- governed artifact updated: `docs/spec-packs/FPKH5410HS/spec_pack.md`
- governed artifact updated: `docs/spec-packs/FPKH5410HS/verification.md`

## 4. Verification Steps And Checks Run

- `Get-Content AGENTS.md`
- `Get-Content docs/spec-packs/FPKH5410HS/spec_pack.md`
- `Get-Content docs/execution/ai-loading-order.md`
- `Get-Content docs/execution/task-contracts.md`
- `Get-Content docs/governance/core-rules.md`
- `Get-Content docs/governance/minimal-context.md`
- `Get-Content docs/spec-packs/FPKH5410HS/reinforcement.md`
- `Get-Content docs/structure.md`
- `Get-Content docs/standards/api-rules.md`
- `Get-Content docs/standards/db-rules.md`
- `Get-Content docs/standards/testing-rules.md`
- `Get-Content docs/standards/schema_database.yaml`
- `Get-Content docs/archive/sdd-v1/decisions/ADR-0002-source-base-anchor-and-style-parity-enforcement.md`
- `Get-Content docs/archive/sdd-v1/sdd/standards/frontend-screen-architecture.md`
- `Get-Content docs/archive/sdd-v1/sdd/standards/frontend-change-rules.md`
- `Get-Content docs/archive/sdd-v1/sdd/standards/repository-context.md`
- repository searches for `tmt104`, `tmt105`, `tmt106`, `tmt107`, `tmt108`, `tmt140`, `tmt100_customer`, `vmt050_all`, `SPKH5410HS`, and archive anchors under `docs/archive/sdd-v1/`
- inspected backend family patterns:
  - `src/main/java/jp/co/brycen/kikancen/spmt01201init/`
  - `src/main/java/jp/co/brycen/kikancen/spmt10101init/`
  - `src/main/java/jp/co/brycen/kikancen/common/initdropdown/`
  - `src/main/java/jp/co/brycen/kikancen/common/focusout/`
  - `src/main/java/jp/co/brycen/kikancen/tmt050allkbnsearch/`
- inspected frontend family patterns:
  - `src/main/webapp/angular/src/app/components/spmt10101/`
  - `src/main/webapp/angular/src/app/components/spmt00021/`
  - `src/main/webapp/angular/src/app/components/common/base/base.component.ts`
- `npm run build` in `src/main/webapp/angular` -> failed due Node heap exhaustion before useful compile output
- `node --max-old-space-size=8192 ./node_modules/@angular/cli/bin/ng build` in `src/main/webapp/angular` -> failed on pre-existing workspace issues unrelated to `SPKH5410HS`, including missing `ag-grid-angular`, missing `ag-grid-community/styles/ag-grid.css`, and widespread existing Angular template/module errors elsewhere in the app
- `$output = node --max-old-space-size=8192 ./node_modules/@angular/cli/bin/ng build 2>&1; $output | Select-String -Pattern 'spkh5410hs|Spkh5410hsInit'; Write-Output ('EXITCODE=' + $LASTEXITCODE)` in `src/main/webapp/angular` -> `EXITCODE=1` with no `spkh5410hs` matches
- `$output = node ./node_modules/typescript/bin/tsc -p tsconfig.app.json --noEmit --noErrorTruncation 2>&1; $output | Select-String -Pattern 'spkh5410hs|TS7027|TS1109|TS1005|TS2304|TS2339|TS2322|TS2554'; Write-Output ('EXITCODE=' + $LASTEXITCODE)` in `src/main/webapp/angular` -> `EXITCODE=2` with no `spkh5410hs` matches
- `mvn -q -DskipTests compile` in repo root -> succeeded
- `python3.12 scripts/validate-task.py docs/spec-packs/FPKH5410HS implement --strict` -> now runs, but fails because the governed folder name is not canonical date-first format

## 5. Tests Run Or Missing

- no automated unit or integration tests were added for `SPKH5410HS`
- no browser/manual UI walkthrough was run inside a live Angular runtime
- Java compile gate passed:
  - `mvn -q -DskipTests compile` succeeded after adding `spkh5410hsinit`
- Angular compile gates remain partial:
  - default `npm run build` failed from Node heap exhaustion
  - heap-expanded `ng build` failed because of unrelated existing workspace issues outside `SPKH5410HS`
  - filtered heap-expanded build showed no `spkh5410hs` or `Spkh5410hsInit` diagnostics in output
  - filtered `tsc --noEmit` exited non-zero because of unrelated workspace errors, but showed no `spkh5410hs` diagnostics
- strict validator now executes in this environment, but still fails because `docs/spec-packs/FPKH5410HS/` does not use canonical date-first folder naming

## 6. Contract And Schema Impact

- application impact: `SPKH5410HS` now has a hybrid scaffold that calls a screen-specific init endpoint and existing product master lookup
- API impact:
  - added read-only `POST /Spkh5410hsInit`
  - reused existing common `POST /FocusOutGetName` for `TMT026_PRODUCT`
- DB impact:
  - no new SQL authored
  - new init endpoint delegates to existing common dropdown queries only when `tableConfig` or `rcdkbnList` are supplied
  - product lookup reuses existing common master-name query path for `TMT026_PRODUCT`
- schema impact: none
- persistence impact: none
- governance and source gaps still unresolved:
  - the governed folder name `FPKH5410HS` does not match the canonical date-first folder pattern required by `docs/structure.md`
  - schema authority does not currently ground the coupon tables referenced by the pack
  - the originating pack still carries blocker-level unresolved items for DB mapping, target ownership, and delete scope
  - the referenced business source file is absent from the repository

## 7. Residual Risks

- `Spkh5410hsInit` is intentionally narrow; FE currently sends empty `tableConfig` / `rcdkbnList` because pack-level `VMT050_ALL` code mapping is still unresolved, so init is a family-aligned backend anchor rather than a fully populated combo source
- product target validation is grounded through existing common lookup, but small-class validation remains local-only because `TMT010_GSMALLCLASSIFICATION` lookup needs `MIDCD`, which the current screen slice does not ground
- customer-code validation is still local-only because `TMT100_CUSTOMER` is not grounded in schema authority and no safe common lookup contract was confirmed for this screen
- save, update, delete, stale-data checks, dialog search, detail display, and numbering authority remain unresolved because OI-01, OI-02, OI-03, OI-04, and OI-09 are still open in the active pack
- direct `表示` by typed `企画番号` is intentionally limited to the scaffold sample row so the screen does not fake a grounded display/search contract that the pack still marks as proposed only
- dialog filtering and paging are now implemented only against local seed rows; they do not prove the unresolved backend count/search contract
- date handling still relies on native HTML date inputs, not the calendar-popup behavior described in the pack
- full Angular build cannot be used as a final confidence gate until the existing workspace-level frontend dependency and compile issues are fixed

## 8. Confidence

- medium that the FE + read-only-backend slice is aligned to existing repo families and safe to keep
- high that save/delete/detail/schema work would still be speculative under the current pack and schema state
