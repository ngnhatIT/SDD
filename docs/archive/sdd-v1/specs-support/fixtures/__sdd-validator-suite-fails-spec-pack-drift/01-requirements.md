---
id: "fixture-valid-full-path"
title: "Full path validator fixture requirements"
owner: "SDD Test Suite"
status: "ready-for-implementation"
last_updated: "2026-03-13"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies: []
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Requirements

## Problem

- The validator needs a small full-path package with contracts and a generated spec-pack.

## In Scope

- One export endpoint
- One audit record shape

## Out Of Scope

- Shared refactors
- UI redesign

## Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | The fixture export endpoint returns a CSV stream for one authorized request path. |
| `REQ-02` | The fixture keeps machine-readable contracts and the generated spec-pack aligned with the prose package. |

## Constraints

- Keep the fixture compact.
- Keep all contract references explicit.
