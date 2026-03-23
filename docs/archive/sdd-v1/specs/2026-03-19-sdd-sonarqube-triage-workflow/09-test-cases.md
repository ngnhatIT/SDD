---
id: "2026-03-19-sdd-sonarqube-triage-workflow"
title: "SDD SonarQube triage workflow test cases"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-19"
related_specs:
  - "08-acceptance-criteria.md"
  - "11-implementation-report.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs: []
test_refs:
  - "11-implementation-report.md"
---

# Test Cases

| ID | Test Case | Acceptance |
| --- | --- | --- |
| `TC-01` | Inspect `AGENTS.md`, `docs/sdd/context/ai-loading-order.md`, `docs/sdd/context/task-profiles.md`, `docs/sdd/execution/task-routing.md`, `docs/sdd/execution/task-input-header.md`, `docs/sdd/execution/contracts/sonar-triage.md`, and `docs/sdd/execution/contracts/sonar-fix-from-triage.md` to confirm the new Sonar task profiles and inputs are routable end-to-end. | `AC-01` |
| `TC-02` | Inspect `docs/sdd/governance/11-static-analysis-triage-policy.md` and the touched governance files to confirm the policy requires current-code validation, blocks blind fixes, preserves the exact classification model, and keeps decision status separate. | `AC-02` |
| `TC-03` | Inspect `docs/sonar/README.md` and `docs/sdd/templates/sonar-triage-report.md` to confirm the artifact location, naming rules, required sections, and issue-detail fields match the requested workflow. | `AC-03` |
| `TC-04` | Inspect the touched implementation-report, review-report, checklist, review-rule, documentation-update, and done artifacts to confirm non-fixed findings must be classified and recorded and approved follow-up fixes remain traceable. | `AC-04` |
| `TC-05` | Inspect `docs/sdd/spec-authoring/README.md`, `docs/sdd/spec-authoring/raw-input-normalization.md`, `docs/specs/README.md`, `docs/sdd/execution/contracts/create-spec.md`, and `docs/sdd/execution-profiles/codex.md` to confirm later approved remediation can start from a Sonar triage artifact without bypassing normal governance. | `AC-05` |
