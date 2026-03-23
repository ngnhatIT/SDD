---
id: "2026-03-17-sdd4-framework-self-validation"
title: "SDD4 framework self-validation and self-audit hardening"
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
dependencies:
  - "AGENTS.md"
  - "docs/README.md"
  - "docs/sdd/README.md"
  - "docs/specs/README.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Feature Spec Package

## Summary

- Feature: `add a practical self-validation and self-audit layer for the SDD4 framework`
- Ticket or request: `repository request to harden validator coverage, operator-facing diagnostics, and framework self-audit guidance`
- Owner: `Codex`
- Status: `ready-for-review`
- Target release: `immediate repository framework update`

## Problem

- Current pain: `scripts/sdd/validate_specs.sh` validates core package shape and traceability, but it does not yet check report completeness, several canonical navigation and reference drift cases, or bridge ambiguity signals that now matter for SDD4 framework maintenance.`
- Desired outcome: `the framework can validate more of its own canonical structure, generated-pack wiring, report completeness, and bridge hygiene with deterministic, actionable output, while a helper self-audit document covers the blind spots that scripts still cannot safely enforce.`

## Scope

### In Scope

- audit current validator and fixture coverage against canonical governance, templates, and spec-pack conventions
- improve validator checks for grounded framework-shape, report-completeness, spec-pack-reference, and bridge-ambiguity cases
- improve validator output so each finding states severity, rule source, rationale, and next action
- add a framework self-audit guide under `docs/sdd/ai-ops/`
- extend validator fixtures or tests only where needed for the new grounded checks
- update validator usage or discoverability docs so operators understand scope and limits

### Out Of Scope

- runtime backend, frontend, SQL, or product contract behavior changes
- speculative validator rules not grounded in canonical governance or templates
- CI integration, background services, or a new validation subsystem
- replacing human review or framework audits with heuristic AI checks

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Docs and tooling only |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No runtime API, DTO, or file contract change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime product workflow change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Validator failure behavior is covered in design, rollout, and tests |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No owned runtime interface change |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `n/a` | Not required for this reduced-path framework change |
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
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `scripts/sdd/validate_specs.sh`, `scripts/sdd/README.md` |
| `REQ-02` | `DES-02`, `DES-03` | `TASK-02` | `AC-02` | `TC-02` | `docs/sdd/templates/feature-package/11-implementation-report.md`, `docs/sdd/templates/feature-package/12-review-report.md`, `docs/sdd/governance/03-implementation-traceability-rules.md`, `docs/sdd/governance/04-review-rules.md` |
| `REQ-03` | `DES-03`, `DES-04` | `TASK-03` | `AC-03` | `TC-02`, `TC-03` | `docs/spec-packs/`, `docs/specs/README.md`, `docs/sdd/README.md`, `scripts/sdd/validate_specs.sh` |
| `REQ-04` | `DES-04`, `DES-05` | `TASK-03`, `TASK-04` | `AC-04` | `TC-03`, `TC-04` | `docs/sdd/README.md`, `docs/sdd/ai-ops/framework-self-audit.md`, `docs/sdd/ai-ops/framework-health-metrics.md` |
| `REQ-05` | `DES-02`, `DES-05` | `TASK-05` | `AC-05` | `TC-01`, `TC-04` | `scripts/sdd/test_validate_specs.sh`, `scripts/sdd/test-fixtures/`, `docs/sdd/README.md`, `scripts/sdd/README.md` |

## Open Questions

- Whether the repo wants validator findings to remain plain text only, or eventually emit a machine-readable result format in a separate follow-up.

## Entry Gate Result

- Required files present: `yes`
- Conditional files present or marked `n/a`: `yes`
- Tasks, acceptance criteria, and test cases written: `yes`
- Pre-implementation gate: `pass for reduced-path framework tooling and docs work`

## Exit Gate Result

- Tasks complete or deferred: `implementation complete; review pending`
- Acceptance criteria proven: `yes for implementation scope`
- Test results recorded: `yes`
- Implementation and review reports complete: `implementation report complete; review not started`
- Feature-local changelog updated: `yes`
