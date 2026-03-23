---
id: "2026-03-23-sdd-route1-operational-alignment"
title: "SDD Route 1 operational alignment acceptance criteria"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-23"
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
| `AC-01` | `REQ-01` | `The framework explicitly defines where stable fixed context lives and where variable task context lives, using existing context, governance, header, and execution-brief artifacts rather than any new top-level control files.` | Updated context, governance, task-input-header, and execution-brief docs |
| `AC-02` | `REQ-02` | `Minimal reading and permission-based exploration are explicit: broader exploration requires a short why/scope/expected-result note, and narrow reading is stated as the default.` | Updated minimal-sufficient-context policy and AI checklist |
| `AC-03` | `REQ-03` | `Codex and Copilot profiles explicitly require three likely hypotheses first for investigation or debugging, verification of the shortest path first, and minimal additional reads tied to hypothesis confirmation or rejection.` | Updated profile docs |
| `AC-04` | `REQ-04` | `Recovery, handoff, and report artifacts explicitly require short restart packets and root-cause excerpts instead of full log pastes by default.` | Updated recover-context contract, AI-ops docs, and report templates |
| `AC-05` | `REQ-05` | `The prompt, checklist, and review-support layers give short immediately usable support for requirement clarification, design review, traceability review, and document refactoring without becoming a second workflow manual.` | Updated prompt docs and review checklists |
| `AC-06` | `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`, `REQ-05` | `The overall framework diff stays inside the existing SDD structure, avoids duplicated authority, and records implementation plus review evidence for the docs-only change.` | Feature package evidence and final self-review |
