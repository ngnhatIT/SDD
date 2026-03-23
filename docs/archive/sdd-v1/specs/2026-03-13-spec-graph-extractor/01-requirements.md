---
id: "2026-03-13-spec-graph-extractor"
title: "First-pass spec graph extractor for feature packages requirements"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "README.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "README.md"
implementation_refs:
  - "scripts/sdd/build_spec_graph.sh"
  - "docs/specs/"
test_refs:
  - "09-test-cases.md"
---

# Requirements

## Problem Statement

The repository needs a machine-readable graph behind the existing markdown feature package, but current automation still depends on ad hoc scraping of human-oriented files. A first extractor is needed to normalize explicit metadata, IDs, and trace links without replacing the current markdown source of truth.

## Scope

### In Scope

- Generate `spec.graph.yaml` from an existing feature package.
- Extract feature metadata, scope, anchors, open questions, `REQ`, `DES`, `TASK`, `AC`, and `TC` items.
- Extract explicit contract file references when they are named in prose.
- Extract only obvious explicit trace links from current markdown tables and headings.
- Mark uncertain or non-extractable relationships explicitly instead of guessing.
- Generate sample outputs for at least one existing feature package.

### Out Of Scope

- Replacing markdown as the approval surface
- Inferring hidden or narrative-only relationships
- Adding repo-wide semantic validation of the graph
- Retrofitting all historical feature packages in one pass

## Requirements

### REQ-01

- Statement: The repository must provide a scriptable way to generate `spec.graph.yaml` from the current feature package conventions.
- Rationale: Automation needs one deterministic entrypoint instead of repeated one-off markdown scrapers.
- Source: graph extractor request

### REQ-02

- Statement: The extractor must capture feature metadata, scope locks, anchors, `REQ`, `DES`, `TASK`, `AC`, `TC`, and explicit contract references using the current markdown structure.
- Rationale: These are the minimum graph elements already modeled in the feature package.
- Source: graph extractor request

### REQ-03

- Statement: The extractor must preserve uncertainty by marking non-extractable or non-explicit relationships as manual authoring work instead of guessing them.
- Rationale: A wrong machine graph is worse than an incomplete one.
- Source: `AGENTS.md` operating rules

### REQ-04

- Statement: The repository must include generated example graphs plus a limitations note that explains what still requires human authorship and what should be improved next.
- Rationale: Reviewers need to see both the produced artifact and the current boundary of the extractor.
- Source: graph extractor request

## Constraints

- Keep `docs/specs/<feature-id>/` as the authoritative human source.
- Keep the graph file deterministic and stable under repeated generation.
- Prefer existing shell-based repo tooling over a new framework.
- Do not invent trace links that are not explicit in markdown.

## Assumptions

- Current feature packages expose enough explicit structure to extract a useful first-pass graph.
- Heading-style `REQ` and `DES` sections need the same support as table-style sections.

## Open Questions

- None.
