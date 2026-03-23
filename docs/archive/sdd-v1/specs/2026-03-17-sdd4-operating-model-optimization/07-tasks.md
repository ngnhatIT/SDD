---
id: "2026-03-17-sdd4-operating-model-optimization"
title: "SDD4 operating-model optimization tasks"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Audit and refactor `AGENTS.md` so it remains the root operating contract but stops duplicating deep governance and standards detail. | `REQ-01` | `DES-01` | `TC-01` |
| `TASK-02` | Add the canonical task-mode matrix and the short daily operator guide, then wire them into the smallest necessary set of canonical entrypoints. | `REQ-02` | `DES-02` | `TC-02` |
| `TASK-03` | Strengthen implementation and review report templates and keep any overlapping alias templates explicitly non-canonical. | `REQ-03` | `DES-03` | `TC-03` |
| `TASK-04` | Reduce ambiguity around legacy bridge references in active canonical docs without creating a new authority surface or performing risky cleanup. | `REQ-04` | `DES-04` | `TC-04` |

## Sequencing

1. `TASK-01`
2. `TASK-02`
3. `TASK-03`
4. `TASK-04`
