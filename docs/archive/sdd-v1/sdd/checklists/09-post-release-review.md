# Post-Release Review Checklist

## When To Use

Use this checklist after deployment or after the release decision is final.

## How To Use

Review the shipped record, rollout results, and any follow-up work.

## Required Output

- final feature status
- recorded release outcome and follow-up actions

## Gate

The feature closes only when all applicable post-release records are complete.

- [ ] The released version or deployment date is recorded in `changelog.md` or release notes.
- [ ] Release checks in `10-rollout.md` were completed or exceptions were recorded.
- [ ] Any production issue or rollback is recorded in the feature package.
- [ ] Follow-up work is recorded as deferred tasks, notes, or a new feature folder reference.
- [ ] `README.md` status is updated to `done` or `cancelled`.
- [ ] Root `CHANGELOG.md` matches the shipped behavior summary.
- [ ] Any decision discovered after release that affects future work is written as an ADR.
