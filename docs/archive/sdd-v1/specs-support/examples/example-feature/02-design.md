---
id: "example-feature"
title: "SPPM00061 expired-file filter design"
owner: "Repository Example"
status: "ready-for-implementation"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
  - "03-data-model.md"
  - "04-api-contract.md"
  - "05-behavior.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: extend the existing `SPPM00061` search request with an `expiredOnly` flag, apply the same condition to count, list, and CSV export paths, and keep the screen and saved-condition flow aligned.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`

## Current State

- `SPPM00061` search returns mixed active and expired attachment rows.
- Users can export the same mixed result set to CSV.
- The current repository does not show a full-path example package for a search and export parity change with SDD2+ companion artifacts.

## Target State

- The search screen offers an `expiredOnly` filter that defaults to `false`.
- Search count, search list, and CSV export use the same expired-only predicate.
- Saved conditions restore the filter consistently.
- The example feature package shows aligned prose, contracts, risk notes, decision notes, and generated spec-pack output.

## Impacted Areas

- Backend: `sppm00061search` request DTOs, search processes, and CSV export process
- Frontend: `sppm00061.component.ts` and `sppm00061.component.html`
- Database: existing expiry-related columns only; no new tables
- Integrations: generated spec-pack for AI execution aid coverage

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Add `expiredOnly` to the existing search workflow instead of creating a new expired-file endpoint. | `REQ-01`, `REQ-03` |
| `DES-02` | Apply the same expired-only predicate to count, list, and CSV export sibling flows. | `REQ-02` |
| `DES-03` | Treat omitted `expiredOnly` as `false` for backward compatibility with existing callers and saved conditions. | `REQ-03` |
| `DES-04` | Keep the example feature documentation, contracts, and generated spec-pack aligned as one governed set. | `REQ-04` |

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchAllRecProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061CSVExportProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061SearchWebService.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061SearchRecCntWebService.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061CSVExportWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchAllRecProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.html`
- Dominant module/style note: Reuse the current search-family split for count, list, and export; preserve `StringBuilder` SQL assembly style; reuse the existing screen component and shared CSV export flow instead of creating a new export-specific path.
- New tables/source families/screen structure in scope: `no`

## Non-Changes

- No new table or audit row
- No change to attachment delete, save, or download flows
- No asynchronous export path
