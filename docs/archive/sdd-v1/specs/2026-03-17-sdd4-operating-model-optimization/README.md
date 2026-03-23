---
id: "2026-03-17-sdd4-operating-model-optimization"
title: "SDD4 operating-model optimization for daily execution"
owner: "Codex"
status: "done"
last_updated: "2026-03-17"
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
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/"
  - "docs/specs/"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
  - "12-review-report.md"
---

# Feature Spec Package

## Summary

- Feature: `optimize the SDD4 daily operating model without weakening governance or anti-hallucination controls`
- Ticket or request: `repository request to streamline framework execution guidance and reporting`
- Owner: `Codex`
- Status: `done`
- Target release: `immediate repository documentation update`

## Problem

- Current pain: `AGENTS.md` carries too much duplicated detail, operator routing is split between task profiles and scattered guidance, daily execution paths are not short enough for routine use, report templates are underspecified, and legacy bridge wording still implies a live authority surface that is not present in this workspace.`
- Desired outcome: `keep one clear authority chain, add practical routing help for daily work, strengthen evidence-oriented reports, and reduce ambiguity around legacy bridge references with minimal-diff canonical edits.`

## Scope

### In Scope

- lighten `AGENTS.md` while preserving its root-contract role
- add a canonical task-mode matrix under `docs/sdd/context/`
- add a short daily operator guide under `docs/sdd/prompts/`
- strengthen canonical implementation and review report templates and any necessary aliases
- tighten legacy bridge wording in active canonical docs to match the current repo state
- update canonical navigation links only where needed so the new guidance is discoverable

### Out Of Scope

- runtime backend, frontend, SQL, contract, or build behavior changes
- speculative workflow expansion beyond current governance and task-profile model
- introducing a new authority layer parallel to `AGENTS.md`, `docs/sdd/`, or `docs/specs/`
- deleting archived historical material except for minimal safety wording updates when clearly needed

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Docs-only framework change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No product API or DTO change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime product workflow change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Covered in design and rollout for docs-only scope |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No owned interface change |
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
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `AGENTS.md`, `docs/README.md`, `docs/sdd/README.md`, `docs/sdd/context/ai-loading-order.md`, `docs/sdd/governance.md` |
| `REQ-02` | `DES-02` | `TASK-02` | `AC-02` | `TC-02` | `docs/sdd/context/task-mode-matrix.md`, `docs/sdd/context/task-profiles.md`, `docs/sdd/prompts/daily-operator-guide.md` |
| `REQ-03` | `DES-03` | `TASK-03` | `AC-03` | `TC-03` | `docs/sdd/templates/feature-package/11-implementation-report.md`, `docs/sdd/templates/feature-package/12-review-report.md`, alias template notes |
| `REQ-04` | `DES-04` | `TASK-04` | `AC-04` | `TC-04` | `docs/sdd/README.md`, `docs/sdd/prompts/quick-guide.md`, active bridge references in canonical docs |

## Open Questions

- Whether generated spec-packs that still mention legacy bridge paths should be regenerated in a separate follow-up change.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass for docs-only framework optimization`

## Exit Gate Result

- Tasks complete or deferred: `complete`
- Acceptance criteria proven: `yes`
- Test results recorded: `yes`
- Implementation and review reports complete: `yes`
- Feature-local changelog updated: `yes`
