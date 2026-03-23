---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC observed requirements"
owner: "Unassigned"
status: "draft"
last_updated: "2026-03-13"
related_specs:
  - "02-design.md"
  - "03-data-model.md"
  - "04-api-contract.md"
  - "05-behavior.md"
  - "06-edge-cases.md"
dependencies:
  - "README.md"
implementation_refs:
  - "src/main/webapp/angular/src/app/components/spor00701ac/spor00701ac.component.ts"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acsearch/process/Spor00701acSearchAllProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acupdate/process/spor00701acUpdateProcess.java"
test_refs:
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Requirements

## Problem

- This document records observed requirements from implementation, not approved business requirements.
- The repository currently contains working `SPOR00701AC` code but no governing feature package or spec-pack.
- Future changes need a draft package that captures current behavior without silently approving questionable implementation details.

## In Scope

- One screen family: `SPOR00701AC`
- One durable business table family centered on `TAOR59_ANACORDERREQUEST`
- Shared code-master, product, partner, user, store, and group lookups used directly by this screen
- UI-visible confirm, warning, and info messaging that is directly referenced by the screen or shared exclusion flow

## Out Of Scope

- Approval of business rules not directly provable from implementation
- Downstream approval, ordering, receipt, or purchase-slip behavior beyond the statuses inferred from search SQL
- Any schema redesign or UI redesign
- Any attempt to fix current runtime behavior in this retrospective package

## Requirements

| ID | Basis | Requirement | Evidence |
| --- | --- | --- | --- |
| `REQ-01` | `confirmed` | The screen must let the user search individual order request rows for the current company by required UI context fields `store`, `section`, `group`, and `request type`, plus optional filters `product`, `partner`, order request date range, delivery date range, user, and status list. | Angular validation and request assembly in `spor00701ac.component.ts`; SQL filter assembly in `Spor00701acSearchAllProcess.java` |
| `REQ-02` | `confirmed` | Search must execute as separate count and row-list calls, support paging, and return a group-specific `deadline` string when available. | `Spor00701acSearchCntProcess.java`; `Spor00701acSearchProcess.java`; `spor00701ac.component.ts` |
| `REQ-03` | `confirmed` | The screen must support entering order-request details and performing create-new, temporary-save, copy, update, and delete actions against `TAOR59_ANACORDERREQUEST`. | Angular submit flows and backend mutation processes under `spor00701accreate`, `spor00701acupdate`, and `spor00701acdelete` |
| `REQ-04` | `confirmed` | Opening or mutating an existing row must go through shared optimistic-lock and deleted-row checks based on `SYSTEMSLIPNO`, `CMPNYCD`, and `UPDDATETIME`. | `MasterCheckExclusionProcess.java`; `spor00701acChecklinkProcess.java`; `spor00701acUpdateProcess.java`; `spor00701acDeleteProcess.java` |
| `REQ-05` | `confirmed` | Before confirm or temporary save, the screen must request warning evaluation for discontinued-date, maximum-amount, and remarks conditions and show a warning confirmation when any message is returned. | `Spor00701accheckWarningProcess.java`; `spor00701ac.component.ts` |
| `REQ-06` | `confirmed` | The feature must preserve shared access-info usage, company scoping, code-master lookup patterns, common message routing, and search-condition persistence services already used by the screen family. | `spor00701ac.component.ts`; JAX-RS webservices; shared base classes and services |

## Constraints

- Keep confirmed, inferred, and unresolved statements visibly separate.
- Do not normalize current runtime oddities into approved behavior without follow-up review.
- Preserve the existing tenant, company, and shared error-flow assumptions until a future approved change says otherwise.

## Inferred Business Intent

- `inferred` `SPOR00701AC` appears to be the manual entry screen for individual order requests.
- `inferred` The screen likely creates requests that later move into approval, ordering, and receipt states outside this module.
- `inferred` The `deadline` display likely indicates whether new entry is still allowed for the selected organizational context.

## Unresolved Requirement Questions

- `unresolved` Should direct API clients be allowed to search without the UI-required fields, or should the backend enforce the same required-field contract?
- `unresolved` Which status values are intentionally supported by the screen versus merely returned by current SQL?
- `unresolved` Are warning messages advisory only, or must alarm persistence be part of the durable contract?
- `unresolved` Should copy create a new business event with new request date and request user, or preserve the original source values?
