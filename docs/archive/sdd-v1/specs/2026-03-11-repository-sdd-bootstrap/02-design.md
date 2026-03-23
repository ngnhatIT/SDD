# Design

## Overview

Create one tracked documentation system rooted at `docs/`, then wire repo entrypoints so the normal change flow starts there instead of in ad hoc notes or code-only implementation.

## Current State

- top-level `README.md` is minimal
- no tracked `docs/` folder exists
- no tracked ADR area exists
- no tracked spec workspace exists
- no tracked changelog exists
- local-only `agent/agent/` notes provide useful ideas but are not a durable repo source of truth

## Target State

- `docs/` becomes the tracked documentation home
- `docs/specs/<change-id>/` becomes the unit of change
- `docs/sdd/` holds the operating playbook, templates, standards, and checklists
- `docs/decisions/` holds cross-cutting decisions
- `CHANGELOG.md` records released or releasable history
- `.github/PULL_REQUEST_TEMPLATE.md` pushes reviewers to verify spec linkage

## Design Decisions

### DES-01

- Decision: Use one canonical tracked documentation tree under `docs/`.
- Why: A single home reduces duplication and makes the workflow discoverable.
- Tradeoffs: More files are introduced up front.
- Requirement links: REQ-01

### DES-02

- Decision: Model every meaningful change as a numbered feature package with `README.md`, `01-requirements.md`, `02-design.md`, `07-tasks.md`, `08-acceptance-criteria.md`, `09-test-cases.md`, and `10-rollout.md`, plus conditional files when data, contracts, behavior, or edge handling change.
- Why: This gives each change an ordered, reviewable spec package with explicit traceability.
- Tradeoffs: Even small changes now require a compact but real document set.
- Requirement links: REQ-02, REQ-03

### DES-03

- Decision: Keep governance lightweight but enforceable through documented stage gates, checklists, ADRs, and a PR template.
- Why: The repository needs practical behavior change without waiting for CI work.
- Tradeoffs: Enforcement is partly social until automation is added.
- Requirement links: REQ-02, REQ-03

### DES-04

- Decision: Reuse the best ideas from local `agent/agent/` notes by normalizing them into tracked SDD docs instead of copying them verbatim.
- Why: This keeps useful knowledge while avoiding a second documentation system.
- Tradeoffs: Some draft local notes will temporarily remain beside the new source of truth.
- Requirement links: REQ-04

## Impacted Areas

### Backend

- No runtime backend changes

### Frontend

- No runtime frontend changes

### Database

- No schema or SQL changes

### Integrations

- GitHub review workflow gains a PR template

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Mirror the existing `docs/sdd/` markdown structure, numbered feature-package format, and lightweight shell tooling style already present in the repository.
- New tables/source families/screen structure in scope: `no`; this bootstrap feature governs repository delivery artifacts only.

## Data Flow

- Request enters through a change folder in `docs/specs/`
- Stage gates are governed by `docs/sdd/`
- Cross-cutting decisions are stored in `docs/decisions/`
- Completed outcomes are logged in `CHANGELOG.md`

## Failure Handling

- If requirements are incomplete, the change must stop in the requirements stage.
- If design choices affect future work broadly, an ADR must be added before review completes.
- If code and spec drift, the spec must be updated before the review is considered complete.

## Alternatives Considered

- Keep the old local `agent/agent/` material as the main system: rejected because it is untracked and not team-facing.
- Create a very large process framework with many specialized folders: rejected because it would be harder to adopt in a legacy repo.

## Rollout Notes

- The bootstrap change folder acts as the first concrete example.
- Existing local notes are migrated into canonical `docs/sdd/` content and can then be removed.
