---
id: "2026-03-19-sdd-sonarqube-triage-workflow"
title: "SDD SonarQube triage workflow edge cases"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-19"
related_specs:
  - "02-design.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Edge Cases

## Edge Case Matrix

| Case | Trigger | Expected System Response | Recovery Or Operator Action |
| --- | --- | --- | --- |
| `Stale line reference` | SonarQube line number or snippet no longer matches current code | do not auto-fix; classify the finding as `not-reproducible` or `likely-false-positive` and record the stale condition | keep the issue in the triage artifact for follow-up if any human confirmation is still needed |
| `Behavior-changing candidate fix` | remediation would alter validation, contract shape, schema semantics, or intended business behavior | stop auto-remediation on that finding and classify it as `confirmed-but-risky` or `needs-human-decision` | escalate through approval and create or update a governing feature package when required |
| `Phase B status not approved` | triage artifact marks the issue as anything other than `approved-fix` for the current pass | do not change code for that issue | leave the issue in `Not fixed in this pass` and keep the recorded decision status |
| `Current code drift after triage` | approved triage artifact exists, but code changed before remediation starts | revalidate the issue against current code before editing | update classification or decision notes if the issue is now stale, risky, or already resolved |

## Failure Routing

- Validation errors: missing Sonar source, missing triage artifact, or missing approval status block the task until the artifact or status is provided.
- Fatal errors: conflict between triage artifact, governing spec, and current code stops the affected fix path and requires escalation instead of guessing.
- Retry, rollback, or cleanup expectations: rerun current-code inspection and update the triage artifact before any resumed remediation pass.

## Residual Risks

- SonarQube exports can become stale quickly after code churn, so the framework must preserve the revalidation step even when an artifact was approved earlier.
