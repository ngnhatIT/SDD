---
id: "2026-03-13-execution-brief-generator"
title: "Execution-brief generator for task-specific SDD loading rollout"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "scripts/sdd/build_execution_brief.sh"
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Deployment Order

1. Add `scripts/sdd/build_execution_brief.sh`.
2. Update command guidance in `AGENTS.md`, `docs/specs/README.md`, and `scripts/sdd/README.md`.
3. Generate the sample execution brief for the example feature package.
4. Run spec validation on the governing feature package for this tooling change.

## Smoke Checks

- Generate the example brief and confirm the output file path.
- Confirm the brief includes `Snapshot`, `Mandatory Reads`, `Locked Decisions`, `Required Validations Before Done`, and `Expected Outputs`.
- Confirm missing request-scoped inputs are rendered as `unknown (...)` or `n/a` instead of guessed values.

## Rollback

1. Remove `scripts/sdd/build_execution_brief.sh`.
2. Remove generated `*.brief.md` outputs that were introduced by this feature.
3. Revert the command-documentation lines for the brief generator.

## Release Risks

- Generated briefs may drift if teams edit source specs without regenerating the brief.
- The first version uses narrow markdown parsing and may omit narrative details that are not stated under expected headings.

## Monitoring

- Number of governed features with generated briefs used in review
- Feedback on missing fields that still force users back into manual control-plane synthesis
