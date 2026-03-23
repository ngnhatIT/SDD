---
id: "2026-03-13-btcc0080ac-zairyokosei-nonnegative"
title: "BTCC0080AC zairyo kosei non-negative validation acceptance criteria"
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
| `AC-01` | `REQ-01` | Payload `upsert.mZairyoKoseiSs` có giá trị âm ở các field mục tiêu phải trả lỗi validation. | Response payload có lỗi đúng `itemNm` và `errIndex`. |
| `AC-02` | `REQ-02` | Không xuất hiện lỗi duplicate cho cùng `errIndex + itemNm` giữa shared validator và non-negative validator. | Response payload chứng minh chỉ một lỗi cho field đó. |
| `AC-03` | `REQ-03` | Không có thay đổi về API contract/DTO shape/SQL flow. | Code diff + build pass. |
