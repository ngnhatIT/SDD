---
id: "2026-03-16-codebase-derived-rule-calibration"
title: "Codebase-derived rule calibration requirements"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "02-design.md"
  - "07-tasks.md"
dependencies: []
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Requirements

## Problem

- The repository still contains rule text that is broader or more absolute than the patterns visible in the scanned anchors.

## In Scope

- Search rule calibration from `Spvm00131` and `SPMT00231`
- CSV import rule calibration from `Spmt00231CsvImportProcess` and `Spmt01102ACCsvImportProcess`
- Backend validation rule calibration from `Spvm00131`, `SPMT00231`, and `BTCC0080AC`
- Inconsistency guidance for anchored path-style and parameter-index patterns
- SQL construction and `TMT050` lookup rule calibration from the scanned backend anchors
- Shared constant-catalog and `VMT050` code-constant rule calibration across frontend and backend
- Frontend `.html` template rule calibration from `Spvm00131` and `SPMT00231`

## Out Of Scope

- Product behavior changes in the scanned modules
- Contract or schema changes
- New rules that are not grounded in the scanned anchors

## Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | Search-related rules must be derived from the observed `Spvm00131` and `SPMT00231` search flows instead of from generic assumptions. |
| `REQ-02` | CSV import rules must reflect the repeated lifecycle present in `Spmt00231CsvImportProcess` and `Spmt01102ACCsvImportProcess`. |
| `REQ-03` | Backend validation and API import rules must reflect the actual placement and deduplication behavior present in `Spvm00131`, `SPMT00231`, and `BTCC0080AC`. |
| `REQ-04` | Rule text must call out real legacy inconsistencies when the scanned anchors disagree, instead of forcing one normalized pattern. |
| `REQ-05` | SQL-related rules must reflect the observed `StringBuilder` construction style and the real `TMT050` lookup-family behavior present in the scanned backend anchors. |
| `REQ-06` | Hardcode-prevention rules must direct agents to scan the shared frontend and backend constant catalogs first, and to use `ConstCcd` for `DATACD` plus `ConstCcdDef` for `RCDKBN` values sourced from `VMT050`. |
| `REQ-07` | Frontend screen rules must reflect the repeated `.html` layout patterns present in `Spvm00131` and `SPMT00231`, especially card-block separation, `formItemNm[...]` label binding, inline field-error placement, and result-header pager layout. |

## Constraints

- Only promote patterns that are repeated or explicit in the scanned anchors.
- Preserve local-family inconsistencies when the anchors do not agree.
- Do not add rule text that requires behavior not evidenced in the scanned modules.
