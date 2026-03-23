---
id: "2026-03-17-sdd-framework-rationalization"
title: "SDD framework rationalization requirements"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
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

- The SDD framework is functionally rich, but authority is spread across overlapping root instructions, canonical docs, additive SDD2+ layers, bridge docs, legacy migration records, and prompt libraries.
- Humans and AI agents can reach correct behavior, but the current structure increases reading load, duplicates rules, and leaves stale or conflicting guidance in navigationally important places.

## In Scope

- audit the current framework structure across `AGENTS.md`, `docs/sdd/`, `docs/specs/README.md`, and `agent/`
- classify each in-scope file with explicit operational criteria
- assign a concrete keep, tighten, merge, drop, or split decision to each in-scope file
- produce a lean target structure and safe migration order
- make safe direct edits that clarify canonical authority, legacy status, or stale historical notes

## Out Of Scope

- runtime product code changes
- codebase-wide standard extraction or rule derivation from implementation files
- speculative removal of legacy bridge files without explicit review of compatibility risk
- tooling rewrites outside documentation updates

## Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | The cleanup must produce a complete file-by-file audit of the current framework scope with explicit evidence-based judgments. |
| `REQ-02` | The cleanup must make canonical sources, policy files, process files, standards, templates, prompts, and legacy bridge artifacts obvious to humans and AI agents. |
| `REQ-03` | Any direct cleanup edits in this branch must be safe, grounded, and limited to changes that reduce ambiguity without breaking current workflow assumptions. |
| `REQ-04` | Risky merges, drops, or structural reductions that need human confirmation must be called out explicitly instead of being guessed through or silently applied. |

## Constraints

- Follow `AGENTS.md`, the canonical `docs/sdd/context/` loading contract, and `docs/specs/README.md`.
- Preserve the governing role of `docs/specs/` and the non-authoritative role of generated spec-packs.
- Respect existing SDD2+ compatibility decisions until a new approved framework decision explicitly changes them.
- Do not invent governance or workflow rules that are not grounded in the repository.
- Do not start repository-wide code review or standards extraction before the framework audit is complete.
