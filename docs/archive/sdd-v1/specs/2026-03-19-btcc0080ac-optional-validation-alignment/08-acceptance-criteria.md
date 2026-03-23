---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment acceptance criteria"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01` | Omitted nullable optional fields in `BTCC0080AC` no longer produce `INFORM_REQUIRE_DATA` validation errors. | Updated `BTCC0080AC` static rule block plus manual/static verification notes |
| `AC-02` | `REQ-02` | `templateFlg` no longer appears as a required-validation error target when omitted from `mMenuPlans`. | Updated static rule block and reproduction-oriented verification note |
| `AC-03` | `REQ-03` | Minimal key validation still exists for current `BTCC0080AC` write/delete keys after the optional-field calibration. | Code inspection evidence with line references |
| `AC-04` | `REQ-04` | Existing date-range validation, non-negative validation, DTO shape, SQL flow, and response envelope remain unchanged outside the intended bug fix. | Code diff plus backend compile or equivalent verification |

