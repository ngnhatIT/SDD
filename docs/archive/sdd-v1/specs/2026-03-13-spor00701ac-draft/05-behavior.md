---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC observed behavior"
owner: "Unassigned"
status: "draft"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "04-api-contract.md"
  - "06-edge-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "src/main/webapp/angular/src/app/components/spor00701ac/spor00701ac.component.ts"
  - "src/main/webapp/angular/src/app/components/spor00701ac/spor00701ac.component.html"
test_refs:
  - "09-test-cases.md"
---

# Behavior

## Preconditions

- `confirmed` The user reaches route `SPOR00701AC`.
- `confirmed` The screen pulls `accessInfo` for `DisplayScreenID.SPOR00701AC`.
- `confirmed` The screen initializes store dropdown data and code-master lists before normal use.

## Screen-Level Scenarios

| Scenario | Observed behavior | Basis |
| --- | --- | --- |
| Initial load | Sets default store from `accessInfo.STORECD`, fetches store list, loads code-master dropdowns, builds the result table, and loads saved search conditions | `confirmed` |
| Search validation | UI requires store, section, group, and request type; also validates date formats and ranges | `confirmed` |
| Search with no data | Count endpoint returning `0` or `undefined` shows `MI000001` and clears table plus pager | `confirmed` |
| Search with data | Count endpoint updates `recordsCnt`, pager, and possibly `deadline`; list endpoint fills the table rows | `confirmed` |
| Row open | Clicking a row first calls check-link; on success the input block is populated from the row | `confirmed` |
| Unsaved input and row switch | If local input differs from an empty DTO snapshot, the screen prompts `MQ000018` before changing rows | `confirmed` |
| Confirm submit | Validates input, calls warning check, prompts `MQ000004`, then calls create-new or update depending on whether `systemSlipNoInput` is empty | `confirmed` |
| Temporary save | Validates input, calls warning check, prompts a message derived from `MQ000013`, then calls create-save | `confirmed` |
| Copy | Prompts `MQ000013`, calls create-copy, then updates the input block with the new identifiers returned by the backend | `confirmed` |
| Delete | Prompts `MQ000006`, then calls soft delete and refreshes search results | `confirmed` |

## Button-State Rules

| Screen state | Observed button state | Basis |
| --- | --- | --- |
| Initial load | Clear input, temporary save, confirm, copy, and delete are disabled | `confirmed` |
| After search when `deadline` exists | Clear input, temporary save, and confirm are enabled; copy and delete stay disabled | `confirmed` |
| After selecting status `01`, `03`, or `07` | Clear input, temporary save, confirm, copy, and delete are all enabled | `confirmed` |
| After selecting other visible statuses | Clear input and copy are enabled; temporary save, confirm, and delete are disabled | `confirmed` |

## Input Behavior

- `confirmed` Required input fields in the UI are request type, product code, product name, delivery date, order request quantity, and delivery type.
- `confirmed` Quantity, change quantity, unit price, and order price use numeric validation; negative values are blocked in the Angular layer.
- `confirmed` Order price is calculated as `changeQty * unitPrice` when `changeQty > 0`; otherwise `orderRequestQty * unitPrice`.
- `confirmed` If the calculated order price is `0`, the screen displays it as blank.
- `confirmed` The product focus-out flow can populate product name, memo, supplier, unit price, and unit code through shared lookup behavior.
- `confirmed` The partner input field does not perform a shared focus-out lookup on blur; only modal selection clearly populates partner name.

## Warning Behavior

- `confirmed` The screen calls warning check before confirm and temporary save.
- `confirmed` When warning messages are returned, the screen concatenates them with the separator currently encoded in the component and shows a warning dialog.
- `confirmed` When warnings are returned, Angular sets `alarmKbnInput` to `GC_D3071_ALARMON` and stores the concatenated warning text in `alarmInput`.
- `confirmed` When no warning message is returned, Angular sets `alarmKbnInput` to `GC_D3071_ALARMOFF` and clears `alarmInput`.
- `unresolved` The backend does not persist these values consistently across all mutation paths.

## Search-Condition Persistence

- `confirmed` The screen registers save and delete hooks with the shared `SearchConditionService`.
- `confirmed` Search conditions are loaded through `SearchConditionManagementService`.
- `confirmed` The screen persists store, section, group, request type, product, partner, dates, user, and the six visible status checkboxes.

## User Messages Directly Traceable From Message Resources

| Message ID | English text in repo | Observed use |
| --- | --- | --- |
| `MI000001` | `Applicable data not found.` | Search count returns zero or undefined |
| `MI000002` | `Confirmed.` | Success notification for confirm, temporary save, copy, and update |
| `MQ000004` | `Confirming.Is it OK?` | Confirm submit before create-new or update |
| `MQ000006` | `Deleting.(%1)。Is it OK?` | Delete confirmation |
| `MQ000013` | `Copying.Is it OK?` | Copy confirmation and temporary-save confirmation text hack |
| `MQ000018` | `Discarding changes.Is it OK?` | Unsaved input discard confirmation |
| `ME000063` | `%1 has already been deleted. Searching again.` | Shared exclusion error and current delete-success toast |
| `ME000174` | `There is an input error. [HTML line break] Please check the input contents.` | Angular validation modal type |
| `ME100069` | `%1 is not present in the master.` | Product validation helper error |

## Inferred Behavior

- `inferred` The red deadline banner is intended to warn users about a business cutoff for request entry.
- `inferred` Confirm appears to mean moving a request into a "requested" state, while temporary save leaves it editable.
