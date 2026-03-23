---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment review report"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-21"
related_specs:
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "11-implementation-report.md"
---

# Review Report

## Scope

Review current `BTCC0080AC` optional-field validation alignment against `REQ-01` to `REQ-04`, including spec-code-schema parity.

## Findings

- None.

## Verification

- `TC-01`: passed by static review. `templateFlg` remains optional in `StaticApiCheckConfig`, the shared `seihinCd` rule stays required for `mZairyoKoseiSs`, and `Btcc0080acProcess` disables only the `mHaigoKoseiHdrs.seihinCd` required check through `validateDataList(..., "seihinCd")`, which matches `taor55_combinationheader.SEIHIN_CD` nullable schema versus `taor57_productionmaterialcomposition.SEIHIN_CD` non-nullable schema.
- `TC-02`: not executed in the workspace because the referenced reproduction payloads were not present locally.
- `TC-03`: passed by static review. Existing date-range validation and non-negative validation remain intact, and the `seihinCd` alignment is limited to the conflicting `mHaigoKoseiHdrs` path.
- `TC-04`: `mvn -q -DskipTests compile` passed on `2026-03-21`.
- `TC-05` to `TC-09`: `mvn -q "-Dtest=Btcc0080acProcessValidationTest" test` passed on `2026-03-21`, covering omitted `templateFlg`, omitted `mHaigoKoseiHdrs.seihinCd` on both upsert and delete, retained required validation for `mZairyoKoseiSs.seihinCd` on both upsert and delete, and a valid delete payload regression check.
- `TC-10` to `TC-12`: `mvn -q "-Dtest=Btcc0080acWebServiceJsonIntegrationTest" test` passed on `2026-03-21`, confirming the same optional-field alignment behavior for both upsert and delete and a stable valid delete path through the external JSON route `/api/Bcc0080ac`.

## Verdict

- Result: `pass`
- Blocking findings: 0
- Non-blocking findings: 0

## Confidence And Residual Risk

- Confidence: `high`
- Basis: current code, schema authority, and the governing requirements now align on the optional-field behavior under review.
- Residual risk: the external API sheet and the original reproduction payload files are still absent from the repository, so runtime confirmation of the reported payloads remains manual-only.
