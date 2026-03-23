# Design

## When To Use

Use this stage after requirements are stable enough to choose a solution.

## How To Use

1. Write `02-design.md`.
2. Record the current state, target state, impacted layers, and `DES-` decisions.
3. Add `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, and `06-edge-cases.md` when they apply.
4. Add machine-readable contracts when the feature introduces or changes a meaningful API or durable data contract.
5. Record the shared utilities, constants, message catalogs, base or common flows, touched-scope cleanup expectations, and sibling patterns that the touched scope must reuse or modernize toward.
6. For touched frontend screens or forms, record the required screen-family structure, responsive layout behavior, and paired-field alignment expectations from the inspected anchors.
7. For touched comments or newly added comments, record any comment-language migration note only when the touched scope requires comment rewrites.
8. Where repository evidence is mixed, classify the touched concern as `preferred current pattern`, `tolerated legacy pattern`, or `required migration pattern` instead of treating every live pattern as equally valid.
9. Add an ADR if the design decision is cross-cutting.

## Required Output

- `02-design.md`
- conditional design artifacts for data, contracts, behavior, and edge handling
- ADR link when the decision affects work outside the current feature

## Gate

Advance only when:

- an implementer can build the change without inventing behavior
- impacted layers and contracts are explicit
- required shared helper, constant, message, table, focus-out, touched-scope cleanup, responsive-layout, and validation-parity reuse notes are explicit for touched concerns
- preferred-current versus tolerated-legacy classification is explicit for touched concerns that have mixed repository evidence
- field-level versus popup error-routing expectations are explicit for touched frontend validation or fatal-error concerns
- risky choices and non-changes are documented
- `docs/sdd/checklists/03-design-review.md` passes
