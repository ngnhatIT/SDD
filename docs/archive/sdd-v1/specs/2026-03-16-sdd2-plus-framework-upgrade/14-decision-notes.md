# Decision Notes

## Local Decisions

| Decision ID | Status | Summary | Why it matters | Related spec | ADR |
| --- | --- | --- | --- | --- | --- |
| `NOTE-01` | accepted | keep SDD2+ additive and leave the current SDD2 lifecycle untouched | prevents accidental framework replacement | `DES-01` | `ADR-0004` |
| `NOTE-02` | accepted | add risk and decision files as feature companions instead of renumbering the base package | preserves backward compatibility for existing features | `DES-03` | `ADR-0004` |
| `NOTE-03` | accepted | keep `scripts/sdd/` as the executable tooling entrypoint and use `tools/sdd/` only as the stable index | avoids breaking existing commands while adding a clearer tool map | `DES-04` | `ADR-0004` |
| `NOTE-04` | accepted | use `docs/specs-support/examples/example-feature/` as the reserved framework example path outside the governed approval tree | keeps reference material available without polluting `docs/specs/` | `DES-05` | `n/a` |

## Reconsideration Rules

- Raise a new ADR if SDD2+ ever needs to change the core approval path rather than extend it.
- Revisit `NOTE-03` only if a future toolchain genuinely replaces `scripts/sdd/`.
