---
id: "2026-03-19-sdd-sonarqube-triage-workflow"
title: "SDD SonarQube triage workflow requirements"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-19"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "README.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | The SDD governance layer must treat SonarQube findings as advisory inputs, require validation against the current codebase before remediation, forbid blind fixes from scanner output alone, use the exact required classification model, and require English-only comments in any related remediation. |
| `REQ-02` | The SDD execution layer must support `sonar-triage`, `sonar-triage-and-fix`, and `sonar-fix-from-triage` as canonical task profiles with deterministic routing, input expectations, and execution contracts for the two-phase workflow. |
| `REQ-03` | The SDD artifact and reporting layer must define a canonical `docs/sonar/<date>-<scope>-triage.md` markdown artifact with the required sections, issue fields, fixed/non-fixed tracking, user decision tracking, and remediation-update expectations. |
| `REQ-04` | The SDD checklist, review, implementation-report, and definition-of-done layers must verify that each Sonar-driven fix was validated against current code, did not change intended behavior without approval, and left all non-fixed findings classified and traceable. |
| `REQ-05` | The SDD spec-authoring and agent-guidance layers must allow an approved Sonar triage artifact to act as the input source for later approved remediation while preserving the governing role of `docs/specs/` for any non-trivial remediation work. |
