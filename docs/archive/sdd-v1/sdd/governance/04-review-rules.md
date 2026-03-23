# Review Rules

## When To Use

Use this rule during code review and review approval.

## How To Use

Review the change against the governing feature package, the selected review contract, the relevant context layer, and the applicable standards or checklists.

## Required Output

- findings linked to the governing spec
- `12-review-report.md` with severity-rated findings, confidence, verdict, follow-up items, and Sonar-triage verification when applicable

## Gate

If code conflicts with the approved spec, the review fails until the code or spec is corrected.

## Review Order

1. `AGENTS.md`
2. `docs/sdd/context/constitution.md`
3. `docs/sdd/context/note.md`
4. `docs/sdd/execution/task-routing.md`
5. `docs/sdd/execution/contracts/review-feature.md`
6. the relevant repository standards
7. governing feature package
8. owned `contracts/` when present
9. generated spec-pack only as an execution aid when the selected task profile or feature uses it
10. code and implementation evidence
11. `10-rollout.md`
12. `12-review-report.md`

## Reviewer Must Verify

- implementation matches the requirements, design, acceptance criteria, and tests
- scope parity is preserved against the feature package
- contract parity is preserved between prose spec, machine-readable contracts, and implementation when contracts apply
- `docs/sdd/checklists/touched-scope-enforcement.md` passed for the touched concerns
- missing evidence is recorded as a blocker or unsupported assumption instead of being guessed away
- SonarQube or static-analysis findings were checked against the current code before the review accepted any remediation as valid
- the reviewer checked whether any Sonar-driven fix changed intended behavior or another governed surface without approval
- stale, likely-false-positive, risky, deferred, or human-decision Sonar items were recorded correctly in the triage artifact
- approved follow-up Sonar items remain traceable from issue ID to triage artifact, code change, and review evidence
- `12-review-report.md` separates observed facts, grounded risks, unsupported assumptions, and confirmed hallucination findings
- `12-review-report.md` rates findings as `critical`, `high`, `medium`, or `low`
- `12-review-report.md` records confidence for the verdict and does not imply merge readiness at low confidence

## Task-Profile Notes

- `review-from-pack`: load the generated spec-pack after the governing feature package and resolve conflicts in favor of the feature package.
- `review-from-rules`: generated spec-pack is optional, but governing feature-package review remains mandatory for reduced-path and full-path changes.
- Sonar-driven review: load the triage artifact after the governing feature package and confirm that only currently valid, approved items were fixed.
- `no-spec` review without a feature package is valid only when the change was correctly classified as `no-spec`.
