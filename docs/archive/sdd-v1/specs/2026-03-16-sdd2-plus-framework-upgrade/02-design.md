---
id: "2026-03-16-sdd2-plus-framework-upgrade"
title: "SDD2+ additive framework upgrade design"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: add a new SDD2+ extension layer beside the current SDD2 framework, then wire the new docs and companion artifacts into existing pack and brief tooling.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`

## Current State

- `docs/sdd/` already owns context, governance, process, standards, templates, and checklists.
- `docs/spec-packs/` and `scripts/sdd/` already exist, but they do not surface feature risk or local decision companion artifacts.
- The repository lacks a shared prompt library and a client-agnostic AI operations guide.

## Target State

- `docs/sdd/` keeps the current core but gains `foundation/`, `prompts/`, and `ai-ops/`.
- Governance and specs guidance explicitly support `13-risk-log.md` and `14-decision-notes.md` as additive artifacts.
- Existing spec-pack and execution brief scripts automatically surface those files when present.
- The repository includes one realistic full-path example feature under `docs/specs-support/examples/example-feature/` and a generated pack under `docs/spec-packs/example-feature.pack.md`.

## Impacted Areas

- Backend: `n/a`
- Frontend: `n/a`
- Database: `n/a`
- Integrations: repository documentation and shell-based SDD tooling

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Keep SDD2+ additive so existing SDD2 artifacts remain valid without renaming or deletion. | `REQ-01` |
| `DES-02` | Place compatibility, evidence, and AI execution guidance under `docs/sdd/foundation/`, `docs/sdd/prompts/`, and `docs/sdd/ai-ops/` instead of rewriting the core context layer. | `REQ-02` |
| `DES-03` | Add `13-risk-log.md` and `14-decision-notes.md` as optional SDD2+ companion artifacts for new or upgraded feature packages. | `REQ-02` |
| `DES-04` | Extend the current shell-based spec-pack and execution brief generators so they surface companion artifacts only when the feature owns them. | `REQ-03` |
| `DES-05` | Demonstrate the extended framework with one realistic full-path example feature and generated spec-pack. | `REQ-04` |

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Extend the current documentation structure, spec-pack scripts, and feature package conventions in place instead of introducing a replacement framework.
- New tables/source families/screen structure in scope: `yes` for additive documentation folders and feature companion artifacts; `no` for runtime source families, SQL tables, or application screen structure.

## Non-Changes

- No runtime module refactor
- No product API or DTO behavior change
- No deletion of existing SDD2 documents or scripts
