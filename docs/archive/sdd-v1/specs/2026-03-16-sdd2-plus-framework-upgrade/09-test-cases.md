---
id: "2026-03-16-sdd2-plus-framework-upgrade"
title: "SDD2+ additive framework upgrade test cases"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-16"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs: []
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Manual docs review | Inspect the updated `docs/sdd/` root guidance and governance docs. | Existing SDD2 lifecycle remains described as authoritative and the new folders are additive. |
| `TC-02` | `AC-02` | Manual docs review | Open the new templates, prompts, and AI ops docs. | Each artifact is usable immediately and references the canonical repository workflow. |
| `TC-03` | `AC-03` | Script | Build the example spec-pack after the script updates. | Companion artifacts appear when present and the scripts remain backward-compatible. |
| `TC-04` | `AC-04` | Script + manual review | Validate the example feature package and inspect the generated `docs/spec-packs/example-feature.pack.md`. | The example package passes validation and the generated pack matches the extended framework. |
