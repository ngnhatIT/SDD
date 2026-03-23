---
id: "2026-03-13-spec-graph-extractor"
title: "First-pass spec graph extractor for feature packages test cases"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs:
  - "scripts/sdd/build_spec_graph.sh"
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01`, `AC-02`, `AC-03` | Script | Run `sh scripts/sdd/build_spec_graph.sh 2026-03-11-example-customer-export`. | The script writes `docs/specs-support/examples/2026-03-11-example-customer-export/spec.graph.yaml` with explicit metadata, nodes, and links extracted from the full-path reference package. |
| `TC-02` | `AC-01`, `AC-03` | Script | Run `sh scripts/sdd/build_spec_graph.sh 2026-03-13-task-profile-routing`. | The script writes `docs/specs/2026-03-13-task-profile-routing/spec.graph.yaml` and handles heading-style `REQ` and `DES` sections without guessing missing optional artifacts. |
| `TC-03` | `AC-02`, `AC-04` | Manual review | Inspect the extractor output, command docs, and limitations note. | The graph records explicit warnings and manual authoring needs for relations that are not extractable from current markdown. |
| `TC-04` | `AC-04` | Script | Run `sh scripts/sdd/validate_specs.sh 2026-03-13-spec-graph-extractor`. | The governing feature package for the extractor passes current SDD validation. |
