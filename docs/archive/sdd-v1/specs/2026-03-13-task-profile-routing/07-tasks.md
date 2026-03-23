---
id: "2026-03-13-task-profile-routing"
title: "Task-profile routing for agent markdown loading tasks"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/context/"
  - "docs/sdd/governance/"
  - "docs/sdd/templates/"
  - "docs/specs/README.md"
test_refs:
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Add canonical task-profile routing docs, including the prompt header contract and load matrix. | `REQ-01`, `REQ-02` | `DES-01`, `DES-02` | `TC-01`, `TC-02`, `TC-03` |
| `TASK-02` | Update AGENTS and AI loading order so task-profile selection is part of the agent-loading contract. | `REQ-01`, `REQ-02`, `REQ-03` | `DES-01`, `DES-02`, `DES-03` | `TC-01`, `TC-02` |
| `TASK-03` | Update governance and spec guidance so task profiles do not bypass canonical feature-package rules and spec-pack remains optional except where the profile requires it. | `REQ-03`, `REQ-04` | `DES-03`, `DES-04`, `DES-05` | `TC-01`, `TC-02` |
| `TASK-04` | Add canonical task-profile request examples and document helper-only handling for `spec_back.md`. | `REQ-02`, `REQ-04` | `DES-02`, `DES-05` | `TC-02`, `TC-03` |

## Sequencing

1. `TASK-01`
2. `TASK-02`
3. `TASK-03`
4. `TASK-04`

## Blockers

- None.
