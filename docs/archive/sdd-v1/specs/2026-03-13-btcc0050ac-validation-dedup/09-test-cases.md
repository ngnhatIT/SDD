---
id: "2026-03-13-btcc0050ac-validation-dedup"
title: "BTCC0050AC validation duplicate-error dedup test cases"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-21"
related_specs:
  - "08-acceptance-criteria.md"
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Integration | Gửi request `BTCC0050AC` với `modifyCount` vừa sai format (ví dụ vượt độ dài) vừa là số âm. | Chỉ có 1 lỗi cho `modifyCount` trong cùng record. |
| `TC-02` | `AC-02` | Integration | Gửi request có `modifyCount` âm nhưng format hợp lệ. | Có lỗi non-negative cho `modifyCount`. |
| `TC-03` | `AC-03` | Regression | Build backend và rà diff module. | Build pass, không phát sinh thay đổi DTO/API/SQL behavior. |
| `TC-04` | `AC-01` | Automated process validation | Run `Btcc0050acProcessValidationTest.validateRequestData_deduplicatesModifyCountWhenFormatAlreadyFails`. | `modifyCount` chỉ có một lỗi khi shared validation đã đánh dấu lỗi format trước đó. |
| `TC-05` | `AC-02` | Automated process validation | Run `Btcc0050acProcessValidationTest.validateRequestData_reportsNegativeModifyCountWhenFormatIsValid`. | `modifyCount` trả lỗi non-negative khi giá trị âm nhưng format hợp lệ. |
| `TC-06` | `AC-03` | Automated process validation | Run the JSON-structure and valid-delete cases in `Btcc0050acProcessValidationTest`. | Missing required `upsert.mSectionZaikos` returns the JSON-format error, and a valid delete payload remains stable. |
| `TC-07` | `AC-01`, `AC-02`, `AC-03` | Webservice JSON integration | POST external JSON to `/api/Bcc0050ac` through `Btcc0050acWebServiceJsonIntegrationTest` with valid, JSON-format, dedup, negative, valid-delete, and unauthorized variants. | The external JSON route preserves the same `BTCC0050AC` validation behavior as the process-level flow. |
