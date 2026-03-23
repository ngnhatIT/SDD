---
id: "2026-03-19-sdd-sonarqube-triage-workflow"
title: "SDD SonarQube triage workflow tasks"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-19"
related_specs:
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Tasks

| ID | Task | Traceability |
| --- | --- | --- |
| `TASK-01` | Add the SonarQube-specific policy, task profiles, task-header fields, routing, and execution contracts for triage and approved remediation. | `REQ-01`, `REQ-02`, `DES-01`, `DES-02` |
| `TASK-02` | Add the canonical `docs/sonar/` artifact definition and SonarQube triage template with the required classification, decision, and reporting structure. | `REQ-01`, `REQ-03`, `DES-03` |
| `TASK-03` | Update implementation, review, checklist, documentation-update, and completion surfaces so Sonar-driven work must record non-fixed findings and cannot claim completion after blind fixes. | `REQ-03`, `REQ-04`, `DES-01`, `DES-04` |
| `TASK-04` | Update spec-authoring and Codex guidance so an approved triage artifact can drive later remediation without bypassing normal governance for non-trivial fixes. | `REQ-05`, `DES-04`, `DES-05` |
