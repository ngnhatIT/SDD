---
id: "2026-03-13-execution-brief-generator"
title: "Execution-brief generator for task-specific SDD loading tasks"
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
  - "scripts/sdd/"
  - "docs/spec-packs/"
test_refs:
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Add `scripts/sdd/build_execution_brief.sh` so one governed feature and explicit task profile can generate a deterministic execution brief. | `REQ-01`, `REQ-02`, `REQ-03` | `DES-01`, `DES-02`, `DES-03`, `DES-04` | `TC-01`, `TC-02` |
| `TASK-02` | Generate a sample brief for the example customer export feature and keep the output under `docs/spec-packs/`. | `REQ-02`, `REQ-04` | `DES-01`, `DES-03`, `DES-05` | `TC-01`, `TC-02` |
| `TASK-03` | Update command documentation so the generator is discoverable without changing canonical governance ownership. | `REQ-03`, `REQ-04` | `DES-01`, `DES-05` | `TC-02` |
| `TASK-04` | Record implementation evidence and verification results for the new generator and the governing feature package. | `REQ-04` | `DES-05` | `TC-03` |

## Sequencing

1. `TASK-01`
2. `TASK-02`
3. `TASK-03`
4. `TASK-04`

## Blockers

- None.
