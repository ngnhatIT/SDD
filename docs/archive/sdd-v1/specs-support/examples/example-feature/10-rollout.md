---
id: "example-feature"
title: "SPPM00061 expired-file filter rollout"
owner: "Repository Example"
status: "ready-for-implementation"
last_updated: "2026-03-16"
related_specs:
  - "README.md"
dependencies: []
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Deployment Steps

1. Deploy the backend request and search-family changes with the frontend `SPPM00061` screen change in the same release.
2. Keep the generated example spec-pack with the example feature package for agent onboarding.

## Smoke Checks

- Search `SPPM00061` with `expiredOnly = false` and confirm the current mixed result set still appears.
- Search with `expiredOnly = true` and confirm the result count drops to expired rows only.
- Export the filtered result set and confirm row parity with the on-screen list.

## Rollback

- Revert the additive `expiredOnly` request field and screen filter together.
- Remove the example pack if the example feature package is rolled back.
