---
id: "2026-03-13-btcc0080ac-zairyokosei-nonnegative"
title: "BTCC0080AC zairyo kosei non-negative validation rollout"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-13"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
---

# Rollout

1. Deploy backend artifact with `BTCC0080AC` validation update.
2. Execute invalid payload smoke tests for `mZairyoKoseiSs` negative values.
3. Confirm duplicate-error suppression still works.

# Rollback

Revert the `Btcc0080acProcess` validation commit and redeploy backend.
