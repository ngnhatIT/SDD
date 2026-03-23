---
id: "2026-03-17-sdd4-operating-model-optimization"
title: "SDD4 operating-model optimization acceptance criteria"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Link | Acceptance Criterion | Evidence |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01` | `AGENTS.md` is visibly lighter, preserves the root contract, and points operators to canonical governance, task routing, standards, templates, and escalation docs instead of duplicating them.` | Updated `AGENTS.md` with concise root-contract sections and canonical references |
| `AC-02` | `REQ-02` | `A practical task-mode matrix exists under docs/sdd/context and a short daily operator guide exists under docs/sdd/prompts; both are discoverable from the main canonical navigation and align with existing task-profile routing.` | New canonical files plus updated entrypoint links |
| `AC-03` | `REQ-03` | `Implementation and review report templates now require stronger evidence, assumptions, conflicts, traceability, contract drift, and verdict structure.` | Updated template files and alias guidance |
| `AC-04` | `REQ-04` | `Active canonical docs no longer imply a live competing bridge authority surface and instead clearly frame bridge references as bridge-only, historical, or absent where applicable.` | Updated active canonical docs referencing legacy bridge material |
