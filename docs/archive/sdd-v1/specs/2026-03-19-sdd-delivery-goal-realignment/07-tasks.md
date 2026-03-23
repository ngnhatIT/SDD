---
id: "2026-03-19-sdd-delivery-goal-realignment"
title: "SDD delivery-goal realignment tasks"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-19"
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
| `TASK-01` | Add a canonical goal-and-success-metrics document that defines the new goal statement, measurable success criteria, operating principles, quality-proof expectation, and feedback loop. | `REQ-01`, `REQ-02`, `REQ-04`, `REQ-05` | `DES-01` | `TC-01` |
| `TASK-02` | Align top-level README and governance wording with the new delivery-outcome framing and record the cross-cutting delivery-rule decision in a new ADR. | `REQ-01`, `REQ-02`, `REQ-06` | `DES-02`, `DES-06` | `TC-02` |
| `TASK-03` | Update routing and finding-driven-fix guidance so lightweight work stays lightweight, higher-risk work remains controlled, and hotfixes carry explicit backfill expectations when normal evidence is deferred. | `REQ-03`, `REQ-05`, `REQ-06` | `DES-03` | `TC-03` |
| `TASK-04` | Upgrade testing and completion rules so every change names a risk-based quality-proof strategy and points to the strongest practical verification assets. | `REQ-04` | `DES-04` | `TC-04` |
| `TASK-05` | Make the feedback loop explicit across documentation-update and framework-health guidance so review, QA, SonarQube, bug, and production findings feed back into spec, fix, and test artifacts. | `REQ-02`, `REQ-05`, `REQ-06` | `DES-05` | `TC-05` |
| `TASK-06` | Run the repository validators when shell support exists or mirror their checks manually when it does not, then record implementation and review evidence for the docs-only framework change. | `REQ-06` | `DES-06` | `TC-06` |

## Sequencing

1. `TASK-01`
2. `TASK-02`
3. `TASK-03`
4. `TASK-04`
5. `TASK-05`
6. `TASK-06`
