---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC acceptance criteria"
owner: "Unassigned"
status: "draft"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01`, `REQ-02` | The package accurately describes the observed init, search-count, search-row, and row-open behavior of `SPOR00701AC`, including the current UI-required search fields and paged results flow. | Search request and response samples plus manual verification notes from `TC-01` through `TC-04` |
| `AC-02` | `REQ-01`, `REQ-05` | The package documents the central table, dependent master tables, status-derivation rules, and order-number generation dependency used by the current implementation. | SQL inspection notes and data-flow review from `TC-01`, `TC-05`, `TC-08`, and `TC-10` |
| `AC-03` | `REQ-03`, `REQ-05` | The package documents the observed create-new, temporary-save, copy, update, and delete state changes on `TAOR59_ANACORDERREQUEST`, including field-level behaviors that are currently questionable. | Mutation evidence from `TC-05` through `TC-09` |
| `AC-04` | `REQ-02`, `REQ-03`, `REQ-04` | The package documents current optimistic-lock and deleted-row handling, including both the shared intended message IDs and the visible implementation gaps. | Concurrency and stale-row evidence from `TC-04`, `TC-08`, `TC-09`, and `TC-11` |
| `AC-05` | `REQ-04` | The package documents the current warning-check flow, warning inputs and outputs, and the inconsistent alarm-persistence behavior without silently normalizing it. | Warning-flow evidence from `TC-10` and `TC-11` |
| `AC-06` | `REQ-06` | Confirmed behavior, inferred behavior, unresolved questions, and recommended review points remain explicitly separated across the package. | Package review checklist and gap review from `TC-11` |
