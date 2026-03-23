---
id: "2026-03-13-task-profile-routing"
title: "Task-profile routing for agent markdown loading"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
  - "11-implementation-report.md"
dependencies:
  - "docs/sdd/context/ai-loading-order.md"
  - "docs/sdd/governance.md"
  - "docs/decisions/ADR-0003-task-profile-routing.md"
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/context/"
  - "docs/sdd/governance/"
  - "docs/sdd/templates/"
  - "docs/specs/README.md"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
---

# Feature Spec Package

## Summary

- Feature: add canonical task-profile routing so agents load the correct markdown set for implementation, fixing, and review work
- Ticket or request: `repository task-profile routing`
- Owner: `Codex`
- Status: `ready-for-review`
- Target release: `immediate repo adoption`

## Problem

- Current pain: agent work still depends too much on prompt phrasing to decide which markdown files to load for implementation, fixing, and review tasks.
- Current risk: the agent may over-read or under-read specs, wrongly treat `spec-pack` as approval source, or bypass canonical feature packages when working from bug descriptions or rule-based reviews.
- Desired outcome: task type is declared explicitly through a stable header and routed to one canonical loading matrix.

## Scope

### In Scope

- Define canonical task profiles for implementation, fixing, and review work.
- Define a prompt header contract that selects the task profile and key supporting artifacts.
- Define how `spec_back.md` behaves as a helper without becoming a new source of truth.
- Update agent-loading, governance, and spec guidance to use the task-profile contract.
- Add canonical task-profile request examples.

### Out Of Scope

- Runtime backend behavior changes
- Runtime frontend behavior changes
- New spec-pack manifest keys
- Automatic prompt parsing based only on free-form wording
- Turning `spec_back.md` into a canonical approval artifact

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | No runtime data model change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No runtime API or DTO contract change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No application workflow change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | No separate edge-case artifact needed |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | Verification results recorded |
| `12-review-report.md` | Review outcome | `when review starts` | `not started` | Formal review pending |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01`, `DES-02` | `TASK-01`, `TASK-02` | `AC-01` | `TC-01` | `docs/sdd/context/task-profiles.md`, `AGENTS.md`, `docs/sdd/context/ai-loading-order.md` |
| `REQ-02` | `DES-01`, `DES-03` | `TASK-02`, `TASK-03` | `AC-02` | `TC-01`, `TC-02` | `docs/sdd/governance.md`, `docs/sdd/governance/01-when-a-spec-is-required.md`, `docs/sdd/governance/04-review-rules.md` |
| `REQ-03` | `DES-02`, `DES-04` | `TASK-01`, `TASK-04` | `AC-03` | `TC-02`, `TC-03` | `docs/specs/README.md`, `docs/sdd/templates/task-profile-examples.md` |
| `REQ-04` | `DES-03`, `DES-05` | `TASK-03`, `TASK-04` | `AC-04` | `TC-03` | `docs/sdd/context/task-profiles.md`, `AGENTS.md` |

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
- Implementation report complete: `yes`
- Formal review report complete: `no`
- Feature-local changelog updated: `yes`
