---
id: "2026-03-16-codebase-derived-rule-calibration"
title: "Codebase-derived rule calibration from anchored modules"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
dependencies: []
implementation_refs:
  - "11-implementation-report.md"
test_refs:
  - "09-test-cases.md"
---

# Feature Spec Package

## Summary

- Feature: `codebase-derived rule calibration from anchored modules`
- Ticket or request: `Scan Spvm00131, SPMT00231, BTCC0080AC, Spmt01102ACCsvImport and tighten rules only from observed code`
- Owner: `Codex`
- Status: `in-progress`
- Target release: `n/a`

## Problem

- Current pain: some rule and prompt guidance is either too generic or too forceful compared with the real codebase.
- Desired outcome: generation and review rules match the observed module patterns without inventing behavior that is not present in the scanned anchors.

## Scope

### In Scope

- Extract repeated frontend search-flow rules from `Spvm00131` and `SPMT00231`
- Extract repeated backend validation and CSV import lifecycle rules from `SPMT00231`, `Spmt01102ACCsvImport`, and `BTCC0080AC`
- Calibrate inconsistency guidance when the scanned anchors show conflicting local patterns
- Update canonical standards and legacy bridge rules to reflect the anchored findings

### Out Of Scope

- Product behavior changes in the scanned modules
- Contract, DTO, SQL, or screen changes outside documentation or rule artifacts
- New rules that are not supported by the scanned anchors
- Cleanup or normalization of unrelated legacy inconsistencies

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | No product data change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No contract change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No app behavior change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Rule calibration only |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | |
| `12-review-report.md` | Review outcome | `when review starts` | `not started` | |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `docs/sdd/standards/module-patterns/search.md` |
| `REQ-02` | `DES-02` | `TASK-02` | `AC-02` | `TC-02` | `docs/sdd/standards/module-patterns/csv.md` |
| `REQ-03` | `DES-03` | `TASK-03` | `AC-03` | `TC-03` | `docs/sdd/standards/security-validation-and-logging.md` |
| `REQ-04` | `DES-04` | `TASK-04` | `AC-04` | `TC-04` | `docs/sdd/standards/known-inconsistencies.md` |

## Open Questions

- None.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass`

## Exit Gate Result

- Tasks complete or deferred: `pending`
- Acceptance criteria proven: `planned`
- Test results recorded: `planned`
- Implementation and review reports complete: `implementation only`
- Feature-local changelog updated: `yes`
