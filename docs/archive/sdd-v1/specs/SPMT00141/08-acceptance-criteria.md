---
id: "SPMT00141"
title: "SPMT00141 acceptance criteria"
owner: "WMS Delivery Team"
status: "in_progress"
last_updated: "2026-03-18"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01`, `REQ-02`, `REQ-05`, `REQ-07` | Initial display and new mode show a readonly `PRODUCTCD`, hide manual-code editing, and load the requested master data including corrected reserve types and new dropdown sets. | Screen capture or UI verification plus init payload evidence |
| `AC-02` | `REQ-02`, `REQ-04`, `REQ-05`, `REQ-08` | Register validates in both layers, generates `PRODUCTCD` in the backend transaction, stores `PRODUCTCDHANDMADE = NULL`, persists the in-scope fields, and reloads the created record into update mode. | Successful register trace plus persisted record check |
| `AC-03` | `REQ-04`, `REQ-05`, `REQ-07` | Update keeps the selected `PRODUCTCD`, preserves existing `PRODUCTCDHANDMADE`, and loads or saves the in-scope fields without reviving manual-code UI behavior. | Detail load evidence and persisted row comparison |
| `AC-04` | `REQ-03`, `REQ-04`, `REQ-08` | Copy is available only in update mode, validates and confirms like save, inserts exactly one new `TMT026_PRODUCT` row with a newly generated `PRODUCTCD`, writes `PRODUCTCDHANDMADE = NULL`, and reloads the inserted row into update mode. | Copy trace and database comparison between source and inserted row |
| `AC-05` | `REQ-06` | Frontend and backend enforce the same conditional validation for misc-code-target dependent fields and specification acquisition date rules. | Matched validation evidence in UI and backend responses |
| `AC-06` | `REQ-05`, `REQ-06` | `INVENTORYUNITCONVERSION` accepts only a positive decimal within the requested format and the three new dropdown fields store approved code values. | Validation evidence and persisted/request payload evidence |
| `AC-07` | `REQ-01`, `REQ-07` | Search, delete, CSV, and unspecified legacy behavior outside the explicit change scope remain unchanged. | Regression check evidence |
| `AC-08` | `REQ-08` | No numbering-dependent implementation or copy behavior passes review while the approved `KANRIKBN` selector rule for `TAMT050_PRODUCTNUMBERING` is still unresolved. Non-numbering slices may proceed only when the defer is recorded in the package and implementation evidence. | Governance check and package review result |
