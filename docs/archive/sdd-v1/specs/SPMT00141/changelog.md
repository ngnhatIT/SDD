---
id: "SPMT00141-changelog"
title: "SPMT00141 changelog"
owner: "WMS Delivery Team"
status: "in_progress"
last_updated: "2026-03-18"
related_specs:
  - "README.md"
dependencies: []
implementation_refs: []
test_refs: []
---

# Feature Changelog

## 2026-03

- Created the canonical `docs/specs/SPMT00141/` feature package from `docs/spec-packs/SPMT00141.md`.
- Recorded the requested behavior for generated `PRODUCTCD`, copy, manual-code removal, and four new fields.
- Added the four requested `TMT026_PRODUCT` columns to `schema_database.yaml` using existing local column patterns.
- Added `TAMT050_PRODUCTNUMBERING` to `schema_database.yaml` using the local numbering-control table pattern.
- Logged the remaining blocker as the unresolved `KANRIKBN` selector rule.
- Recorded a temporary deferred scope on `2026-03-18` so non-numbering implementation can proceed while numbering and copy remain blocked by the unresolved selector.
