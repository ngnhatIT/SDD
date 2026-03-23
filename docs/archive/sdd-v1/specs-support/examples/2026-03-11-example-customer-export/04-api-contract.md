---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging API contract"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "02-design.md"
  - "03-data-model.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "example: src/main/java/jp/co/brycen/crm/customersearch/csvexport/dto/CustomerSearchCsvExportRequestDto.java"
  - "example: src/main/java/jp/co/brycen/crm/customersearch/csvexport/webservice/CustomerSearchCsvExportWebService.java"
test_refs:
  - "09-test-cases.md"
---

# API Contract

## Endpoint

- Method: `POST`
- Path: `/webapi/customer-search/export-csv`
- Auth: existing authenticated session and export permission

## Request

### Body

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `customerCodeFrom` | string | no | Lower bound filter |
| `customerCodeTo` | string | no | Upper bound filter |
| `customerName` | string | no | Partial match |
| `status` | string[] | no | Active or inactive filters |
| `assignedRepId` | string | no | Assigned representative |
| `lastContactFrom` | string | no | ISO date |
| `lastContactTo` | string | no | ISO date |
| `sortField` | string | yes | Must match allowed search sort fields |
| `sortDirection` | string | yes | `ASC` or `DESC` |

### Server Context

- `company_id` and `user_id` come from the authenticated request context, not from the client body.

## Success Response

| Field | Value |
| --- | --- |
| Status | `200 OK` |
| Content-Type | `text/csv` |
| Content-Disposition | `attachment; filename="customer-search-YYYYMMDD-HHmmss.csv"` |
| Body | CSV byte stream |

## Error Response

Use the standard JSON error envelope when the file cannot be returned.

| Status | Code | Meaning |
| --- | --- | --- |
| `400` | `CUSTOMER_EXPORT_LIMIT_EXCEEDED` | Matching row count exceeds `10,000` |
| `403` | `CUSTOMER_EXPORT_FORBIDDEN` | User lacks export permission |
| `422` | `CUSTOMER_EXPORT_INVALID_FILTER` | Invalid filter input |
| `500` | `CUSTOMER_EXPORT_FAILED` | Unexpected generation or persistence failure |

## Compatibility Rules

- Search request fields remain unchanged.
- Export uses the same filter names as interactive search to avoid DTO drift.
- New errors must be handled by the existing frontend business-error path.

## Machine-Readable Contract Files

- `contracts/openapi.yaml`
- `contracts/schemas/customer-search-export-request.schema.json`
- `contracts/schemas/customer-export-audit.schema.json`
