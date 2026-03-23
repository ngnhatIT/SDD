---
id: "2026-03-16-codebase-derived-rule-calibration"
title: "Codebase-derived rule calibration design"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "docs/sdd/standards/module-patterns/search.md"
  - "docs/sdd/standards/module-patterns/csv.md"
  - "docs/sdd/standards/security-validation-and-logging.md"
  - "docs/sdd/standards/known-inconsistencies.md"
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: update only rule artifacts that can be supported by repeated or explicit patterns in the scanned anchors.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`, `REQ-05`, `REQ-06`, `REQ-07`

## Current State

- Search, CSV import, validation, SQL, constant-usage, and frontend template rules exist, but some guidance is still too generic or too absolute for the observed code.
- The scanned anchors show both strong repeated patterns and real local inconsistencies.

## Target State

- Canonical standards and bridge rules describe only anchored behavior.
- Conflicting local styles are documented as inconsistencies to preserve, not normalized by default.
- Shared constant catalogs and `VMT050` code-constant usage are called out explicitly so agents do not reintroduce hardcoded literals.
- Frontend template guidance reflects the repeated block and message placement patterns in the scanned `.html` anchors.

## Impacted Areas

- Backend: standards and bridge rules for process, validation, SQL, and CSV import
- Frontend: standards and bridge rules for search screen flow
- Database: none
- Integrations: none

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Update search-related rules only for patterns repeated across both `Spvm00131` and `SPMT00231`. | `REQ-01` |
| `DES-02` | Update CSV import rules only for lifecycle steps repeated across `Spmt00231CsvImportProcess` and `Spmt01102ACCsvImportProcess`. | `REQ-02` |
| `DES-03` | Update validation rules to emphasize `beforeProcessing(...)`, checker reuse, and post-shared custom validation deduplication as shown in the scanned backend anchors. | `REQ-03` |
| `DES-04` | Treat `@Path` leading slash style and parameter-index style as legacy inconsistencies; preserve local family style unless the change explicitly normalizes it. | `REQ-04` |
| `DES-05` | Update SQL guidance to match the observed `StringBuilder` query construction pattern and to preserve the touched family's `TMT050` lookup strategy, with `VMT050_ALL` preferred where that family already uses it. | `REQ-05` |
| `DES-06` | Update hardcode-prevention guidance to require scanning the shared constant catalogs first and to map `VMT050` `DATACD` values to `ConstCcd` plus `RCDKBN` values to `ConstCcdDef`. | `REQ-06` |
| `DES-07` | Update frontend template guidance only for `.html` patterns repeated across both `Spvm00131` and `SPMT00231`, and leave non-repeated block-name conventions out of generalized rules. | `REQ-07` |

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/spvm00131search/process/Spvm00131SearchAllProcess.java`, `src/main/java/jp/co/brycen/kikancen/spvm00131Update/process/Spvm00131UpdateProcess.java`, `src/main/java/jp/co/brycen/kikancen/spmt00231search/process/Spmt00231SearchAllRecProcess.java`, `src/main/java/jp/co/brycen/kikancen/spmt00231csvimport/process/Spmt00231CsvImportProcess.java`, `src/main/java/jp/co/brycen/kikancen/spmt01102accsvimport/process/Spmt01102ACCsvImportProcess.java`, `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/process/Btcc0080acProcess.java`, `src/main/java/jp/co/brycen/kikancen/common/process/MasterNameGetProcess.java`, `src/main/java/jp/co/brycen/kikancen/common/process/MasterCodeCheckProcess.java`, `src/main/java/jp/co/brycen/kikancen/tmt050allkbnsearch/process/Tmt050AllKbnSearchProcess.java`, `src/main/java/jp/co/brycen/kikancen/api/bcc0030ac/process/Bcc0030acProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/spvm00131Update/webservice/Spvm00131WebService.java`, `src/main/java/jp/co/brycen/kikancen/spmt00231delete/webservice/Spmt00231DeleteWebService.java`, `src/main/java/jp/co/brycen/kikancen/spmt01102accsvimport/webservice/Spmt01102ACCsvImportWebService.java`, `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/webservice/Btcc0080acWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/spvm00131search/process/Spvm00131SearchAllProcess.java`, `src/main/java/jp/co/brycen/kikancen/spvm00131Update/process/Spvm00131UpdateProcess.java`, `src/main/java/jp/co/brycen/kikancen/spmt00231search/process/Spmt00231SearchAllRecProcess.java`, `src/main/java/jp/co/brycen/kikancen/spmt00231csvimport/process/Spmt00231CsvImportProcess.java`, `src/main/java/jp/co/brycen/kikancen/spmt01102accsvimport/process/Spmt01102ACCsvImportProcess.java`, `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/process/Btcc0080acProcess.java`, `src/main/java/jp/co/brycen/kikancen/common/process/MasterNameGetProcess.java`, `src/main/java/jp/co/brycen/kikancen/common/process/MasterCodeCheckProcess.java`, `src/main/java/jp/co/brycen/kikancen/tmt050allkbnsearch/process/Tmt050AllKbnSearchProcess.java`, `src/main/java/jp/co/brycen/kikancen/api/bcc0030ac/process/Bcc0030acProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/spvm00131/spvm00131.component.ts`, `src/main/webapp/angular/src/app/components/spmt00231/spmt00231.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/spvm00131/spvm00131.component.html`, `src/main/webapp/angular/src/app/components/spmt00231/spmt00231.component.html`
- Frontend shared constant anchor files: `src/main/webapp/angular/src/app/common/Const.ts`, `src/main/webapp/angular/src/app/common/ConstMessageID.ts`, `src/main/webapp/angular/src/app/common/DisplayScreenId.ts`, `src/main/webapp/angular/src/app/common/ConstCcd.ts`, `src/main/webapp/angular/src/app/common/ConstCcdDef.ts`
- Backend shared constant anchor files: `src/main/java/jp/co/brycen/common/ConstantValue.java`, `src/main/java/jp/co/brycen/common/FuncID.java`, `src/main/java/jp/co/brycen/common/ConstCcd.java`, `src/main/java/jp/co/brycen/common/ConstCcdDef.java`
- Dominant module/style note: Derive rules only from repeated patterns across the named anchors; when anchors conflict, preserve the touched local family style or record an inconsistency instead of normalizing by prompt.
- New tables/source families/screen structure in scope: `no`

## Non-Changes

- No production code changes in the scanned modules
- No API or DTO contract changes
- No new business rules beyond the scanned anchors
