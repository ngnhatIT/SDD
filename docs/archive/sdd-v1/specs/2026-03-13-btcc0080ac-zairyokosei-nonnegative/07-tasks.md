---
id: "2026-03-13-btcc0080ac-zairyokosei-nonnegative"
title: "BTCC0080AC zairyo kosei non-negative validation tasks"
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
| `TASK-01` | Add non-negative validation for `mZairyoKoseiSs` fields in `Btcc0080acProcess` upsert path. | `REQ-01` | `DES-01` | `TC-01`, `TC-02` |
| `TASK-02` | Add duplicate-error guard for new non-negative validation errors. | `REQ-02` | `DES-02` | `TC-03` |
| `TASK-03` | Verify no API/DTO/SQL behavior changes outside validation scope. | `REQ-03` | `DES-03` | `TC-04` |
