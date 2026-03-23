---
id: "2026-03-13-spec-graph-extractor"
title: "First-pass spec graph extractor for feature packages"
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
  - "docs/specs/README.md"
  - "docs/sdd/governance.md"
  - "docs/sdd/context/spec-structure-schema.md"
implementation_refs:
  - "scripts/sdd/build_spec_graph.sh"
  - "scripts/sdd/README.md"
  - "AGENTS.md"
  - "docs/specs-support/examples/2026-03-11-example-customer-export/spec.graph.yaml"
  - "docs/specs/2026-03-13-task-profile-routing/spec.graph.yaml"
test_refs:
  - "09-test-cases.md"
  - "11-implementation-report.md"
---

# Feature Spec Package

## Summary

- Feature: add a first-pass extractor that compiles `spec.graph.yaml` from existing feature package markdown
- Ticket or request: `repository spec graph extractor`
- Owner: `Codex`
- Status: `ready-for-review`
- Target release: `immediate repo adoption`

## Problem

- Current pain: feature package traceability is readable by humans, but automation still has to scrape multiple markdown files to reconstruct requirements, decisions, tasks, acceptance criteria, tests, contract references, and scope locks.
- Current risk: impact analysis, self-review question generation, and semantic checks stay brittle because many relations are not normalized into a machine-readable graph.
- Desired outcome: the repository can generate a deterministic first-pass `spec.graph.yaml` from existing markdown conventions, while marking uncertain or non-extractable relations explicitly instead of guessing.

## Scope

### In Scope

- Add a shell extractor that generates `spec.graph.yaml` for one selected feature package.
- Extract feature metadata, scope, anchors, open questions, `REQ`, `DES`, `TASK`, `AC`, and `TC` nodes, explicit contract references, and explicit trace links.
- Generate sample graphs for an existing full-path feature and an existing reduced-path feature.
- Document current limits and which graph fields still require human authoring.

### Out Of Scope

- Replacing the numbered markdown feature package as the approval source of truth
- Adding a repo-wide graph validator or CI gate
- Backfilling every existing feature package in one change
- Inferring relations that are not stated explicitly in current markdown
- Changing runtime backend, frontend, or SQL behavior

## Artifact Checklist

| File | Purpose | Required | Status | Notes |
| --- | --- | --- | --- | --- |
| `01-requirements.md` | Requirements and constraints | `always` | `complete` | |
| `02-design.md` | Solution design | `always` | `complete` | |
| `03-data-model.md` | Data shape and lifecycle | `conditional` | `n/a` | No runtime data model change |
| `04-api-contract.md` | Contract changes | `conditional` | `n/a` | No runtime API or DTO change |
| `05-behavior.md` | User-facing behavior | `conditional` | `n/a` | No runtime behavior change |
| `06-edge-cases.md` | Failure and edge behavior | `conditional` | `n/a` | No separate edge-case artifact needed |
| `contracts/` | Machine-readable contracts | `conditional` | `n/a` | No new machine-readable contract |
| `spec-pack.manifest.yaml` | Generated spec-pack inputs | `conditional` | `n/a` | This feature generates `spec.graph.yaml`, not a spec-pack |
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
| `REQ-01` | `DES-01`, `DES-02` | `TASK-01` | `AC-01` | `TC-01`, `TC-02` | `scripts/sdd/build_spec_graph.sh` |
| `REQ-02` | `DES-02`, `DES-03` | `TASK-01`, `TASK-02` | `AC-01`, `AC-02` | `TC-01`, `TC-03` | `docs/specs-support/examples/2026-03-11-example-customer-export/spec.graph.yaml`, `docs/specs/2026-03-13-task-profile-routing/spec.graph.yaml` |
| `REQ-03` | `DES-03`, `DES-04` | `TASK-02`, `TASK-03` | `AC-02`, `AC-03` | `TC-02`, `TC-03` | `scripts/sdd/build_spec_graph.sh` |
| `REQ-04` | `DES-04`, `DES-05` | `TASK-03`, `TASK-04` | `AC-03`, `AC-04` | `TC-03`, `TC-04` | `scripts/sdd/README.md`, `AGENTS.md` |

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
