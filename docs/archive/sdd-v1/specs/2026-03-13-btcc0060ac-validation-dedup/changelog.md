---
id: "2026-03-13-btcc0060ac-validation-dedup"
title: "BTCC0060AC validation duplicate-error dedup changelog"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-13"
---

# Changelog

## 2026-03-13

- Added dedup guard in `Btcc0060acProcess` to avoid duplicate error entries for same `errIndex + itemNm`.
- Added reduced-path feature package with requirements, design, tasks, acceptance criteria, and test cases for duplicate-error handling.
