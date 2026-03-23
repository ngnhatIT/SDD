---
id: "2026-03-19-sdd-delivery-goal-realignment"
title: "SDD delivery-goal realignment for real-project execution"
owner: "Codex"
status: "done"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
dependencies:
  - "AGENTS.md"
  - "docs/README.md"
  - "docs/sdd/README.md"
  - "docs/sdd/governance.md"
  - "docs/sdd/standards/testing-and-quality-signals.md"
  - "docs/specs/2026-03-17-sdd4-mode-driven-efficiency/01-requirements.md"
  - "docs/specs/2026-03-17-sdd4-operating-model-optimization/01-requirements.md"
  - "docs/decisions/ADR-0001-spec-driven-delivery-framework.md"
  - "docs/decisions/ADR-0004-sdd2-plus-agent-ready-extension.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
  - "12-review-report.md"
---

# Feature Spec Package

## Summary

- Feature: `realign the SDD goal, objectives, principles, and feedback expectations so the framework is explicitly optimized for fast, safe, measurable delivery`
- Ticket or request: `repository request to upgrade the GOAL / OBJECTIVE / PRINCIPLES layer for practical project delivery`
- Owner: `Codex`
- Status: `done`
- Target release: `immediate repository documentation update`

## Problem

- Current pain: `the framework is strong on governance, traceability, anti-hallucination, and stop rules, but the top-level goal is still framed more as document control than as fast, safe, evidence-backed delivery with risk-proportional ceremony and production feedback learning`
- Desired outcome: `teams should be able to read one canonical goal statement and understand that SDD exists to reduce lead time, reduce rework, reduce regression, require the right proof for the risk, and feed review or QA or Sonar or runtime findings back into specs, tests, and follow-up work`

## Scope

### In Scope

- create one canonical SDD goal and success-metrics document
- align canonical README, governance, routing, and testing docs with the new delivery-outcome framing
- make lightweight versus heavier-risk execution intent explicit without weakening existing governance
- make quality-proof strategy and feedback-loop expectations explicit in the canonical framework docs
- add a cross-cutting ADR because this changes delivery rules at framework level

### Out Of Scope

- runtime backend, frontend, SQL, schema, API, or build behavior changes
- new execution modes or new task-profile header tokens
- a mandatory analytics dashboard, per-task metrics ledger, or new approval layer
- replacing the existing source-of-truth hierarchy, anti-hallucination rules, or stop rules

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Docs-only framework change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No product API or DTO change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime workflow change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Covered in design, routing, and governance wording for docs-only scope |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No owned runtime interface change |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `n/a` | Not required for this docs-only framework work |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | |
| `12-review-report.md` | Review outcome | `when review starts` | `complete` | |
| `13-risk-log.md` | Active risks and mitigations | `conditional` | `n/a` | Existing governance, rollout, and review artifacts are sufficient for this docs-only change |
| `14-decision-notes.md` | Local design decisions | `conditional` | `n/a` | Cross-cutting decisions are captured in a new ADR |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `docs/sdd/goal-and-success-metrics.md` |
| `REQ-02` | `DES-02` | `TASK-02` | `AC-02` | `TC-02` | `docs/sdd/governance.md`, `docs/sdd/README.md`, `docs/README.md`, `docs/decisions/ADR-0005-sdd-delivery-outcome-alignment.md` |
| `REQ-03` | `DES-03` | `TASK-03` | `AC-03` | `TC-03` | `docs/sdd/execution/task-routing.md`, `docs/sdd/execution/contracts/fix-from-review.md`, `docs/sdd/governance/definition-of-done.md` |
| `REQ-04` | `DES-04` | `TASK-04` | `AC-04` | `TC-04` | `docs/sdd/standards/testing-and-quality-signals.md`, `docs/sdd/governance/definition-of-done.md` |
| `REQ-05` | `DES-05` | `TASK-05` | `AC-05` | `TC-05` | `docs/sdd/ai-ops/framework-health-metrics.md`, `docs/sdd/governance/09-documentation-update-policy.md` |
| `REQ-06` | `DES-06` | `TASK-06` | `AC-06` | `TC-06` | `docs/README.md`, `docs/sdd/README.md`, `docs/sdd/ai-ops/README.md`, validator outputs |

## Open Questions

- whether maintainers want numeric threshold targets for lead time, regression, or rework after the new framework wording has enough historical baseline data

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass for reduced-path docs-only framework realignment`

## Exit Gate Result

- Tasks complete or deferred: `complete`
- Acceptance criteria proven: `yes`
- Test results recorded: `yes`
- Implementation and review reports complete: `yes`
- Feature-local changelog updated: `yes`
