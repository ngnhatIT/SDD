---
id: "<feature-id>"
title: "<feature title> API contract"
owner: "<team or person>"
status: "draft"
last_updated: "YYYY-MM-DD"
related_specs:
  - "02-design.md"
  - "03-data-model.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# API Contract

Canonical numbered template for `04-api-contract.md`.

Use this file when API shape, DTOs, file contracts, integration shape, or compatibility behavior changes.

If the feature owns `contracts/`, add a `Machine-Readable Contract Files` section that lists the exact files under `contracts/`.

## Contract Scope

- Interfaces or endpoints: `<list>`
- Affected consumers: `<list or none>`

## Requests

| Interface | Request Shape | Validation | Notes |
| --- | --- | --- | --- |
| `<ws or file>` | `<summary>` | `<rules>` | `<notes>` |

## Responses And Errors

| Interface | Success Shape | Error Shape | Notes |
| --- | --- | --- | --- |
| `<ws or file>` | `<summary>` | `<summary>` | `<notes>` |

## Compatibility

- Compatibility class: `<additive or behavior-tightening or breaking or internal-only>`
- Affected consumers: `<list or none>`
- Approval or migration notes: `<notes>`

## Machine-Readable Contract Files

- `<contracts/... or none>`
