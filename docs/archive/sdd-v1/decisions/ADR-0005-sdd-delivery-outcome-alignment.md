# ADR-0005 SDD Delivery-Outcome Alignment

- Status: accepted
- Date: 2026-03-19
- Owners: repository maintainers
- Related specs: `2026-03-19-sdd-delivery-goal-realignment`

## Context

The repository already has a strong SDD operating system for source-of-truth control, anti-hallucination, traceability, stop rules, and governed execution.

That strength is necessary, but the top-level framework wording still reads more like a document-control system than a practical delivery system.

The missing emphasis is that SDD should help teams ship faster and safer, scale ceremony with risk, demand proof instead of assumption, and learn from review, QA, SonarQube, bug, and production feedback.

## Decision

This repository realigns SDD with these rules:

1. SDD exists to help the project ship faster and safer, not to maximize governance ceremony.
2. Governance, traceability, anti-hallucination, and stop rules remain non-negotiable controls.
3. The framework goal, measurable success criteria, operating principles, quality-proof expectation, and feedback loop live in `docs/sdd/goal-and-success-metrics.md`.
4. Small bounded changes should use the lightest safe path, while larger or riskier changes must carry stronger spec, test, review, and rollout evidence.
5. Every change must have a quality-proof strategy that uses the strongest practical mix of automated and controlled manual evidence for the actual risk.
6. Findings from review, QA, SonarQube, bug reports, and production incidents must be triaged against current reality and fed back into source-of-truth, implementation, verification, and residual-risk records when applicable.

## Consequences

- The framework will read more like a delivery system and less like governance-only documentation.
- Lightweight paths stay valid, but they are now explicitly justified by risk rather than by convenience alone.
- Testing expectations become proof-oriented even in areas where automation is limited.
- Framework metrics can track delivery outcomes such as lead time, rework, evidence coverage, and defect escape without requiring a heavy new reporting layer.
- Future framework changes should preserve this outcome-driven framing unless a later ADR supersedes it.
