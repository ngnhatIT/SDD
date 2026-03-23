---
id: "2026-03-13-sdd-governance-hardening"
title: "SDD governance hardening for source-base anchors and style parity design"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "docs/sdd/governance.md"
  - "docs/sdd/checklists/"
  - "docs/sdd/templates/"
  - "scripts/sdd/build_spec_pack.sh"
  - "scripts/sdd/validate_specs.sh"
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: update repository standards, governance, checklists, templates, sample specs, and shell tooling so they all enforce the same source-base anchor and scope-parity contract.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`

## Current State

- `AGENTS.md` already requires source-base anchors before coding, but downstream docs and scripts do not enforce that requirement consistently.
- Spec-pack output lists implementation constraints, but does not surface anchor data, scope guardrails, or traceability snapshots clearly.
- `validate_specs.sh` currently requires a manifest and checks only a small set of markers, so non-manifest features and incomplete design packages are not validated meaningfully.

## Target State

- `02-design.md` uses one parseable `Source Base Anchors` block with fixed labels.
- Governance and checklists fail when anchors, scope notes, or parity checks are missing.
- Generated spec-packs include anchor, scope, traceability, and implementation-constraint sections.
- Validation works for all feature packages and applies manifest-specific checks only when a manifest exists.

## Design Decisions

### DES-01

- Decision: Make the `Source Base Anchors` section in `02-design.md` parseable through fixed labels rather than free-form prose.
- Why: This gives both reviewers and scripts one stable structure.
- Tradeoffs: Authors must follow a stricter section format.
- Requirement links: `REQ-01`, `REQ-02`

### DES-02

- Decision: Harden existing governance, checklist, and template files instead of introducing a parallel rule set.
- Why: The repository already has the right operating model; the gap is enforcement consistency.
- Tradeoffs: Multiple existing docs need coordinated edits.
- Requirement links: `REQ-01`, `REQ-03`

### DES-03

- Decision: Keep validator checks at a semantic minimum rather than exact template lockstep.
- Why: Existing feature packages vary in heading shapes, and the goal is safe enforcement without unnecessary retrofit churn.
- Tradeoffs: Validation remains lighter than a strict schema validator.
- Requirement links: `REQ-02`, `REQ-03`

### DES-04

- Decision: Keep manifest schema unchanged and apply manifest or generated-pack checks only when the feature owns a manifest.
- Why: This expands validation coverage without widening feature-package requirements.
- Tradeoffs: Manifest-less features still rely on prose plus semantic checks instead of pack generation.
- Requirement links: `REQ-03`

### DES-05

- Decision: Retrofit repository sample specs that would fail the new contract, starting with the customer export pack and the repository bootstrap design.
- Why: Repository examples must remain usable as references and verification targets.
- Tradeoffs: A small amount of sample documentation churn is required.
- Requirement links: `REQ-04`

## Impacted Areas

- Backend: no runtime backend code changes; shell tooling under `scripts/sdd/` changes
- Frontend: no runtime frontend code changes
- Database: no runtime schema or SQL behavior changes
- Integrations: spec-pack generation and validation workflow changes
- Operations: repository contributors and reviewers receive stricter pre-implementation and review gates

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Mirror the current `docs/sdd/` markdown structure, checklist phrasing, template front matter shape, and shell conventions already present in `scripts/sdd/build_spec_pack.sh` and `scripts/sdd/validate_specs.sh`.
- New tables/source families/screen structure in scope: `no`; this feature changes repository governance artifacts and spec tooling only.

## Non-Changes

- No runtime application behavior changes
- No new spec-pack manifest keys
- No new `agent/` guidance
- No new repository documentation subsystem outside the existing `docs/sdd/`, `docs/specs/`, `docs/spec-packs/`, and `scripts/sdd/` locations
