---
id: "2026-03-13-spec-graph-extractor"
title: "First-pass spec graph extractor for feature packages acceptance criteria"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "scripts/sdd/build_spec_graph.sh"
  - "docs/specs-support/examples/2026-03-11-example-customer-export/spec.graph.yaml"
  - "docs/specs/2026-03-13-task-profile-routing/spec.graph.yaml"
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01`, `REQ-02` | Running the extractor on a governed feature package writes a deterministic `spec.graph.yaml` with feature metadata, scope, anchors, and explicit `REQ`, `DES`, `TASK`, `AC`, `TC` nodes. | Generated graph exists and contains the expected top-level sections and node kinds |
| `AC-02` | `REQ-02`, `REQ-03` | Explicit trace links from current markdown are extracted, and uncertain or non-extractable relationships are surfaced as warnings or manual authoring notes instead of guessed links. | Generated graph contains explicit links plus explicit limitation sections |
| `AC-03` | `REQ-04` | The repository includes generated example graphs for at least one full-path feature and one reduced-path feature. | Generated `spec.graph.yaml` files are present in the selected existing feature packages |
| `AC-04` | `REQ-04` | Repository docs describe how to run the extractor, what it currently covers, and what still requires human authorship. | Updated script notes and implementation evidence describe usage, limitations, and follow-up improvements |
