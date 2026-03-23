---
id: "2026-03-13-sdd-governance-hardening"
title: "SDD governance hardening for source-base anchors and style parity tasks"
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
  - "docs/sdd/"
  - "docs/specs/"
  - "scripts/sdd/"
test_refs:
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Update standards and governance rules for source-base anchors, style parity, scope parity, and contract parity. | `REQ-01` | `DES-01`, `DES-02` | `TC-01`, `TC-02` |
| `TASK-02` | Update stage checklists so design, pre-implementation, and review gates fail when anchor or parity information is missing. | `REQ-01`, `REQ-03` | `DES-01`, `DES-02` | `TC-01`, `TC-02` |
| `TASK-03` | Update templates and `docs/specs/README.md` so `02-design.md` carries a parseable anchor block with fixed labels. | `REQ-02` | `DES-01`, `DES-03` | `TC-01`, `TC-02` |
| `TASK-04` | Update `build_spec_pack.sh` and `validate_specs.sh` to surface and enforce anchors, scope guardrails, traceability, and conditional manifest checks. | `REQ-03` | `DES-02`, `DES-03`, `DES-04` | `TC-01`, `TC-02`, `TC-03` |
| `TASK-05` | Retrofit sample spec artifacts and regenerate the example spec-pack used for verification. | `REQ-04` | `DES-05` | `TC-03` |

## Sequencing

1. `TASK-01`
2. `TASK-02`
3. `TASK-03`
4. `TASK-04`
5. `TASK-05`

## Blockers

- None.
