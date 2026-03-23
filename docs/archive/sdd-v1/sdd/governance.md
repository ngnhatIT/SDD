# Governance Rules

## When To Use

Use this file before coding, reviewing, releasing, or approving exceptions.

## How To Use

1. Classify the change as `no-spec`, `reduced-path`, or `full-path`.
2. Route the task through `docs/sdd/execution/task-routing.md`.
3. Load the selected execution contract and current agent profile.
4. Apply the matching rules in `docs/sdd/governance/`.
5. Load the governing feature package or the spec-authoring workflow as required.
6. Use the matching checklist before moving to the next stage.
7. Confirm the active path uses the lightest rigor that still keeps scope, contracts, regression risk, and reviewability under control.
8. Use `docs/sdd/governance/minimal-sufficient-context-policy.md` to load the smallest compliant canonical context set for the active mode.
9. Confirm `02-design.md` names source-base anchors, dominant module or style notes, required shared reuse notes, classification notes where evidence is mixed, responsive or paired-field layout notes for touched frontend forms, and scope parity notes for each touched layer before coding or review.

## Required Output

- change classification
- required artifact list
- risk-appropriate proof strategy or explicit reason proof stays manual or lightweight
- pass or fail decision for the current gate

## Gate

No non-trivial change may proceed unless the applicable governance rules are satisfied at the rigor level the change risk actually requires.

## Delivery Intent

`docs/sdd/goal-and-success-metrics.md` defines why the framework exists.

Governance exists to support fast, safe, evidence-backed delivery. It is not permission to skip controls, and it is not a reason to add extra ceremony when the lighter grounded path is sufficient.

## Non-Negotiable Rules

1. Non-trivial work is governed by a feature package in `docs/specs/`.
2. Requirements, design, tasks, acceptance criteria, and test cases are written before coding.
3. Implementation, tests, review notes, and release records must trace back to the feature package.
4. Cross-cutting decisions are recorded in `docs/decisions/`.
5. Behavior changes require matching spec updates in the same branch.
6. Releasable behavior changes update `CHANGELOG.md`.
7. When machine-readable contracts exist, they must stay aligned with the governing feature package.
8. Generated spec-packs are execution aids; they do not replace feature-package approval.
9. `AGENTS.md`, `docs/sdd/context/constitution.md`, `docs/sdd/context/note.md`, and `docs/sdd/context/ai-loading-order.md` are the canonical agent-loading contract.
10. `docs/spec-packs/`, execution briefs, prompts, and helper notes support execution and validation; they do not replace governance review on `docs/specs/`.
11. `docs/sdd/execution/` owns task routing and minimum execution contracts; prompts and profiles adapt, but do not authorize, work.
12. `docs/sdd/spec-authoring/` governs how raw inputs become approved feature packages.
13. `02-design.md` must record source-base anchors for each touched layer and state whether new tables, source families, or screen structure are in scope.
14. Review must verify traceability `REQ -> DES -> TASK -> AC -> TC`, scope parity, contract parity, and SQL or HTML style parity against the named anchor files where applicable.
15. `review-from-rules` may omit a generated spec-pack, but it does not permit skipping the governing feature package for governed changes.
16. SDD2+ companion artifacts such as `13-risk-log.md`, `14-decision-notes.md`, generated spec-packs, and execution briefs are additive aids. They do not replace the numbered feature package.
17. AI-assisted work must follow `docs/sdd/governance/01-ai-agent-policy.md` and `docs/sdd/governance/02-anti-hallucination.md`.
18. AI-assisted DB-related work must follow `docs/sdd/governance/03-context-binding.md` before analysis, design, implementation, or review.
19. When evidence is insufficient, AI-assisted work must follow `docs/sdd/governance/12-uncertainty-escalation-policy.md` instead of guessing through the gap.
20. `docs/sdd/checklists/touched-scope-enforcement.md` is mandatory wherever touched-scope hygiene, parity, reuse, or schema-binding checks are in scope.
21. No non-trivial change is complete until self-review, done-checking, and pre-merge audit evidence exist.
22. Contract, schema, and externally visible behavior changes require explicit approval before breaking changes are implemented.
23. SonarQube or equivalent static-analysis finding work must follow `docs/sdd/governance/11-static-analysis-triage-policy.md`.
24. Static-analysis findings may not be fixed blindly; every non-fixed Sonar-driven finding must be classified and recorded in `docs/sonar/` when the Sonar workflow is used.
25. Approved Sonar triage artifacts may guide later remediation, but they do not bypass normal feature-package governance for non-trivial fixes.
26. Use the lightest path that still controls the real risk; small bounded work should stay lightweight, but risky work must not be hidden inside a lighter label.
27. Every change must carry a quality-proof strategy proportionate to risk and the strongest practical verification evidence for the touched scope.
28. When review, QA, SonarQube, bug, or production feedback changes the understanding of intended behavior, acceptance, or residual risk, the governing artifacts and evidence must be updated in the same branch or explicitly carried as a blocker or backfill.
29. Governance must reduce hallucination, contract drift, regression, and rework without creating duplicate authority layers or avoidable process overhead.

## Rule Library

| File | Use |
| --- | --- |
| `governance/01-when-a-spec-is-required.md` | classify the change path |
| `governance/02-minimum-completeness-before-coding.md` | decide whether coding may start |
| `governance/03-implementation-traceability-rules.md` | link code and PRs back to the spec |
| `governance/04-review-rules.md` | review code against the spec |
| `governance/05-test-traceability-rules.md` | prove acceptance with test evidence |
| `governance/06-release-readiness-rules.md` | decide whether a change is releasable |
| `governance/07-emergency-change-handling.md` | run the compact emergency path |
| `governance/08-decision-log-policy.md` | decide when an ADR is required |
| `governance/01-ai-agent-policy.md` | govern AI-assisted work from approved evidence |
| `governance/02-anti-hallucination.md` | block unsupported inference and hallucinated output |
| `governance/03-context-binding.md` | require schema binding for DB-related work |
| `governance/minimal-sufficient-context-policy.md` | load the smallest sufficient canonical read set |
| `governance/09-documentation-update-policy.md` | keep code and spec in sync |
| `governance/10-code-standards.md` | verify code against implementation standards |
| `governance/11-static-analysis-triage-policy.md` | triage and remediate SonarQube or static-analysis findings safely |
| `governance/12-uncertainty-escalation-policy.md` | handle insufficient evidence, ask-before-break, and confidence |
| `governance/12-quality-gate-levels.md` | decide the current quality gate level and next required evidence |
| `governance/definition-of-done.md` | apply the completion standard |
