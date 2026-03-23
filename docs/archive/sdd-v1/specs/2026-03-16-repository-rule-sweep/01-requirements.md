---
id: "2026-03-16-repository-rule-sweep"
title: "Repository-wide rule sweep requirements"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "02-design.md"
  - "07-tasks.md"
dependencies: []
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Requirements

## Problem

- Review findings and live implementation show repeated risks around sibling SQL drift, duplicated frontend or backend validation drift, silent frontend transport failures, contract-by-implementation APIs, and weak test evidence in areas with no automated tests.

## In Scope

- Rules derived from shared backend process and API foundations
- Rules derived from shared frontend base and transport foundations
- Rules derived from representative API export or import, search, CSV, and review-report evidence
- Review and QA guardrails for contract gaps and missing automated tests

## Out Of Scope

- Runtime feature changes
- New layering abstractions not already used in this repository
- Enforcing repo-wide normalization where live code is still inconsistent

## Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | Root operating rules must add cross-layer parity and sibling-flow parity checks that match the actual repository structure. |
| `REQ-02` | Backend standards must formalize the need to preserve filter and guard parity across sibling process flows that touch the same table family. |
| `REQ-03` | Frontend standards must formalize transport error-handling and frontend or backend validation-parity guardrails without inventing a new frontend architecture. |
| `REQ-04` | Validation standards must state how duplicated frontend and backend validation is handled so review can catch drift. |
| `REQ-05` | Code-review checklist items must cover the repeated risks found in review reports: sibling-flow SQL drift, silent catches, cross-layer validation drift, and undocumented contract gaps. |
| `REQ-06` | QA and review guidance must require explicit manual regression evidence when automated tests are absent in the touched area. |

## Constraints

- Only add rules supported by repeated code patterns, repeated review findings, or repository-wide architectural boundaries.
- Do not promote one-off local conventions into repo-wide mandates.
- Do not require immediate machine-readable contracts or automated tests for legacy areas that do not already own them.
