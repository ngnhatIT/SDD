# Rollout

## Deployment Steps

1. Add the canonical SDD documents under `docs/`.
2. Update the root repo entrypoints and PR template.
3. Migrate reusable legacy guidance into `docs/sdd/standards/`, `docs/sdd/checklists/`, and `docs/sdd/process/`.
4. Remove the obsolete duplicate documentation tree under `agent/agent/`.

## Risk And Rollback

- Main risk: stale links or inconsistent file names after migration
- Rollback trigger: documentation links or feature package guidance no longer resolve cleanly
- Rollback steps:
  1. restore removed docs from git history if needed
  2. correct broken links before marking the migration complete

## Release Checks

- root `README.md` points to the correct docs entrypoints
- `docs/README.md` points to `docs/decisions/`
- `docs/specs/README.md` matches the numbered package standard
- no references remain to the removed `agent/agent/` docs as active sources of truth
