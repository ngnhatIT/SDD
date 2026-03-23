---
id: "2026-03-13-task-profile-routing"
title: "Task-profile routing for agent markdown loading design"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/context/ai-loading-order.md"
  - "docs/sdd/context/task-profiles.md"
  - "docs/sdd/governance/"
  - "docs/sdd/templates/task-profile-examples.md"
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: add one canonical task-profile routing document, wire it into agent-loading and governance docs, and provide stable request examples so the agent can select the right markdown set without guessing.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`

## Current State

- The repository defines base loading order and feature-package rules, but not a canonical routing model for different kinds of agent work.
- Prompt phrasing such as "implement", "fix", and "review" is currently interpreted informally.
- Generated spec-packs exist, but the docs do not clearly say when a task should require one versus when it is optional.
- Backend helper notes like `spec_back.md` have no explicit policy.

## Target State

- A `Task Profile` header can select the routing model for an agent request.
- The routing model clearly states which markdown files are required and optional for each profile.
- Governance states that task profiles do not bypass governing feature-package requirements.
- `spec_back.md` is explicitly helper-only and maps to the backend-facing subset of the feature package.

## Design Decisions

### DES-01

- Decision: Define task profiles in a dedicated context file instead of burying them inside one governance rule.
- Why: Routing is an agent-loading concern shared by implementation, fixing, and review.
- Tradeoffs: One more context file must be referenced in the canonical reading order.
- Requirement links: `REQ-01`, `REQ-02`

### DES-02

- Decision: Use a fixed prompt header to select task profiles rather than auto-detecting from free-form wording.
- Why: Explicit selection is more stable and reviewable.
- Tradeoffs: Request authors need to provide a small amount of structure.
- Requirement links: `REQ-02`

### DES-03

- Decision: Keep governance classification separate from task-profile routing.
- Why: A convenient loading profile must not weaken the rule that non-trivial work needs a governing feature package.
- Tradeoffs: Users must understand both the change path and the task profile.
- Requirement links: `REQ-03`

### DES-04

- Decision: Keep `spec-pack` optional by governance, but make it required for `fix-from-pack` and `review-from-pack`.
- Why: Some task profiles intentionally use the generated pack as an execution aid, while others do not need it.
- Tradeoffs: The same feature may be worked in multiple profiles depending on the request.
- Requirement links: `REQ-02`, `REQ-03`

### DES-05

- Decision: Treat `spec_back.md` as helper-only input and define `alias:backend-spec` as shorthand for the backend-facing subset of canonical artifacts.
- Why: Backend-focused work benefits from a compact view, but approval must still point back to `docs/specs/<feature-id>/`.
- Tradeoffs: The alias mapping must be documented clearly to avoid drift.
- Requirement links: `REQ-04`

## Impacted Areas

- Backend: no runtime backend changes
- Frontend: no runtime frontend changes
- Database: no runtime schema or SQL behavior changes
- Integrations: agent request routing for docs and review workflow changes
- Operations: contributors gain a stable request header and task-profile matrix

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Mirror the existing `docs/sdd/` context/governance phrasing, `docs/specs/` feature-package model, and compact example style already used in canonical docs.
- New tables/source families/screen structure in scope: `no`; this feature changes task-routing guidance only.

## Non-Changes

- No runtime code changes
- No new feature-package numbered artifact
- No new spec-pack manifest schema
- No replacement of feature packages as approval source
