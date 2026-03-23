---
id: "2026-03-19-static-analysis-warning-remediation"
title: "Static-analysis warning remediation design"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
---

# Design

## Overview

Apply the narrowest source-level changes that satisfy the reported static-analysis warnings while preserving the touched screen-family HTML structure and the touched process-family Java execution flow.

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/spor01501accheckupdate/process/Spor01501acCheckUpdateProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor01501acupdate/process/Spor01501acUpdateProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor01101acupdate/process/Spor01101acUpdateAlarmProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor01101acsearch/process/Spor01101acSearchAllRecProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor01101acsearch/process/Spor01101acSearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor01101acupdate/process/Spor01101acUpdateProcess.java`; `src/main/java/jp/co/brycen/kikancen/spmt01103accsvimport/process/Spmt01103ACCsvImportProcess.java`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/spor01501accheckupdate/process/Spor01501acCheckUpdateProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor01501acupdate/process/Spor01501acUpdateProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor01101acupdate/process/Spor01101acUpdateAlarmProcess.java`; `src/main/java/jp/co/brycen/kikancen/spor01101acsearch/process/Spor01101acSearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/spmt01103accsvimport/process/Spmt01103ACCsvImportProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.ts`; `src/main/webapp/angular/src/app/components/spmt00241/spmt00241.feature.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.html`; `src/main/webapp/angular/src/app/components/spmt00241/spmt00241.feature.component.html`
- Dominant module/style note: Preserve the existing process-centric backend structure and screen-template frontend structure; fix warnings with local guards, attribute additions, and narrow helper renames instead of introducing new layers or changing transport or SQL contracts.
- New tables/source families/screen structure in scope: `no`

## Schema Binding

- `docs/sdd/context/schema_database.yaml`
- Relevant tables:
  - `tamt026_productagreement`
  - `tamt029_group`
  - `taor59_anacorderrequest`
  - `tapr04_scheduledfordeliveryfile`
  - `tmt002_user`

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Add `scope` attributes to the reported `spor01401ac` table headers and assign unique DOM ids in `spmt00241` while preserving the existing label bindings and click handlers. | `REQ-01` |
| `DES-02` | Replace analyzer-ambiguous null assumptions in the `spor01501ac` date-comparison logic with explicit null checks before string comparison, and keep the `spor01101ac` order-lot guard explicit before `remainder(...)`. | `REQ-02` |
| `DES-03` | Rename the local `Spor01101acSearchRecCntProcess` helper that duplicates a parent private method name and remove the redundant early `return;` from `Spor01101acUpdateProcess.beforeProcessing(...)` by restructuring the control flow only. | `REQ-03` |
| `DES-04` | Remove unused password-named constants from `Spmt01103ACConstant` instead of changing the supplier CSV-import SQL or stored values. | `REQ-04` |

## Confidence Note

- Confidence: `medium`
- Basis: all planned changes are grounded in the current workspace files and schema authority, but one user-listed warning in `Spor01101acCreateProcess` is not reproducible from the current source snapshot.

