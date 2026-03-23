---
id: "<feature-id>"
title: "<feature title> design"
owner: "<team or person>"
status: "draft"
last_updated: "YYYY-MM-DD"
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

Canonical numbered template for `02-design.md`.

## Overview

- Approach: `<high-level solution>`
- Requirement links: `<REQ-01, REQ-02>`

## Current State

- `<how the repo works now>`

## Target State

- `<what changes after this work>`

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | `<decision>` | `<REQ-01>` |

## Impacted Areas

- Backend: `<area or n/a>`
- Frontend: `<area or n/a>`
- Database: `<area or n/a>`
- Integrations: `<area or n/a>`
- Operations: `<area or n/a>`

## Source Base Anchors

- Backend process anchor files: `<repo-relative path or n/a>`
- Backend webservice anchor files: `<repo-relative path or n/a>`
- SQL anchor files: `<repo-relative path or n/a>`
- Frontend .ts anchor files: `<repo-relative path or n/a>`
- Frontend .html anchor files: `<repo-relative path or n/a>`
- Dominant module/style note: `<what local pattern must be mirrored>`
- Shared helper or constant reuse note: `<helpers, constants, message catalogs, base-common flows, or table helpers that the touched scope must reuse>`
- Touched-scope cleanup note: `<unused-import cleanup, redundant-code removal, comment rewrite note, or n/a>`
- Backend validation/helper reuse note: `<beforeProcessing, error DTOs, ValidateUtility, MasterCodeCheckProcess, MasterNameGetProcess, or n/a>`
- Frontend base-common reuse note: `<validateFields, fnFocusOutCommon, generateColumns, SearchConditionManagementService, or n/a>`
- Frontend structure reuse note: `<existing component/service/dto/helper shape that must be reused, or n/a>`
- Touched-scope modernization note: `<what weaker local duplicate must be modernized inside scope, or n/a>`
- Mixed-pattern classification note: `<preferred current / tolerated legacy / required migration by concern, or n/a>`
- Frontend-backend validation parity note: `<required, not required, or explicit approved divergence>`
- Field-level vs popup error-routing note: `<expected routing for touched frontend validation or fatal-error flows, or n/a>`
- Frontend responsive layout note: `<breakpoint/grid expectations for touched frontend forms or n/a>`
- Paired-field alignment note: `<FROM-TO or range-field alignment expectations on smaller windows, or n/a>`
- Search or CSV lifecycle note: `<init/save/load/count/list/pager/zero-result or csv preprocess/import lifecycle expectations, or n/a>`
- Comment language note: `<English-only new comments, touched-comment rewrite note, or n/a>`
- New tables/source families/screen structure in scope: `<yes or no>`

Use repo-relative paths. Use `n/a` when the layer is not touched. The last line defaults to `no` unless the governing spec explicitly opens that scope. Template placeholders such as `<...>`, `TODO`, or `TBD` are not valid final anchor values.

## Non-Changes

- `<locked non-change boundary>`
