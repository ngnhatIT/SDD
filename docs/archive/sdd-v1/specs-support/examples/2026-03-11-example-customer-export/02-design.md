---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging design"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "01-requirements.md"
  - "03-data-model.md"
  - "04-api-contract.md"
  - "05-behavior.md"
  - "06-edge-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "example: src/main/java/jp/co/brycen/crm/customersearch/csvexport/webservice/CustomerSearchCsvExportWebService.java"
  - "example: src/main/java/jp/co/brycen/crm/customersearch/csvexport/process/CustomerSearchCsvExportProcess.java"
  - "example: src/main/webapp/angular/src/app/components/customer-search/customer-search.component.ts"
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

Add an export action to the customer search screen. The frontend submits the active filter payload to a dedicated export endpoint. The backend reuses the same criteria builder as the interactive search, checks the matching row count, generates the CSV when the result set is within limit, and writes an audit row for the attempt.

- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`, `REQ-05`, `REQ-06`

## Current State

- Customer search is available only as an on-screen list.
- Users must manually copy data or request an extract.
- No export-specific audit trail exists for this screen.

## Target State

- Authorized users can export the current filtered result set to CSV from the search screen.
- Exported rows match the same visibility rules as the interactive search.
- Over-limit requests are blocked before file generation.
- An audit table records successful and failed attempts.

## Impacted Areas

| Area | Impact |
| --- | --- |
| Frontend | Add export button, loading state, blob download handling, and error messages on the customer search screen |
| Backend web service | Add a dedicated export endpoint and request DTO |
| Backend process | Reuse search criteria builder, enforce count guard, generate file, write audit rows |
| Database | Add export audit table |
| Operations | Add smoke checks for export success, over-limit rejection, and audit persistence |

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/tmt220funcget/process/Tmt220FuncGetProcess.java`; `src/main/java/jp/co/brycen/kikancen/tsm030search/process/Tsm030SearchProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/spcm00011searchStore/webservice/Spcm00011SearchStoreWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/tmt220funcget/process/Tmt220FuncGetProcess.java`; `src/main/java/jp/co/brycen/kikancen/tsm030search/process/Tsm030SearchProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/spcm00021/spcm00021.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/spcm00021/spcm00021.component.html`
- Dominant module/style note: Reuse the current JAX-RS webservice plus process split, `StringBuilder` SQL assembly style, and Angular screen-family layout patterns from the chosen anchor files instead of inventing a new export-specific structure.
- New tables/source families/screen structure in scope: `yes` for one additive audit table; `no` for new backend source families and `no` for new screen structure.

## Design Decisions

| ID | Decision |
| --- | --- |
| `DES-01` | Add a dedicated export action to the existing customer search screen instead of creating a separate export screen. |
| `DES-02` | Reuse the existing customer search criteria builder so on-screen search and export use the same filter, sort, and visibility logic. |
| `DES-03` | Run a count query before file generation and block requests above `10,000` rows. |
| `DES-04` | Keep export synchronous for this feature because the limit is bounded and the output is generated from a single request. |
| `DES-05` | Persist an audit row for both `SUCCESS` and `FAILED` outcomes in a dedicated audit table. |
| `DES-06` | Use the shared CSV module family for file creation and define one explicit export column order for the screen. |

## Design Flow

1. User searches on the customer search screen.
2. User clicks `Export CSV`.
3. Frontend submits the current filter payload to the export endpoint.
4. Backend validates permission and company context.
5. Backend executes a count query with the same criteria builder as search.
6. If count is above limit, backend writes a `FAILED` audit row and returns a business error.
7. If count is within limit, backend generates the CSV, writes a `SUCCESS` audit row, and returns the file stream.

## Non-Changes

- Search result pagination behavior does not change.
- Customer master data is not updated.
- No asynchronous job or notification flow is introduced.

## Alternatives Considered

- Background export job: rejected because it adds queueing, job tracking, and notification complexity that is not needed for the current limit.
- Export from the client-side result grid: rejected because only the current page is loaded and it would break parity with server-side visibility rules.
