---
id: "2026-03-13-btcc0050ac-validation-dedup"
title: "BTCC0050AC validation duplicate-error dedup tasks"
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
| `TASK-01` | Update `Btcc0050acProcess` to skip non-negative error insertion when `modifyCount` already has validation error for same `errIndex + itemNm`. | `REQ-01`, `REQ-02` | `DES-01` | `TC-01`, `TC-02` |
| `TASK-02` | Verify no API/DTO/SQL behavioral drift outside validation dedup scope. | `REQ-03` | `DES-02` | `TC-03` |
