---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment rollout"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
---

# Rollout

1. Deploy the backend artifact with the `BTCC0080AC` validation-rule calibration.
2. Re-run the reported optional-field and `templateFlg` omission cases.
3. Re-check existing `BTCC0080AC` date-range and non-negative validation scenarios.

# Rollback

Revert the `BTCC0080AC` validation-rule calibration change and redeploy the previous backend artifact.

