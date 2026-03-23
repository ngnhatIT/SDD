---
id: "SPMT00141"
title: "SPMT00141 design"
owner: "WMS Delivery Team"
status: "blocked"
last_updated: "2026-03-18"
related_specs:
  - "01-requirements.md"
  - "03-data-model.md"
  - "04-api-contract.md"
  - "05-behavior.md"
  - "06-edge-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spmt00141init/process/Spmt00141initProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/process/Spmt00141GetDetailProcess.java"
  - "src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts"
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

Adapt the existing `SPMT00141` screen family instead of creating a new module. The frontend stays in the current component and webservice pattern. The backend keeps the current `webservice -> process -> SQL builder` structure. The requested changes are limited to generated `PRODUCTCD`, copy, four new fields, dropdown alignment, and dynamic validation parity.

- Requirement links: `REQ-01` to `REQ-08`

## Current State

- The screen already supports init, search, detail load, register, update, and delete.
- The current frontend still exposes editable/manual `PRODUCTCD` behavior and does not have a copy action.
- The current backend register flow reads `productCd` from the request and current update logic still overwrites `PRODUCTCDHANDMADE`.
- The current init and shared constants do not fully align with the requested master codes.
- The requested numbering table is now present in schema authority, but the `KANRIKBN` selector rule remains unresolved.

## Target State

- New mode shows a blank readonly `PRODUCTCD`.
- Register and copy generate `PRODUCTCD` in the backend persistence path, not on the frontend.
- Copy inserts exactly one new `TMT026_PRODUCT` row and reloads the inserted row into update mode.
- Update preserves the persisted `PRODUCTCD` and existing `PRODUCTCDHANDMADE`.
- The four requested fields are available in init, detail, register, and update contracts.
- Dynamic validation is enforced in both layers.
- Implementation remains blocked until schema authority is aligned.

## Impacted Areas

| Area | Impact |
| --- | --- |
| Frontend component | Remove manual-code editing, add copy control/state, add four new fields, update save/reload behavior |
| Frontend shared constants | Align reserve type master codes and add the missing master code constant for `3096` |
| Backend init | Load additional master data and correct reserve type sources |
| Backend detail/register/update | Carry the four requested fields, preserve `PRODUCTCDHANDMADE` on update, and stop trusting client-generated `PRODUCTCD` |
| Backend family expansion | Add one copy action in the existing family pattern |
| Database authority docs | Resolve the `KANRIKBN` selector rule before implementation |

## Source Base Anchors

- Backend process anchors:
  - `src/main/java/jp/co/brycen/kikancen/spmt00141init/process/Spmt00141initProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/process/Spmt00141GetDetailProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141search/process/Spmt00141SearchAllRecProcess.java`
- Backend webservice anchors:
  - `src/main/java/jp/co/brycen/kikancen/spmt00141init/webservice/Spmt00141initWebService.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141register/webservice/Spmt00141RegisterWebService.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141update/webservice/Spmt00141UpdateWebService.java`
  - `src/main/java/jp/co/brycen/kikancen/spmt00141getdetail/webservice/Spmt00141GetDetailWebService.java`
- Frontend anchors:
  - `src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts`
  - `src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.html`
  - `src/main/webapp/angular/src/app/common/Const.ts`
  - `src/main/webapp/angular/src/app/common/ConstCcd.ts`
  - `src/main/webapp/angular/src/app/common/ConstCcdDef.ts`
- Copy-pattern anchors for local convention only:
  - `src/main/webapp/angular/src/app/components/spmt01101ac/spmt01101ac.component.ts`
  - `src/main/webapp/angular/src/app/components/spor00701ac/spor00701ac.component.ts`

## Design Decisions

| ID | Decision |
| --- | --- |
| `DES-01` | Reuse the existing `SPMT00141` screen family, DTO family, and process/webservice split instead of inventing a new module or transport style. |
| `DES-02` | Move `PRODUCTCD` generation to the backend register and copy persistence path so the code is created only at save time and can share transaction control with numbering. |
| `DES-03` | Add copy as a dedicated action that inserts only a new `TMT026_PRODUCT` row and then reloads the inserted row into update mode. |
| `DES-04` | Remove manual-code UI behavior from the canonical contract, set `PRODUCTCDHANDMADE` to `NULL` on register and copy, and preserve the stored value on update. |
| `DES-05` | Extend init, detail, register, and update flows for the four requested fields and align master data usage to `3062/3063/3064`, `3087`, `3096`, and `3097`. |
| `DES-06` | Preserve unchanged legacy behavior for search layout, delete semantics, CSV, related-table copy, and unspecified joins. |
| `DES-07` | Keep dynamic validation logic in both frontend and backend so request-time and persistence-time rules stay consistent. |
| `DES-08` | Treat the unresolved `KANRIKBN` selector rule for numbering as a hard implementation blocker rather than inferring it from code traces or helper docs. |

## Design Flow

1. `Init`
   - Load existing screen state and search defaults.
   - Load master data for existing dropdowns plus the newly requested sets.
   - Keep search/result areas available under the current screen structure.
2. `New`
   - Switch the detail area to register mode.
   - Clear editable business fields per current form reset rules.
   - Show `PRODUCTCD` as blank and readonly.
   - Keep copy disabled.
3. `Register`
   - Run frontend validation.
   - Submit the detail payload without a trusted client-generated `PRODUCTCD`.
   - Run backend validation.
   - Allocate the new code from the numbering source inside the same transaction as the insert.
   - Insert `TMT026_PRODUCT` with `PRODUCTCDHANDMADE = NULL`.
   - Reload the inserted record into update mode.
4. `Update`
   - Load detail from the selected grid row into the current form.
   - Preserve `PRODUCTCD`.
   - Preserve existing `PRODUCTCDHANDMADE` in the database.
   - Save only the changed business fields in scope.
5. `Copy`
   - Allow the action only when a persisted detail record is loaded.
   - Reuse validation and confirmation behavior similar to save.
   - Allocate a new `PRODUCTCD` and insert a new row only into `TMT026_PRODUCT`.
   - Set `PRODUCTCDHANDMADE = NULL`.
   - Reload the inserted record into update mode.

## Non-Changes

- No CSV change is defined by this package.
- No related-table copy is defined by this package.
- No change to delete semantics is defined by this package.
- No change to navigation behavior for other buttons is defined by this package.
- No new database schema is defined here; schema authority must be updated separately if the request stands.

## Alternatives Considered

- Generating `PRODUCTCD` in the frontend on `New`: rejected because the request says generation happens on save/copy and transaction control belongs in the backend.
- Reusing update as copy by changing the key in-place: rejected because the request explicitly requires a new inserted row and preservation of the source row.
- Implementing against non-authoritative code traces only: rejected because `schema_database.yaml` has higher authority and currently conflicts with the request.
