---
id: "2026-03-13-btcc0060ac-validation-dedup"
title: "BTCC0060AC validation duplicate-error dedup"
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

Fix duplicate validation errors in `BTCC0060AC` import flow when a numeric field already fails shared format validation and then is re-checked by non-negative custom validation.

# Scope

- In scope: backend process validation behavior in `Btcc0060acProcess`.
- Out of scope: DTO/API contract changes, SQL behavior changes, frontend changes.
