---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging requirements"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "README.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "README.md"
implementation_refs:
  - "example: src/main/java/jp/co/brycen/crm/customersearch/csvexport/process/CustomerSearchCsvExportProcess.java"
test_refs:
  - "09-test-cases.md"
---

# Requirements

## Problem Statement

Customer service users can search customer data on screen, but they cannot export the filtered result set without manual work. The repository also lacks a durable audit trail for customer data exports from this screen.

## Actors

- Customer service staff
- Team leaders with export permission
- Compliance reviewers who inspect export history

## In Scope

- Export current customer search results to CSV from the search screen
- Reuse active filters and sort order
- Enforce permission and company isolation
- Record audit rows for export attempts

## Out Of Scope

- Background export jobs
- Export scheduling
- Email delivery
- Audit UI screens

## Constraints

- Export must follow the same visibility and company filters as on-screen search.
- Export must use the established CSV module pattern.
- Export must block when the matching row count exceeds `10,000`.
- Audit logging must not change customer master data.

## Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | An authorized user can export the current customer search result set from the customer search screen without re-entering filter criteria. |
| `REQ-02` | The export returns only the rows the user is allowed to see and respects the same company and data-access filters as the interactive search. |
| `REQ-03` | If the matching row count exceeds `10,000`, the system blocks the export and returns an actionable message instead of generating a partial file. |
| `REQ-04` | Each export attempt writes an audit record with company, user, screen, timestamp, filter summary, row count, and outcome. |
| `REQ-05` | The CSV output uses the approved customer export column order and the same sort order as the on-screen search results. |
| `REQ-06` | If export generation fails after the request is accepted, the user sees a user-safe error message and the audit outcome is recorded as `FAILED`. |

## Dependencies

- Existing customer search criteria builder
- Shared CSV writer utilities
- Standard authenticated JAX-RS request flow

