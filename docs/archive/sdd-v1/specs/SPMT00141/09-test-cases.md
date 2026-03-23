---
id: "SPMT00141"
title: "SPMT00141 test cases"
owner: "WMS Delivery Team"
status: "blocked"
last_updated: "2026-03-18"
related_specs:
  - "08-acceptance-criteria.md"
  - "06-edge-cases.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs: []
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01`, `AC-07` | UI / integration | Open `SPMT00141` and inspect init payload plus rendered form state. | `PRODUCTCD` is readonly, manual-code input is absent, reserve types use `3062/3063/3064`, and new dropdown masters are available. |
| `TC-02` | `AC-01`, `AC-02` | UI | Click `New` and inspect the detail area before save. | The form enters register mode, `PRODUCTCD` is blank readonly, copy is disabled, and new fields are available. |
| `TC-03` | `AC-02`, `AC-06` | Integration / database | Register a valid new product with all in-scope fields populated. | Backend generates a new `PRODUCTCD`, persists the requested fields, sets `PRODUCTCDHANDMADE = NULL`, and the UI reloads the created record in update mode. |
| `TC-04` | `AC-05`, `AC-06` | Validation | Submit invalid conditional combinations and invalid `INVENTORYUNITCONVERSION` from both UI and direct request paths. | Frontend and backend reject the same invalid states. |
| `TC-05` | `AC-03`, `AC-07` | Integration / database | Load a historical row that already has `PRODUCTCDHANDMADE`, update another field, and save. | The row keeps the same `PRODUCTCD`, preserves `PRODUCTCDHANDMADE`, and saves only the intended changes. |
| `TC-06` | `AC-04` | Integration / database | Load an existing record in update mode and execute copy. | One new row is inserted with a new `PRODUCTCD`, `PRODUCTCDHANDMADE = NULL`, the source row remains unchanged, and the UI reloads the new row. |
| `TC-07` | `AC-05`, `AC-06` | UI / integration | Exercise dynamic validation around misc-code-target and specification acquisition date states, including new dropdown selections. | Required markers and backend validation responses remain consistent with the requested rules. |
| `TC-08` | `AC-07` | Regression | Run smoke checks for search, delete, and CSV entry points after the change. | No behavior regression appears outside the approved scope. |
| `TC-09` | `AC-08` | Documentation / governance | Review the approved `KANRIKBN` selector for `TAMT050_PRODUCTNUMBERING` before implementation starts. | The selector is either approved in authority artifacts or implementation remains stopped. |

## Test Data Notes

- Include at least one historical product row with non-null `PRODUCTCDHANDMADE`.
- Include at least one row that can exercise the current specification acquisition status rules.
- Prepare valid code values for `3087`, `3096`, and `3097` after schema and master-data authority is confirmed.
