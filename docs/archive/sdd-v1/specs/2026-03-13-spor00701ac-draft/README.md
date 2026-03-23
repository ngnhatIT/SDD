---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC observed-behavior draft package"
owner: "Unassigned"
status: "draft"
last_updated: "2026-03-13"
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
dependencies:
  - "docs/sdd/standards/repository-context.md"
  - "docs/sdd/standards/backend-process-architecture.md"
  - "docs/sdd/standards/security-validation-and-logging.md"
  - "docs/sdd/standards/frontend-screen-architecture.md"
  - "docs/sdd/standards/frontend-change-rules.md"
  - "docs/sdd/standards/module-patterns/search.md"
implementation_refs:
  - "src/main/webapp/angular/src/app/components/spor00701ac/spor00701ac.component.ts"
  - "src/main/webapp/angular/src/app/components/spor00701ac/spor00701ac.component.html"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acsearch/process/Spor00701acSearchAllProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateNewProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acupdate/process/spor00701acUpdateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acdelete/process/spor00701acDeleteProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accheckWarning/process/Spor00701accheckWarningProcess.java"
test_refs:
  - "09-test-cases.md"
---

# Feature Spec Package

## Summary

- Feature code: `SPOR00701AC`
- Screen title observed in code: `個別発注依頼入力`
- Package intent: reconstruct a governed artifact from existing implementation so future work can re-enter the normal SDD flow
- Package status: retrospective draft from observed code, not approved behavior
- Governance classification: `full-path`

## Source Basis Legend

- `confirmed`: directly observed in source code or repo artifacts
- `inferred`: deduced from names, comments, UI labels, or surrounding module patterns
- `unresolved`: material ambiguity, contradiction, or missing source remains

## Problem

- The repository contains a working `SPOR00701AC` screen family, but no governing feature package and no spec-pack were found.
- Future work on this area would otherwise rely on implementation-only knowledge.
- This package records what the code does today, including questionable behavior, without silently approving it.

## Scope

### In Scope

- Angular screen `SPOR00701AC`
- Observed backend endpoints for init, search count, search rows, check-link, check-warning, create new, create save, create copy, update, and delete
- Durable reads and writes centered on `TAOR59_ANACORDERREQUEST`
- Visible validations, state transitions, warnings, and side effects traceable from source code

### Out Of Scope

- Approving business intent not provable from code
- Fixing implementation defects
- Generating a spec-pack or machine-readable contract in this draft
- Backfilling historical test evidence that is not present in the repository

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Observed requirements and scope | `always` | `complete` | Draft, retrospective |
| `02-design.md` | Source-base anchors and observed design | `always` | `complete` | Uses implementation as evidence |
| `03-data-model.md` | Tables, state changes, and dependencies | `conditional` | `complete` | Required by this feature |
| `04-api-contract.md` | Endpoint and DTO reconstruction | `conditional` | `complete` | No machine-readable contract found |
| `05-behavior.md` | Screen and workflow behavior | `conditional` | `complete` | Observed from Angular and backend flow |
| `06-edge-cases.md` | Edge handling, questionable behavior, gaps | `conditional` | `complete` | Explicitly separates confirmed and unresolved |
| `07-tasks.md` | Closure tasks before approval | `always` | `complete` | Focused on review and verification |
| `08-acceptance-criteria.md` | Acceptance criteria for this draft and runtime behavior | `always` | `complete` | Mixed runtime and artifact gates |
| `09-test-cases.md` | Verification paths for observed behavior | `always` | `complete` | No existing automated coverage found |
| `10-rollout.md` | Approval and adoption plan | `always` | `complete` | Documentation-only change |
| `11-implementation-report.md` | Implemented change record | `when implementation starts` | `not started` | Existing runtime code predates this package |
| `12-review-report.md` | Review findings and verdict | `when review starts` | `complete` | Static source review completed; blocking findings recorded |
| `changelog.md` | Feature-local history | `always` | `complete` | Records this draft package creation |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case |
| --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01`, `DES-02` | `TASK-01`, `TASK-04` | `AC-01`, `AC-02` | `TC-01`, `TC-02`, `TC-03` |
| `REQ-02` | `DES-01`, `DES-03` | `TASK-01`, `TASK-04` | `AC-01`, `AC-04` | `TC-01`, `TC-04` |
| `REQ-03` | `DES-02`, `DES-03` | `TASK-02`, `TASK-04` | `AC-03`, `AC-04` | `TC-05`, `TC-06`, `TC-07`, `TC-08`, `TC-09` |
| `REQ-04` | `DES-04`, `DES-05` | `TASK-03`, `TASK-04` | `AC-05` | `TC-10` |
| `REQ-05` | `DES-02`, `DES-05` | `TASK-02`, `TASK-04` | `AC-02`, `AC-03` | `TC-01`, `TC-05`, `TC-08`, `TC-10` |
| `REQ-06` | `DES-06` | `TASK-01`, `TASK-03`, `TASK-05` | `AC-06` | `TC-11` |

## Confirmed Behaviors

- `confirmed` The screen routes through `SPOR00701AC` and uses a single Angular component with separate backend endpoints for count, list, mutation, warning, and concurrency checks.
- `confirmed` Search rows are read from `TAOR59_ANACORDERREQUEST` with company scoping and optional filters; count and list are separate endpoints.
- `confirmed` Search results can expose statuses `01` through `08`, but the UI filter checkboxes only expose `01`, `02`, `03`, `05`, `06`, and `07`.
- `confirmed` Create, temporary save, copy, update, and delete all mutate `TAOR59_ANACORDERREQUEST`.
- `confirmed` Shared optimistic-lock checking compares client `UPDDATETIME` against the current row before row-open or mutation flows.
- `confirmed` Warning checks read product, agreement, and code-master data before submit or temporary save.
- `confirmed` No `SPOR00701AC`-specific automated tests, feature package, spec-pack, or feature-owned contract artifacts were found in this repository.

## Inferred Behaviors

- `inferred` The business purpose is individual order request entry before later approval, ordering, and receipt steps handled elsewhere.
- `inferred` The `deadline` returned by search count is a cutoff or release timestamp for the selected store, section, and group context.
- `inferred` `DATAPARTITION`, `APPROVALSTATUS`, and `ORDERCATEGORY` together represent the screen's lifecycle state model that is surfaced as code group `GC_H3060`.

## Unresolved Questions

- `unresolved` Should pullback (`04`) and drop (`08`) statuses be searchable or actionable on this screen, or are they intentionally omitted from the UI filter?
- `unresolved` Should warning text persist into `ALARM`, `AIRLN`, both, or neither, and should update or temporary-save flows preserve that data?
- `unresolved` Should copy preserve the original request date and request user, or stamp the current user and current timestamp?
- `unresolved` Should missing rows during check-link, update, or delete raise `ME000063` consistently instead of sometimes succeeding silently?
- `unresolved` Is server-side rejection required when direct API callers omit UI-required search fields or numeric payload values?
- `unresolved` Should this feature own machine-readable contracts before future behavior changes begin?

## Recommended Review Points Before Approval

- Review the alarm-field mapping in create, create-save, copy, and update flows before treating current persistence behavior as approved.
- Review the delete success message path, which currently reuses `ME000063` text that normally means "already deleted."
- Review the product validation helper, because the called method does not filter by the submitted `PRODUCTCD`.
- Review the check-link and mutation missing-row behavior in `MasterCheckExclusionProcess`.
- Review whether the absence of server-side required-field validation on search is acceptable for API consumers outside the Angular screen.
- Decide whether this feature should add `contracts/` and a `spec-pack.manifest.yaml` once the draft is accepted.

## Open Questions

- Should this feature own machine-readable contracts before future behavior changes begin?
- Should a generated spec-pack be added immediately after draft approval or only when the next code change starts?

## Entry Gate Result

- Required files present: `yes`
- Applicable optional files present: `yes`
- Machine-readable contract present: `no`
- Pre-implementation gate: `failed historically`; runtime code existed before this package
- Current approval state: `reviewed with blocking findings; not ready for approval`

## Exit Gate Result

- Tasks complete or deferred: `pending`
- Acceptance criteria proven: `planned`
- Test results recorded: `planned`
- Implementation report complete: `no`
- Review report complete: `yes`
- Feature-local changelog updated: `yes`
