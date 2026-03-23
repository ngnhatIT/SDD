---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment requirements"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
---

# Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | `BTCC0080AC` must not raise shared required-validation errors for omitted fields that are optional in the reported BCC0080AC request behavior and map to nullable columns in the current `TAOR55`, `TAOR56`, or `TAOR57` schema entries. |
| `REQ-02` | `BTCC0080AC` must not emit a required-validation error for `templateFlg` when that field is omitted from `mMenuPlans` input. |
| `REQ-03` | Shared or custom required validation must remain on the minimal key fields needed for the current `BTCC0080AC` upsert and delete flows. |
| `REQ-04` | Existing `BTCC0080AC` date-range validation, non-negative validation, DTO shape, SQL flow, and response envelope must remain unchanged outside this required-rule alignment. |

