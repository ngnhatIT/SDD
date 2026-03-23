---
id: "2026-03-13-spec-graph-extractor"
title: "First-pass spec graph extractor for feature packages design"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "scripts/sdd/build_spec_graph.sh"
  - "docs/specs-support/examples/2026-03-11-example-customer-export/spec.graph.yaml"
  - "docs/specs/2026-03-13-task-profile-routing/spec.graph.yaml"
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: add one shell extractor under `scripts/sdd/`, emit `spec.graph.yaml` into the selected feature package, and record explicit uncertainty in the graph output for anything the markdown does not state clearly.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`

## Current State

- The repository already has stable `REQ`, `DES`, `TASK`, `AC`, and `TC` conventions plus feature metadata and scope sections.
- Many cross-file links are explicit in `README.md`, `07-tasks.md`, `08-acceptance-criteria.md`, and `09-test-cases.md`.
- Contract links, entity links, and touched-component links are only partly explicit and often remain narrative.

## Target State

- `scripts/sdd/build_spec_graph.sh` generates a deterministic `spec.graph.yaml` from existing feature markdown.
- The graph captures the explicit parts of the feature model and calls out manual authoring gaps where the markdown is not yet structured enough.
- The repository includes generated examples for both a full-path and a reduced-path feature package.

## Design Decisions

### DES-01

- Decision: Emit `spec.graph.yaml` beside the feature package as a companion artifact instead of replacing numbered markdown files.
- Why: The markdown package remains the approval source of truth.
- Tradeoffs: The graph can drift unless regeneration becomes part of later workflow.
- Requirement links: `REQ-01`, `REQ-03`

### DES-02

- Decision: Implement the extractor in shell with repo-local markdown parsing rules rather than introducing a new language runtime or parser framework.
- Why: Existing SDD tooling already uses shell and awk, and the first pass should stay easy to review.
- Tradeoffs: The parser stays narrow and convention-dependent.
- Requirement links: `REQ-01`, `REQ-02`

### DES-03

- Decision: Extract only explicit relations from current tables and headings, and record anything else under warnings or manual authoring notes.
- Why: Current markdown does not make every high-value relation machine-checkable.
- Tradeoffs: The first graph will be intentionally incomplete for contract-to-requirement, entity-to-task, and touched-component relations.
- Requirement links: `REQ-02`, `REQ-03`

### DES-04

- Decision: Support both table-style and heading-style `REQ` and `DES` sections in the first extractor.
- Why: Current feature packages already use both patterns.
- Tradeoffs: The extraction logic is slightly more complex, but still bounded to current conventions.
- Requirement links: `REQ-02`, `REQ-04`

### DES-05

- Decision: Generate example graphs for `2026-03-11-example-customer-export` and `2026-03-13-task-profile-routing`.
- Why: Those two features exercise full-path versus reduced-path shape and table-style versus heading-style source patterns.
- Tradeoffs: The sample set is intentionally small and not yet representative of every legacy variation.
- Requirement links: `REQ-04`

## Impacted Areas

- Backend: no runtime backend change
- Frontend: no runtime frontend change
- Database: no runtime schema or SQL change
- Tooling: `scripts/sdd/` gains a graph extractor
- Documentation: command guidance and limitations note describe the extractor boundary

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Mirror the deterministic shell-and-markdown parsing style already used by the existing SDD scripts and keep the graph explicitly non-authoritative.
- New tables/source families/screen structure in scope: `no`; this feature changes docs and tooling only.

## Non-Changes

- No runtime module behavior changes
- No new validator gate or CI integration
- No automatic inference of narrative-only relationships
- No rewrite of the current feature-package authoring model
