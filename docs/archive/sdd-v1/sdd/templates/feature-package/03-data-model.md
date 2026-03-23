---
id: "<feature-id>"
title: "<feature title> data model"
owner: "<team or person>"
status: "draft"
last_updated: "YYYY-MM-DD"
related_specs:
  - "02-design.md"
  - "04-api-contract.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Data Model

Canonical numbered template for `03-data-model.md`.

Use this file when schema, field, lifecycle, persistence, or state rules matter.

## Data Scope

- Tables or entities: `<list>`
- State or lifecycle areas: `<list>`

## Data Changes

| Area | Current | Target | Notes |
| --- | --- | --- | --- |
| `<table or entity>` | `<today>` | `<after change>` | `<notes>` |

## Integrity And Guard Rules

- Tenant or company guards: `<rules>`
- Existence or `DELFLG` guards: `<rules>`
- Audit column expectations: `<rules>`
- Rollback or recovery notes: `<notes>`

## Compatibility And Migration Notes

- Compatibility class: `<additive or behavior-tightening or breaking or internal-only>`
- Affected consumers: `<list or none>`
- Backfill or migration steps: `<steps or none>`
