---
id: "2026-03-19-sdd-delivery-goal-realignment"
title: "SDD delivery-goal realignment design"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

Create one canonical goal-and-success-metrics document under `docs/sdd/`, use small cross-links from existing entrypoints, align governance with risk-proportional rigor and feedback-driven updates, strengthen routing and fix contracts for lightweight versus higher-risk paths, and upgrade testing plus framework-health guidance so proof and delivery outcomes are explicit without adding a new authority surface.

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: `docs-only framework change; preserve the current authority split where AGENTS routes loading, governance owns rules, execution owns routing and contracts, standards own verification expectations, and ai-ops remains helper-only`
- New tables/source families/screen structure in scope: `no`

## Framework Anchors Inspected

- `AGENTS.md`
- `docs/README.md`
- `docs/sdd/README.md`
- `docs/sdd/governance.md`
- `docs/sdd/governance/README.md`
- `docs/sdd/governance/01-when-a-spec-is-required.md`
- `docs/sdd/governance/04-review-rules.md`
- `docs/sdd/governance/05-test-traceability-rules.md`
- `docs/sdd/governance/08-decision-log-policy.md`
- `docs/sdd/governance/09-documentation-update-policy.md`
- `docs/sdd/governance/11-static-analysis-triage-policy.md`
- `docs/sdd/governance/definition-of-done.md`
- `docs/sdd/context/product-context.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/execution/task-routing.md`
- `docs/sdd/execution/contracts/fix-from-review.md`
- `docs/sdd/execution-profiles/codex.md`
- `docs/sdd/standards/testing-and-quality-signals.md`
- `docs/sdd/ai-ops/framework-health-metrics.md`
- `docs/sdd/ai-ops/README.md`
- `docs/sdd/foundation/README.md`
- `docs/specs/2026-03-17-sdd4-mode-driven-efficiency/01-requirements.md`
- `docs/specs/2026-03-17-sdd4-operating-model-optimization/01-requirements.md`
- `docs/decisions/ADR-0001-spec-driven-delivery-framework.md`
- `docs/decisions/ADR-0004-sdd2-plus-agent-ready-extension.md`

## Raw Input Normalization

### Facts

- The framework already treats anti-hallucination, source-of-truth, traceability, and stop rules as non-negotiable.
- Current README and governance wording still frame SDD mainly as governed delivery or document control rather than a speed-plus-safety delivery system.
- Current testing guidance is honest about limited automation, but it does not yet define a named quality-proof strategy or verification-asset expectation.
- Current routing already supports lightweight modes and hotfix handling, but the delivery-intent language for risk-proportional rigor is still implicit.
- Current Sonar workflow is already triage-first and evidence-aware, which can be generalized into a broader finding-feedback loop.

### Open Questions

- Whether maintainers later want explicit numeric thresholds for the new success criteria after enough baseline history exists.

### Non-Changes

- No change to task-profile header tokens.
- No change to runtime code, contracts, schema, or build system.
- No change to the existing authority order.

### Approval Gaps

- none; the user request explicitly authorizes a framework-goal upgrade within the existing SDD core

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | `Create docs/sdd/goal-and-success-metrics.md as the single canonical home for the new goal statement, measurable success criteria, operating principles, quality-proof expectation, and feedback loop.` | `REQ-01`, `REQ-02`, `REQ-04`, `REQ-05` |
| `DES-02` | `Add a new ADR that records the shift from governance-first framing to delivery-outcome framing while preserving the existing authority chain and anti-hallucination controls.` | `REQ-01`, `REQ-06` |
| `DES-03` | `Adjust governance, routing, and finding-driven-fix wording so small work can stay light, larger-risk work is clearly controlled, and hotfixes carry explicit backfill expectations when normal proof or docs are deferred.` | `REQ-03`, `REQ-05`, `REQ-06` |
| `DES-04` | `Upgrade the testing standard and Definition of Done so every change requires a quality-proof strategy matched to the actual risk and evidence is recorded against TC items.` | `REQ-04` |
| `DES-05` | `Expand framework-health metrics and documentation-update wording so feedback from review, QA, SonarQube, bug reports, and production incidents loops back into triage, spec updates, verification, and residual-risk visibility.` | `REQ-02`, `REQ-05`, `REQ-06` |
| `DES-06` | `Use only minimal README and ai-ops cross-links for discoverability so teams can find the new goal quickly without creating a competing process hub.` | `REQ-06` |

## Canonical Placement

| Concern | Canonical Home | Why |
| --- | --- | --- |
| framework goal, objectives, principles, and feedback loop | `docs/sdd/goal-and-success-metrics.md` | one discoverable home is better than spreading intent across multiple readmes |
| non-negotiable delivery rules | `docs/sdd/governance.md` | governance remains the canonical rule layer |
| lightweight versus stronger execution path intent | `docs/sdd/execution/task-routing.md` and `docs/sdd/governance/definition-of-done.md` | routing chooses the path and DoD states the completion bar |
| proof strategy and verification assets | `docs/sdd/standards/testing-and-quality-signals.md` | testing expectations belong in standards |
| delivery outcome and drift signals | `docs/sdd/ai-ops/framework-health-metrics.md` | helper-only metrics should remain outside the approval layer |
| delivery-rule decision record | `docs/decisions/ADR-0005-sdd-delivery-outcome-alignment.md` | this change affects future framework behavior beyond one feature package |

## Implementation Plan

1. Create the reduced-path docs-only feature package and ADR for the goal realignment.
2. Add the canonical goal-and-success-metrics document.
3. Update README and governance entrypoints so the new goal is discoverable and rule-aligned.
4. Update routing and finding-driven-fix contract wording for risk-proportional rigor and hotfix backfill.
5. Update testing, Definition of Done, documentation-update, and metrics docs for proof strategy and feedback loop alignment.
6. Run doc validators when the current shell supports them, otherwise mirror their checks manually, then record implementation and review evidence.

## Local Shape Constraints To Preserve

- Keep the current source-of-truth order unchanged.
- Keep lightweight execution paths explicit but safety-bounded.
- Keep helper metrics helper-only, not merge gates.
- Do not duplicate complete rules from governance into README or prompt surfaces.
- Use delivery wording that is practical and measurable, not generic quality slogans.

## Risks And Mitigations

| Risk | Mitigation |
| --- | --- |
| The new goal doc becomes a parallel authority hub. | Keep it intent-and-metrics focused and cross-link to governance, routing, and standards for the actual rules. |
| Delivery-speed wording is interpreted as permission to skip controls. | State minimal sufficient process and risk-proportional rigor explicitly in governance and routing. |
| Proof expectations become unrealistic for a repo with limited automated coverage. | Require the strongest practical evidence mix and controlled manual proof when automation is absent. |
| Feedback-loop wording stays abstract. | Ground it in specific sources, triage steps, documentation updates, and measurable metrics. |
