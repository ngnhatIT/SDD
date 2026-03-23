# Definition Of Done

## When To Use

Use this rule when deciding whether a feature, fix, review, audit, docs change, hotfix, or recovery pass is complete for its active mode.

## How To Use

1. Verify the traceability chain that applies to the current change.
2. Confirm the active mode and whether the current risk still matches that mode.
3. Record the quality-proof strategy from `docs/sdd/standards/testing-and-quality-signals.md`.
4. Apply the mode-specific completion bar below.
5. Do not claim completion when the mode still has unresolved escalation triggers.

## Required Output

- explicit proof that the active mode's required grounding, outputs, evidence, validation, and quality-proof strategy are complete

## Gate

Work is not done until both the applicable traceability chain and the active mode's completion requirements pass.

## Required Chain

1. `01-requirements.md` defines stable `REQ-` items.
2. `08-acceptance-criteria.md` maps `AC-` items to the requirements.
3. `09-test-cases.md` maps `TC-` items to the acceptance criteria and records results.
4. `07-tasks.md` and `11-implementation-report.md` identify the delivered implementation.
5. `12-review-report.md` confirms the implementation matches the governing spec.

Apply the full chain above to governed implementation or governed fixes. Lighter modes may use only the subset explicitly required for that mode below.

## Quality Proof Strategy Rule

- Every change must name a quality-proof strategy that matches the actual risk and touched scope.
- The proof strategy may be lightweight for low-risk work, but it cannot be implicit.
- When automation is absent, the manual proof path, operator assumptions, and residual risk must be visible.
- When a finding or incident triggered the work, the proof strategy must cover the triggering path and the highest-risk adjacent regression path.

## Mode-Specific Done

### tiny-fix

- Required grounding: confirmed `no-spec` or still-obviously-tiny classification, touched local context, and the applicable local rule when one exists.
- Required outputs: minimal safe diff and an explicit classification decision.
- Required evidence: direct inspection or the smallest relevant check for the touched surface, plus an explicit reason broader proof is not needed.
- Required validation depth: touched surface only, with obvious rollback.
- Escalation triggers: the fix changes behavior, spans more than one local surface, or stops being obviously reversible.
- Not required: governing feature package, implementation report, review report, or broad checklist execution unless classification changes.

### reduced-path fix

- Required grounding: governing reduced-path feature package, relevant `TASK-`, `AC-`, `TC-` items, touched anchors, and only the standards needed for the touched layer.
- Required outputs: implemented fix, updated reduced-path feature artifacts, and `11-implementation-report.md` once implementation starts.
- Required evidence: grounded defect statement or finding, updated acceptance and test evidence, explicit quality-proof strategy, self-review result, and explicit residual risks or blockers.
- Required validation depth: targeted verification of the touched behavior plus the highest-risk sibling flow touched by the fix.
- Escalation triggers: shared contract drift, schema or file-shape impact, non-obvious edge handling, or widening scope beyond the reduced-path package.
- Not required: unused full-path companion artifacts, spec-pack regeneration, or machine-readable contracts unless the feature actually owns them.

### full-path governed implementation

- Required grounding: full owned feature package, relevant standards, owned contracts, anchors, companion risk or decision files when present, and ADRs when referenced.
- Required outputs: implementation, updated feature package, owned contract updates, `11-implementation-report.md`, and `12-review-report.md` once review starts.
- Required evidence: complete `REQ -> DES -> TASK -> AC -> TC` traceability, explicit quality-proof strategy, validation results, self-review, formal review verdict, rollout readiness, and changelog updates when applicable.
- Required validation depth: planned `TC-` coverage for the implemented scope, strongest practical automated plus manual proof mix for the risk, sibling-flow parity checks where risk exists, self-review, formal review, pre-merge audit, and done-check.
- Escalation triggers: missing owned artifact, conflict between spec and code, unsupported breaking change, or low-confidence completion claim.
- Not required: only artifacts explicitly marked `n/a` by the governing package remain not required.

### review-only

- Required grounding: explicit review basis, governing feature package when the work is governed, relevant standards or checklists, and current implementation evidence when present.
- Required outputs: findings-first review note and `12-review-report.md` when the review is governed.
- Required evidence: severity-rated findings or an explicit no-finding verdict, hallucination checks, contract-drift checks, traceability check, and confidence statement.
- Required validation depth: inspection depth sufficient to support the verdict; do not imply implementation or test execution that did not occur.
- Escalation triggers: review basis unclear, governed work missing required artifacts, or evidence too weak for a defensible verdict.
- Not required: code changes, implementation report updates by the reviewer, or rollout completion unless the review explicitly includes release readiness.

### docs-only

- Required grounding: touched canonical docs, governing policy or feature package when the docs change is non-trivial, and authority-order confirmation for the affected surfaces.
- Required outputs: updated docs, corrected navigation links, and a governing feature package plus `11-implementation-report.md` when the docs change is non-trivial.
- Required evidence: manual consistency review, cross-link check, source-of-truth check, and explicit note that runtime behavior did not change unless separately approved.
- Required validation depth: inspect every touched canonical surface for conflicts, duplicate authority, broken references, and whether the docs still support fast safe delivery rather than new ceremony.
- Escalation triggers: the docs change starts altering approved runtime behavior, contract meaning, or governance intent without explicit authorization.
- Not required: runtime tests, machine-readable contracts, or runtime rollout artifacts unless the docs change is part of an approved behavior change.

### audit-only

- Required grounding: target scope, explicit audit basis, and the standards, governance rules, or feature artifacts needed to support observations.
- Required outputs: grounded audit findings and recommendations, plus `12-review-report.md` when the audit attaches to a governed feature.
- Required evidence: cited observations, risks, blockers, and confidence; no hidden assumptions about implementation status.
- Required validation depth: inspection-only depth that supports the stated findings.
- Escalation triggers: governed work cannot be assessed because required artifacts are missing, or the audit uncovers a possible breaking change that needs a separate governed path.
- Not required: implementation changes, implementation report completion, or a release-ready claim.

### hotfix

- Required grounding: emergency justification, compact emergency package or current governing package, rollback intent, and uncertainty handling for any possible break surface.
- Required outputs: minimal safe fix, rollback steps, compact artifact set, and follow-up stabilization note when documentation normalization or fuller proof is deferred.
- Required evidence: strongest targeted verification practical before deployment, rollback readiness evidence, explicit quality-proof strategy for the incident path, and explicit unknowns that remain.
- Required validation depth: incident-focused validation plus rollback verification; do not over-claim normal-path coverage that was not feasible during the emergency.
- Escalation triggers: rollback undefined, blast radius unclear, emergency justification weak, or a locked contract may break without explicit approval.
- Not required: full documentation normalization before deployment when `docs/sdd/governance/07-emergency-change-handling.md` explicitly allows a deferred follow-up and the follow-up is recorded.

### recovery or resume task

- Required grounding: current task context, changed files or current reports already in play, blockers, and the smallest next grounded step.
- Required outputs: recovery note with scope, completed work, remaining work, blockers, next action, and confidence.
- Required evidence: current-state reconstruction only; facts must be distinguished from assumptions.
- Required validation depth: enough reconstruction to resume safely, not enough to claim implementation or review completion.
- Escalation triggers: no grounded next action can be identified, or the blocker remains unresolved after recovery.
- Not required: code edits, review verdict, rollout evidence, or a done claim for the underlying feature.

## Sonar Task Extensions

### sonar-triage

- Required grounding: Sonar finding source, current code, `docs/sdd/governance/11-static-analysis-triage-policy.md`, and the Sonar triage template or existing triage artifact.
- Required outputs: triage artifact with classification and decision status for every issue; no code changes.
- Required evidence: current-code validation for each issue plus explicit reasons for any stale, false-positive, risky, deferred, or human-decision item.
- Not done when: any issue is left unclassified, the artifact is missing, or code was changed during a triage-only pass.

### sonar-triage-and-fix

- Required grounding: all `sonar-triage` grounding plus the normal governance classification before code changes begin.
- Required outputs: safe fixes only for currently valid `confirmed-fixable` items, triage artifact updated for every issue, and implementation evidence when code changes were made.
- Required evidence: issue-by-issue current-code validation, explicit fixed vs non-fixed summary, proof that no risky or ambiguous item was auto-fixed, and proof of the triggering path plus the highest-risk adjacent regression path.
- Not done when: any finding was fixed blindly, non-fixed findings were not recorded, or the work became non-trivial without the required governing feature package.

### sonar-fix-from-triage

- Required grounding: approved triage artifact, current code, Sonar triage policy, and the normal governance classification before code changes begin.
- Required outputs: fixes only for items with `Decision status: approved-fix`, triage artifact updated to `done` or left unchanged with a recorded reason, and implementation evidence when code changes were made.
- Required evidence: revalidation that each fixed issue still applies, traceability from issue ID to code change, and proof that non-approved items were untouched.
- Not done when: items outside `approved-fix` were changed, the triage artifact was not updated, or the current code no longer matched the approved issue but the fix still proceeded.

## Done Means

- required artifacts for the active mode are complete
- acceptance or audit claims are backed by visible evidence
- implementation and review evidence is present when the mode requires it
- every change has an explicit quality-proof strategy proportionate to risk
- all Sonar-driven non-fixed findings are classified and recorded when the Sonar workflow is in scope
- finding-driven work updates the governing artifacts when the finding changed intended behavior, proof, or residual-risk understanding
- touched files no longer carry unused imports, obvious redundant code, or commented-out placeholder blocks inside the delivered scope
- touched frontend work preserves the repository-approved screen structure and smaller-window layout behavior, including paired range-field alignment where applicable
- newly added or rewritten comments are English-only and comments remain minimal
- uncertainty and confidence are recorded honestly
- escalation triggers were either resolved or explicitly carried as blockers
- no higher-risk path is being hidden inside a lighter mode label
