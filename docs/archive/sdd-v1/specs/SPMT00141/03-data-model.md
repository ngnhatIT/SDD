---
id: "SPMT00141"
title: "SPMT00141 data model"
owner: "WMS Delivery Team"
status: "blocked"
last_updated: "2026-03-18"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "04-api-contract.md"
dependencies:
  - "docs/sdd/context/schema_database.yaml"
  - "01-requirements.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spmt00141csvimport/dto/Spmt00141CsvImportRowDto.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00601acsearch/process/Spor00601acSearchAllRecProcess.java"
test_refs:
  - "09-test-cases.md"
---

# Data Model

## Authority Status

This feature is no longer blocked by missing table or column structure, but it is still blocked by numbering-rule ambiguity.

- Authoritative source: `docs/sdd/context/schema_database.yaml`
The four requested `TMT026_PRODUCT` columns were added to schema authority on `2026-03-18`, and `TAMT050_PRODUCTNUMBERING` was added on the same date using the local numbering-control table pattern.

## Primary Entities

| Entity | Role | Authority status |
| --- | --- | --- |
| `TMT026_PRODUCT` | Primary procurement product record shown and edited by `SPMT00141` | Authoritative for the current request, including the four newly added columns |
| `TMT050_NAME` | Shared code/name master for dropdowns | Authoritative and already used by the screen family |
| `TAMT050_PRODUCTNUMBERING` | Requested numbering source for generated `PRODUCTCD` | Authoritative table exists, but `KANRIKBN` usage remains unresolved |

## Requested Field Mapping

| Functional field | Expected persisted field | Master or validation source | Authority status | Notes |
| --- | --- | --- | --- | --- |
| Product code | `PRODUCTCD` | Backend-generated from numbering table | Partially authoritative | Table exists, but the approved `KANRIKBN` selector is still unknown |
| Manual product code | `PRODUCTCDHANDMADE` | Hidden from UI in this change | Authoritative | Preserve on update, set `NULL` on register/copy |
| Urgent deadline category | `URGENTDEADLINECATEGORY` | `TMT050_NAME.RCDKBN = 3097` | Authoritative | Added to `TMT026_PRODUCT` using the existing code-field pattern |
| Expiration date management | `EXPIRATIONDATEMANAGEMENT` | `TMT050_NAME.RCDKBN = 3087` | Authoritative | Added to `TMT026_PRODUCT` using the existing code-field pattern |
| Inventory management pattern | `INVENTORYMANAGEMENTPATTERN` | `TMT050_NAME.RCDKBN = 3096` | Authoritative | Added to `TMT026_PRODUCT` using the existing code-field pattern |
| Inventory unit conversion | `INVENTORYUNITCONVERSION` | `decimal(6,2)` and value `> 0` | Authoritative | Added to `TMT026_PRODUCT` using the existing conversion-field pattern |

## Existing Master Data Usage

| Purpose | Requested source |
| --- | --- |
| Purchase type | `RCDKBN = 3007` |
| Category | `RCDKBN = 3008` |
| Specification acquisition status | `RCDKBN = 3009` |
| Product type | `RCDKBN = 3010` |
| Buyback obligation | `RCDKBN = 3011` |
| Reserve type 1 | `RCDKBN = 3062` |
| Reserve type 2 | `RCDKBN = 3063` |
| Reserve type 3 | `RCDKBN = 3064` |
| Expiration date management | `RCDKBN = 3087` |
| Inventory management pattern | `RCDKBN = 3096` |
| Urgent deadline category | `RCDKBN = 3097` |

## Numbering Table Shape

| Column | Type | Notes |
| --- | --- | --- |
| `KANRIKBN` | `varchar(20)` | Management category key for the numbering row |
| `MINSEQNO` | `int` | Minimum sequence number |
| `CURRENTSEQNO` | `int` | Current sequence number |
| `MAXSEQNO` | `int` | Maximum sequence number |
| Audit columns | standard | `ENTUSRCD`, `ENTDATETIME`, `ENTPRG`, `UPDUSRCD`, `UPDDATETIME`, `UPDPRG` |

## Lifecycle Rules

1. `Init`
   - Load dropdown code/name pairs required by the current and newly requested fields.
2. `Register`
   - Validate request.
   - Allocate a new product code inside the same transaction as insert.
   - Persist the four requested fields using the now-authoritative `TMT026_PRODUCT` columns.
   - Persist `PRODUCTCDHANDMADE` as `NULL`.
3. `Update`
   - Use the current `PRODUCTCD` as the record key.
   - Preserve the existing `PRODUCTCDHANDMADE`.
   - Update only the in-scope business fields.
4. `Copy`
   - Read the current persisted source record.
   - Allocate a new `PRODUCTCD`.
   - Insert one new `TMT026_PRODUCT` row only.
   - Persist `PRODUCTCDHANDMADE` as `NULL`.

## Data Risks

- The current request cannot be implemented safely until the approved `KANRIKBN` literal is defined.
- The numbering filter literal for `KANRIKBN` is unresolved and may affect uniqueness or partitioning behavior.
