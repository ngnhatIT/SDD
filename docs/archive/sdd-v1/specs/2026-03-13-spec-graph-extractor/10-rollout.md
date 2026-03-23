---
id: "2026-03-13-spec-graph-extractor"
title: "First-pass spec graph extractor for feature packages rollout"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "scripts/sdd/build_spec_graph.sh"
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Deployment Order

1. Add `scripts/sdd/build_spec_graph.sh`.
2. Update command guidance and limitations notes.
3. Generate `spec.graph.yaml` for the selected existing feature packages.
4. Validate the governing feature package for this tooling change.

## Smoke Checks

- Generate a graph for the example customer export feature and confirm `REQ`, `DES`, `TASK`, `AC`, and `TC` nodes are present.
- Generate a graph for the task-profile-routing feature and confirm heading-style `REQ` and `DES` extraction works.
- Confirm graphs include warnings or manual authoring notes for non-explicit contract, entity, and component relationships.

## Rollback

1. Remove `scripts/sdd/build_spec_graph.sh`.
2. Remove generated `spec.graph.yaml` files added by this feature.
3. Revert the command and limitations documentation lines.

## Release Risks

- The first extractor only sees current markdown conventions and may miss legacy variations.
- Generated graphs can drift if later changes do not regenerate them.
- Consumers might over-trust inferred classification or incomplete links if the non-authoritative role is ignored.

## Monitoring

- Number of features with generated graphs
- Number of manual authoring gaps repeatedly reported by the extractor
- Whether future validators or review tools can consume the graph without additional scraping
