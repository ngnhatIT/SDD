---
id: "2026-03-17-sdd4-framework-self-validation"
title: "SDD4 framework self-validation and self-audit acceptance criteria"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01` | The implementation records a grounded audit of current validator coverage, grounded gaps, and non-mechanical blind spots. | Implementation report summarizes current checks, missing checks, and blind spots with canonical sources |
| `AC-02` | `REQ-02`, `REQ-05` | The validator detects grounded implementation-report and review-report completeness issues and emits actionable diagnostics with severity, rule source, rationale, and next action. | Validator output and fixtures show report-completeness failures with structured messages |
| `AC-03` | `REQ-03`, `REQ-05` | The validator detects grounded framework-shape and packaging drift for canonical targets, spec-pack references, conditional contract cues, classification mismatches, spec-pack drift, and bridge ambiguity where documented rules support it. | Updated validator plus fixtures demonstrate the new drift and structure checks |
| `AC-04` | `REQ-04`, `REQ-05` | A helper framework self-audit document exists under `docs/sdd/ai-ops/` and defines recurring audit scope, drift signals, cadence, outputs, and validation blind spots without becoming a parallel authority layer. | New self-audit doc plus README or AI-ops discoverability update |
| `AC-05` | `REQ-05` | Validator docs explain what is checked, what is not checked, how to read severity and failure levels, and when to use the self-audit instead of expecting automatic validation. | Updated `scripts/sdd/README.md`, `docs/sdd/README.md`, or equivalent discoverability docs |
