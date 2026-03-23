---
id: "2026-03-19-spmt0021-halfwidth-validation"
title: "SPMT0021 half-width validation tasks"
owner: "Kikancen Screen Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Add the minimum shared `BaseComponent.validateFields(...)` support needed to validate half-width-character input through the existing field-config pipeline. | `REQ-01`, `REQ-02` | `DES-01` | `TC-01`, `TC-02` |
| `TASK-02` | Update `SPMT0021` detail validation so `factoryKanaNm`, `addrKanaLine1`, and `addrKanaLine2` use the half-width-character rule instead of the current kana-restricted rules. | `REQ-01`, `REQ-02` | `DES-02` | `TC-01`, `TC-02` |
| `TASK-03` | Reconfirm that non-targeted frontend validation, HTML structure, and backend register/update processing remain unchanged. | `REQ-03` | `DES-03` | `TC-03` |
