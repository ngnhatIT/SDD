---
id: "2026-03-13-btcc0080ac-zairyokosei-nonnegative"
title: "BTCC0080AC zairyo kosei non-negative validation review report"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-21"
related_specs:
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Review Report

## Scope

Review the current `Btcc0080acProcess` non-negative validation for `upsert.mZairyoKoseiSs` against `REQ-01` to `REQ-03`.

## Findings

- None.

## Verification

- `TC-01` to `TC-03`: static inspection confirms the current validator covers `hKoseiLineSeqNo`, `dishTonyuSyoyoryo`, `dishTonyuZyuryo`, `potionSu`, and `modifyCount`, and uses `hasFieldError(errIndex, fieldName, errors)` to prevent duplicate emission.
- `TC-04`: `mvn -q -DskipTests compile` passed on `2026-03-21`.
- `TC-05` to `TC-09`: `mvn -q "-Dtest=Btcc0080acProcessValidationTest" test` passed on `2026-03-21`, covering the multi-field valid-negative branch, field-specific negative validation for `dishTonyuSyoyoryo`, `dishTonyuZyuryo`, and `potionSu`, duplicate-format suppression for both `hKoseiLineSeqNo` and `dishTonyuSyoyoryo`, and the record-count interaction when shared required validation already flagged the same record.
- `TC-10`: `mvn -q "-Dtest=Btcc0080acWebServiceJsonIntegrationTest" test` passed on `2026-03-21`, confirming field-specific non-negative errors, duplicate suppression for shared-format plus custom validation, and single-record counting through the external JSON webservice route.

## Verdict

- Result: `pass`
- Severity-rated findings: none

## Confidence And Residual Risk

- Confidence: `high`
- Basis: the reviewed non-negative path and dedup guard align with the governing package, compile succeeds, and automated process-validation tests cover the targeted branches.
- Residual risk: manual runtime payloads for the other negative-value fields in `TC-02` were not executed in the workspace.
