---
id: "2026-03-16-codebase-derived-rule-calibration"
title: "Codebase-derived rule calibration acceptance criteria"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
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
| `AC-01` | `REQ-01` | Search-related rule text reflects the observed `validate -> store/snapshot -> SearchCnt -> Search` flow and the `init data before loadSearchConditions` pattern from the scanned search screens. | Updated canonical and bridge rule files with anchor-based wording |
| `AC-02` | `REQ-02` | CSV import rule text reflects the observed `typed row mapping -> preprocess -> IMPSETTING gate -> history update` lifecycle and popup fatal-error pattern from the scanned import modules. | Updated canonical and bridge CSV rule files |
| `AC-03` | `REQ-03` | Validation rule text reflects the observed use of `beforeProcessing(...)`, existing checker processes, and post-shared custom validation deduplication in the scanned backend anchors. | Updated canonical and bridge validation rule files |
| `AC-04` | `REQ-04` | Inconsistency guidance stops forcing unsupported normalization and instead tells agents to preserve local family style when the scanned anchors conflict. | Updated inconsistency and indexing rule files |
| `AC-05` | `REQ-05` | SQL rule text reflects the observed `StringBuilder` query construction style and tells agents to preserve the touched family's `TMT050` lookup pattern, with `VMT050_ALL` retained where that family already uses it. | Updated canonical and bridge SQL rule files |
| `AC-06` | `REQ-06` | Hardcoding guidance tells agents to scan the named frontend and backend constant catalogs first, and to use `ConstCcd` for `DATACD` plus `ConstCcdDef` for `RCDKBN` values sourced from `VMT050`. | Updated canonical and bridge hardcoding or constant rule files |
| `AC-07` | `REQ-07` | Frontend template rule text reflects the repeated `.html` patterns from the scanned screens: separate `card wms-card` blocks by area when already present, `formItemNm[...]` captions, `inputError` placement directly under controls, and result-header `recordsCnt` plus `wms-page` layout. | Updated canonical and bridge frontend template rule files |
