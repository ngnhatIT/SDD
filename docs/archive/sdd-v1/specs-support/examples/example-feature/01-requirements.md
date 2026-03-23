---
id: "example-feature"
title: "SPPM00061 expired-file filter requirements"
owner: "Repository Example"
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

- Users on `SPPM00061` cannot isolate expired attachment records before exporting or reviewing them, which causes manual filtering and easy mismatches between on-screen review and CSV output.

## In Scope

- add an `expiredOnly` search condition to `SPPM00061`
- apply the same condition to search count, search list, and CSV export
- preserve current saved-condition restore behavior
- document the request-contract change and expected screen behavior

## Out Of Scope

- new database tables
- attachment lifecycle changes outside search and export
- asynchronous processing

## Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | The `SPPM00061` screen must let the user filter the result set to expired attachment records only. |
| `REQ-02` | Search count, search list, and CSV export must apply the same expired-only filtering logic. |
| `REQ-03` | The request contract and saved-condition behavior must support the new filter without breaking existing callers that omit it. |
| `REQ-04` | The example feature package, contracts, risk log, decision notes, and generated spec-pack must stay aligned. |

## Constraints

- Reuse the current `SPPM00061` search family and shared CSV export pattern.
- Preserve existing authorization, tenant, and company isolation behavior.
- Treat `expiredOnly` as an additive request field that defaults to `false` when omitted.
- Do not add new table definitions or new screen structure.
