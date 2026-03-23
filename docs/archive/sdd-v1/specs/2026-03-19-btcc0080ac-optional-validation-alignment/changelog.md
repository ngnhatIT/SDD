---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment changelog"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-19"
---

# Changelog

## 2026-03-19

- Added a reduced-path governing package for the reported `BTCC0080AC` optional-field validation bug.
- Calibrated the `BTCC0080AC` static validation rules so nullable optional fields no longer use shared required validation.
- Added a narrow process-level required check for `mZairyoKoseiSs.seihinCd` to preserve key validation without reintroducing false positives on `mHaigoKoseiHdrs`.
