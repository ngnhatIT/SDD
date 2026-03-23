---
id: "2026-03-13-btcc0080ac-zairyokosei-nonnegative"
title: "BTCC0080AC zairyo kosei non-negative validation test cases"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-21"
related_specs:
  - "08-acceptance-criteria.md"
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Integration | Send `upsert.mZairyoKoseiSs` with negative `hKoseiLineSeqNo`. | The response returns an error for `hKoseiLineSeqNo`. |
| `TC-02` | `AC-01` | Integration | Send `upsert.mZairyoKoseiSs` with negative `dishTonyuSyoyoryo`, `dishTonyuZyuryo`, `potionSu`, or `modifyCount`. | The response returns an error for each targeted negative field. |
| `TC-03` | `AC-02` | Integration | Use a target field value that is both negative and format-invalid. | The response returns only one error for the same `errIndex + itemNm`. |
| `TC-04` | `AC-03` | Regression | Build the backend and inspect the touched module diff. | Build passes and contract/SQL flow do not change. |
| `TC-05` | `AC-01` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_reportsMultipleNegativeZairyoFieldsAndCountsRecordOnce`. | Negative numeric fields in one `mZairyoKoseiSs` record return field errors, and record count increases once for that record. |
| `TC-06` | `AC-02` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_deduplicatesZairyoFieldWhenFormatAlreadyFails`. | `hKoseiLineSeqNo` returns only one error when shared validation already marked the same field as format-invalid. |
| `TC-07` | `AC-01` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_reportsNegativeDishTonyuSyoyoryoWhenFormatIsValid`, `Btcc0080acProcessValidationTest.validateRequestData_reportsNegativeDishTonyuZyuryoWhenFormatIsValid`, and `Btcc0080acProcessValidationTest.validateRequestData_reportsNegativePotionSuWhenFormatIsValid`. | Each targeted negative numeric field returns the expected validation error. |
| `TC-08` | `AC-02` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_deduplicatesDishTonyuSyoyoryoWhenFormatAlreadyFails`. | `dishTonyuSyoyoryo` returns only one error when shared validation already marked the same field as format-invalid. |
| `TC-09` | `AC-02` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_keepsRecordCountSingleWhenSharedRequiredErrorExistsBeforeNegativeError`. | When shared validation already flagged the record, the custom non-negative validator adds the field error without incrementing record count a second time. |
| `TC-10` | `AC-01`, `AC-02` | Webservice JSON integration | POST external JSON to `/api/Bcc0080ac` through `Btcc0080acWebServiceJsonIntegrationTest.search_returnsNonNegativeErrorForExternalJson`, `search_returnsMultipleNegativeErrorsAndCountsExternalJsonRecordOnce`, `search_keepsRecordCountSingleForExternalJsonWithSharedAndCustomErrors`, `search_returnsNegativeDishTonyuSyoyoryoForExternalJson`, `search_returnsNegativeDishTonyuZyuryoForExternalJson`, `search_returnsNegativePotionSuForExternalJson`, `search_deduplicatesDishTonyuSyoyoryoWhenExternalJsonFormatAlreadyFails`, and `search_deduplicatesHKoseiLineSeqNoWhenExternalJsonFormatAlreadyFails`. | The external JSON webservice route returns the same field-specific non-negative errors, deduplicates shared-format and custom validation on the same field, and keeps record count aligned to one failing `mZairyoKoseiSs` record. |
