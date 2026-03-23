---
id: "2026-03-19-sdd-delivery-goal-realignment"
title: "SDD delivery-goal realignment requirements"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-19"
related_specs:
  - "README.md"
  - "02-design.md"
  - "07-tasks.md"
dependencies: []
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Requirements

## Objective

Realign the SDD framework so it is explicitly optimized for practical project delivery: faster lead time, lower rework, lower regression risk, stronger proof, and a governed feedback loop from findings back into source-of-truth artifacts.

## In Scope

- canonical goal statement, measurable success criteria, and operating principles for the framework
- governance, routing, testing, and metrics wording needed to align the framework with real delivery outcomes
- explicit feedback-loop language for review, QA, SonarQube, bug, and production findings

## Out Of Scope

- runtime code, schema, contract, or build behavior changes
- new execution modes, dashboards, or mandatory reporting ledgers
- any weakening of current source-of-truth, anti-hallucination, or stop-rule controls

## Requirements

| ID | Requirement | Rationale |
| --- | --- | --- |
| `REQ-01` | `The framework MUST define one canonical goal statement that says SDD exists to help the project ship faster and safer by turning approved requirements into traceable change with risk-appropriate implementation, test, review, and rollout evidence.` | The current top-level framing is too governance-centric for day-to-day delivery. |
| `REQ-02` | `The framework MUST define measurable objectives or success criteria that cover lead time, rework, evidence coverage, regression or defect escape, and triage quality without requiring a heavy new reporting system.` | Teams need a practical way to tell whether the framework improves real delivery outcomes. |
| `REQ-03` | `The operating model MUST make risk-proportional rigor explicit so tiny or clearly bounded work stays lightweight, larger or riskier work carries stronger governed artifacts, and hotfixes use a compact path with required backfill when normal evidence is deferred.` | One-size-fits-all ceremony slows routine work, while under-controlled risky work causes regressions and rework. |
| `REQ-04` | `The canonical testing and completion rules MUST require a quality-proof strategy for every change, using the strongest practical mix of unit, integration, end-to-end, contract, static-analysis, or controlled manual evidence for the actual risk.` | SDD should render verification assets and proof, not only code from specs. |
| `REQ-05` | `The framework MUST define a feedback loop for review findings, QA findings, SonarQube findings, bug reports, and production incidents that routes through triage, current-applicability confirmation, source-of-truth updates when needed, implementation, verification, and residual-risk recording.` | Delivery frameworks only improve if real feedback changes the next spec, fix, and test decisions. |
| `REQ-06` | `Canonical entrypoints and helper metrics MUST stay aligned with the new goal so teams can discover the intent quickly without creating a second authority layer or duplicating governance rules.` | Real-project applicability depends on discoverability and low-friction usage. |

## Constraints

- Keep `AGENTS.md`, `docs/sdd/context/`, `docs/sdd/governance.md`, and `docs/specs/` as the canonical authority chain.
- Preserve anti-hallucination, source-of-truth priority, traceability, stop rules, and ask-before-break behavior.
- Do not turn the framework goal into generic slogans or abstract quality language detached from repository artifacts.
- Do not make lightweight paths a loophole for skipping explicit classification, evidence, or escalation.
- Prefer short, high-leverage documentation changes over broad rewrites or parallel workflow hubs.

## Non-Goals

- no runtime code, contract, schema, or release behavior change
- no new mandatory dashboard or metrics database
- no requirement that every change add automated tests even when the repository or touched area makes that impractical
- no downgrade of current governance strength for risky or externally visible changes
