---
id: "2026-03-16-sdd2-plus-framework-upgrade"
title: "SDD2+ additive framework upgrade requirements"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-16"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "README.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Requirements

## Problem

- The repository has a working SDD2 framework, but it does not yet provide a clean additive layer for AI execution aids, evidence-first documentation, feature-level risk tracking, local decision capture, and prompt reuse.

## In Scope

- add new SDD2+ folders and guidance while preserving current SDD2 artifacts
- document agent-agnostic operating rules and prompt starters
- add practical templates and example artifacts for immediate use
- enrich current spec-pack and execution brief tooling without replacing current entrypoints

## Out Of Scope

- product runtime changes
- deletion of existing `docs/sdd/`, `docs/specs/`, or `docs/spec-packs/` artifacts
- mandatory retroactive migration of historical feature packages

## Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | The framework must preserve compatibility with the current SDD2 lifecycle, governance, and feature package structure. |
| `REQ-02` | The framework must add immediately usable SDD2+ documentation for prompts, AI operations, templates, and evidence-first guidance. |
| `REQ-03` | The current spec-pack and execution brief tooling must surface SDD2+ companion artifacts when a feature owns them, without breaking older packages. |
| `REQ-04` | The repository must include one realistic example feature package and a corresponding generated spec-pack that demonstrate the extended framework. |

## Constraints

- Keep all changes additive.
- Keep `docs/specs/` as the approval source of truth.
- Keep `scripts/sdd/` as the active executable tooling surface.
- Write all framework docs so they are usable from Claude, Codex, GitHub Copilot, Cursor, and GPT-class assistants.
