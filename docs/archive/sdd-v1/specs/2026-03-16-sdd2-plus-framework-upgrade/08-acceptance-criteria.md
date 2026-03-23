---
id: "2026-03-16-sdd2-plus-framework-upgrade"
title: "SDD2+ additive framework upgrade acceptance criteria"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01` | The repository keeps the current SDD2 operating model intact while exposing the new SDD2+ extension folders and compatibility guidance. | Updated `docs/sdd/` docs and ADR |
| `AC-02` | `REQ-02` | The repository contains practical templates, prompt starters, AI ops rules, and evidence-first guidance that can be used immediately. | New docs and template files |
| `AC-03` | `REQ-03` | Current spec-pack and execution brief tooling surface SDD2+ companion artifacts when present and still work for older packages. | Script diff and successful pack output |
| `AC-04` | `REQ-04` | A realistic example feature package and generated spec-pack exist under the requested example paths. | `docs/specs-support/examples/example-feature/` and `docs/spec-packs/example-feature.pack.md` |
