---
id: "2026-03-18-sdd-multi-agent-os-upgrade"
title: "Multi-agent SDD operating system upgrade"
owner: "Repository maintainers"
status: "ready-for-review"
last_updated: "2026-03-18"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
  - "11-implementation-report.md"
dependencies:
  - "AGENTS.md"
  - "docs/README.md"
  - "docs/sdd/README.md"
  - "docs/specs/README.md"
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/"
  - "docs/specs/"
  - "docs/spec-packs/"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
  - "docs/sdd/reports/2026-03-18-sdd-multi-agent-upgrade-report.md"
---

# Feature Spec Package

## Summary

- Feature: `upgrade the repository SDD into a multi-agent, execution-first operating system`
- Ticket or request: `repository request to redesign SDD for Codex, Claude, and GitHub Copilot`
- Owner: `Repository maintainers`
- Status: `ready-for-review`
- Target release: `immediate documentation update`

## Problem

- Current pain: the SDD has strong governance, but the active execution path is spread across too many overlapping routing, prompt, checklist, and historical files; spec authoring is not first-class; and agent guidance is implicitly Codex-first.
- Desired outcome: one clear governance chain, one explicit execution layer, agent-specific operating profiles, first-class spec authoring, reusable enforcement checklists, and a smaller main path that stays robust under real AI behavior.

## Scope

### In Scope

- redesign `docs/sdd/` into clearer governance, execution, agent-profile, prompt-adapter, and spec-authoring layers
- add explicit operating profiles for Codex, Claude, and GitHub Copilot
- create minimum execution contracts for spec authoring, spec-pack generation, implementation, review, fix-from-review, recovery, and execution-brief generation
- reduce prompt duplication by moving operational rules into canonical execution contracts and keeping prompts thin
- convert recurring fragile rules into reusable enforcement checklists
- tighten `docs/specs/README.md`, `docs/spec-packs/` guidance, and canonical entrypoints so agents know what is live, optional, historical, or compatibility-only
- produce a concise upgrade report

### Out Of Scope

- runtime backend, frontend, SQL, contract, or schema behavior changes in the product
- replacing `docs/decisions/` or changing ADR semantics
- large-scale relocation of every historical validator or example artifact when a clearer canonical classification is sufficient
- adding a new tooling framework or build system

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Docs-only framework change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No product API or DTO change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime workflow change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Captured in governance, rollout, and risks |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No owned runtime contract |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `n/a` | Not required for this docs-only framework change |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | |
| `12-review-report.md` | Review outcome | `when review starts` | `not started` | |
| `13-risk-log.md` | Active risks and mitigations | `sdd2+` | `complete` | |
| `14-decision-notes.md` | Local design decisions | `sdd2+` | `complete` | |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `AGENTS.md`, `docs/sdd/README.md`, `docs/sdd/context/ai-loading-order.md`, `docs/sdd/governance.md` |
| `REQ-02` | `DES-02`, `DES-03` | `TASK-02` | `AC-02` | `TC-02` | `docs/sdd/execution/`, `docs/sdd/execution/contracts/` |
| `REQ-03` | `DES-04` | `TASK-03` | `AC-03` | `TC-03` | `docs/sdd/execution-profiles/`, `docs/sdd/prompts/` |
| `REQ-04` | `DES-07` | `TASK-03` | `AC-03` | `TC-03` | `docs/sdd/prompts/`, `docs/sdd/execution/task-routing.md` |
| `REQ-05` | `DES-05` | `TASK-04` | `AC-04` | `TC-04` | `docs/sdd/spec-authoring/`, `docs/specs/README.md`, `docs/sdd/checklists/spec-authoring-checklist.md` |
| `REQ-06` | `DES-06` | `TASK-05` | `AC-05` | `TC-05` | `docs/sdd/checklists/touched-scope-enforcement.md`, `docs/sdd/checklists/`, `docs/sdd/process/99-ai-checklist.md` |
| `REQ-07` | `DES-02`, `DES-08` | `TASK-06`, `TASK-07` | `AC-06` | `TC-06` | `docs/README.md`, `docs/sdd/README.md`, `docs/specs/README.md`, `docs/specs-support/README.md`, `docs/archive/README.md` |
| `REQ-08` | `DES-07`, `DES-08` | `TASK-06`, `TASK-07` | `AC-07` | `TC-07` | `docs/sdd/context/task-profiles.md`, `docs/sdd/context/task-mode-matrix.md`, `docs/sdd/prompts/HEADER_TEMPLATE.md`, `docs/sdd/reports/2026-03-18-sdd-multi-agent-upgrade-report.md` |

## Open Questions

- Whether archived historical snapshots should be normalized to the new paths or preserved exactly as pre-cleanup evidence.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass for full-scope docs-only framework redesign`

## Exit Gate Result

- Tasks complete or deferred: `implementation complete`
- Acceptance criteria proven: `manual consistency review complete; formal review pending`
- Test results recorded: `manual-only`
- Implementation and review reports complete: `implementation complete; review pending`
- Feature-local changelog updated: `yes`
