---
id: "2026-03-13-btcc0070-0080-validation-review"
title: "BTCC0070AC and BTCC0080AC validation review test cases"
owner: "Kikancen API Team"
status: "done"
last_updated: "2026-03-21"
related_specs:
  - "08-acceptance-criteria.md"
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Static review | Inspect `Btcc0070acProcess` non-negative validation method and helper usage. | `hasFieldError` guard exists before `setErrorResponse` in non-negative path. |
| `TC-02` | `AC-02` | Static review | Inspect `Btcc0080acProcess` date-range validation condition. | Date-range error is raised only when both dates are valid format and `from > to`. |
| `TC-03` | `AC-03` | Regression | Run backend build after the review/fix set. | Build passes and no unexpected compile regression appears. |
| `TC-04` | `AC-01` | Automated process validation | Run `Btcc0070acProcessValidationTest`, including the JSON-structure gate and valid delete payload cases. | `BTCC0070AC` suppresses duplicate format-plus-negative errors, keeps `tJuchuSeisanDtls.seihinCd` optional on valid payloads, raises the JSON-format error for missing required upsert lists, and keeps the valid delete path stable across the covered lists. |
| `TC-05` | `AC-02` | Automated process validation | Run the `BTCC0080AC` date-range cases in `Btcc0080acProcessValidationTest`. | `BTCC0080AC` raises date-range inconsistency only when both dates are valid and `from > to`, including the delete path, and does not add that inconsistency when date format is invalid, a date is missing, or both dates are equal. |
| `TC-06` | `AC-02` | Webservice JSON integration | POST external JSON to `/api/Bcc0080ac` through `Btcc0080acWebServiceJsonIntegrationTest` with valid, equal-date, missing-date, invalid-date-format, and invalid-date-range variants for both upsert and delete. | The endpoint deserializes JSON correctly and returns the same date-range behavior at webservice entry as the process-level validation, including the delete path. |
| `TC-07` | `AC-01` | Webservice JSON integration | POST external JSON to `/api/Bcc0070ac` through `Btcc0070acWebServiceJsonIntegrationTest` with valid, JSON-format, negative, dedup, valid-delete, and unauthorized variants. | The endpoint deserializes JSON correctly and preserves the same `BTCC0070AC` optional-field and non-negative dedup behavior at webservice entry. |
