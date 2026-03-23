---
id: "example-feature"
title: "SPPM00061 expired-file filter with search and export parity"
owner: "Repository Example"
status: "ready-for-implementation"
last_updated: "2026-03-16"
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
dependencies:
  - "docs/sdd/standards/repository-context.md"
  - "docs/sdd/standards/module-patterns/search.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Feature Spec Package

## Summary

- Feature: `add an expired-only filter to SPPM00061 search and keep CSV export aligned`
- Ticket or request: `framework example feature`
- Owner: `Repository Example`
- Status: `ready-for-implementation`
- Target release: `example only`

## Problem

- Current pain: users reviewing attachment records on `SPPM00061` must manually identify expired files after search or CSV export because the screen cannot filter expired rows directly.
- Desired outcome: users can filter expired files on screen, reuse the same filter for CSV export, and understand the behavior from a governed full-path example package.

## Scope

### In Scope

- add an `expiredOnly` filter to the `SPPM00061` search screen
- apply the same filter to search count, search list, and CSV export paths
- preserve saved-condition restore behavior for the new filter
- document the request-contract change and screen behavior

### Out Of Scope

- new tables or durable audit records
- changes to attachment delete or download flows
- asynchronous export or background jobs
- permission model changes

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `complete` | Existing expiry fields only |
| `04-api-contract.md` | Contract changes | `conditional` | `complete` | Search request adds `expiredOnly` |
| `05-behavior.md` | User-facing behavior | `conditional` | `complete` | Screen and export parity |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `complete` | Saved condition and boundary handling |
| `contracts/` | Machine-readable contracts | `conditional` | `complete` | OpenAPI and schemas |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `complete` | Example pack output |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `not started` | Example package stops before implementation |
| `12-review-report.md` | Review outcome | `when review starts` | `not started` | Example package stops before review |
| `13-risk-log.md` | Active risks and mitigations | `sdd2+` | `complete` | |
| `14-decision-notes.md` | Local design decisions | `sdd2+` | `complete` | |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.ts` |
| `REQ-02` | `DES-02` | `TASK-01`, `TASK-02` | `AC-02` | `TC-02` | `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchProcess.java` |
| `REQ-03` | `DES-03` | `TASK-01`, `TASK-02` | `AC-03` | `TC-03` | `docs/specs-support/examples/example-feature/contracts/openapi.yaml` |
| `REQ-04` | `DES-04` | `TASK-03` | `AC-04` | `TC-04` | `docs/spec-packs/example-feature.pack.md` |

Note:

- In this example package, the `Implementation Ref` column names intended grounding refs or anchor artifacts. It is not proof that implementation has been completed. Delivered implementation evidence belongs in `11-implementation-report.md`.

## Open Questions

- None.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass`

## Exit Gate Result

- Tasks complete or deferred: `planned`
- Acceptance criteria proven: `planned`
- Test results recorded: `planned`
- Implementation and review reports complete: `no`
- Feature-local changelog updated: `yes`
