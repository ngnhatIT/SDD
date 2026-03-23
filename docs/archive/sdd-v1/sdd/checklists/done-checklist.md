# Done Checklist

## When To Use

Use this checklist before merge, release signoff, or feature closeout.

## How To Use

Check an item only when the evidence is visible in the governing feature package, code, reports, or release artifacts.

Use `docs/sdd/governance/definition-of-done.md` first and mark an item `n/a` only when the active mode explicitly says that item is not required.

## Required Output

- explicit `done` or `not done` result
- list of remaining blockers or missing artifacts when not done

## Gate

The feature is not done until all applicable items are checked.

- [ ] In-scope `AC-` items have visible evidence from `TC-` items, implementation evidence, or approved review evidence.
- [ ] Required feature-package artifacts are current for the delivered scope.
- [ ] `11-implementation-report.md` is complete, including self-review, uncertainty, and confidence notes.
- [ ] `12-review-report.md` is complete and has a clear verdict.
- [ ] Any owned `contracts/` artifacts are updated or the ownership gap is explicit.
- [ ] Any schema or durable-data change is approved and documented.
- [ ] No SonarQube or static-analysis finding was fixed blindly from raw scanner output or stale artifact state.
- [ ] All non-fixed Sonar-driven findings are classified and recorded when the Sonar workflow is in scope.
- [ ] Only approved triage items were changed when `Task Profile: sonar-fix-from-triage` was used.
- [ ] Self-review completed and blocking self-findings are resolved or explicitly deferred by rule.
- [ ] Pre-merge audit completed and no hidden blockers remain.
- [ ] `docs/sdd/checklists/touched-scope-enforcement.md` passed for the touched concerns.
- [ ] Rollout, rollback, and release notes are current when the change is releasable.
- [ ] Feature-local `changelog.md` is updated and root `CHANGELOG.md` is updated when required.
- [ ] Remaining uncertainty is explicit and does not invalidate the completion claim.
- [ ] The final confidence level is not `low` for the claimed complete scope.
