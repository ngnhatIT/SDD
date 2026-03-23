---
id: "2026-03-13-btcc0060ac-validation-dedup"
title: "BTCC0060AC validation duplicate-error dedup design"
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

Shared validator chạy trước và đã ghi lỗi format vào danh sách lỗi. Bổ sung check tồn tại lỗi theo cặp `errIndex + fieldName` trong non-negative validator để tránh add lỗi trùng.

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0060ac/process/Btcc0060acProcess.java`; `src/main/java/jp/co/brycen/kikancen/api/btcc0070ac/process/Btcc0070acProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0060ac/webservice/Btcc0060acWebService.java`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Giữ pattern `validateDataList(...)` của `APIImportProcess` chạy trước, custom non-negative chạy sau; chỉ thêm guard dedup trong process hiện tại.
- New tables/source families/screen structure in scope: `no`

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Thêm helper kiểm tra field đã có lỗi trước khi set lỗi số âm trong `Btcc0060acProcess`. | `REQ-01`, `REQ-02` |
| `DES-02` | Không thay đổi error code, response schema, và SQL xử lý batch. | `REQ-03` |
