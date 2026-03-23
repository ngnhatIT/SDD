# Emergency Change Handling

## When To Use

Use this rule only for production outage, severe customer impact, security incident, or legal and regulatory hotfix work.

## How To Use

Run the compact path. Write only the minimum artifacts needed to implement, review, and roll back the change safely.

## Required Output

- `README.md`
- `01-requirements.md`
- `02-design.md`
- `07-tasks.md`
- `08-acceptance-criteria.md`
- `09-test-cases.md`
- `10-rollout.md`
- `changelog.md`

## Gate

If the written record is not enough to review the change or roll it back, the emergency package is incomplete.

## Rules

- record unknowns explicitly
- define rollback before deployment
- refine the spec after stabilization if the emergency package was intentionally brief
- deferred documentation normalization is allowed only when the compact emergency package already grounds scope, validation, and rollback, and the follow-up normalization work is recorded before closeout
- do not use chat history as the only record of the change
