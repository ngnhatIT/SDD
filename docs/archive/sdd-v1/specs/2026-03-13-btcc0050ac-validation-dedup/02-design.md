---
id: "2026-03-13-btcc0050ac-validation-dedup"
title: "BTCC0050AC validation duplicate-error dedup design"
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

`validateDataList(...)` chạy trước và đã có thể ghi lỗi format cho `modifyCount`. Thêm guard theo cặp `errIndex + itemNm` trước khi custom non-negative set lỗi để tránh duplicate.

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0050ac/process/Btcc0050acProcess.java`; `src/main/java/jp/co/brycen/kikancen/api/btcc0060ac/process/Btcc0060acProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0050ac/webservice/Btcc0050acWebService.java`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Giữ lifecycle của `APIImportProcess`, chỉ thêm dedup guard trong custom validator của process.
- New tables/source families/screen structure in scope: `no`

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Add `hasFieldError(...)` guard before setting non-negative error for `modifyCount`. | `REQ-01`, `REQ-02` |
| `DES-02` | Keep existing error codes and DB processing unchanged. | `REQ-03` |
