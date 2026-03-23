---
id: "2026-03-13-btcc0080ac-zairyokosei-nonnegative"
title: "BTCC0080AC zairyo kosei non-negative validation requirements"
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
| `REQ-01` | Với list `mZairyoKoseiSs` của `upsert`, các field `hKoseiLineSeqNo`, `dishTonyuSyoyoryo`, `dishTonyuZyuryo`, `potionSu`, `modifyCount` không được nhận giá trị âm. |
| `REQ-02` | Nếu field đã có lỗi từ shared validator cho cùng `errIndex + itemNm`, non-negative validation không được add lỗi trùng. |
| `REQ-03` | Giữ nguyên API contract/DTO/SQL flow hiện tại của `BTCC0080AC`. |
