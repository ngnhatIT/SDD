---
id: "2026-03-13-btcc0070-0080-validation-review"
title: "BTCC0070AC and BTCC0080AC validation review report"
owner: "Kikancen API Team"
status: "done"
last_updated: "2026-03-21"
related_specs:
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Review Report

## Scope

Review current `BTCC0070AC` non-negative dedup guard and `BTCC0080AC` date-range validation interaction with shared format validation.

## Findings

- None.

## Verification

- `TC-01`: static inspection confirms `Btcc0070acProcess` uses `hasFieldError(errIndex, fieldName, errors)` before adding custom non-negative errors.
- `TC-02`: static inspection confirms `Btcc0080acProcess` raises the date-range inconsistency only when both values are non-empty, valid `uuuuMMdd`, and `from > to`.
- `TC-03`: `mvn -q -DskipTests compile` passed on `2026-03-21`.
- `TC-04`: `mvn -q "-Dtest=Btcc0070acProcessValidationTest" test` passed on `2026-03-21`, covering missing-upsert-list JSON-format, valid upsert/delete payloads including optional `tJuchuSeisanDtls.seihinCd`, duplicate-format suppression, and valid-negative handling for the reviewed `BTCC0070AC` lists.
- `TC-05`: `mvn -q "-Dtest=Btcc0080acProcessValidationTest" test` passed on `2026-03-21`, covering the `from > to` inconsistency path for both upsert and delete, plus the no-custom-error paths when date format is invalid, a date is missing, or both dates are equal.
- `TC-06`: `mvn -q "-Dtest=Btcc0080acWebServiceJsonIntegrationTest" test` passed on `2026-03-21`, confirming the external JSON route `/api/Bcc0080ac` preserves the same `BTCC0080AC` date-range behavior for upsert and delete, including equal-date, missing-date, invalid-date-format, and `from > to` variants.
- `TC-07`: `mvn -q "-Dtest=Btcc0070acWebServiceJsonIntegrationTest" test` passed on `2026-03-21`, confirming the external JSON route `/api/Bcc0070ac` preserves the same `BTCC0070AC` optional-field and non-negative dedup behavior.

## Verdict

- Result: `pass`
- Severity-rated findings: none

## Confidence And Residual Risk

- Confidence: `high`
- Basis: the reviewed behaviors are directly visible in the current code, compile succeeded, and focused process/webservice validation tests now exercise the main normal and abnormal branches.
- Residual risk: this review still does not use real auth or DB, so external end-to-end API replay remains outside the repository scope.
