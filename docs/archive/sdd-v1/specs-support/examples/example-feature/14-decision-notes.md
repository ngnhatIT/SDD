# Decision Notes

## Local Decisions

| Decision ID | Status | Summary | Why it matters | Related spec | ADR |
| --- | --- | --- | --- | --- | --- |
| `NOTE-01` | accepted | extend the existing search request instead of creating a new expired-file endpoint | keeps the screen, count, list, and export flow in one family | `DES-01` | `n/a` |
| `NOTE-02` | accepted | enforce predicate parity across count, list, and export sibling flows | prevents search or export drift | `DES-02` | `n/a` |
| `NOTE-03` | accepted | default omitted `expiredOnly` to `false` for backward compatibility | preserves current callers and saved conditions | `DES-03` | `n/a` |
| `NOTE-04` | accepted | keep risk and decision notes in the example package so the generated spec-pack can surface them | demonstrates the SDD2+ companion artifact model | `DES-04` | `ADR-0004` |

## Reconsideration Rules

- Raise an ADR only if the expired-only filter changes shared request semantics outside the `SPPM00061` family.
