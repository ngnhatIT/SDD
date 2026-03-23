---
id: "SPMT00141"
title: "SPMT00141 procurement product master change package"
owner: "WMS Delivery Team"
status: "in_progress"
last_updated: "2026-03-21"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "03-data-model.md"
  - "04-api-contract.md"
  - "05-behavior.md"
  - "06-edge-cases.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
  - "12-review-report.md"
  - "spec-pack.manifest.yaml"
  - "changelog.md"
dependencies:
  - "docs/spec-packs/SPMT00141.md"
  - "docs/sdd/context/schema_database.yaml"
  - "docs/sdd/standards/backend-process-architecture.md"
  - "docs/sdd/standards/frontend-screen-architecture.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/process/Spmt00141GetDetailProcess.java"
  - "src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts"
  - "src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.html"
test_refs:
  - "09-test-cases.md"
---

# Feature Spec Package

## Summary

- Feature: adapt the existing `SPMT00141` procurement product master screen to the latest requested input and copy behavior
- Ticket or request: `docs/spec-packs/SPMT00141.md`
- Owner: `WMS Delivery Team`
- Status: `in_progress`
- Target release: `tbd after schema authority review`

## Problem

- Current pain: the current screen still exposes manual `PRODUCTCD` handling, lacks a copy flow, and does not carry the four requested fields end-to-end.
- Current risk: the numbering table now exists in schema authority, but the `KANRIKBN` selector rule for `SPMT00141` is still unresolved.
- Desired outcome: the canonical package defines the requested behavior, preserves traceability, and records the deferred numbering-dependent scope while non-numbering work proceeds.

## Scope

### In Scope

- Initial display, search, detail load, new, register, update, copy, and delete behavior for `SPMT00141`
- Removal of manual `PRODUCTCD` entry from the input form
- Backend-generated `PRODUCTCD` during register and copy
- Four new input fields and their validation/master data requirements
- Dynamic validation parity between frontend and backend for the touched rules
- Traceability and blockers needed for governed implementation

### Out Of Scope

- CSV import or export behavior changes
- New database schema design beyond what authority docs explicitly approve
- Clarifying legacy `TAMT049_BASEGROUP` join behavior
- Finalizing the `KANRIKBN` filter literal for `TAMT050_PRODUCTNUMBERING` without an approved source
- Any unrelated screen-family refactor

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `complete` | Includes schema authority conflict record |
| `04-api-contract.md` | Contract changes | `conditional` | `complete` | Contract deltas are documented, implementation blocked |
| `05-behavior.md` | User-facing behavior | `conditional` | `complete` | |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `complete` | |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | Deferred until schema authority and endpoint naming are approved |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `complete` | Existing execution aid is `docs/spec-packs/SPMT00141.md` |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | Current state is partial because numbering-dependent scope stays deferred |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `not started` | |
| `12-review-report.md` | Review outcome | `when review starts` | `complete` | `2026-03-21` rule-based review recorded attached `TMT026_PRODUCT` SQL conflicts and current code impact |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01`, `DES-06` | `TASK-02`, `TASK-05` | `AC-01`, `AC-07` | `TC-01`, `TC-08` | `src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts` |
| `REQ-02` | `DES-02`, `DES-05` | `TASK-03`, `TASK-05` | `AC-01`, `AC-02` | `TC-02`, `TC-03` | `src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java` |
| `REQ-03` | `DES-02`, `DES-03` | `TASK-03`, `TASK-04`, `TASK-05` | `AC-04` | `TC-06` | `src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java` |
| `REQ-04` | `DES-04` | `TASK-03`, `TASK-05` | `AC-02`, `AC-03`, `AC-04` | `TC-03`, `TC-05`, `TC-06` | `src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/process/Spmt00141GetDetailProcess.java` |
| `REQ-05` | `DES-05` | `TASK-02`, `TASK-03`, `TASK-05` | `AC-01`, `AC-02`, `AC-03`, `AC-06` | `TC-01`, `TC-03`, `TC-05`, `TC-07` | `src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.html` |
| `REQ-06` | `DES-05`, `DES-07` | `TASK-03`, `TASK-05` | `AC-05`, `AC-06` | `TC-04`, `TC-07` | `src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java` |
| `REQ-07` | `DES-01`, `DES-05`, `DES-06` | `TASK-02`, `TASK-03`, `TASK-05` | `AC-01`, `AC-03`, `AC-07` | `TC-01`, `TC-05`, `TC-08` | `src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/process/Spmt00141GetDetailProcess.java` |
| `REQ-08` | `DES-02`, `DES-08` | `TASK-01`, `TASK-03` | `AC-02`, `AC-04`, `AC-08` | `TC-03`, `TC-06`, `TC-09` | `src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java` |

## Open Questions

- The `KANRIKBN` selector for the numbering table is still unresolved.
- The request does not authorize new behavior for CSV, `TAMT049_BASEGROUP`, or other legacy joins.

## Temporary Deferred Scope

- User direction on `2026-03-18` allows implementation to continue for non-numbering work while the unresolved `KANRIKBN` selector stays recorded as a deferred gap.
- The deferred gap applies only to numbering-dependent behavior:
  - backend-generated `PRODUCTCD`
  - copy action
  - numbering-driven register or reload behavior
- Non-numbering work may proceed for:
  - four new fields
  - reserve-type master alignment
  - hiding manual-code UI behavior
  - preserving stored `PRODUCTCDHANDMADE` on update

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or explicitly deferred: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Schema authority aligned with required table and columns: `yes`
- Numbering selector rule aligned: `no`
- Pre-implementation gate: `pass for non-numbering scope only`

## Exit Gate Result

- Tasks complete or deferred: `in progress`
- Acceptance criteria proven: `no`
- Test results recorded: `no`
- Implementation and review reports complete: `no`
- Feature-local changelog updated: `yes`
