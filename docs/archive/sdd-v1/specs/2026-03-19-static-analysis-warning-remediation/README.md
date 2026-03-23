---
id: "2026-03-19-static-analysis-warning-remediation"
title: "Static-analysis warning remediation for targeted backend and frontend files"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "05-behavior.md"
  - "06-edge-cases.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
implementation_refs:
  - "11-implementation-report.md"
---

# Feature Summary

Remediate the user-reported static-analysis warnings in the named `spor01401ac`, `spmt00241`, `spmt01103ac`, `spor01501ac`, and `spor01101ac` source files without changing API shape, schema, or approved business behavior.

# Request Source

- User warning list dated `2026-03-19`
- `static-analysis-report.md`

# Classification

- Governed path: `full-path`
- Task profile: `fix-from-bug`

# Scope

## In Scope

- Add accessible header metadata to the reported `spor01401ac` table headers
- Remove duplicate DOM `id` usage in `spmt00241`
- Add explicit backend defensive guards for reported nullable and zero-divisor paths
- Remove or rename source elements that trigger the reported static-analysis findings without changing runtime contracts
- Record governed implementation evidence for the warning remediation

## Out Of Scope

- Route, DTO, response, or request-contract changes
- Schema or durable-data changes
- Business-rule redesign outside the narrow warning fixes
- Broad cleanup outside the files named in the request

# Raw Input Normalization

## Facts

- The user supplied a concrete list of static-analysis findings against specific Java and Angular source files.
- The reported frontend findings concern missing `<th>` accessibility attributes and a duplicate DOM `id`.
- The reported backend findings concern nullable values, a possible zero-divisor path, a duplicated private helper name against the parent class, a redundant `return`, and a hard-coded-password rule hit in a constants class.
- Current repository evidence shows the touched backend files remain process-family classes under `src/main/java/jp/co/brycen/kikancen/.../process`.
- Current repository evidence shows the touched frontend files remain screen templates under `src/main/webapp/angular/src/app/components/...`.

## Open Questions

- The user warning list includes a redundant-`return` finding for `Spor01101acCreateProcess`, but the current workspace copy does not contain a matching `return;` statement in that file.
- The user warning list includes an order-lot division warning in `Spor01101acUpdateAlarmProcess`, but the current workspace copy already contains a zero guard; the fix will keep that guard explicit in code.

## Non-Changes

- Do not change table names, column names, or SQL result shape.
- Do not change Angular component routes, labels, or backend message IDs.
- Do not change user-password storage behavior in this task.

## Approval Gaps

- Do not alter externally visible behavior or password-handling design beyond the narrow static-analysis remediation without separate approval.

# Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | No schema or durable-data change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No request or response shape change |
| `05-behavior.md` | User-facing behavior | `conditional` | `complete` | Frontend accessibility and DOM-id behavior only |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `complete` | Null and zero defensive handling |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | |
| `12-review-report.md` | Review outcome | `when review starts` | `not started` | |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

# Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case |
| --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` |
| `REQ-02` | `DES-02` | `TASK-02` | `AC-02` | `TC-02` |
| `REQ-03` | `DES-03` | `TASK-03` | `AC-03` | `TC-03` |
| `REQ-04` | `DES-04` | `TASK-04` | `AC-04` | `TC-04` |

