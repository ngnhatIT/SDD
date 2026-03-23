---
id: "2026-03-13-spec-graph-extractor-changelog"
title: "First-pass spec graph extractor for feature packages changelog"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "README.md"
dependencies: []
implementation_refs:
  - "scripts/sdd/build_spec_graph.sh"
test_refs: []
---

# Feature Changelog

## 2026-03-13

- Added `scripts/sdd/build_spec_graph.sh` to generate first-pass `spec.graph.yaml` files from current feature package markdown.
- Generated example graph files for one existing full-path feature and one existing reduced-path feature.
- Documented the extractor command, current extraction limits, and recommended next improvements in `scripts/sdd/README.md` and `AGENTS.md`.
