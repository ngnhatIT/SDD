---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging test cases"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "08-acceptance-criteria.md"
  - "06-edge-cases.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs:
  - "example: src/test/java/jp/co/brycen/crm/customersearch/csvexport/CustomerSearchCsvExportProcessTest.java"
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01`, `AC-02`, `AC-04` | Integration | Search with a filter set that returns `250` rows, then export. | CSV download succeeds, file contains `250` rows, audit row is written with `SUCCESS`. |
| `TC-02` | `AC-01` | UI | Open the screen with a search result count of `0`. | Export button is disabled and no request is sent. |
| `TC-03` | `AC-03`, `AC-05` | Integration | Search with a filter set that returns `10,001` rows, then export. | Export is blocked, error code is `CUSTOMER_EXPORT_LIMIT_EXCEEDED`, no file is returned, audit row is `FAILED`. |
| `TC-04` | `AC-02` | Integration | Attempt export with a user lacking export permission. | Response is `403`, no file is returned, and no data outside the user's scope is exposed. |
| `TC-05` | `AC-04` | Database | Verify the audit row after a successful export. | Audit row stores company, user, screen, filter summary, row count, file name, and `SUCCESS`. |
| `TC-06` | `AC-05` | Integration | Simulate CSV writer failure after the export request is accepted. | User-safe error response is returned and audit row is stored with `FAILED` and the error code. |
| `TC-07` | `AC-02` | Integration | Export results sorted by `lastContactDate DESC`. | CSV row order matches the requested sort order and the approved column sequence. |

## Test Data Notes

- Use a dataset with at least one tenant boundary and one permission-restricted user.
- Use one filter set that returns exactly `10,000` rows and one that returns `10,001` rows.

