---
id: "2026-03-13-btcc0060ac-validation-dedup"
title: "BTCC0060AC validation duplicate-error dedup rollout"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-13"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
---

# Rollout

1. Deploy backend artifact containing `Btcc0060acProcess` update.
2. Run API smoke check for `BTCC0060AC` invalid payload cases.
3. Confirm error list no longer returns duplicate entries for same `errIndex + itemNm`.

# Rollback

Revert commit that introduced dedup guard in `Btcc0060acProcess` and redeploy backend artifact.
