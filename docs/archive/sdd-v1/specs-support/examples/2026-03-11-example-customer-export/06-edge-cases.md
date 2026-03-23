---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging edge cases"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "02-design.md"
  - "04-api-contract.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "example: src/main/java/jp/co/brycen/crm/customersearch/csvexport/process/CustomerSearchCsvExportProcess.java"
test_refs:
  - "09-test-cases.md"
---

# Edge Cases

| Case | Expected behavior | Related requirement |
| --- | --- | --- |
| Search result count is `0` | Export action remains disabled and no request is sent | `REQ-01` |
| Search result count is `10,001` | Backend blocks the export, returns `CUSTOMER_EXPORT_LIMIT_EXCEEDED`, and writes a `FAILED` audit row | `REQ-03`, `REQ-04` |
| User loses permission after page load | Backend returns `CUSTOMER_EXPORT_FORBIDDEN` and no file is returned | `REQ-02` |
| Filter input is invalid after client manipulation | Backend returns `CUSTOMER_EXPORT_INVALID_FILTER` and no file is generated | `REQ-02`, `REQ-06` |
| CSV generation fails after count passes | Backend records a `FAILED` audit row and returns `CUSTOMER_EXPORT_FAILED` | `REQ-04`, `REQ-06` |
| Two export requests are sent quickly | Each request is processed independently; audit rows reflect both attempts | `REQ-04` |
| Sort field is unsupported | Backend rejects the request as invalid instead of falling back silently | `REQ-05` |

## Recovery Rules

- Business failures return a user-safe message and keep the page usable.
- Additive audit schema does not require rollback of customer data.
- If audit insert fails, treat the whole export as failed to avoid untracked downloads.

