---
id: "2026-03-17-sdd4-mode-driven-efficiency"
title: "SDD4 mode-driven efficiency tasks"
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
| `TASK-01` | Add the canonical minimal-sufficient-context policy and update loading or routing entrypoints to reference it without duplicating rule detail. | `REQ-01`, `REQ-05` | `DES-01`, `DES-05` | `TC-01` |
| `TASK-02` | Extend the canonical definition-of-done structure so each required mode has explicit grounding, output, evidence, validation, escalation, and not-required rules. | `REQ-02` | `DES-02` | `TC-02` |
| `TASK-03` | Expand lightweight-path guidance for docs-only, audit-only, tiny-fix, review-only, low-risk cleanup, hotfix, and recovery or resume work, and keep the path boundaries consistent with governance. | `REQ-03`, `REQ-05` | `DES-02`, `DES-03`, `DES-05` | `TC-03` |
| `TASK-04` | Add the framework-health-metrics document and wire it into the helper-only AI-ops navigation. | `REQ-04`, `REQ-05` | `DES-04`, `DES-05` | `TC-04` |
| `TASK-05` | Refresh only the minimum README and prompt surfaces needed so operators can find the new policy, DoD, lightweight paths, and metrics quickly. | `REQ-05` | `DES-05` | `TC-05` |

## Sequencing

1. `TASK-01`
2. `TASK-02`
3. `TASK-03`
4. `TASK-04`
5. `TASK-05`
