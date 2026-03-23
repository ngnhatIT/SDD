---
id: "SPMT00141"
title: "SPMT00141 api contract"
owner: "WMS Delivery Team"
status: "blocked"
last_updated: "2026-03-18"
related_specs:
  - "02-design.md"
  - "03-data-model.md"
  - "05-behavior.md"
dependencies:
  - "02-design.md"
  - "03-data-model.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spmt00141init/webservice/Spmt00141initWebService.java"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141register/webservice/Spmt00141RegisterWebService.java"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141update/webservice/Spmt00141UpdateWebService.java"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/webservice/Spmt00141GetDetailWebService.java"
test_refs:
  - "09-test-cases.md"
---

# API Contract

## Contract Status

- Existing family services remain the baseline.
- The requested changes affect init, detail, register, update, and one new copy action.
- Implementation is blocked until schema authority is aligned.
- This document defines the contract deltas that must be reviewed before code changes start.

## Existing Family Services

| Service family | Current status | Requested delta |
| --- | --- | --- |
| `Spmt00141Init` | Exists | Extend master-data payload for `3087`, `3096`, `3097` and align reserve types to `3062/3063/3064` |
| `Spmt00141SearchCnt` | Exists | No requested payload change in this package |
| `Spmt00141Search` | Exists | No requested payload change in this package unless current reserve type display resolution depends on corrected master sources |
| `Spmt00141GetDetail` | Exists | Return the four requested fields and stop driving UI behavior from `productCdManual` |
| `Spmt00141Register` | Exists | Do not trust client-generated `PRODUCTCD`; accept the new fields; return enough data to reload the created record |
| `Spmt00141Update` | Exists | Accept the new fields; keep `PRODUCTCD` as key; preserve `PRODUCTCDHANDMADE` |
| `Spmt00141Delete` | Exists | No contract change requested |
| `SPMT00141 copy action` | Missing | Add one family-consistent action for copy after approval of naming and schema authority |

## Request and Response Delta

### Init

- Response must expose master lists for:
  - reserve type `3062`
  - reserve type `3063`
  - reserve type `3064`
  - expiration date management `3087`
  - inventory management pattern `3096`
  - urgent deadline category `3097`
- Existing master payload shapes should be preserved.

### Get Detail

- Response must include:
  - persisted `PRODUCTCD`
  - audit fields already used by the current UI
  - the four requested fields
- UI must no longer depend on a manual-code input field.
- If legacy records contain `PRODUCTCDHANDMADE`, the backend may preserve that value internally but the canonical UI contract does not expose it as an editable field.

### Register

- Request must carry the editable business fields including the four requested additions.
- Request must not rely on the client to provide the persisted `PRODUCTCD`.
- Response must make it possible for the frontend to reload the created record in update mode.
- Register must persist `PRODUCTCDHANDMADE = NULL`.

### Update

- Request must carry the current persisted `PRODUCTCD` as the target key.
- Request must carry the four requested additions.
- Update must not overwrite existing `PRODUCTCDHANDMADE` with blank UI data.
- Response may remain lightweight if the frontend reloads detail after save, but the current component contract must support loading the saved record.

### Copy

- A new copy contract is required in the `SPMT00141` family.
- The copy request source is the current input-area business payload for a persisted record.
- Copy must validate like save, create a new row, set `PRODUCTCDHANDMADE = NULL`, and not copy related-table data.
- Copy response must make it possible for the frontend to reload the inserted row in update mode.
- Exact webservice token and route naming remain subject to local family review and are not frozen by this package while authority conflicts remain open.

## Validation Expectations

- Frontend and backend must enforce the same conditional rules for:
  - misc-code-target dependent required fields
  - specification acquisition date requirements
  - `INVENTORYUNITCONVERSION` numeric format and positivity
- Business validation must not be weakened relative to the current family.

## Contract Risks

- The contract cannot be finalized into machine-readable schemas while schema authority is incomplete.
- The copy route name is intentionally left unfrozen to avoid inventing an external token before review.
