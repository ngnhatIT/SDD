---
id: "2026-03-13-btcc0060ac-validation-dedup"
title: "BTCC0060AC validation duplicate-error dedup acceptance criteria"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01` | Cùng một record và cùng một field chỉ có tối đa một lỗi format/validation trong danh sách lỗi của `BTCC0060AC`. | Response payload kiểm tra số lượng lỗi theo `errIndex + itemNm`. |
| `AC-02` | `REQ-02` | Field âm nhưng chưa có lỗi format trước đó vẫn trả lỗi theo non-negative validation. | Response payload có lỗi cho field âm hợp lệ về format. |
| `AC-03` | `REQ-03` | Không phát sinh thay đổi API contract, DTO shape, hoặc SQL behavior. | So sánh code diff và build pass. |
