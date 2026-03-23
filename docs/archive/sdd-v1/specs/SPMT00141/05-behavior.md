---
id: "SPMT00141"
title: "SPMT00141 behavior"
owner: "WMS Delivery Team"
status: "blocked"
last_updated: "2026-03-18"
related_specs:
  - "02-design.md"
  - "04-api-contract.md"
  - "06-edge-cases.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.ts"
  - "src/main/webapp/angular/src/app/components/spmt00141/spmt00141.component.html"
test_refs:
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Behavior

## Screen Modes

| Mode | Expected behavior |
| --- | --- |
| `INIT` | Search area is usable, detail area is not yet tied to a persisted record, `PRODUCTCD` is not user-editable, copy stays disabled |
| `REGIST` | Triggered by `New`; detail fields are editable, `PRODUCTCD` is blank and readonly, copy stays disabled |
| `UPDATE` | Triggered by selecting an existing record or by successful register/copy reload; `PRODUCTCD` is readonly and populated, copy is enabled |

## Control Rules

| Control | INIT | REGIST | UPDATE |
| --- | --- | --- | --- |
| Search filters | enabled | enabled | enabled |
| Grid selection | enabled after search | enabled after search | enabled after search |
| `New` | enabled | enabled | enabled |
| `PRODUCTCD` in detail | readonly or blank | blank readonly | populated readonly |
| Manual code field | hidden | hidden | hidden |
| `Confirm` | disabled until a valid edit context exists | enabled | enabled |
| `Copy` | disabled | disabled | enabled |
| `Delete` | disabled until a persisted record is loaded | disabled | enabled |

## Register Behavior

1. User enters new data in `REGIST` mode.
2. Frontend validates required and conditional rules.
3. User confirms save.
4. Backend validates the same rules.
5. Backend generates `PRODUCTCD`, inserts the row, and sets `PRODUCTCDHANDMADE = NULL`.
6. After success, the screen reloads the inserted row and enters `UPDATE`.

## Update Behavior

1. User selects a record from the grid.
2. The detail area loads the persisted values, including the four requested fields once schema authority permits implementation.
3. `PRODUCTCD` remains readonly.
4. Save updates only the selected record.
5. Update preserves the existing stored `PRODUCTCDHANDMADE`.

## Copy Behavior

1. User is in `UPDATE` mode with a persisted record loaded.
2. User edits or keeps the current form values.
3. User clicks `Copy`.
4. Frontend validates and asks for confirmation.
5. Backend validates, allocates a new `PRODUCTCD`, inserts one new row, and sets `PRODUCTCDHANDMADE = NULL`.
6. The source record remains unchanged.
7. The screen reloads the inserted row into `UPDATE`.

## Dynamic Validation Rules

| Rule | Expected behavior |
| --- | --- |
| Misc code target dependent fields | When misc-code-target is `OFF`, the dependent unit and conversion fields remain required in both frontend and backend |
| Specification acquisition date | When specification acquisition status is one of the requested acquired states, the acquisition date is required in both frontend and backend |
| Inventory unit conversion | Accept only a positive decimal value within the requested `decimal(6,2)` envelope |

## New Field Behavior

| Field | UI behavior |
| --- | --- |
| `URGENTDEADLINECATEGORY` | Dropdown backed by master `3097` |
| `EXPIRATIONDATEMANAGEMENT` | Dropdown backed by master `3087` |
| `INVENTORYMANAGEMENTPATTERN` | Dropdown backed by master `3096` |
| `INVENTORYUNITCONVERSION` | Numeric input with requested validation |

## Preserved Behavior

- Search result navigation and current grid usage remain in place.
- Delete stays as the current screen-family delete action unless higher authority changes it.
- CSV and unrelated buttons are not changed by this package.
