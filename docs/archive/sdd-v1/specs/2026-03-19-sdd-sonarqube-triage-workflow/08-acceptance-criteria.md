---
id: "2026-03-19-sdd-sonarqube-triage-workflow"
title: "SDD SonarQube triage workflow acceptance criteria"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-19"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Acceptance Criterion | Traceability |
| --- | --- | --- |
| `AC-01` | The canonical routing surfaces list `sonar-triage`, `sonar-triage-and-fix`, and `sonar-fix-from-triage`, define their required inputs, and route them to dedicated execution contracts. | `TASK-01` |
| `AC-02` | The governance layer states that SonarQube findings are advisory, must be validated against current code, cannot be fixed blindly, and must use the exact required classification values with decision status kept separate. | `TASK-01`, `TASK-02` |
| `AC-03` | The repository contains a canonical `docs/sonar/` artifact definition and a SonarQube triage template with the required summary sections, per-issue fields, fixed/non-fixed sections, user decision items, and next actions. | `TASK-02` |
| `AC-04` | The implementation, review, checklist, documentation-update, and definition-of-done surfaces require current-code validation, behavior-safety checks, recording of stale/false-positive/risky findings, and traceable use of approved follow-up items. | `TASK-03` |
| `AC-05` | Spec-authoring guidance and Codex execution guidance allow an approved Sonar triage artifact to serve as later remediation input while preserving feature-package governance for non-trivial remediation work. | `TASK-04` |
