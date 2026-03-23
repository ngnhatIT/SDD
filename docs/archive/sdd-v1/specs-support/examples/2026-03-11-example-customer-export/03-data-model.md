---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging data model"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "02-design.md"
  - "04-api-contract.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "example: db/migration/V20260311__create_customer_export_audit.sql"
test_refs:
  - "09-test-cases.md"
---

# Data Model

## Scope

This feature does not change customer master data. It adds one audit table for export attempts.

## New Table

### `crm_customer_export_audit`

| Column | Type | Notes |
| --- | --- | --- |
| `export_audit_id` | bigint | Primary key |
| `company_id` | varchar(20) | Company or tenant context |
| `user_id` | varchar(50) | Requesting user |
| `screen_id` | varchar(20) | Source screen identifier, for example `CUS0100` |
| `requested_at` | timestamp | Request acceptance time |
| `filter_summary_json` | text | Serialized filter summary used for the export |
| `sort_field` | varchar(50) | Effective sort field |
| `sort_direction` | varchar(4) | `ASC` or `DESC` |
| `row_count` | integer | Matching row count |
| `result_status` | varchar(20) | `SUCCESS` or `FAILED` |
| `error_code` | varchar(50) | Business or technical error code when failed |
| `file_name` | varchar(255) | Returned file name on success |

## Indexes

- Primary key on `export_audit_id`
- Composite index on `company_id`, `requested_at`
- Secondary index on `user_id`, `requested_at`

## Lifecycle Rules

- An audit row is written for every accepted export request.
- `FAILED` rows are retained even when no file is produced.
- Audit rows are append-only.
- Retention target: `180 days` unless compliance policy requires longer retention.

## Data Notes

- `filter_summary_json` stores only request filters and sort metadata.
- No customer row data is stored in the audit table.

