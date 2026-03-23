---
id: "2026-03-13-btcc0070-0080-validation-review"
title: "BTCC0070AC and BTCC0080AC validation review design"
owner: "Kikancen API Team"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
---

# Design

## Review Approach

1. Inspect process validators in `Btcc0070acProcess` and `Btcc0080acProcess`.
2. Confirm behavior against dedup standard and cross-field date-range rule.
3. Record findings and decision.

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0070ac/process/Btcc0070acProcess.java`; `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/process/Btcc0080acProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/api/btcc0070ac/webservice/Btcc0070acWebService.java`; `src/main/java/jp/co/brycen/kikancen/api/btcc0080ac/webservice/Btcc0080acWebService.java`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Keep existing import-process validation flow; review-only scope for 0070/0080.
- New tables/source families/screen structure in scope: `no`

## Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | `BTCC0070AC` is compliant with dedup guard (`hasFieldError`) in non-negative validation path. | `REQ-01`, `REQ-03` |
| `DES-02` | `BTCC0080AC` date-range validation is retained as-is; no change required. | `REQ-02`, `REQ-03` |
