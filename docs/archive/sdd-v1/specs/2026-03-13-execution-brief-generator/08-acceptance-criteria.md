---
id: "2026-03-13-execution-brief-generator"
title: "Execution-brief generator for task-specific SDD loading acceptance criteria"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "scripts/sdd/build_execution_brief.sh"
  - "docs/spec-packs/2026-03-11-example-customer-export.implement-new.brief.md"
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01`, `REQ-02` | Running the generator for an existing governed feature produces a deterministic execution brief with stable section ordering and task-profile-specific routing context. | Generated brief exists and contains the expected top-level sections |
| `AC-02` | `REQ-02`, `REQ-03` | The brief includes task profile, governance classification, governing files, mandatory reads, optional consults, locked decisions, prohibited scope, touched layers, required validations, expected outputs, and explicit unknown markers when source data is missing. | Generated brief content matches the required fields and uses `unknown (...)` instead of guessed content |
| `AC-03` | `REQ-03` | The repository documents that the brief is a generated execution aid only and does not replace the governing feature package. | Updated command docs and sample brief both state the non-authoritative role clearly |
| `AC-04` | `REQ-04` | The repository contains runnable command documentation plus one generated sample brief for review. | `AGENTS.md` and `scripts/sdd/README.md` show the command, and the example brief is present under `docs/spec-packs/` |
