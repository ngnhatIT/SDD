---
id: "2026-03-17-sdd4-mode-driven-efficiency"
title: "SDD4 mode-driven efficiency rollout"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
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

## Rollout Strategy

- Apply the documentation updates in one repository change so routing, policy, and operator links stay in sync.
- Treat this as a docs-only framework rollout with no runtime deployment step.
- Keep new rules authoritative only in their canonical homes and use cross-references elsewhere.

## Verification Before Closeout

- Manually inspect cross-references from governance, context, prompts, and ai-ops entrypoints.
- Confirm the new policy and DoD rules do not conflict with existing governance, task profiles, or emergency handling.
- Confirm the lightweight-path guidance still escalates to reduced-path or full-path when scope or risk increases.

## Rollback

- Revert the changed markdown files together if the update causes authority confusion or conflicting routing.
- If a navigation update survives but the canonical rule is reverted, remove the stale link in the same rollback change.

## Release Notes

- Docs-only framework update.
- No runtime code, API, DTO, schema, or build behavior change.
