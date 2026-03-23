---
id: "<feature-id>"
title: "<feature title>"
owner: "<team or person>"
status: "draft"
last_updated: "YYYY-MM-DD"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
dependencies: []
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Feature Spec Package

## Summary

- Feature: `<one-line feature name>`
- Ticket or request: `<ticket-id or request source>`
- Owner: `<team or person>`
- Status: `<draft / ready-for-design / ready-for-implementation / in-progress / ready-for-review / done / cancelled>`
- Target release: `<release or date>`

## Problem

- Current pain: `<what is broken, manual, risky, or missing>`
- Desired outcome: `<what changes for users or operations>`

## Scope

### In Scope

- `<item 1>`
- `<item 2>`

### Out Of Scope

- `<item 1>`

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `<draft>` | |
| `02-design.md` | Solution design | `always` | `<draft>` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `<n/a>` | `<required if schema/state changes>` |
| `04-api-contract.md` | Contract changes | `conditional` | `<n/a>` | `<required if API/DTO/integration changes>` |
| `05-behavior.md` | User-facing behavior | `conditional` | `<n/a>` | `<required if UI/workflow changes>` |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `<draft>` | `<required if handling is non-trivial>` |
| `contracts/` | Machine-readable contracts | `conditional` | `<n/a>` | `<list owned files in 04-api-contract.md when present>` |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `<n/a>` | `<required when the feature owns a generated spec-pack>` |
| `07-tasks.md` | Implementation tasks | `always` | `<draft>` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `<draft>` | |
| `09-test-cases.md` | Test cases | `always` | `<draft>` | |
| `10-rollout.md` | Rollout and rollback | `always` | `<draft>` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `<not started>` | |
| `12-review-report.md` | Review outcome | `when review starts` | `<not started>` | |
| `changelog.md` | Feature-local change summary | `always` | `<draft>` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `<src/...>` |

## Open Questions

- `<question 1>`

## Entry Gate

Implementation starts only when:

- required files are present
- tasks, acceptance criteria, and test cases are written
- conditional files are either present or marked `n/a` above

## Exit Gate

Feature is ready only when:

- tasks are complete or explicitly deferred
- acceptance criteria are proven
- test results are recorded
- implementation and review reports are complete
- changelog is updated
