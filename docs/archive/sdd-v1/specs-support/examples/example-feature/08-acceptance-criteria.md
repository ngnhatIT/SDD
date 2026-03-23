---
id: "example-feature"
title: "SPPM00061 expired-file filter acceptance criteria"
owner: "Repository Example"
status: "ready-for-implementation"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01` | The `SPPM00061` screen provides an `expiredOnly` filter that defaults to `false` and can be restored from saved conditions. | Screen behavior walk-through |
| `AC-02` | `REQ-02` | Search count, search list, and CSV export apply the same expired-only predicate. | Search and export parity evidence |
| `AC-03` | `REQ-03` | The request contract accepts omitted `expiredOnly` as `false` and rejects invalid typed values through the normal validation path. | Contract and validation evidence |
| `AC-04` | `REQ-04` | The example package, risk and decision notes, contracts, and generated spec-pack remain aligned. | Validator output and generated pack |
