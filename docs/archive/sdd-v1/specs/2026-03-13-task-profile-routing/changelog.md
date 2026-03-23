---
id: "2026-03-13-task-profile-routing-changelog"
title: "Task-profile routing changelog"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "README.md"
dependencies: []
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/context/"
  - "docs/sdd/governance/"
  - "docs/sdd/templates/"
test_refs:
  - "09-test-cases.md"
---

# Feature Changelog

## 2026-03-13

### Changed

- Added canonical task-profile routing for agent implementation, fix, and review work.
- Added a stable prompt header contract for selecting task profiles and supporting artifacts.
- Documented `spec_back.md` as helper-only input rather than an approval source.
- Corrected `07-tasks.md` verification links so the feature package passes the current traceability validator.

### Notes

- This change affects repository delivery workflow only; no runtime application behavior changed.
