---
id: "2026-03-17-sdd4-mode-driven-efficiency"
title: "SDD4 mode-driven efficiency and minimal-context optimization"
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
  - "docs/README.md"
  - "docs/sdd/README.md"
  - "docs/sdd/context/ai-loading-order.md"
  - "docs/sdd/context/task-profiles.md"
  - "docs/sdd/context/task-mode-matrix.md"
  - "docs/sdd/governance.md"
  - "docs/sdd/governance/minimal-sufficient-context-policy.md"
  - "docs/sdd/governance/definition-of-done.md"
  - "docs/sdd/governance/07-emergency-change-handling.md"
  - "docs/sdd/governance/09-documentation-update-policy.md"
  - "docs/sdd/governance/README.md"
  - "docs/sdd/checklists/done-checklist.md"
  - "docs/sdd/prompts/daily-operator-guide.md"
  - "docs/sdd/prompts/quick-guide.md"
  - "docs/sdd/prompts/README.md"
  - "docs/sdd/ai-ops/framework-health-metrics.md"
  - "docs/sdd/ai-ops/README.md"
  - "docs/sdd/templates/execution-brief-template.md"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
  - "12-review-report.md"
---

# Feature Spec Package

## Summary

- Feature: `add the next SDD4 optimization layer for mode-driven execution, minimal sufficient context, and lightweight operational signals`
- Ticket or request: `repository request to make SDD4 more mode-driven, token-efficient, and easier to operate without weakening governance`
- Owner: `Codex`
- Status: `done`
- Target release: `immediate repository documentation update`

## Problem

- Current pain: `task-mode routing exists, but the framework still lacks a canonical minimal-context policy, completion standards are not explicit by mode, lightweight paths are not sharp enough, and framework health signals are not documented in an operationally realistic way.`
- Desired outcome: `operators should know the smallest compliant read set, the exact done bar for each mode, the allowed lightweight path boundaries, and the lightweight signals that indicate framework drift or misuse.`

## Scope

### In Scope

- add a canonical minimal-sufficient-context policy under `docs/sdd/governance/`
- define completion expectations by mode without creating a second authority layer
- sharpen lightweight execution paths for docs-only, audit-only, tiny-fix, review-only, low-risk cleanup, hotfix, and recovery or resume work
- add a practical framework-health-metrics document under `docs/sdd/ai-ops/`
- update only the minimum canonical navigation and operator guidance needed for discoverability

### Out Of Scope

- runtime backend, frontend, SQL, contract, or build behavior changes
- new task-profile header tokens beyond the current canonical set
- a new analytics system, dashboard, or mandatory per-task metrics artifact
- duplicating governance rules into prompts or templates for convenience

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Docs-only framework change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No product API or DTO change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime product workflow change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Captured in governance and rollout notes for docs-only scope |
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
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `docs/sdd/governance/minimal-sufficient-context-policy.md`, `docs/sdd/context/ai-loading-order.md`, `docs/sdd/context/task-profiles.md` |
| `REQ-02` | `DES-02` | `TASK-02` | `AC-02` | `TC-02` | `docs/sdd/governance/definition-of-done.md`, `docs/sdd/context/task-mode-matrix.md`, `docs/sdd/checklists/done-checklist.md` |
| `REQ-03` | `DES-03` | `TASK-03` | `AC-03` | `TC-03` | `docs/sdd/context/task-mode-matrix.md`, `docs/sdd/prompts/daily-operator-guide.md`, `docs/sdd/prompts/quick-guide.md` |
| `REQ-04` | `DES-04` | `TASK-04` | `AC-04` | `TC-04` | `docs/sdd/ai-ops/framework-health-metrics.md`, `docs/sdd/ai-ops/README.md` |
| `REQ-05` | `DES-05` | `TASK-05` | `AC-05` | `TC-05` | `docs/README.md`, `docs/sdd/README.md`, `docs/sdd/governance/README.md`, `docs/sdd/prompts/README.md` |

## Open Questions

- Whether a later follow-up should add a compact framework-status template once the new metrics have been used in practice.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass for reduced-path docs-only framework optimization`

## Exit Gate Result

- Tasks complete or deferred: `complete`
- Acceptance criteria proven: `yes`
- Test results recorded: `yes`
- Implementation and review reports complete: `yes`
- Feature-local changelog updated: `yes`
