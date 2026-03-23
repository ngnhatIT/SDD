---
id: "2026-03-19-sdd-delivery-goal-realignment"
title: "SDD delivery-goal realignment rollout"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-19"
related_specs:
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "07-tasks.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Deployment Steps

- Apply the goal, governance, routing, testing, and metrics wording updates in one repository change so the framework message stays internally consistent.
- Treat this as a docs-only framework rollout with no runtime deployment step.
- Keep the new goal in one canonical doc and use short cross-links elsewhere.

## Release Checks

- Confirm the new goal statement does not weaken source-of-truth priority, anti-hallucination rules, or stop rules.
- Confirm lightweight-path language still escalates when scope or risk grows.
- Confirm testing guidance still reflects the repo's limited automation reality while requiring honest proof.
- Confirm feedback-loop language stays grounded in existing artifacts and workflows instead of inventing a new process hub.

## Rollback

- Revert the changed markdown files together if the update introduces conflicting framework intent or duplicate authority.
- If the goal document is removed in a rollback, remove any cross-links to it in the same change.

## Release Notes

- Docs-only framework update.
- No runtime code, contract, schema, or build behavior change.
