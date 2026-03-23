---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment design"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-21"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
---

# Design

## Overview

Calibrate only the `BTCC0080AC` static required rules so nullable optional fields no longer fail shared validation, and use the existing `validateDataList(..., "seihinCd")` blacklist hook to disable the conflicting shared required rule only for the nullable `mHaigoKoseiHdrs` list.

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/process/Btcc0080acProcess.java`; `src/main/java/jp/co/brycen/kikancen/api/common/process/APIImportProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/webservice/Btcc0080acWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/process/Btcc0080acProcess.java`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Preserve the shared `APIImportProcess` validation flow and keep `BTCC0080AC` custom validation after the shared pass; limit the fix to `StaticApiCheckConfig` plus the narrowest per-list required-rule override needed for key parity.
- New tables/source families/screen structure in scope: `no`

## Schema Binding

- `docs/sdd/context/schema_database.yaml`
- Relevant tables:
  - `taor56_menuplanning`
  - `taor55_combinationheader`
  - `taor57_productionmaterialcomposition`

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Change `BTCC0080AC` static rules so only schema-backed key fields stay required by default and schema-nullable mapped fields become optional. | `REQ-01`, `REQ-03` |
| `DES-02` | Keep `templateFlg` in the existing DTO and SQL path, but make it optional in shared validation so omitted request data does not produce a required-control error. | `REQ-02`, `REQ-04` |
| `DES-03` | Where the same field alias is shared by multiple DTOs but has different requiredness, keep the shared rule required for the non-nullable list and disable the conflicting required check only for the nullable list through the existing `validateDataList(..., "seihinCd")` hook in `Btcc0080acProcess`. | `REQ-03`, `REQ-04` |
| `DES-04` | Preserve existing date-range validation, non-negative validation, DTO shape, SQL statements, and response shape. | `REQ-04` |

## Confidence Note

- Confidence: `medium`
- Basis: the exact API-sheet marker matrix is not stored in the repo, so the fix is intentionally narrowed to user-reported behavior plus schema-backed key/nullability evidence from the current tables and process SQL.
