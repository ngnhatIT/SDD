---
id: "2026-03-13-execution-brief-generator"
title: "Execution-brief generator for task-specific SDD loading test cases"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs:
  - "scripts/sdd/build_execution_brief.sh"
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01`, `AC-04` | Script | Run `sh scripts/sdd/build_execution_brief.sh 2026-03-11-example-customer-export`. | The script writes `docs/spec-packs/2026-03-11-example-customer-export.implement-new.brief.md` with the deterministic brief structure. |
| `TC-02` | `AC-02`, `AC-03`, `AC-04` | Manual review | Inspect `scripts/sdd/build_execution_brief.sh`, `AGENTS.md`, `docs/specs/README.md`, `scripts/sdd/README.md`, and the generated example brief. | The non-authoritative role, unknown handling, and required brief fields are all stated consistently. |
| `TC-03` | `AC-03`, `AC-04` | Script | Run `sh scripts/sdd/validate_specs.sh 2026-03-13-execution-brief-generator`. | The governing feature package for the generator passes current SDD validation. |
