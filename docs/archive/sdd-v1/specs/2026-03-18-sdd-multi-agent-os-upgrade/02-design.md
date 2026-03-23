# Design

## Overview

This design satisfies `REQ-01` through `REQ-08` by compressing the live SDD path into a smaller canonical stack, moving repeated operating logic into contracts and profiles, and relocating non-canonical history or support packages out of the approval tree.

## Current State

The current SDD has strong repository discipline but weak operational compression. Routing logic is duplicated across `AGENTS.md`, `context/`, and multiple prompt files. Prompts restate governance instead of adapting to agent behavior. Spec authoring is treated as one prompt plus the feature-package template rather than as a governed workflow. Repeated implementation and review rules live in too many places, which makes enforcement noisy and easy to skip.

## Target State

The upgraded SDD exposes a clear operating stack:

1. Governance remains canonical and authoritative.
2. Execution becomes a first-class layer with routing and minimum execution contracts.
3. Agent profiles define how Codex, Claude, and GitHub Copilot should consume the same system safely.
4. Prompt files become thin intent adapters instead of second workflow manuals.
5. Spec authoring becomes a governed workflow with raw-input normalization and explicit authoring gates.
6. Shared enforcement checklists remove repeated fragile rules from scattered prompts and stage docs.

## Design Decisions

## Design Traceability

| Design ID | Summary | Requirement Links |
| --- | --- | --- |
| `DES-01` | Keep governance and authority canonical while adding clearer execution layers. | `REQ-01`, `REQ-07`, `REQ-08` |
| `DES-02` | Move routing to one execution surface and keep older routing docs as bridges only. | `REQ-02`, `REQ-07`, `REQ-08` |
| `DES-03` | Define short execution contracts with explicit inputs, reads, outputs, and stop rules. | `REQ-02` |
| `DES-04` | Add separate Codex, Claude, and GitHub Copilot profiles. | `REQ-03` |
| `DES-05` | Make spec authoring a governed workflow with normalization and review gates. | `REQ-05` |
| `DES-06` | Centralize fragile repeated rules in a shared enforcement checklist. | `REQ-06` |
| `DES-07` | Reduce prompts to thin adapters that point to contracts and profiles. | `REQ-04`, `REQ-08` |
| `DES-08` | Move non-canonical examples, fixtures, and historical cleanup records off the live approval path while keeping tooling support. | `REQ-07`, `REQ-08` |

### DES-01 Canonical Layers

Keep authority in `AGENTS.md`, `docs/sdd/context/`, `docs/sdd/governance.md`, and `docs/sdd/governance/`. Add the following active layers under `docs/sdd/`:

- `execution/`
- `execution-profiles/`
- `spec-authoring/`
- `reports/`

### DES-02 Canonical Routing Move

Create `docs/sdd/execution/task-routing.md` as the canonical routing surface for task profiles, practical modes, prompt entrypoints, deliverables, and escalation boundaries.

Keep `docs/sdd/context/task-profiles.md` and `docs/sdd/context/task-mode-matrix.md` only as compatibility bridges pointing back to `execution/task-routing.md`.

### DES-03 Minimum Execution Contracts

Create `docs/sdd/execution/contracts/` for the task families:

- `create-spec`
- `generate-spec-pack`
- `implement-feature`
- `review-feature`
- `fix-from-review`
- `recover-context`
- `generate-execution-brief`

Each contract owns:

- required inputs
- required reads
- optional support reads
- forbidden assumptions
- expected outputs
- stop conditions

### DES-04 Multi-Agent Profiles

Create `docs/sdd/execution-profiles/` with separate operating profiles for Codex, Claude, and GitHub Copilot.

The profiles define:

- best-fit tasks
- failure modes
- loading strategy
- how aggressively to chunk work
- how strictly to rely on contracts and checklists
- when to stop and ask
- what output format is expected

### DES-05 Spec Authoring Layer

Create `docs/sdd/spec-authoring/` with:

- a governed workflow
- raw-input normalization rules
- output requirements
- review rules

Create `docs/sdd/checklists/spec-authoring-checklist.md` so authoring becomes executable rather than advisory.

### DES-06 Shared Enforcement Checklist

Create `docs/sdd/checklists/touched-scope-enforcement.md` as the shared enforcement surface for hygiene, parity, reuse, and schema-binding checks.

Update self-review, implementation-completion, review, done, and AI checklists to call this shared checklist instead of restating the same rules independently.

### DES-07 Thin Prompt Architecture

Keep the existing top-level prompt filenames for backward compatibility, but rewrite them so they point to:

- the relevant execution contract
- the selected agent profile
- the canonical task header

Reduce `MASTER_ROUTINE.md`, `daily-operator-guide.md`, and `quick-guide.md` to prompt-selection and routing entrypoints rather than full duplicated operating manuals.

### DES-08 Physical Support And History Separation

Keep `docs/specs/` for governed approval-source packages only.

Move:

- support examples to `docs/specs-support/examples/`
- validator fixtures to `docs/specs-support/fixtures/`
- historical migration and cleanup records to `docs/archive/sdd/history/`
- review-only leftovers to `docs/archive/reviews/`

Update the SDD helper scripts so the repository can still build packs, briefs, graphs, and validations from both canonical and support package roots.

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: `docs-only framework refactor; preserve authority order, numbered feature-package model, and non-authoritative status of generated aids`
- New tables/source families/screen structure in scope: `no`

## Documentation Anchor Files

- `AGENTS.md`
- `docs/README.md`
- `docs/sdd/README.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/governance.md`
- `docs/specs/README.md`
- `docs/sdd/prompts/README.md`
- `docs/sdd/checklists/README.md`
- `docs/sdd/templates/README.md`

## Compatibility Plan

- Keep existing prompt filenames, but make them thin and non-authoritative.
- Keep existing context routing filenames as compatibility bridges.
- Preserve archived history as history, not as live guidance.
- Allow support examples and fixtures to keep stable generated outputs without remaining inside `docs/specs/`.

## Risks To Control

- broken cross-links after moving the canonical path
- partial migration where old routing docs still look authoritative
- adding new layers without actually removing duplicated rules from the active path
