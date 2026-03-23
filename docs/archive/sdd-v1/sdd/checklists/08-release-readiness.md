# Release Readiness Checklist

## When To Use

Use this checklist before marking a feature ready for release or done.

## How To Use

Review rollout, review, implementation, and changelog artifacts together.

## Required Output

- release-ready or not-ready decision
- missing release artifacts or risks when the gate fails

## Gate

Release readiness passes only when all applicable items are checked.

- [ ] `10-rollout.md` lists deployment steps in execution order.
- [ ] `10-rollout.md` lists rollback steps.
- [ ] `10-rollout.md` lists release checks or smoke checks.
- [ ] `11-implementation-report.md` is complete.
- [ ] `12-review-report.md` contains a release recommendation.
- [ ] `changelog.md` is updated in the feature folder.
- [ ] Root `CHANGELOG.md` is updated when the change is releasable.
- [ ] The feature status in `README.md` is `ready-for-review`, `done`, or another explicit release state.
