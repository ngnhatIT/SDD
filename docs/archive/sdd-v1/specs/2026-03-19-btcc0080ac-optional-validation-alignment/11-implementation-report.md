---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment implementation report"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-21"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
---

# Implementation Report

## Delivered Scope

- Added the reduced-path governing package for the reported `BTCC0080AC` validation defect.
- Calibrated the `BTCC0080AC` static validation map so nullable optional fields no longer use shared required validation.
- Kept `templateFlg` in the current DTO and SQL flow but removed its required-validation behavior.
- Applied a narrow per-list override in `Btcc0080acProcess` so the shared `seihinCd` required rule is disabled only for `mHaigoKoseiHdrs`, where that alias is nullable in the current schema.

## Anchors Reviewed

- Validation flow:
  - `src/main/java/jp/co/brycen/kikancen/api/common/process/APIImportProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/api/common/validator/APIValidator.java`
  - `src/main/java/jp/co/brycen/kikancen/api/common/validator/config/StaticApiCheckConfig.java`
- `BTCC0080AC` family:
  - `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/process/Btcc0080acProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/webservice/Btcc0080acWebService.java`
  - `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/dto/Btcc0080acMenuPlanDto.java`
  - `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/dto/Btcc0080acHaigoKoseiHdrDto.java`
  - `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/dto/Btcc0080acZairyoKoseiDto.java`
- Schema authority:
  - `docs/sdd/context/schema_database.yaml`

## Verification

- `TC-01`: passed by static inspection of the updated `BTCC0080AC` static rule block and the per-list `seihinCd` override in `Btcc0080acProcess`.
- `TC-03`: passed by static inspection; existing date-range and non-negative validators remain in the same flow, with only the narrow `seihinCd` blacklist override added for `mHaigoKoseiHdrs`.
- `TC-04`: passed via `mvn -q -DskipTests compile`.
- `TC-02`: not executed in the workspace because the referenced response payload files were not present locally.
- `TC-05` to `TC-09`: passed via `mvn -q "-Dtest=Btcc0080acProcessValidationTest" test`, including both upsert and delete optional/required key-validation paths after the `seihinCd` override.
- `TC-10` to `TC-12`: passed via `mvn -q "-Dtest=Btcc0080acWebServiceJsonIntegrationTest" test`, confirming the same optional/required behavior and valid delete-path regression through the external JSON webservice route.

## Residual Risk And Confidence

- Confidence: `medium`
- Basis: the repo does not contain the original BCC0080AC API sheet or the referenced reproduction payload files, so the calibration is intentionally limited to user-reported symptoms plus current schema and code evidence.
- Residual risk: if the external API sheet marks additional fields as required or optional beyond what can be defended from current schema and SQL-key usage, a follow-up adjustment may still be needed.
