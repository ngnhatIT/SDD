---
id: "2026-03-16-sdd2-plus-framework-upgrade"
title: "SDD2+ additive framework upgrade"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
  - "11-implementation-report.md"
dependencies:
  - "docs/sdd/README.md"
  - "docs/decisions/ADR-0004-sdd2-plus-agent-ready-extension.md"
implementation_refs:
  - "docs/sdd/"
  - "scripts/sdd/"
  - "tools/sdd/"
  - "docs/specs-support/examples/example-feature/"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
---

# Feature Spec Package

## Summary

- Feature: `upgrade the existing SDD2 repository framework to an additive SDD2+ model`
- Ticket or request: `repository framework upgrade request`
- Owner: `Codex`
- Status: `ready-for-review`
- Target release: `immediate repository adoption`

## Problem

- Current pain: the repository already has a working SDD2 core, but it lacks a formal extension layer for AI execution aids, evidence-first guidance, prompt reuse, and feature-level risk or local decision capture.
- Desired outcome: extend the existing framework in place so humans and AI agents can use richer execution artifacts without replacing current SDD2 lifecycle, governance, or feature package rules.

## Scope

### In Scope

- add missing SDD2+ folders and operating documents under `docs/sdd/`
- add prompt library, AI operations guidance, and tool index documentation
- add practical templates for specs, implementation, review, risk, decision, and execution brief artifacts
- enrich current spec-pack and execution brief tooling to surface SDD2+ companion artifacts when present
- add one realistic example feature package and generated spec-pack

### Out Of Scope

- runtime backend, frontend, SQL, or screen behavior changes in the product
- deletion or replacement of existing SDD2 artifacts
- a new build framework or new executable toolchain outside `scripts/sdd/`
- retroactive backfill of every historical feature package

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | Docs-only change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No product API change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime feature behavior change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | Covered by requirements, design, and risks |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No owned product contract |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `n/a` | Example feature owns the generated pack |
| `07-tasks.md` | Implementation tasks | `always` | `complete` | |
| `08-acceptance-criteria.md` | Acceptance conditions | `always` | `complete` | |
| `09-test-cases.md` | Test cases | `always` | `complete` | |
| `10-rollout.md` | Rollout and rollback | `always` | `complete` | |
| `11-implementation-report.md` | Delivered implementation | `when implementation starts` | `complete` | Verification recorded |
| `12-review-report.md` | Review outcome | `when review starts` | `not started` | Formal review pending |
| `13-risk-log.md` | Active risks and mitigations | `sdd2+` | `complete` | |
| `14-decision-notes.md` | Local design decisions | `sdd2+` | `complete` | |
| `changelog.md` | Feature-local change summary | `always` | `complete` | |

## Traceability Summary

| Requirement | Design | Task | Acceptance | Test Case | Implementation Ref |
| --- | --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01` | `TASK-01` | `AC-01` | `TC-01` | `docs/sdd/README.md`, `docs/sdd/foundation/` |
| `REQ-02` | `DES-02`, `DES-03` | `TASK-02` | `AC-02` | `TC-02` | `docs/sdd/templates/`, `docs/sdd/prompts/`, `docs/sdd/ai-ops/` |
| `REQ-03` | `DES-04` | `TASK-03` | `AC-03` | `TC-03` | `scripts/sdd/build_spec_pack.sh`, `scripts/sdd/build_execution_brief.sh`, `tools/sdd/README.md` |
| `REQ-04` | `DES-05` | `TASK-04` | `AC-04` | `TC-04` | `docs/specs-support/examples/example-feature/`, `docs/spec-packs/example-feature.pack.md` |

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
- Implementation and review reports complete: `implementation only`
- Feature-local changelog updated: `yes`
