---
id: "example-feature"
title: "SPPM00061 expired-file filter test cases"
owner: "Repository Example"
status: "ready-for-implementation"
last_updated: "2026-03-16"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs: []
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Manual | Load `SPPM00061`, turn `expiredOnly` on and off, then restore saved conditions. | The filter defaults to `false`, can be changed, and restores correctly. |
| `TC-02` | `AC-02` | Manual | Run search, count, and CSV export with `expiredOnly = true` and compare row counts. | Count, list, and export include the same expired rows. |
| `TC-03` | `AC-03` | Contract | Submit request payloads with omitted, valid, and invalid `expiredOnly` values. | Omitted behaves as `false`; valid boolean works; invalid values fail through normal validation. |
| `TC-04` | `AC-04` | Script | Run `sh scripts/sdd/validate_specs.sh example-feature` and `sh scripts/sdd/build_spec_pack.sh example-feature`. | The feature package validates and the generated pack stays aligned with the source package. |
