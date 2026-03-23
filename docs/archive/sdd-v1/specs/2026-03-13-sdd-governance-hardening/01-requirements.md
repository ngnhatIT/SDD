---
id: "2026-03-13-sdd-governance-hardening"
title: "SDD governance hardening for source-base anchors and style parity requirements"
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
  - "docs/sdd/"
  - "scripts/sdd/"
test_refs:
  - "09-test-cases.md"
---

# Requirements

## Problem Statement

The repository requires source-base anchors, dominant local pattern reuse, and traceable spec-driven delivery, but those requirements are not yet enforced consistently across rules, checklists, templates, spec-pack generation, and validation scripts.

## Scope

### In Scope

- Make source-base anchors explicit and parseable in design docs.
- Make pre-implementation and review gates fail when anchor, style parity, scope parity, or contract parity information is missing.
- Make generated spec-packs surface implementation constraints around source-base, style, and scope.
- Make validation work for all feature packages while keeping manifest checks conditional.

### Out Of Scope

- Changing application runtime flows
- Introducing new spec-pack manifest keys
- Rewriting legacy runtime modules to fit a new structure
- Adding CI integration

## Requirements

### REQ-01

- Statement: Repository governance and standards must require explicit source-base anchors and style or scope parity constraints before implementation begins.
- Rationale: Authors and reviewers need one stable contract instead of scattered prose hints.
- Source: `AGENTS.md` operating rules

### REQ-02

- Statement: Design authoring guidance must require a parseable anchor block with fixed labels so scripts and reviewers can consume the same structure.
- Rationale: Tooling cannot enforce anchor rules reliably if the structure changes per feature.
- Source: governance hardening request

### REQ-03

- Statement: Spec-pack generation and validation must surface and check source-base anchors, scope guardrails, traceability, and implementation constraints without forcing manifests on every feature package.
- Rationale: Repo tooling should reinforce governance instead of only summarizing files.
- Source: governance hardening request

### REQ-04

- Statement: Repository sample artifacts must remain valid under the hardened rules and scripts.
- Rationale: Reference examples should demonstrate the current contract instead of silently failing it.
- Source: repository maintainability requirement

## Constraints

- Preserve the current manifest schema for `spec-pack.manifest.yaml`.
- Keep validation semantic enough to tolerate current feature-package variations where possible.
- Do not invent runtime behavior, schema rules, or screen structure changes.
- Keep the scope limited to governance, templates, sample specs, and spec tooling.

## Assumptions

- Git for Windows `sh.exe` is available even though bare `sh` is not on `PATH`.
- Existing sample feature packages can be retrofitted with minimal changes instead of a repository-wide rewrite.

## Open Questions

- None.
