---
id: "2026-03-13-btcc0050ac-validation-dedup"
title: "BTCC0050AC validation duplicate-error dedup"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Feature Summary

Fix duplicate validation errors in `BTCC0050AC` when `modifyCount` already fails shared format validation and is re-checked by custom non-negative validation.

# Scope

- In scope: backend validation behavior in `Btcc0050acProcess`.
- Out of scope: API contract/DTO shape/SQL flow/frontend behavior.
