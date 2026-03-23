# Test Traceability Rules

## When To Use

Use this rule when writing test cases, recording results, and validating readiness.

## How To Use

Map every acceptance criterion to one or more test cases and record the result.

## Required Output

- `AC-` to `TC-` mapping
- recorded result for each critical `TC-` item
- named quality-proof strategy for the touched change scope
- edge-case coverage when `06-edge-cases.md` exists

## Gate

If an acceptance criterion has no linked test case, no recorded result, or no visible proof strategy, the feature is not ready.

## Minimum Coverage

- main flow
- validation and negative paths
- regression-sensitive behavior
- search and count families: init-data plus saved-condition restore order, count or list parity, zero-result handling, and guarded fatal-error paths
- mutation families: success, exclusion or timestamp conflict, not-found or already-deleted behavior, and audit-column or logical-delete effects
- contract-bearing API, file, or batch flows: shared validator behavior, custom validation extensions, batch-boundary handling, and compatibility-sensitive payload shape

## Path Rules

- `reduced-path`: manual tests are allowed when automation is impractical, but the result must still be recorded
- `full-path`: use the strongest practical mix of automated and manual checks and record compile, integration, contract, and runtime evidence when relevant
- when automation is absent, the test evidence must name the concrete manual regression path, the operator assumption set, and any residual risk or backfill expectation
