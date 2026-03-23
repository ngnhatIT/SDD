---
id: "2026-03-17-sdd-framework-rationalization"
title: "SDD framework rationalization audit and targeted cleanup"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-17"
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
  - "docs/sdd/README.md"
  - "docs/specs/README.md"
implementation_refs:
  - "docs/sdd/"
  - "agent/"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
---

# Feature Spec Package

## Summary

- Feature: `audit and rationalize the SDD framework before broader codebase scanning or standards extraction`
- Ticket or request: `repository request to clean up the SDD framework first`
- Owner: `Codex`
- Status: `ready-for-review`
- Target release: `immediate repository guidance update`

## Problem

- Current pain: the repository now has multiple overlapping framework layers (`AGENTS.md`, `docs/sdd/`, `agent/`, templates, prompts, migration history), and the current shape is hard for humans and AI agents to navigate without drift.
- Desired outcome: reduce ambiguity, redundancy, and stale guidance so the SDD framework is clearer, leaner, and safer for AI execution.

## Scope

### In Scope

- audit `AGENTS.md`, `docs/sdd/`, `docs/specs/README.md`, and `agent/` as the active framework surface
- classify every in-scope file by role, canonicality, operational value, overlap, AI usability, and maintenance burden
- produce a file-level audit report and cleanup or migration plan
- identify conflicts, merge or drop candidates, and the minimum prompt set worth keeping
- apply safe, evidence-backed cleanup edits that clarify canonical authority, remove redundant leaf files, and reduce immediate AI confusion

### Out Of Scope

- product runtime code review or codebase-wide standards extraction
- speculative prompt optimization before framework cleanup is complete
- risky deletion of bridge files or large framework rewrites without explicit follow-up approval
- changes to application backend, frontend, SQL, contracts, or delivery tooling behavior outside documentation guidance

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Docs-only framework work |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No product API change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime workflow change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Covered by risks and migration plan |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No owned product contract |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `n/a` | Not needed for this docs-only change |
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
| `REQ-01` | `DES-01`, `DES-02` | `TASK-01`, `TASK-02` | `AC-01`, `AC-02` | `TC-01`, `TC-02` | `docs/archive/sdd/history/2026-03-17-rationalization/10-sdd-framework-audit-report.md`, `docs/archive/sdd/history/2026-03-17-rationalization/11-sdd-framework-cleanup-migration-plan.md` |
| `REQ-02` | `DES-02`, `DES-03` | `TASK-02`, `TASK-03` | `AC-02`, `AC-03` | `TC-02`, `TC-03` | `docs/sdd/README.md`, `docs/sdd/target-architecture.md`, `docs/archive/sdd/history/migration/migration-notes.md`, `docs/sdd/foundation/README.md`, `docs/sdd/process/05-implementation.md`, `docs/sdd/process/07-review.md`, `docs/sdd/process/08-release.md` |
| `REQ-03` | `DES-03`, `DES-04` | `TASK-03` | `AC-04` | `TC-04` | `agent/START_HERE.md`, `agent/PROMPTS.md`, `agent/standards/README.md`, `agent/pipeline/README.md`, `agent/checklists/README.md` |
| `REQ-04` | `DES-04`, `DES-05` | `TASK-02`, `TASK-04` | `AC-02`, `AC-04` | `TC-02`, `TC-04` | `docs/archive/sdd/history/2026-03-17-rationalization/11-sdd-framework-cleanup-migration-plan.md`, `docs/specs/2026-03-17-sdd-framework-rationalization/11-implementation-report.md` |

## Open Questions

- Whether the repository wants the legacy `agent/` tree reduced to a tiny bridge in this branch or only marked as legacy and left structurally intact for a follow-up change.
- Whether broader prompt, template, and bridge reductions that go beyond the executed high-confidence merges should be recorded in a new ADR after this audit is reviewed.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass for docs-only framework audit and targeted cleanup`

## Exit Gate Result

- Tasks complete or deferred: `complete for audit plus targeted cleanup scope`
- Acceptance criteria proven: `implementation evidence recorded; formal review pending`
- Test results recorded: `yes`
- Implementation and review reports complete: `implementation complete; review pending`
- Feature-local changelog updated: `yes`
