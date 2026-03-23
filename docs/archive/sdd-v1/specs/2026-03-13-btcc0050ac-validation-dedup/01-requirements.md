---
id: "2026-03-13-btcc0050ac-validation-dedup"
title: "BTCC0050AC validation duplicate-error dedup requirements"
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
| `REQ-01` | Khi `modifyCount` đã có lỗi format từ shared validator, custom non-negative validation không được add lỗi trùng cho cùng `errIndex + itemNm`. |
| `REQ-02` | Với dữ liệu âm nhưng không lỗi format trước đó, `modifyCount` vẫn phải trả lỗi non-negative như hiện hành. |
| `REQ-03` | Không thay đổi API contract, DTO shape, SQL update/insert/delete flow của `BTCC0050AC`. |
