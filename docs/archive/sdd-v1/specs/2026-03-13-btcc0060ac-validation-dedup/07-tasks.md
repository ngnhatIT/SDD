---
id: "2026-03-13-btcc0060ac-validation-dedup"
title: "BTCC0060AC validation duplicate-error dedup tasks"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Cập nhật `Btcc0060acProcess` để chặn add lỗi số âm khi field đã có lỗi validation trước đó. | `REQ-01`, `REQ-02` | `DES-01` | `TC-01`, `TC-02` |
| `TASK-02` | Rà soát không đổi API/SQL/DTO behavior ngoài phạm vi dedup. | `REQ-03` | `DES-02` | `TC-03` |
| `TASK-03` | Bổ sung test case tài liệu cho scenario duplicate-error dedup. | `REQ-01`, `REQ-02` | `DES-01` | `TC-01`, `TC-02`, `TC-03` |
