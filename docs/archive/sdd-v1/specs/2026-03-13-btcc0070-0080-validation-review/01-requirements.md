---
id: "2026-03-13-btcc0070-0080-validation-review"
title: "BTCC0070AC and BTCC0080AC validation review requirements"
owner: "Kikancen API Team"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
---

# Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | Verify `BTCC0070AC` no longer adds duplicate non-negative error for the same `errIndex + itemNm`. |
| `REQ-02` | Verify `BTCC0080AC` date-range validation logic does not conflict with shared format validation rules. |
| `REQ-03` | Record review evidence and conclusion for both modules without changing behavior unless an issue is found. |
