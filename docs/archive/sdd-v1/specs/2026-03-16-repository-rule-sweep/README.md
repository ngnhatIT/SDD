---
id: "2026-03-16-repository-rule-sweep"
title: "Repository-wide rule sweep from codebase evidence"
owner: "Codex"
status: "complete"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
dependencies: []
implementation_refs:
  - "11-implementation-report.md"
test_refs:
  - "09-test-cases.md"
---

# Feature Spec Package

## Summary

- Feature: `repository-wide rule sweep from codebase evidence`
- Ticket or request: `Scan the entire codebase and derive additional repository rules grounded in actual implementation patterns, review findings, and architectural boundaries`
- Owner: `Codex`
- Status: `complete`
- Target release: `n/a`

## Problem

- Current pain: repository governance covers core SDD flow, but several high-risk implementation and review checks are still weakly enforced even though the codebase and review reports show recurring drift.
- Desired outcome: add only high-signal rules that are supported by repeated implementation patterns, repeated review findings, or clear architectural boundaries in the current repository.

## Scope

### In Scope

- Scan repository structure, shared backend and frontend foundations, representative API and CSV modules, review reports, and build or test tooling
- Formalize repo-wide rules for sibling-flow SQL parity, frontend or backend validation parity, frontend transport error handling, contract-gap review handling, and manual regression evidence when automated tests are absent
- Update `AGENTS.md`, canonical standards, review checklist, QA checklist, and review guidance

### Out Of Scope

- Product behavior changes in runtime modules
- New architectural abstractions not already present in the repository
- Repo-wide normalization of legacy inconsistencies that are not consistently implemented today
- Mandatory machine-readable contracts or automated tests for every legacy feature

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Governance-only change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No runtime contract change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime behavior change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Covered by review and QA rules |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | |
| `12-review-report.md` | Review outcome | `when review starts` | `not started` | |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `AGENTS.md` |
| `REQ-02` | `DES-02` | `TASK-02` | `AC-02` | `TC-02` | `docs/sdd/standards/backend-change-rules.md` |
| `REQ-03` | `DES-03` | `TASK-03` | `AC-03` | `TC-03` | `docs/sdd/standards/frontend-change-rules.md` |
| `REQ-04` | `DES-04` | `TASK-04` | `AC-04` | `TC-04` | `docs/sdd/standards/security-validation-and-logging.md` |
| `REQ-05` | `DES-05` | `TASK-05` | `AC-05` | `TC-05` | `docs/sdd/checklists/06-code-review-against-spec.md` |
| `REQ-06` | `DES-06` | `TASK-06` | `AC-06` | `TC-06` | `docs/sdd/checklists/07-qa-validation.md`, `docs/sdd/governance/04-review-rules.md` |

## Open Questions

- None.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass`

## Exit Gate Result

- Tasks complete or deferred: `complete`
- Acceptance criteria proven: `yes`
- Test results recorded: `yes`
- Implementation and review reports complete: `implementation only`
- Feature-local changelog updated: `yes`
