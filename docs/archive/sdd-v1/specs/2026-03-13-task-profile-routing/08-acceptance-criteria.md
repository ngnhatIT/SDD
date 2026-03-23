---
id: "2026-03-13-task-profile-routing"
title: "Task-profile routing for agent markdown loading acceptance criteria"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/context/task-profiles.md"
  - "docs/sdd/templates/task-profile-examples.md"
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01`, `REQ-02` | The repository defines canonical task profiles, a fixed prompt header contract, and deterministic selection precedence for agent work. | Updated loading docs describe the profiles, header fields, and precedence clearly |
| `AC-02` | `REQ-03` | Governance and review guidance state that task profiles do not bypass governing feature-package rules and that spec-pack remains an execution aid only. | Updated governance docs explicitly describe those boundaries |
| `AC-03` | `REQ-02`, `REQ-04` | The repository contains canonical examples for the five task profiles, and `spec_back.md` is documented as helper-only with an alias mapping to backend-facing canonical artifacts. | Example doc and routing doc both describe the helper policy and per-profile load set |
| `AC-04` | `REQ-04` | The new task-profile feature package itself is structurally valid and passes spec validation without requiring a spec-pack manifest. | `validate_specs.sh` passes for the new feature package |
