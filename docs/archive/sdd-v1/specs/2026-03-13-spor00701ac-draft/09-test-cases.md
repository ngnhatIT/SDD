---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC test cases"
owner: "Unassigned"
status: "draft"
last_updated: "2026-03-13"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
---

# Test Cases

## Coverage Status

- No `SPOR00701AC`-specific automated tests were found under `src/test/java`.
- The cases below are the minimum verification paths needed before this draft can be treated as an approved governing package.

## Test Cases

| ID | Covers | Verification path | Expected result |
| --- | --- | --- | --- |
| `TC-01` | `AC-01`, `AC-02` | From the Angular screen, search with valid store, section, group, and request type plus one optional filter. Compare count and list results. | Count and list align; rows are scoped to the current company and reflect the applied filters |
| `TC-02` | `AC-01` | Search with a combination that returns no rows. | `MI000001` is shown, table data is cleared, pager resets |
| `TC-03` | `AC-01` | Search with store, section, and group that have a current `REQORDDEADLINETM`; then search with one that does not. | The `deadline` banner and button-state changes match current implementation |
| `TC-04` | `AC-01`, `AC-04` | Open a row, then change or delete the same row from another session before re-opening. | Check-link returns shared stale or deleted-data behavior; current missing-row behavior is recorded if observed |
| `TC-05` | `AC-02`, `AC-03` | Create a new confirmed row from blank input using valid search context and product data. | A new `TAOR59_ANACORDERREQUEST` row is inserted with requested-state flags and appears in search results |
| `TC-06` | `AC-03` | Temporary-save a new row, then temporary-save the same row again after editing it. | First call inserts a temp-save row; second call updates the same row and keeps temp-save state |
| `TC-07` | `AC-03` | Copy an existing row and inspect the returned identifiers and copied values. | Backend returns new identifiers; copied row behavior matches current implementation, including preserved source fields |
| `TC-08` | `AC-02`, `AC-03`, `AC-04` | Update an existing row and inspect key audit or lifecycle fields in the database. | The row is updated, `EDITIONNUMBER` increments, and requested-state fields are reset as currently coded |
| `TC-09` | `AC-03`, `AC-04` | Delete an existing row and refresh the search. | `DELFLG` becomes deleted, the row disappears from valid search results, and the current user-facing message is recorded |
| `TC-10` | `AC-02`, `AC-05` | Trigger warning checks for discontinued-date, maximum-amount, and remarks cases; then confirm and temporary-save. | Warning messages match code-master configuration and the observed persistence behavior is captured |
| `TC-11` | `AC-04`, `AC-05`, `AC-06` | Exercise direct API requests with missing required search fields, missing numeric fields, or missing rows. | Any mismatch between UI assumptions and backend behavior is captured as a confirmed gap or unresolved question |

## Evidence Expectations

- Record whether each case was verified manually, through SQL inspection, or through automated coverage.
- If a case cannot be executed because the environment or reference data is missing, record that explicitly before approval.
