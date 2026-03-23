---
id: "2026-03-23-sdd-route1-operational-alignment"
title: "SDD Route 1 operational alignment inside the existing SDD structure"
owner: "Codex"
status: "done"
last_updated: "2026-03-23"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
  - "11-implementation-report.md"
  - "12-review-report.md"
dependencies:
  - "AGENTS.md"
  - "docs/sdd/context/ai-loading-order.md"
  - "docs/sdd/governance/01-ai-agent-policy.md"
  - "docs/sdd/governance/minimal-sufficient-context-policy.md"
  - "docs/sdd/execution-profiles/codex.md"
  - "docs/sdd/execution-profiles/copilot.md"
  - "docs/specs/2026-03-17-sdd4-operating-model-optimization/01-requirements.md"
  - "docs/specs/2026-03-19-sdd-delivery-goal-realignment/01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Feature Spec Package

## Summary

- Feature: `align the current SDD framework to the Route 1 operating approach described in the approved request, without creating any parallel AI-governance surface`
- Ticket or request: `repository request to absorb Document 32 principles into the existing SDD structure`
- Owner: `Codex`
- Status: `done`
- Target release: `immediate repository documentation update`

## Problem

- Current pain: `the framework already has routing, governance, execution profiles, prompts, and recovery helpers, but it does not yet define a stable fixed-prefix operating model, an explicit fixed-vs-variable context split, permission-based exploration, hypothesis-first investigation, log excerpt discipline, or a short restart packet in a single coherent Route 1-friendly way`
- Desired outcome: `Codex and Copilot should be able to operate through the existing SDD layers with lower token usage, lower context drift, and more repeatable debugging or review behavior, while keeping governance, traceability, and the current repository structure intact`

## Scope

### In Scope

- define where stable fixed context lives in the current SDD
- define where variable task context lives in the current SDD
- add explicit minimal-reading, permission-based exploration, and hypothesis-first operating rules in canonical locations
- add log excerpt discipline and long-session restart or handoff summary guidance
- strengthen prompt, checklist, and report support for requirement clarification, design review, traceability review, and document refactoring
- keep all changes inside existing `docs/sdd/` and `docs/specs/` structures

### Out Of Scope

- creating `CLAUDE.md`
- creating `.claude/` rules or any parallel AI-governance structure
- redesigning the repository from scratch
- adding CI or CD flow, validator automation, or API-level `cache_control`
- inventing new business requirements or runtime application behavior

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Docs-only framework change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No runtime API, DTO, or schema change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime workflow change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Covered in design, recovery, and reporting rules |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No owned runtime interface change |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `n/a` | Not required for this docs-only framework work |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | |
| `12-review-report.md` | Review outcome | `when review starts` | `complete` | |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `docs/sdd/context/ai-loading-order.md`, `docs/sdd/execution/task-input-header.md`, `docs/sdd/templates/execution-brief-template.md` |
| `REQ-02` | `DES-02` | `TASK-02` | `AC-02` | `TC-02` | `docs/sdd/governance/01-ai-agent-policy.md`, `docs/sdd/governance/minimal-sufficient-context-policy.md`, `docs/sdd/process/99-ai-checklist.md` |
| `REQ-03` | `DES-03` | `TASK-03` | `AC-03` | `TC-03` | `docs/sdd/execution-profiles/codex.md`, `docs/sdd/execution-profiles/copilot.md` |
| `REQ-04` | `DES-04` | `TASK-04` | `AC-04` | `TC-04` | `docs/sdd/execution/contracts/recover-context.md`, `docs/sdd/ai-ops/09-recovery-mode.md`, `docs/sdd/ai-ops/agent-clients-and-handoff.md`, report templates |
| `REQ-05` | `DES-05` | `TASK-05` | `AC-05` | `TC-05` | `docs/sdd/prompts/README.md`, `docs/sdd/prompts/create-spec.md`, `docs/sdd/prompts/review-feature.md`, review checklists |

## Open Questions

- The full text of `Document 32` is not present in the repository; this feature is grounded only on the explicitly approved principles and constraints listed in the request.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass for reduced-path docs-only framework alignment`

## Exit Gate Result

- Tasks complete or deferred: `complete`
- Acceptance criteria proven: `yes`
- Test results recorded: `yes`
- Implementation and review reports complete: `yes`
- Feature-local changelog updated: `yes`
