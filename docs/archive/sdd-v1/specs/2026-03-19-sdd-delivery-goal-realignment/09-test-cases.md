---
id: "2026-03-19-sdd-delivery-goal-realignment"
title: "SDD delivery-goal realignment test cases"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-19"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs: []
test_refs: []
---

# Test Cases

| ID | Acceptance Link | Test Type | Procedure | Expected Result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Manual review | Inspect `docs/sdd/goal-and-success-metrics.md`. Confirm it contains a concise goal statement, measurable success criteria, operating principles, risk-based execution intent, quality-proof expectation, and explicit feedback-loop steps. | One canonical document states the new framework purpose in practical delivery language. |
| `TC-02` | `AC-02` | Manual review | Inspect `docs/README.md`, `docs/sdd/README.md`, `docs/sdd/governance.md`, and `docs/decisions/ADR-0005-sdd-delivery-outcome-alignment.md`. Confirm the wording is consistent and does not create a second authority layer. | Entry points and governance align around the same delivery-outcome framing. |
| `TC-03` | `AC-03` | Manual review | Inspect `docs/sdd/execution/task-routing.md`, `docs/sdd/execution/contracts/fix-from-review.md`, and `docs/sdd/governance/definition-of-done.md`. Confirm lightweight, higher-risk, and hotfix paths now reflect risk-proportional rigor and backfill expectations. | Routing and completion guidance are explicit and proportionate. |
| `TC-04` | `AC-04` | Manual review | Inspect `docs/sdd/standards/testing-and-quality-signals.md` and `docs/sdd/governance/definition-of-done.md`. Confirm they require a named quality-proof strategy and define acceptable verification asset mixes by risk. | Testing expectations are proof-oriented rather than code-only. |
| `TC-05` | `AC-05` | Manual review | Inspect `docs/sdd/goal-and-success-metrics.md`, `docs/sdd/governance/09-documentation-update-policy.md`, `docs/sdd/execution/contracts/fix-from-review.md`, and `docs/sdd/ai-ops/framework-health-metrics.md`. Confirm the feedback loop is explicit and traceable to source-of-truth updates and verification. | The framework describes a concrete learning loop from findings to artifacts and proof. |
| `TC-06` | `AC-06` | Script or manual review | Run `scripts/sdd/validate_framework_docs.sh` and `scripts/sdd/validate_specs.sh` when the current shell can execute them. Otherwise mirror their relevant checks manually against the changed framework docs and the new spec package, then inspect the changed docs for broken cross-links or duplicated authority. | The changed framework docs and new spec package validate successfully or satisfy the same rule set through equivalent manual checks, with environment limits recorded explicitly. |
