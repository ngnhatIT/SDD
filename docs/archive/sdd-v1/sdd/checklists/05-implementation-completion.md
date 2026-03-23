# Implementation Completion Checklist

## When To Use

Use this checklist before handing the change to review or QA.

## How To Use

Check implementation evidence against the feature package and implementation report.

## Required Output

- updated `11-implementation-report.md`
- pass or fail decision for review readiness

## Gate

Review starts only when all applicable items are checked.

- [ ] Completed `TASK-` items are marked `done` in `07-tasks.md`.
- [ ] Deferred work is marked `deferred` in `07-tasks.md` or noted in `11-implementation-report.md`.
- [ ] `11-implementation-report.md` lists the delivered tasks and changed paths.
- [ ] The spec package was updated for any behavior or design change introduced during implementation.
- [ ] `08-acceptance-criteria.md` still matches the implemented behavior.
- [ ] `09-test-cases.md` still matches the implemented behavior.
- [ ] If SonarQube or static-analysis findings drove the task, the triage artifact lists fixed and non-fixed items with current decision status.
- [ ] If `Task Profile: sonar-fix-from-triage` was used, only `approved-fix` items were changed and completed items were marked `done` in the triage artifact.
- [ ] `docs/sdd/checklists/touched-scope-enforcement.md` passed for the touched concerns.
- [ ] Self-review is complete or is the explicit next gate before formal review.
