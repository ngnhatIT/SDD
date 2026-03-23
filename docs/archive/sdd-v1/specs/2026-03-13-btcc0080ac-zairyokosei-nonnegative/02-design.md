---
id: "2026-03-13-btcc0080ac-zairyokosei-nonnegative"
title: "BTCC0080AC zairyo kosei non-negative validation design"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
---

# Design

## Overview

After `validateDataList(...)` for `mZairyoKoseiSs`, run an additional non-negative validator for target numeric fields and reuse dedup guard `errIndex + itemNm`.

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/process/Btcc0080acProcess.java`; `src/main/java/jp/co/brycen/kikancen/api/btcc0070ac/process/Btcc0070acProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/webservice/Btcc0080acWebService.java`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Keep `APIImportProcess` shared validation first, then custom non-negative checks with duplicate-error guard.
- New tables/source families/screen structure in scope: `no`

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Add non-negative validation method for `mZairyoKoseiSs` in upsert flow only. | `REQ-01` |
| `DES-02` | Add `hasFieldError` guard before setting non-negative errors. | `REQ-02` |
| `DES-03` | Keep existing response shape and SQL logic unchanged. | `REQ-03` |
