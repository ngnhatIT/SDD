---
id: "2026-03-16-codebase-derived-rule-calibration"
title: "Codebase-derived rule calibration tasks"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Update canonical search and frontend rule artifacts using only the repeated search-flow patterns from `Spvm00131` and `SPMT00231`. | `REQ-01` | `DES-01` | `TC-01` |
| `TASK-02` | Update canonical CSV module guidance from the repeated import lifecycle in `Spmt00231CsvImportProcess` and `Spmt01102ACCsvImportProcess`. | `REQ-02` | `DES-02` | `TC-02` |
| `TASK-03` | Update canonical and bridge validation rules from the observed `beforeProcessing(...)`, checker reuse, and API import validation behavior. | `REQ-03` | `DES-03` | `TC-03` |
| `TASK-04` | Record inconsistencies that must be preserved locally and remove unsupported normalization guidance from rule text. | `REQ-04` | `DES-04` | `TC-04` |
| `TASK-05` | Update canonical and bridge SQL rules from the observed `StringBuilder` query construction pattern and the anchored `TMT050` lookup-family behavior. | `REQ-05` | `DES-05` | `TC-05` |
| `TASK-06` | Update canonical and bridge hardcoding guidance to require scanning shared constant catalogs first and to use `ConstCcd` or `ConstCcdDef` for `VMT050`-backed code values. | `REQ-06` | `DES-06` | `TC-06` |
| `TASK-07` | Update canonical and bridge frontend template rules from the repeated `.html` block, label, pager, and field-error layout patterns in `Spvm00131` and `SPMT00231`. | `REQ-07` | `DES-07` | `TC-07` |

## Sequencing

1. `TASK-01`
2. `TASK-02`
3. `TASK-03`
4. `TASK-04`
5. `TASK-05`
6. `TASK-06`
7. `TASK-07`
