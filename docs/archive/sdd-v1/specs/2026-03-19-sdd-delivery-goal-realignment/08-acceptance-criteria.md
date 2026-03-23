---
id: "2026-03-19-sdd-delivery-goal-realignment"
title: "SDD delivery-goal realignment acceptance criteria"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-19"
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
| `AC-01` | `REQ-01`, `REQ-02` | `A canonical SDD goal document exists and clearly states faster and safer delivery, traceable approved change, measurable success criteria, reduced rework and regression, and feedback-driven improvement.` | New canonical goal doc |
| `AC-02` | `REQ-01`, `REQ-02`, `REQ-06` | `README, governance, and ADR surfaces consistently frame SDD as a delivery system with governance controls rather than governance for its own sake, without creating a second authority layer.` | Updated entrypoints plus new ADR |
| `AC-03` | `REQ-03`, `REQ-06` | `Routing and finding-driven-fix docs clearly state that small bounded work should use the lightest safe path, riskier work needs stronger governed evidence, and hotfixes require backfill when normal proof or docs are deferred.` | Updated routing, contract, and DoD wording |
| `AC-04` | `REQ-04` | `Testing and completion standards require a named quality-proof strategy and describe the strongest practical verification mix for low-risk, reduced-path, full-path, and hotfix work.` | Updated testing standard and Definition of Done |
| `AC-05` | `REQ-05`, `REQ-06` | `The framework explicitly states how review comments, QA findings, SonarQube findings, bug reports, and production incidents flow through triage, source-of-truth updates, implementation, verification, and residual-risk recording.` | Updated goal doc, documentation-update policy, fix-from-review contract, and framework metrics |
| `AC-06` | `REQ-06` | `The updated docs pass manual consistency review and either the repository validator scripts or equivalent rule-matched manual checks when the current shell environment cannot run the validator scripts.` | Implementation report validation records |
