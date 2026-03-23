# Release Readiness Rules

## When To Use

Use this rule before marking a feature ready for release, done, or merged for shipment.

## How To Use

Check the implemented change, feature package, and rollout plan together.

## Required Output

- release-ready or not-ready decision
- list of missing artifacts or unresolved risks when the gate fails

## Gate

If rollback steps, test results, or review verdict are missing, the feature is not release-ready.

## Required Before Release

- required tasks are done or explicitly deferred
- acceptance criteria are proven
- test results are recorded
- rollout and rollback steps are current
- `11-implementation-report.md` is complete
- `12-review-report.md` contains a clear verdict
- open high risks in `13-risk-log.md` are either mitigated, explicitly accepted, or documented as release blockers when that file exists
- feature-local `changelog.md` is updated
- root `CHANGELOG.md` is updated when the change is releasable

## Path Rules

- `reduced-path`: rollout and review notes may be short
- `full-path`: rollout must include deployment order, release checks, rollback triggers, and a release recommendation
