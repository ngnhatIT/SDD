---
id: "2026-03-13-btcc0060ac-validation-dedup"
title: "BTCC0060AC validation duplicate-error dedup requirements"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-13"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
---

# Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | Khi field số trong payload `BTCC0060AC` đã có lỗi format từ shared validator, non-negative validation không được add thêm lỗi trùng cho cùng `errIndex + itemNm`. |
| `REQ-02` | Non-negative validation vẫn phải hoạt động bình thường cho field chưa có lỗi format và giá trị âm. |
| `REQ-03` | Không thay đổi API contract, DTO shape, SQL flow, hoặc kết quả thành công hiện tại. |
