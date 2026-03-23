---
id: "2026-03-17-sdd4-operating-model-optimization"
title: "SDD4 operating-model optimization rollout"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Deployment Steps

1. Update the governing feature package and canonical framework docs in the same change set.
2. Verify the new task-mode matrix and daily guide are linked from the expected entrypoints.
3. Verify report templates remain the only canonical implementation and review report structures.
4. Manually inspect active bridge references for non-canonical wording and current repo-state accuracy.

## Rollback Steps

1. Revert the documentation edits in this feature package and the touched canonical docs together.
2. Remove the new matrix and daily guide only if the linked entrypoints are reverted in the same rollback.
3. Revert template changes together with any README or quick-guide references that describe the stronger schema.

## Release Notes

- Docs-only framework update.
- No runtime behavior, API, SQL, or build change.

## Verification Notes

- Manual verification is the primary evidence path for this change.
- If repository diff tooling is unavailable, record file-by-file inspection evidence in `11-implementation-report.md`.
