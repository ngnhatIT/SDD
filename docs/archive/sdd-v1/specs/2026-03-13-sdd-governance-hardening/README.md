---
id: "2026-03-13-sdd-governance-hardening"
title: "SDD governance hardening for source-base anchors and style parity"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
  - "11-implementation-report.md"
dependencies:
  - "docs/sdd/governance.md"
  - "docs/decisions/ADR-0002-source-base-anchor-and-style-parity-enforcement.md"
implementation_refs:
  - "docs/sdd/standards/"
  - "docs/sdd/checklists/"
  - "docs/sdd/templates/"
  - "docs/specs/README.md"
  - "scripts/sdd/build_spec_pack.sh"
  - "scripts/sdd/validate_specs.sh"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
---

# Feature Spec Package

## Summary

- Feature: harden governance, templates, spec-pack generation, and validation around source-base anchors and style parity
- Ticket or request: `repository governance hardening`
- Owner: `Codex`
- Status: `ready-for-review`
- Target release: `immediate repo adoption`

## Problem

- Current pain: source-base anchor rules, SQL or HTML style parity expectations, and scope parity constraints are partially documented but not enforced consistently across standards, gates, templates, spec-pack output, and validation scripts.
- Current risk: agent-assisted changes can still drift from the local source base, create new families outside spec scope, or miss minimum traceability before implementation and review.
- Desired outcome: repository governance and tooling enforce one parseable contract for anchors, scope guardrails, traceability, and spec-pack implementation constraints.

## Scope

### In Scope

- Update repository governance and standards for source-base anchors, style parity, scope parity, and contract parity.
- Update pre-implementation and code-review checklists to fail when anchor or scope information is missing.
- Update design templates and specs guidance to require a parseable anchor block.
- Update spec-pack generation and validation scripts.
- Retrofit repository sample feature packages that would otherwise fail the new validation rules.

### Out Of Scope

- Runtime backend behavior changes
- Runtime frontend behavior changes
- Database schema or SQL behavior changes in application code
- `agent/` cleanup or migration
- New manifest schema or new spec-pack manifest keys

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | No runtime data model change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No runtime API or DTO contract change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No application screen behavior change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | No separate feature edge-case doc needed beyond design and tests |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | Verification results recorded |
| `12-review-report.md` | Review outcome | `when review starts` | `not started` | Formal review pending |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01`, `DES-02` | `TASK-01`, `TASK-02` | `AC-01` | `TC-01`, `TC-02` | `docs/sdd/standards/`, `docs/sdd/governance.md`, `docs/sdd/checklists/` |
| `REQ-02` | `DES-01`, `DES-03` | `TASK-01`, `TASK-03` | `AC-02` | `TC-01`, `TC-02` | `docs/sdd/templates/feature/design.md`, `docs/sdd/templates/feature-package/02-design.md`, `docs/specs/README.md` |
| `REQ-03` | `DES-02`, `DES-04` | `TASK-02`, `TASK-04` | `AC-03` | `TC-01`, `TC-02` | `scripts/sdd/build_spec_pack.sh`, `scripts/sdd/validate_specs.sh` |
| `REQ-04` | `DES-02`, `DES-05` | `TASK-04`, `TASK-05` | `AC-04` | `TC-03` | `docs/specs-support/examples/2026-03-11-example-customer-export/02-design.md`, `docs/spec-packs/2026-03-11-example-customer-export.pack.md` |

## Open Questions

- None.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass`

## Exit Gate Result

- Tasks complete or deferred: `complete`
- Acceptance criteria proven: `yes`
- Test results recorded: `yes`
- Implementation report complete: `yes`
- Formal review report complete: `no`
- Feature-local changelog updated: `yes`
