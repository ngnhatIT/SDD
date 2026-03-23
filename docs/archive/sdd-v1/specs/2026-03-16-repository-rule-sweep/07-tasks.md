---
id: "2026-03-16-repository-rule-sweep"
title: "Repository-wide rule sweep tasks"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Update `AGENTS.md` with cross-layer parity, sibling-flow parity, explicit contract-gap, constant-catalog, and manual-regression obligations. | `REQ-01`, `REQ-06` | `DES-01` | `TC-01` |
| `TASK-02` | Update backend standards to require sibling-flow parity checks when shared tables are touched across process families. | `REQ-02` | `DES-02` | `TC-02` |
| `TASK-03` | Update frontend standards to prevent new silent transport catches and to require parity management for frontend or backend duplicated validation. | `REQ-03` | `DES-03` | `TC-03` |
| `TASK-04` | Update validation guidance so duplicated frontend and backend validation rules are reviewed together with backend remaining authoritative. | `REQ-04` | `DES-04` | `TC-04` |
| `TASK-05` | Update code-review guidance with explicit checks for sibling-flow parity, silent catches, validation parity, and contract-gap recording. | `REQ-05` | `DES-05` | `TC-05` |
| `TASK-06` | Update QA and review rules to require manual regression evidence when automated tests are absent in the touched area. | `REQ-06` | `DES-06` | `TC-06` |

## Sequencing

1. `TASK-01`
2. `TASK-02`
3. `TASK-03`
4. `TASK-04`
5. `TASK-05`
6. `TASK-06`
