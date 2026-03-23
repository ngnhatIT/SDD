---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC observed design"
owner: "Unassigned"
status: "draft"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "03-data-model.md"
  - "04-api-contract.md"
  - "05-behavior.md"
  - "06-edge-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spor00701acinit/process/Spor00701acInitProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acsearch/process/Spor00701acSearchAllProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateNewProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateSaveProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acupdate/process/spor00701acUpdateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acdelete/process/spor00701acDeleteProcess.java"
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

`SPOR00701AC` is implemented as one Angular screen with a split backend module family:

- init endpoint for store-list bootstrap
- separate search count and search row endpoints
- one check-link endpoint for row-open concurrency checking
- one warning endpoint for advisory checks before submit or temporary save
- separate mutation endpoints for create new, create save, create copy, update, and delete

Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`, `REQ-05`, `REQ-06`

This document describes the observed design. It does not treat all current behavior as approved.

## Impacted Areas

| Area | Observed impact |
| --- | --- |
| Frontend screen | Search form, results table, input form, button-state management, warning and confirmation dialogs, saved search conditions |
| Backend webservices | Ten JAX-RS endpoints under `/kikancen/*` dedicated to this screen family |
| Backend processes | SQL assembly, validation, optimistic-lock checking, warning evaluation, and state mutation |
| Shared backend | `MasterCheckExclusionProcess`, `MasterNameGetProcess`, shared access-info and error-routing behavior |
| Database | Reads and writes across `TAOR59_ANACORDERREQUEST` and several master/code tables; stored procedure `SP_GET_ORDER_NO` |

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/spor00701acinit/process/Spor00701acInitProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acsearch/process/Spor00701acSearchAllProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acsearch/process/Spor00701acSearchCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acchecklink/process/spor00701acChecklinkProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accheckWarning/process/Spor00701accheckWarningProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateNewProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateSaveProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateCopyProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acupdate/process/spor00701acUpdateProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acdelete/process/spor00701acDeleteProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/spor00701acinit/webservice/Spor00701acInitWebService.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acsearch/webservice/Spor00701acSearchCntWebService.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acsearch/webservice/Spor00701acSearchWebService.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acchecklink/webservice/Spor00701acChecklinkWebService.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accheckWarning/webservice/Spor00701accheckWarningWebService.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/webservice/Spor00701acCreateNewWebService.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/webservice/Spor00701acCreateSaveWebService.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/webservice/Spor00701acCreateCopyWebService.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acupdate/webservice/Spor00701acUpdateWebService.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acdelete/webservice/Spor00701acDeleteWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/spor00701acinit/process/Spor00701acInitProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acsearch/process/Spor00701acSearchAllProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acsearch/process/Spor00701acSearchCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accheckWarning/process/Spor00701accheckWarningProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateNewProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateSaveProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateCopyProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acupdate/process/spor00701acUpdateProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor00701acdelete/process/spor00701acDeleteProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/spor00701ac/spor00701ac.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/spor00701ac/spor00701ac.component.html`
- Dominant module/style note: Reuse the existing JAX-RS webservice plus process split, inline `StringBuilder` SQL assembly, shared exclusion-check helpers, and one large Angular component pattern already used by this screen family.
- New tables/source families/screen structure in scope: `no`

## Design Decisions

| ID | Basis | Decision | Requirement Links |
| --- | --- | --- | --- |
| `DES-01` | `confirmed` | The feature keeps count and list as separate endpoints rather than collapsing them into one response. | `REQ-01`, `REQ-02` |
| `DES-02` | `confirmed` | The durable state model is centered on `TAOR59_ANACORDERREQUEST`; all create, save, copy, update, and delete flows operate on that table. | `REQ-01`, `REQ-03`, `REQ-05` |
| `DES-03` | `confirmed` | Existing-row open and mutation flows use `MasterCheckExclusionProcess` for optimistic locking and deleted-row detection. | `REQ-02`, `REQ-03`, `REQ-04` |
| `DES-04` | `confirmed` | Warning evaluation is implemented as a dedicated endpoint invoked before confirm and temporary save, not as inline client-side logic. | `REQ-04` |
| `DES-05` | `confirmed` | The screen reuses shared code-master retrieval, focus-out name lookup, modal master search, and saved-search-condition services instead of owning those concerns locally. | `REQ-05` |
| `DES-06` | `confirmed` | This draft deliberately preserves visible contradictions and gaps from implementation instead of rewriting them into clean requirements. | `REQ-06` |

## Observed Flow

1. The screen loads `accessInfo`, dropdown code lists, and a store list.
2. The user enters required search fields and optional filters.
3. Search count runs first and may also return a `deadline` value for the selected store, section, and group.
4. If count is positive, the row-list endpoint is called and the table is rendered.
5. Clicking a result row first calls check-link to compare `UPDDATETIME`.
6. The input block supports confirm, temporary save, copy, update, and delete actions depending on current row state and local button rules.
7. Confirm and temporary save first call warning-check, then a confirmation dialog, then the mutation endpoint.

## Confirmed Dependencies

- Shared request envelope with `accessInfo`
- Shared response error routing through `fatalError`
- Shared search condition persistence service in Angular
- Shared focus-out name lookup endpoint and modal master-selection screens
- Stored procedure `SP_GET_ORDER_NO` for new order request numbers

## Inferred Design Intent

- `inferred` The screen is designed to work as a local data-entry screen inside a larger purchasing workflow.
- `inferred` The `deadline` result is intended to drive whether new entry or certain mutations remain available for the selected organizational unit.

## Design Gaps To Resolve Before Approval

- `unresolved` Whether the current alarm-field persistence behavior is correct or accidental
- `unresolved` Whether server-side validation should mirror all UI-required rules
- `unresolved` Whether copy should preserve source timestamps and request-user metadata
- `unresolved` Whether missing-row behavior in exclusion checking is acceptable
