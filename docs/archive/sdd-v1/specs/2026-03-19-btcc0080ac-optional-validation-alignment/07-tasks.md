---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment tasks"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-21"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Add the reduced-path governing package for the reported `BTCC0080AC` optional-field validation bug. | `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04` | `DES-01`, `DES-02`, `DES-03`, `DES-04` | `TC-01` |
| `TASK-02` | Calibrate `StaticApiCheckConfig` for `BTCC0080AC` so nullable optional fields no longer use shared required validation. | `REQ-01`, `REQ-02` | `DES-01`, `DES-02` | `TC-01`, `TC-02` |
| `TASK-03` | Apply the narrow per-list required-rule override needed to preserve list-specific key validation where the shared alias map cannot express it safely. | `REQ-03`, `REQ-04` | `DES-03`, `DES-04` | `TC-01`, `TC-03`, `TC-05`, `TC-06` |
| `TASK-04` | Verify that existing custom validators and transport shape stay unchanged. | `REQ-04` | `DES-04` | `TC-03`, `TC-04` |
