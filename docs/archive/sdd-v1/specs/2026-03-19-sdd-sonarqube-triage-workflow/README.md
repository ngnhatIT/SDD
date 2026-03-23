---
id: "2026-03-19-sdd-sonarqube-triage-workflow"
title: "SDD SonarQube triage and approved remediation workflow"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "05-behavior.md"
  - "06-edge-cases.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
  - "11-implementation-report.md"
dependencies:
  - "AGENTS.md"
  - "docs/sdd/README.md"
  - "docs/specs/README.md"
implementation_refs:
  - "docs/sdd/"
  - "docs/sonar/"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
---

# Feature Summary

Add a governed two-phase SonarQube issue triage and remediation capability to the SDD framework so scanner findings are validated against the current codebase, only clearly safe findings are auto-remediated, and all non-fixed findings are tracked in a canonical markdown artifact under `docs/sonar/`.

# Request Source

- User request dated `2026-03-19`

# Classification

- Governed path: `full-path`
- Task profile: `implement-new`

# Scope

## In Scope

- add SonarQube-specific governance rules that block blind remediation from scanner output
- add canonical routing, task-header support, and execution contracts for phase A and phase B Sonar work
- add a canonical `docs/sonar/<date>-<scope>-triage.md` artifact definition and template
- update review, implementation, checklist, completion, and report expectations so Sonar-driven work is traceable
- update spec-authoring guidance so an approved Sonar triage artifact can drive later governed remediation
- add explicit Codex operating guidance for Sonar triage and approved remediation

## Out Of Scope

- runtime business-feature code changes
- SonarQube server integration, API automation, or export tooling
- replacing the governing role of `docs/specs/` for non-trivial remediation work
- changing product API, DTO, schema, or user-visible runtime behavior

# Raw Input Normalization

## Facts

- The requested framework change must support a two-phase SonarQube workflow: `sonar-triage-and-fix` and `sonar-fix-from-triage`.
- SonarQube findings must be validated against the current codebase before any fix decision.
- The workflow must classify each finding, fix only findings that are still valid and safe, and record all non-fixed findings in a markdown artifact.
- The classification model must use exactly: `confirmed-fixable`, `confirmed-but-risky`, `not-reproducible`, `likely-false-positive`, `needs-human-decision`, and `deferred`.
- The recommended decision-status model is separate from classification and should use: `approved-fix`, `approved-later`, `false-positive`, `stale`, `needs-business-confirmation`, `needs-technical-confirmation`, `risky-no-auto-fix`, and `done`.
- The framework must update governance, routing, artifacts, templates, review checklists, completion rules, reporting expectations, and Codex execution guidance.

## Open Questions

- None at authoring time.

## Non-Changes

- Do not introduce product runtime behavior changes.
- Do not treat SonarQube scanner output as a replacement for feature-package approval.
- Do not add database, API, or file-format changes to the application itself.

## Approval Gaps

- Later remediation sourced from a triage artifact still needs the normal governance classification and a governing feature package whenever the resulting code change is non-trivial or behavior-sensitive.

# Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Docs-only framework change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No product API or DTO change |
| `05-behavior.md` | Operator workflow behavior | `conditional` | `complete` | Sonar workflow behavior changes |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `complete` | Triage ambiguity and stale-findings handling |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No machine-readable product contract owned |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `n/a` | Not needed for this docs-only framework change |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | |
| `12-review-report.md` | Review outcome | `when review starts` | `not started` | |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

# Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01`, `DES-03` | `TASK-01`, `TASK-02` | `AC-02`, `AC-03` | `TC-02`, `TC-03` | `docs/sdd/governance/11-static-analysis-triage-policy.md`, `docs/sonar/README.md`, `docs/sdd/templates/sonar-triage-report.md` |
| `REQ-02` | `DES-02` | `TASK-01` | `AC-01` | `TC-01` | `AGENTS.md`, `docs/sdd/execution/task-routing.md`, `docs/sdd/execution/task-input-header.md`, `docs/sdd/execution/contracts/sonar-triage.md`, `docs/sdd/execution/contracts/sonar-fix-from-triage.md` |
| `REQ-03` | `DES-03`, `DES-04` | `TASK-02`, `TASK-03` | `AC-03`, `AC-04` | `TC-03`, `TC-04` | `docs/sdd/checklists/06-code-review-against-spec.md`, `docs/sdd/governance/definition-of-done.md`, `docs/sdd/templates/feature-package/11-implementation-report.md`, `docs/sdd/templates/feature-package/12-review-report.md` |
| `REQ-04` | `DES-04`, `DES-05` | `TASK-03`, `TASK-04` | `AC-04`, `AC-05` | `TC-04`, `TC-05` | `docs/sdd/spec-authoring/README.md`, `docs/sdd/spec-authoring/raw-input-normalization.md`, `docs/specs/README.md`, `docs/sdd/execution-profiles/codex.md` |
| `REQ-05` | `DES-02`, `DES-05` | `TASK-04` | `AC-05` | `TC-05` | `docs/sdd/execution/contracts/create-spec.md`, `docs/sdd/spec-authoring/README.md`, `docs/sdd/spec-authoring/raw-input-normalization.md`, `docs/specs/README.md`, `docs/sdd/execution-profiles/codex.md` |
