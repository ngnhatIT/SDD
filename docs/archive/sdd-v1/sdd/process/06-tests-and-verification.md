# Tests And Verification

## When To Use

Use this stage after implementation work exists and before formal review starts.

## How To Use

1. Execute the planned `TC-` coverage for the implemented scope.
2. Record automated and manual results in `09-test-cases.md` or `11-implementation-report.md`.
3. Update `08-acceptance-criteria.md` and `09-test-cases.md` if behavior changed during implementation.
4. Record failures, gaps, deferrals, and retest requirements explicitly.
5. Feed the resulting evidence into self-review before formal review starts.

## Required Output

- test execution results for applicable `TC-` items
- acceptance evidence for applicable `AC-` items
- unresolved verification gaps, if any

## Gate

Advance only when:

- implemented acceptance criteria have matching test evidence
- failed or deferred tests are explicit
- test evidence is linked from the feature package
- `docs/sdd/governance/05-test-traceability-rules.md` is satisfied
