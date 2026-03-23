---
id: "SPMT00141"
title: "SPMT00141 table-change impact review report"
owner: "WMS Delivery Team"
status: "completed"
last_updated: "2026-03-21"
related_specs:
  - "README.md"
  - "03-data-model.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Review Report

## Scope

- Review current `SPMT00141` implementation against the governing package and the external schema input `C:/Users/nk_nhat.BRYCENVN/Desktop/CREATE_TABLE_TMT026_PRODUCT.sql`.
- Review mode: `review-from-rules` / audit only.
- Code changes: none.

## Review Basis

- Governance and review flow:
  - `AGENTS.md`
  - `docs/sdd/context/constitution.md`
  - `docs/sdd/context/note.md`
  - `docs/sdd/context/architecture-context.md`
  - `docs/sdd/context/product-context.md`
  - `docs/sdd/context/tech-context.md`
  - `docs/sdd/context/ai-loading-order.md`
  - `docs/sdd/execution/task-routing.md`
  - `docs/sdd/execution/contracts/review-feature.md`
  - `docs/sdd/governance.md`
  - `docs/sdd/governance/03-context-binding.md`
  - `docs/sdd/governance/04-review-rules.md`
  - `docs/sdd/governance/12-uncertainty-escalation-policy.md`
  - `docs/sdd/checklists/touched-scope-enforcement.md`
- Governing feature package:
  - `docs/specs/SPMT00141/README.md`
  - `docs/specs/SPMT00141/01-requirements.md`
  - `docs/specs/SPMT00141/02-design.md`
  - `docs/specs/SPMT00141/03-data-model.md`
  - `docs/specs/SPMT00141/04-api-contract.md`
  - `docs/specs/SPMT00141/05-behavior.md`
  - `docs/specs/SPMT00141/06-edge-cases.md`
  - `docs/specs/SPMT00141/07-tasks.md`
  - `docs/specs/SPMT00141/08-acceptance-criteria.md`
  - `docs/specs/SPMT00141/09-test-cases.md`
  - `docs/specs/SPMT00141/10-rollout.md`
- Schema evidence:
  - `docs/sdd/context/schema_database.yaml`
  - `C:/Users/nk_nhat.BRYCENVN/Desktop/CREATE_TABLE_TMT026_PRODUCT.sql`
- Code anchors reviewed:
  - `src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/process/Spmt00141GetDetailProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141search/process/Spmt00141SearchAllRecProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141init/process/Spmt00141initProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141init/dto/Spmt00141initResponse.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141/dto/Spmt00141RegisterItemConditionDto.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141/dto/Spmt00141UpdateConditionDto.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/dto/Spmt00141GetDetailResponse.java`
  - `src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts`
  - `src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.html`
  - `src/main/webapp/angular/src/app/common/ConstCcdDef.ts`

## Schema Comparison Summary

- `docs/sdd/context/schema_database.yaml` and `CREATE_TABLE_TMT026_PRODUCT.sql` disagree on `27` `TMT026_PRODUCT` points:
  - `24` type/nullability differences
  - `2` SQL-only columns: `PACKAGING`, `QUANTITYPERPACKAGE`
  - `1` schema-only column: `STRKBN`
- Representative conflicts:
  - `GMIDCLASSCD2`: schema authority `varchar(10)` vs attached SQL `varchar(3)`
  - `GSMALLCLASSCD3`: schema authority `varchar(10)` vs attached SQL `varchar(4)`
  - `INVENTORYUNITCONVERSION`: schema authority `varchar(7)` vs attached SQL `decimal(5,2)`
  - `EXPIRATIONDATEMANAGEMENT`, `INVENTORYMANAGEMENTPATTERN`, `URGENTDEADLINECATEGORY`: schema authority `varchar(20)` vs attached SQL `varchar(2)`
  - `STRKBN`: present in schema authority, absent from attached SQL
- Per `AGENTS.md` and `docs/sdd/governance/03-context-binding.md`, repository authority remains `docs/sdd/context/schema_database.yaml`; the attached SQL is review input only until that authority is updated.

## Findings

- `F-01 Critical` Attached SQL cannot be treated as the active implementation target because it conflicts with schema authority on `27` points, including `STRKBN`, `PACKAGING`, and `QUANTITYPERPACKAGE`.
  - Impacted requirements: `REQ-01`, `REQ-05`, `REQ-08`
  - Evidence:
    - `docs/specs/SPMT00141/03-data-model.md`
    - `docs/sdd/context/schema_database.yaml`
    - `C:/Users/nk_nhat.BRYCENVN/Desktop/CREATE_TABLE_TMT026_PRODUCT.sql`
  - Impact:
    - safe implementation is blocked until authority is updated or the attached SQL is corrected.
    - any code change against the attached SQL today would violate the repository stop rule for DB-related work.

- `F-02 High` Current `SPMT00141` CRUD and search flows still hard-depend on `STRKBN`, but the attached SQL removes that column entirely.
  - Impacted requirements: `REQ-01`, `REQ-05`
  - Evidence:
    - register insert still writes `STRKBN` in [`Spmt00141RegisterProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java):361 and binds it at `:171`
    - update still writes `STRKBN` in [`Spmt00141UpdateProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java):175 and binds it at `:134`
    - detail still selects `TMT026.STRKBN` in [`Spmt00141GetDetailProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/process/Spmt00141GetDetailProcess.java):159 and maps it at `:56`
    - search still selects `TMT026.STRKBN` in [`Spmt00141SearchAllRecProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141search/process/Spmt00141SearchAllRecProcess.java):518
  - Impact:
    - if the attached SQL is applied as-is, register, update, detail, and search paths will fail at runtime with invalid-column SQL errors.

- `F-03 High` Product-code handling is still capped at `10` characters across UI and backend validation, while both schema sources still define `PRODUCTCD` as `varchar(13)`.
  - Impacted requirements: `REQ-01`, `REQ-02`, `REQ-04`
  - Evidence:
    - search input uses `[maxlength]="10"` in [`spmt00141.component.html`](src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.html):15
    - detail inputs use `maxlength="10"` for `productCd` and `productCdManual` in [`spmt00141.component.html`](src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.html):269 and `:279`
    - frontend validation still enforces `Const.length10` in [`spmt00141.component.ts`](src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts):2241 and `:2246`
    - backend register validation still enforces `LENGTH_10` in [`Spmt00141RegisterProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java):240-241
    - backend update validation still enforces `LENGTH_10` in [`Spmt00141UpdateProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java):251-252
    - backend search validation still enforces `LENGTH_10` in [`Spmt00141SearchAllRecProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141search/process/Spmt00141SearchAllRecProcess.java):48
  - Impact:
    - valid `11` to `13` character product codes from the changed table shape cannot be searched or edited through the current screen family.

- `F-04 High` The screen contract and SQL mapping do not carry the changed/additive table fields from the attached SQL and still bind the legacy `STANDARDPIECE` path only.
  - Impacted requirements: `REQ-05`, `REQ-06`, `REQ-07`
  - Evidence:
    - request DTOs expose only legacy fields in [`Spmt00141RegisterItemConditionDto.java`](src/main/java/jp/co/brycen/kikancen/spmt00141/dto/Spmt00141RegisterItemConditionDto.java):5-35 and [`Spmt00141UpdateConditionDto.java`](src/main/java/jp/co/brycen/kikancen/spmt00141/dto/Spmt00141UpdateConditionDto.java):8-38
    - detail response still exposes only legacy fields in [`Spmt00141GetDetailResponse.java`](src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/dto/Spmt00141GetDetailResponse.java):383-410
    - register insert column list does not include `PACKAGING`, `QUANTITYPERPACKAGE`, `EXPIRATIONDATEMANAGEMENT`, `INVENTORYMANAGEMENTPATTERN`, `INVENTORYUNITCONVERSION`, or `URGENTDEADLINECATEGORY` in [`Spmt00141RegisterProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java):292-364
    - update set clause does not include those fields in [`Spmt00141UpdateProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java):152-181
    - detail select does not load them in [`Spmt00141GetDetailProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/process/Spmt00141GetDetailProcess.java):147-183
    - current detail mapping still uses `STANDARDPIECE` for `unitsPerPackage` in [`Spmt00141GetDetailProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/process/Spmt00141GetDetailProcess.java):69
    - frontend request/response handling also contains only the legacy field set in [`spmt00141.component.ts`](src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts):1727-1731, `:1879-1895`, `:2133-2164`, and `:2176-2190`
  - Impact:
    - the current screen cannot read, edit, validate, or persist the new or resized `TMT026_PRODUCT` fields described by the attached SQL.

- `F-05 Medium` Master-data initialization is still on the old code groups and cannot drive the newer code-backed fields required by the changed table shape.
  - Impacted requirements: `REQ-05`, `REQ-07`
  - Evidence:
    - `Spmt00141Init` backend is effectively empty in [`Spmt00141initProcess.java`](src/main/java/jp/co/brycen/kikancen/spmt00141init/process/Spmt00141initProcess.java):18-27 and [`Spmt00141initResponse.java`](src/main/java/jp/co/brycen/kikancen/spmt00141init/dto/Spmt00141initResponse.java):7
    - frontend dropdown init still requests `3011/3012/3013/3014` instead of the governed `3062/3063/3064/3087/3096/3097` in [`spmt00141.component.ts`](src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts):866-945
    - shared constants define `GC_H3062`, `GC_H3063`, `GC_H3064`, `GC_H3087`, and `GC_H3097`, but no `GC_H3096` exists in [`ConstCcdDef.ts`](src/main/webapp/angular/src/app/common/ConstCcdDef.ts):474-540
  - Impact:
    - even after schema authority is fixed, the current init path still cannot hydrate the code tables needed for the newer field set.

## Verification

- `TC-01`, `TC-02`, `TC-03`, `TC-05`, `TC-06`, `TC-07`: failed by static review because current code does not align with the changed table shape on field set, `PRODUCTCD` length, and `STRKBN` usage.
- `TC-04`: failed by static review because the new code-based and numeric fields from the changed table are not present in the current frontend/backend validation path.
- `TC-08`: not executed. No runtime smoke test or build was run in this audit-only pass.
- `TC-09`: failed. As of `2026-03-21`, the attached SQL still conflicts with `docs/sdd/context/schema_database.yaml`, so schema-dependent implementation remains blocked.

## Verdict

- Result: `fail`
- Blocking findings: `5`
- Non-blocking findings: `0`

## Confidence And Residual Risk

- Confidence: `medium`
- Basis:
  - grounded in the governing feature package, current repository code, and a direct column-level comparison between schema authority and the attached SQL file.
  - no runtime database migration or end-to-end execution was performed in this review pass.
- Residual risk:
  - this review was intentionally scoped to the `SPMT00141` family; other modules joining or mutating `TMT026_PRODUCT` may have additional breakpoints once the table change is finalized.
