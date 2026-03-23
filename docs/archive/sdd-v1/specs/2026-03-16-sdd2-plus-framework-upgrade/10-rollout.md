---
id: "2026-03-16-sdd2-plus-framework-upgrade"
title: "SDD2+ additive framework upgrade rollout"
owner: "Codex"
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

1. Merge the documentation and script updates in one branch.
2. Treat the new SDD2+ artifacts as immediately available for new governed work.
3. Keep the current SDD2 core documents and `scripts/sdd/` commands as the active baseline.

## Smoke Checks

- Open `docs/sdd/README.md` and confirm the additive SDD2+ workflow is clear.
- Run the example feature validation and spec-pack build commands.
- Confirm `tools/sdd/README.md` still points to `scripts/sdd/` commands.

## Rollback

- Revert the documentation and script changes together.
- Remove the example feature package and generated pack if the framework upgrade is rolled back.
