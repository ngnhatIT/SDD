---
id: "2026-03-13-execution-brief-generator"
title: "Execution-brief generator for task-specific SDD loading"
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
  - "docs/sdd/context/task-profiles.md"
  - "docs/sdd/context/ai-loading-order.md"
  - "docs/sdd/governance.md"
  - "docs/specs/README.md"
implementation_refs:
  - "scripts/sdd/build_execution_brief.sh"
  - "scripts/sdd/README.md"
  - "AGENTS.md"
  - "docs/spec-packs/2026-03-11-example-customer-export.implement-new.brief.md"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
---

# Feature Spec Package

## Summary

- Feature: add a deterministic execution-brief generator for one governed task request
- Ticket or request: `repository execution brief generator`
- Owner: `Codex`
- Status: `ready-for-review`
- Target release: `immediate repo adoption`

## Problem

- Current pain: the control-plane rules needed to start one task are split across `AGENTS.md`, `docs/sdd/context/`, `docs/sdd/governance.md`, `docs/specs/README.md`, and the governing feature package.
- Current risk: AI tools and new developers must merge those instructions manually before they can start execution, which increases startup variance and makes it easy to miss scope locks or required validations.
- Desired outcome: one generated brief can summarize the task profile, governing files, task scope, constraints, required reads, and required validations for a specific governed task without creating a second source of truth.

## Scope

### In Scope

- Add a shell generator that builds one task-specific execution brief from canonical SDD markdown.
- Generate a concise deterministic brief under `docs/spec-packs/`.
- Support explicit request-scoped inputs for task profile, spec-pack, backend helper, bug source, and review scope.
- Document how to run the generator and what the first version does not infer automatically.
- Generate a sample brief for an existing feature package.

### Out Of Scope

- Changing runtime backend, frontend, or SQL behavior
- Turning the execution brief into an approval artifact
- Auto-detecting task profile from free-form prompt wording
- CI enforcement or freshness validation for generated briefs
- Rewriting the SDD governance model

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | No runtime data model change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No runtime API or DTO change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No application workflow change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | No separate edge-case artifact needed |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No new machine-readable contract |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `n/a` | Brief generator writes directly to `docs/spec-packs/` |
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
| `REQ-01` | `DES-01`, `DES-02` | `TASK-01` | `AC-01` | `TC-01` | `scripts/sdd/build_execution_brief.sh` |
| `REQ-02` | `DES-02`, `DES-03` | `TASK-01`, `TASK-02` | `AC-01`, `AC-02` | `TC-01`, `TC-02` | `docs/spec-packs/2026-03-11-example-customer-export.implement-new.brief.md` |
| `REQ-03` | `DES-01`, `DES-04` | `TASK-01`, `TASK-03` | `AC-02`, `AC-03` | `TC-02`, `TC-03` | `AGENTS.md`, `docs/specs/README.md`, `scripts/sdd/README.md` |
| `REQ-04` | `DES-03`, `DES-05` | `TASK-02`, `TASK-04` | `AC-04` | `TC-01`, `TC-03` | `scripts/sdd/build_execution_brief.sh`, `scripts/sdd/README.md` |

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
