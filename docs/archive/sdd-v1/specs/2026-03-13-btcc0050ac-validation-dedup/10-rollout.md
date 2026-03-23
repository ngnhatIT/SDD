---
id: "2026-03-13-btcc0050ac-validation-dedup"
title: "BTCC0050AC validation duplicate-error dedup rollout"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-13"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
---

# Rollout

1. Deploy backend artifact with `Btcc0050acProcess` dedup guard.
2. Execute invalid-payload smoke for `BTCC0050AC`.
3. Confirm no duplicate error entries for `modifyCount` per record.

# Rollback

Revert `Btcc0050acProcess` dedup guard commit and redeploy backend artifact.
