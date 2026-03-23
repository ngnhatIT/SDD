---
id: "2026-03-13-task-profile-routing"
title: "Task-profile routing for agent markdown loading requirements"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "README.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "README.md"
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/context/"
  - "docs/sdd/governance/"
test_refs:
  - "09-test-cases.md"
---

# Requirements

## Problem Statement

The repository needs a canonical way to route agent work to the right markdown set for implementation, fixing, and review. Today that routing is too dependent on prompt wording, which can cause inconsistent loading of feature specs, standards, generated spec-packs, and helper notes.

## Scope

### In Scope

- Define canonical task profiles for implementation, fixing, and review.
- Define a prompt header contract that chooses the task profile.
- Define the required and optional markdown load set for each profile.
- Define how `spec_back.md` behaves as a helper input.
- Update governance and guidance so task profiles do not bypass spec rules.

### Out Of Scope

- Runtime application behavior changes
- New machine-readable manifest schema
- Auto-detect routing as the primary mechanism
- Converting `spec_back.md` into a new approval source

## Requirements

### REQ-01

- Statement: The repository must define canonical task profiles for `implement-new`, `fix-from-pack`, `fix-from-bug`, `review-from-pack`, and `review-from-rules`.
- Rationale: Agents need a stable routing model instead of guessing from prompt wording.
- Source: task-profile routing request

### REQ-02

- Statement: The repository must define a prompt header contract and selection precedence so agents can resolve the task profile, feature package, spec-pack, backend helper, bug source, and review scope deterministically.
- Rationale: Task routing must be explicit and repeatable.
- Source: task-profile routing request

### REQ-03

- Statement: Governance and review rules must state that task profiles do not override whether a governing feature package is required, and that generated spec-packs remain execution aids only.
- Rationale: Routing convenience must not weaken approval rules.
- Source: existing governance model

### REQ-04

- Statement: The repository must define `spec_back.md` as a helper-only backend-facing alias rather than a new source of truth.
- Rationale: Backend-focused helpers are useful, but approval must stay anchored in the feature package.
- Source: task-profile routing request

## Constraints

- Preserve `docs/specs/<feature-id>/` as the approval source of truth.
- Preserve `docs/spec-packs/<feature-id>.pack.md` as an execution aid only.
- For implement and fix work without a generated spec-pack, default to reduced-path or full-path feature packages rather than bypassing specs.
- Only `no-spec` changes under existing governance may be reviewed without a feature package.

## Assumptions

- Prompt headers are acceptable as the primary selector for task profiles.
- A backend helper alias is sufficient; no new artifact type is required.

## Open Questions

- None.
