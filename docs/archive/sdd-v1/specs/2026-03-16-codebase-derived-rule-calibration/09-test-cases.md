---
id: "2026-03-16-codebase-derived-rule-calibration"
title: "Codebase-derived rule calibration test cases"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Test case | Evidence |
| --- | --- | --- | --- |
| `TC-01` | `AC-01` | Inspect updated search-related rule files and confirm they mention only search-flow steps observed in `Spvm00131` and `SPMT00231`. | Text diff against updated rule files |
| `TC-02` | `AC-02` | Inspect updated CSV rule files and confirm they mention typed row mapping, preprocess, import-setting gating, TWK003 or TWK004 history handling, and popup fatal errors. | Text diff against updated rule files |
| `TC-03` | `AC-03` | Inspect updated validation rule files and confirm they mention `beforeProcessing(...)`, checker reuse, and deduplicated custom API import validation. | Text diff against updated rule files |
| `TC-04` | `AC-04` | Inspect updated inconsistency and indexing rule files and confirm they no longer force one global normalization when the scanned anchors conflict. | Text diff against updated rule files |
| `TC-05` | `AC-05` | Inspect updated SQL rule files and confirm they mention `StringBuilder` construction plus family-preserving `TMT050` lookup guidance anchored by `VMT050_ALL` or legacy `TMT050_NAME` usage. | Text diff against updated rule files |
| `TC-06` | `AC-06` | Inspect updated hardcoding and constant rule files and confirm they name the shared constant catalogs plus the `ConstCcd` or `ConstCcdDef` split for `VMT050` values. | Text diff against updated rule files |
| `TC-07` | `AC-07` | Inspect updated frontend template rule files and confirm they mention repeated card-block separation, `formItemNm[...]` captions, inline `inputError` placement, and result-header pager layout without forcing a normalized block-name attribute style. | Text diff against updated rule files |
