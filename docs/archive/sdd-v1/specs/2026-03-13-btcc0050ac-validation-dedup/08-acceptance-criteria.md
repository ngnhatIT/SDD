---
id: "2026-03-13-btcc0050ac-validation-dedup"
title: "BTCC0050AC validation duplicate-error dedup acceptance criteria"
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
| `AC-01` | `REQ-01` | Với cùng `errIndex + modifyCount`, response error list chỉ có một lỗi sau validate. | Payload response cho case format+âm không có duplicate. |
| `AC-02` | `REQ-02` | Khi `modifyCount` âm và không lỗi format trước đó, vẫn trả lỗi non-negative. | Payload response có lỗi non-negative đúng field. |
| `AC-03` | `REQ-03` | Không đổi contract và luồng SQL xử lý import của `BTCC0050AC`. | So sánh code diff + build pass. |
