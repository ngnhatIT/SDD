# Self-Review Checklist

## When To Use

Use this checklist after implementation and verification and before formal review or completion claims.

## How To Use

Check an item only when the evidence is visible in the feature package, code, contracts, or implementation report.

## Required Output

- pass or fail self-review decision
- severity-rated self-findings or explicit statement that no blocking self-findings remain

## Gate

Do not move to formal review or claim completion until all applicable blocking items pass.

- [ ] The governing feature package, selected execution contract, and changed code were re-read before self-review.
- [ ] The final diff still matches the grounded scope or the scope update is explicit.
- [ ] Only files required for the grounded scope were changed.
- [ ] Required artifacts are updated for the actual change scope.
- [ ] `docs/sdd/checklists/touched-scope-enforcement.md` passed for the touched concerns.
- [ ] `AC-` items implemented in code have matching `TC-` evidence or explicit blockers.
- [ ] Self-findings are classified as `critical`, `high`, `medium`, or `low`.
- [ ] Critical or high self-findings are fixed or explicitly escalated as blockers.
- [ ] If SonarQube or static-analysis findings drove the task, the triage artifact and approved item list were re-read before the completion claim.
- [ ] Uncertainty and unsupported assumptions are recorded instead of guessed through.
- [ ] A confidence level with basis is recorded for the claimed completed scope.
