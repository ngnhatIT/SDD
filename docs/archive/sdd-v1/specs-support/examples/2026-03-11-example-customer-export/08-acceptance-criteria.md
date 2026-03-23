---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging acceptance criteria"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "example: src/main/java/jp/co/brycen/crm/customersearch/csvexport/process/CustomerSearchCsvExportProcess.java"
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01` | An authorized user can download a CSV from the customer search screen using the currently applied filters and sort order. | Successful export result and downloaded file example |
| `AC-02` | `REQ-02`, `REQ-05` | The exported rows and ordering match the same filtered result set the user is allowed to see on screen. | Query parity check and CSV content verification |
| `AC-03` | `REQ-03` | When the matching row count exceeds `10,000`, the export is blocked before file generation and the user sees the configured business message. | Business error result and no file response |
| `AC-04` | `REQ-04` | A successful export creates one audit row with user, company, screen, filter summary, row count, and `SUCCESS` status. | Audit table verification |
| `AC-05` | `REQ-04`, `REQ-06` | A failed export creates one audit row with `FAILED` status and an error code, and the user receives a user-safe error message. | Audit table verification and error response evidence |

