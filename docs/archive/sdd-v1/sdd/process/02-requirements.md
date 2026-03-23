# Requirements

## When To Use

Use this stage after intake and before solution design.

## How To Use

1. Write `01-requirements.md`.
2. Define stable `REQ-` items.
3. State scope boundaries, business rules, constraints, dependencies, and non-goals.
4. Keep requirements testable and free of solution details.
5. When applicable, state validation ownership across frontend and backend, user-visible message normalization expectations, responsive small-window behavior and paired-field alignment expectations for touched frontend forms, and any repository-mandated shared pattern reuse that the design must preserve.

## Required Output

- `docs/specs/<feature-id>/01-requirements.md`
- explicit scope and non-scope
- open questions or assumptions that still affect design

## Gate

Advance only when:

- the problem and desired outcome are clear without reading code
- requirements are testable and not written as implementation details
- validation ownership, user-facing message expectations, responsive layout expectations, and cross-layer parity expectations are explicit when those concerns are in scope
- conflicts, assumptions, and unresolved questions are explicit
- `docs/sdd/checklists/02-requirements-review.md` passes
