---
id: "2026-03-17-sdd4-framework-self-validation"
title: "SDD4 framework self-validation and self-audit rollout"
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

## Deployment Steps

1. Update canonical framework docs and validator scripts in the same branch.
2. Run the validator suite and any targeted validator commands needed for new fixtures.
3. Verify operator-facing docs and self-audit guidance reflect the implemented validator scope and limitations.

## Release Checks

- `scripts/sdd/test_validate_specs.sh` passes
- targeted validator commands for new checks pass or fail as expected
- implementation evidence records grounded gaps and blind spots explicitly
- touched canonical docs do not introduce a competing authority surface

## Rollback

- Revert the validator and docs changes together if the new checks prove too noisy or conflict with canonical rules.
- If a specific new rule is the problem, disable or remove only that grounded rule and keep the rest of the validator unchanged.
- Preserve any implementation-report notes about false positives or remaining blind spots when adjusting the rule set.
