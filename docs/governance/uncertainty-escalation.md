# Uncertainty Escalation

Stop and escalate instead of guessing when:

- two active sources disagree
- a contract or externally visible behavior is unclear
- a DB fact is not confirmed by `docs/standards/schema_database.yaml` or inspected code
- a code pattern looks inconsistent and the correct local family cannot be identified
- verification evidence is too weak to defend the change

## Ask-Before-Break Areas

- API paths, request fields, response fields, DTO keys, file formats
- DB schema, durable data meaning, audit columns, tenant or company boundaries
- auth, permissions, validation meaning, error messages, rollback behavior
- new routes, new screen structures, or new shared abstractions

## What To Record

When escalation is required, record all of this in `reinforcement.md` or the active task artifact (`verification.md`, `review.md`, or `audit.md`):

- exact missing fact or conflict
- sources inspected
- why the next step would be unsafe
- decision needed from a human or missing evidence needed from the repo
- current confidence and residual risk

## Recovery Rule

Once the missing fact is resolved, update the affected artifact before continuing. Do not carry an old assumption forward silently.
