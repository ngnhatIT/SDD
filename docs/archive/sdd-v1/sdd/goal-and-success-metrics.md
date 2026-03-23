# SDD Goal And Success Metrics

## Goal Statement

SDD exists to help the project ship faster and safer by turning approved requirements into traceable change with the right level of implementation, test, review, and rollout evidence for the actual risk.

It keeps source-of-truth control, anti-hallucination, traceability, stop rules, and governance intact so delivery can move with less scope drift, less regression, and less rework.

## Objectives And Success Criteria

Use these as directional success signals for the framework. Track them lightly from existing artifacts, review notes, and delivery timestamps where available.

| Objective | What Good Looks Like | Why It Matters |
| --- | --- | --- |
| Reduce lead time | comparable work moves faster from approved spec or grounded request to review-ready or merge-ready without rising defect risk | speed only matters if the path stays governable and safe |
| Reduce rework | fewer review reopens, fewer contract or scope misunderstandings, and fewer redo cycles caused by missing context | rework is one of the clearest signs that the framework is too vague or too heavy |
| Increase evidence coverage | more governed tasks show explicit `AC -> TC -> implementation/review evidence` and a named quality-proof strategy | proof reduces debate, hidden assumptions, and merge-time surprises |
| Reduce regression and defect escape | fewer post-release regressions, fewer repeated hotfixes on the same surface, and fewer fixes that break sibling flows | safety is part of delivery outcome, not a separate concern |
| Improve triage quality | SonarQube, QA, review, bug, and production findings are confirmed against current reality before fixes start | triage-first avoids blind fixes and wrong-scope work |
| Keep ceremony proportional | small bounded work usually completes through lightweight paths while higher-risk work carries the expected stronger artifacts and review depth | one framework must work for both tiny fixes and serious changes |

## Operating Principles

| Principle | Practical Meaning |
| --- | --- |
| `minimal sufficient process` | use only the ceremony needed to keep the next step safe, grounded, and reviewable |
| `risk-proportional rigor` | increase spec, proof, and review depth as change risk, blast radius, or ambiguity increases |
| `spec-to-test traceability` | every accepted change should still map from requirement to acceptance to test evidence |
| `evidence over assumption` | code, review, or release claims are not valid without visible repository evidence |
| `production-feedback-aware change loop` | findings from real delivery and runtime use must change the next spec, fix, or proof when they reveal a gap |
| `no silent fix when source-of-truth is unclear` | when a finding suggests a change but approved intent is unclear, stop, triage, and update the source-of-truth before coding through the gap |
| `small changes should feel lightweight, big changes must be controlled` | do not force tiny work through full ceremony, and do not hide risky work inside a lightweight label |

## Risk-Based Execution Intent

- `tiny-fix` and bounded `docs-only` work should use the lightest safe path, but they still need explicit classification and the smallest relevant proof.
- Reduced-path governed changes should stay compact while still carrying `TASK`, `AC`, `TC`, and targeted evidence.
- Full-path or higher-risk changes should carry stronger design, verification, review, and rollout evidence because the blast radius is higher.
- Hotfixes may use the compact emergency path only when urgency is real; any deferred documentation or proof must be backfilled after stabilization when governance requires it.

## Quality-Proof Expectation

SDD does not stop at rendering code from a spec. It should also render the verification assets needed to prove the change is safe enough for its risk.

Every change should name a quality-proof strategy using the strongest practical mix of:

- `unit` proof for local logic and branching
- `integration` proof for process, data, or cross-layer flow
- `end-to-end` or screen-flow proof for user-visible journeys
- `contract` proof for request, response, file, or data-shape compatibility
- `static-analysis` or diff inspection as supporting evidence
- controlled `manual` proof when automation is not practical in the touched area

When proof stays manual, the regression path, operator assumptions, and residual risk must be explicit.

## Feedback Loop

Use the same loop for review comments, QA findings, SonarQube findings, bug reports, and production incidents:

1. Triage the input and confirm it against the current code or current docs.
2. Decide whether the issue is valid, stale, risky, or blocked on clarification.
3. Update the governing source-of-truth when the finding changes intended behavior, scope, acceptance, or proof.
4. Implement only the grounded fix or follow-up.
5. Verify the triggering path and the highest-risk adjacent regression path.
6. Record residual risk, deferred items, or backfill work explicitly.

## Governance Fit

Governance remains a delivery control, not a second product.

The framework should stay strict enough to block hallucination, contract drift, and unsupported visible changes, while staying light enough that routine low-risk work is not buried in unnecessary ceremony.
