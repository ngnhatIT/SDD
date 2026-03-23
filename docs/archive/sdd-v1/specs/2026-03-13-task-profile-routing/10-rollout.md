---
id: "2026-03-13-task-profile-routing"
title: "Task-profile routing for agent markdown loading rollout"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/context/"
  - "docs/sdd/governance/"
  - "docs/sdd/templates/"
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Deployment Order

1. Publish the new ADR and governing feature package.
2. Add the task-profile routing context doc and prompt header contract.
3. Update AGENTS, loading-order, governance, and spec guidance docs.
4. Add canonical request examples for the supported task profiles.
5. Validate the new governing feature package.

## Smoke Checks

- Confirm the five supported task profiles are documented.
- Confirm the prompt header contract appears in AGENTS and task-profile docs.
- Confirm governance docs explicitly say that `review-from-rules` does not bypass a governing feature package for governed changes.
- Confirm the new feature package passes validation.

## Rollback

1. Revert the routing doc, ADR, and guidance updates together.
2. Remove the task-profile examples if the routing contract is rejected.
3. Re-run feature package validation to confirm the prior baseline.

## Release Risks

- Request authors may initially omit the new header fields until the convention is socialized.
- Teams may misread `review-from-rules` as permission to skip canonical specs unless the examples are clear.

## Monitoring

- Reviewer feedback on the prompt header clarity
- Repeated confusion about when a spec-pack is optional versus required
- Requests that misuse `spec_back.md` as approval source
