---
id: "2026-03-13-spec-graph-extractor"
title: "First-pass spec graph extractor for feature packages tasks"
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
  - "docs/specs/"
test_refs:
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Add `scripts/sdd/build_spec_graph.sh` to parse existing feature package markdown and emit deterministic `spec.graph.yaml`. | `REQ-01`, `REQ-02`, `REQ-03` | `DES-01`, `DES-02`, `DES-03`, `DES-04` | `TC-01`, `TC-02` |
| `TASK-02` | Extract explicit metadata, scope, anchors, IDs, contract references, and obvious trace links while recording uncertainty instead of guessing. | `REQ-02`, `REQ-03` | `DES-02`, `DES-03`, `DES-04` | `TC-01`, `TC-03` |
| `TASK-03` | Generate sample graphs for one full-path and one reduced-path feature package. | `REQ-04` | `DES-01`, `DES-05` | `TC-01`, `TC-02`, `TC-04` |
| `TASK-04` | Document command usage, current limitations, and recommended next improvements. | `REQ-04` | `DES-03`, `DES-05` | `TC-03`, `TC-04`, `TC-02` |

## Sequencing

1. `TASK-01`
2. `TASK-02`
3. `TASK-03`
4. `TASK-04`

## Blockers

- None.
