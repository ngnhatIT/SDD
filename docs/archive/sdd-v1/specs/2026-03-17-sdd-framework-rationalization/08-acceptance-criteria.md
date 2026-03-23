---
id: "2026-03-17-sdd-framework-rationalization"
title: "SDD framework rationalization acceptance criteria"
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
| `AC-01` | `REQ-01` | The repository contains a file-level framework audit covering every in-scope file and assigning an explicit cleanup decision to each one. | `docs/archive/sdd/history/2026-03-17-rationalization/10-sdd-framework-audit-report.md` |
| `AC-02` | `REQ-02` | The audit output makes canonical authority, policy, process, standards, templates, prompts, and legacy bridge roles obvious and identifies the biggest AI-confusion points in the current framework. | Audit report sections for canonical artifacts, prompt plan, AI checklist, conflicts, and target structure |
| `AC-03` | `REQ-03` | The repository contains a cleanup or migration plan that maps the current structure to a leaner target structure and separates safe immediate changes from follow-up structural moves. | `docs/archive/sdd/history/2026-03-17-rationalization/11-sdd-framework-cleanup-migration-plan.md` |
| `AC-04` | `REQ-03`, `REQ-04` | Safe direct edits clarify authority or legacy status without silently applying risky framework deletions or merges. | Updated framework guide and bridge docs plus explicit human-confirmation notes in the migration plan and implementation report |
