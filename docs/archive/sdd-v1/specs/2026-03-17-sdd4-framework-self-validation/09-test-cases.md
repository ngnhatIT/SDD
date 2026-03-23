---
id: "2026-03-17-sdd4-framework-self-validation"
title: "SDD4 framework self-validation and self-audit test cases"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
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
| `TC-01` | `AC-01`, `AC-05` | Manual review | Inspect the updated implementation evidence and validator docs. | Current validated coverage, grounded gaps, non-mechanical blind spots, validator scope, and interpretation guidance are explicit and consistent with canonical sources. |
| `TC-02` | `AC-02`, `AC-03` | Script | Run the validator suite and targeted validator commands against fixtures covering missing report sections, packaging drift, or bridge ambiguity. | New grounded checks fail on the intended fixtures, pass on aligned fixtures, and emit structured actionable diagnostics. |
| `TC-03` | `AC-03`, `AC-05` | Manual plus script | Inspect the updated validator output and supporting fixture coverage for canonical-target, spec-pack, and bridge-drift checks. | Findings identify severity, hard failure versus warning, canonical rule source, why the rule exists, and the next action. |
| `TC-04` | `AC-04`, `AC-05` | Manual review | Open the new framework self-audit doc and linked discoverability docs. | The self-audit scope, cadence, outputs, drift signals, and validator blind spots are clear and framed as helper-only guidance subordinate to canonical governance. |
