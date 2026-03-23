---
id: "2026-03-17-sdd-framework-rationalization"
title: "SDD framework rationalization rollout"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Deployment Order

1. Add the governing feature package for this framework cleanup.
2. Publish the framework audit report and cleanup or migration plan.
3. Apply safe authority and legacy-status clarifications to the current framework docs.
4. Validate the edited documentation paths and record implementation evidence.
5. Review the file-level merge or drop recommendations before any destructive follow-up cleanup.

## Rollback

1. Revert only the documentation files changed by this feature package.
2. Keep the audit report and migration plan if the team still wants the analysis, or revert them with the same branch if the entire effort is withdrawn.
3. Do not partially remove legacy bridge warnings without also reverting the related canonical-clarity edits.

## Release Checks

- Open `docs/sdd/README.md` and confirm the canonical versus legacy distinction is visible.
- Open `docs/archive/sdd/history/2026-03-17-rationalization/10-sdd-framework-audit-report.md` and `docs/archive/sdd/history/2026-03-17-rationalization/11-sdd-framework-cleanup-migration-plan.md`.
- Confirm the edited `agent/` entry files no longer read like primary source-of-truth entrypoints.
- Confirm the implementation report records residual risks and required human-confirmation decisions.
