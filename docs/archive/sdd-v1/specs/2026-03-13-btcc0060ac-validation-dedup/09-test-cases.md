---
id: "2026-03-13-btcc0060ac-validation-dedup"
title: "BTCC0060AC validation duplicate-error dedup test cases"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-21"
related_specs:
  - "08-acceptance-criteria.md"
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Integration | Send a `BTCC0060AC` payload with a numeric field that is both negative and format-invalid. | The response returns only one error for the same `errIndex + itemNm` pair. |
| `TC-02` | `AC-02` | Integration | Send a payload with a negative numeric field that still matches the shared format rule. | The response returns the non-negative validation error for that field. |
| `TC-03` | `AC-03` | Regression | Build the backend and inspect the touched module diff. | Build passes and no DTO/API contract or SQL logic changes appear. |
| `TC-04` | `AC-01` | Automated process validation | Run `Btcc0060acProcessValidationTest.validateRequestData_deduplicatesNegativeValidationWhenFormatAlreadyFails`. | `hatchuSu` returns only one error when shared validation already marked the field as format-invalid. |
| `TC-05` | `AC-02` | Automated process validation | Run `Btcc0060acProcessValidationTest.validateRequestData_reportsMultipleNegativeShokuzaiFieldsAndCountsRecordOnce`. | Negative numeric fields in `tShokuzaiSiyoHokokushos` return field errors and increment record count once for the record. |
| `TC-06` | `AC-01` | Automated process validation | Run `Btcc0060acProcessValidationTest.validateRequestData_deduplicatesMonthlyNegativeValidationWhenFormatAlreadyFails`. | `shiyoSu` returns only one error when shared validation already marked the field as format-invalid. |
| `TC-07` | `AC-02` | Automated process validation | Run `Btcc0060acProcessValidationTest.validateRequestData_reportsMultipleNegativeMonthlyFieldsAndCountsRecordOnce`. | Negative numeric fields in `tMonthlyShiyoyoteiDtls` return field errors and increment record count once for the record. |
| `TC-08` | `AC-03` | Automated process validation | Run the JSON-structure and valid-delete cases in `Btcc0060acProcessValidationTest`. | Missing required upsert lists return the JSON-format error, and a valid delete payload remains stable. |
| `TC-09` | `AC-01`, `AC-02`, `AC-03` | Webservice JSON integration | POST external JSON to `/api/Bcc0060ac` through `Btcc0060acWebServiceJsonIntegrationTest` with valid, JSON-format, shokuzai negative/dedup, monthly negative/dedup, valid-delete, and unauthorized variants. | The external JSON route preserves the same `BTCC0060AC` validation behavior as the process-level flow. |
