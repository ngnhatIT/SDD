---
id: "2026-03-13-execution-brief-generator"
title: "Execution-brief generator for task-specific SDD loading design"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "scripts/sdd/build_execution_brief.sh"
  - "docs/spec-packs/2026-03-11-example-customer-export.implement-new.brief.md"
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: add one shell generator next to the existing SDD tooling, compile the execution brief from canonical markdown plus explicit request-scoped flags, and write the generated brief into `docs/spec-packs/`.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`

## Current State

- Task startup context is spread across `AGENTS.md`, `docs/sdd/context/`, `docs/sdd/governance.md`, `docs/specs/README.md`, and the governing feature package.
- The repository has generated spec-packs, but they are feature-wide execution aids rather than task-specific startup briefs.
- Task profile, backend helper, bug source, and review scope are request-scoped concepts that are not compiled into one file today.

## Target State

- `scripts/sdd/build_execution_brief.sh` generates a concise deterministic brief for one feature and one explicit task profile.
- The brief is stored under `docs/spec-packs/` and clearly states that the governing feature package remains authoritative.
- Missing request-scoped or narrative details are surfaced as `unknown (...)` instead of guessed.

## Design Decisions

### DES-01

- Decision: Keep the execution brief as a generated file under `docs/spec-packs/` instead of adding a new canonical artifact inside each feature package.
- Why: The brief is an execution aid and should not compete with the governing feature package.
- Tradeoffs: The brief can drift if users forget to regenerate it.
- Requirement links: `REQ-01`, `REQ-03`

### DES-02

- Decision: Implement the generator as `scripts/sdd/build_execution_brief.sh` in shell rather than introducing a new framework or parser stack.
- Why: Existing SDD tooling already uses shell entrypoints and repo-specific markdown parsing patterns.
- Tradeoffs: Markdown parsing stays intentionally narrow and rule-based.
- Requirement links: `REQ-01`, `REQ-02`

### DES-03

- Decision: Take request-scoped inputs through explicit CLI flags and infer classification from the owned numbered feature files for the first version.
- Why: Task profile and helper inputs are not derivable from repo state alone, while classification can be approximated deterministically from package shape.
- Tradeoffs: The first version does not parse free-form prompts and may need manual flags for fix or review tasks.
- Requirement links: `REQ-02`, `REQ-04`

### DES-04

- Decision: Emit `unknown (...)` for missing decisions, helper inputs, or scope notes rather than synthesizing them.
- Why: The generator must reduce context overhead without introducing false facts.
- Tradeoffs: Some briefs will still contain open gaps that require reading the canonical docs directly.
- Requirement links: `REQ-03`

### DES-05

- Decision: Document the command in `AGENTS.md` and `scripts/sdd/README.md`, and ship one generated sample brief for the reference feature package.
- Why: Reviewers need both the invocation contract and a concrete output sample.
- Tradeoffs: One generated sample file becomes part of repo maintenance.
- Requirement links: `REQ-04`

## Impacted Areas

- Backend: no runtime backend change
- Frontend: no runtime frontend change
- Database: no runtime schema or SQL change
- Tooling: `scripts/sdd/` gains an execution-brief generator
- Documentation: `AGENTS.md`, `docs/specs/README.md`, and `scripts/sdd/README.md` describe the command and non-authoritative brief role

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Mirror the deterministic shell-and-markdown parsing style already used by `scripts/sdd/build_spec_pack.sh` and keep generated execution aids under `docs/spec-packs/`.
- New tables/source families/screen structure in scope: `no`; this feature adds docs and scripting only.

## Non-Changes

- No runtime module behavior changes
- No new machine-readable contract schema
- No change to the governing role of `docs/specs/<feature-id>/`
- No CI enforcement for generated brief freshness
