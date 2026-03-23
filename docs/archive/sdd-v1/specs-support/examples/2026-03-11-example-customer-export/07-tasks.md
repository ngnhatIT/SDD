---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging tasks"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "example: src/main/java/jp/co/brycen/crm/customersearch/csvexport"
  - "example: src/main/webapp/angular/src/app/components/customer-search"
test_refs:
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Add export endpoint, request DTO, permission check, and request validation | `REQ-01`, `REQ-02` | `DES-01`, `DES-02` | `TC-01`, `TC-04` |
| `TASK-02` | Reuse search criteria builder and add pre-export count guard with the `10,000` row limit | `REQ-02`, `REQ-03`, `REQ-05` | `DES-02`, `DES-03` | `TC-01`, `TC-03`, `TC-07` |
| `TASK-03` | Generate the CSV through the shared CSV pattern and persist success or failure audit rows | `REQ-04`, `REQ-05`, `REQ-06` | `DES-05`, `DES-06` | `TC-01`, `TC-05`, `TC-06`, `TC-07` |
| `TASK-04` | Add frontend export button, loading state, blob download handling, and business error handling | `REQ-01`, `REQ-03`, `REQ-06` | `DES-01`, `DES-04` | `TC-01`, `TC-02`, `TC-03`, `TC-06` |
| `TASK-05` | Add database migration for the audit table and retention-ready indexes | `REQ-04` | `DES-05` | `TC-05`, `TC-06` |
| `TASK-06` | Complete verification, rollout notes, implementation report, and review report | `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`, `REQ-05`, `REQ-06` | `DES-01` to `DES-06` | `TC-01` to `TC-07` |

## Sequencing

1. `TASK-05`
2. `TASK-01`
3. `TASK-02`
4. `TASK-03`
5. `TASK-04`
6. `TASK-06`

## Notes

- `TASK-02` and `TASK-03` must use the same criteria builder as the interactive search to avoid drift.
- `TASK-04` depends on the final error codes defined in `04-api-contract.md`.

