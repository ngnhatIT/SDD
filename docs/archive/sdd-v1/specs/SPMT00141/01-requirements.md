---
id: "SPMT00141"
title: "SPMT00141 requirements"
owner: "WMS Delivery Team"
status: "blocked"
last_updated: "2026-03-18"
related_specs:
  - "README.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "README.md"
  - "docs/spec-packs/SPMT00141.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Requirements

## Problem

- Current pain: the live `SPMT00141` family still treats `PRODUCTCD` as user-entered data, still exposes `PRODUCTCDHANDMADE` semantics in the contract, and does not implement the requested copy flow or the four requested fields.
- Desired outcome: the screen keeps its current family structure while changing only the requested behavior for generated codes, copy, new fields, and validation parity.

## Scope

### In Scope

- Existing `SPMT00141` initial display, search, detail load, register, update, delete, and new-mode flow
- New copy behavior from the loaded detail record
- `PRODUCTCD` generation on register and copy
- Removal of manual-code UI handling
- Four requested new input fields and their validation/master data requirements
- Documentation of blocking schema authority conflicts

### Out Of Scope

- CSV behavior changes
- Any new database schema design that is not explicitly approved in `schema_database.yaml`
- Clarifying unspecified legacy joins or unrelated button navigation
- Data migration or backfill rules for historical records

## Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | Keep the current `SPMT00141` screen family shape, search/list/detail structure, and unchanged legacy behaviors unless the request explicitly changes them. |
| `REQ-02` | In new mode, the input area must show `PRODUCTCD` as blank and readonly, and the backend must generate the persisted `PRODUCTCD` only when register is confirmed. |
| `REQ-03` | Add a copy action that is available only from a loaded update record, validates like save, confirms with the user, inserts one new `TMT026_PRODUCT` row, and reloads the inserted row into update mode. |
| `REQ-04` | Remove manual `PRODUCTCD` entry from the input form, stop exposing editable `PRODUCTCDHANDMADE` behavior to the user, set `PRODUCTCDHANDMADE = NULL` on register and copy, and preserve the existing stored value during update. |
| `REQ-05` | Carry the four requested fields end-to-end for init, detail load, register, and update: `URGENTDEADLINECATEGORY`, `EXPIRATIONDATEMANAGEMENT`, `INVENTORYMANAGEMENTPATTERN`, and `INVENTORYUNITCONVERSION`. |
| `REQ-06` | Enforce the requested dynamic validation in both frontend and backend for misc-code-target dependent fields, specification acquisition date requirements, and `INVENTORYUNITCONVERSION` numeric acceptance. |
| `REQ-07` | Align the affected master data sources with the request, including reserve type dropdowns `3062/3063/3064` and new dropdowns `3087/3096/3097`, while leaving unaffected search and CSV behaviors unchanged. |
| `REQ-08` | Use one transaction for numbering and insert behavior so a failed insert rolls back the sequence update, and do not implement this path until the `KANRIKBN` selector rule for `TAMT050_PRODUCTNUMBERING` is approved. |

## Constraints

- `docs/sdd/context/schema_database.yaml` is the single source of truth for database structure.
- The request does not authorize inventing new API names, route keys, schema columns, or fallback rules that are not supported by approved artifacts.
- The unresolved `KANRIKBN` selection rule for numbering must be treated as an open question, not guessed in code.
- CSV import/export behavior, related-table copy behavior, and unspecified legacy joins remain unchanged unless a higher-authority artifact says otherwise.

## Open Questions

- What is the approved `KANRIKBN` filter for `TAMT050_PRODUCTNUMBERING`?
- Which `KANRIKBN` literal is approved for `SPMT00141` product numbering?
- Does the future copy contract return the inserted `PRODUCTCD` only or a full detail payload? Current package assumes at least the inserted key is needed so the frontend can reload detail.
