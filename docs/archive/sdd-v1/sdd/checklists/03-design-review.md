# Design Review Checklist

## When To Use

Use this checklist before task planning or coding.

## How To Use

Review the design package against the approved requirements and identify missing conditional artifacts.

## Required Output

- reviewed `02-design.md`
- confirmation that all required conditional files exist

## Gate

Task planning starts only when all applicable items are checked.

- [ ] `02-design.md` references the relevant `REQ-` items.
- [ ] `02-design.md` contains at least one `DES-` item for non-trivial design choices.
- [ ] Current state and target state are both described.
- [ ] Impacted backend, frontend, database, and integration areas are named or marked `n/a`.
- [ ] `02-design.md` contains a valid `Source Base Anchors` block with concrete values or `n/a`.
- [ ] Required shared helpers, constants, message paths, base-common flows, and validation or table patterns are explicit.
- [ ] Mixed live patterns are classified where repository evidence is mixed.
- [ ] Scope notes state whether new tables, source families, or screen structure are in scope.
- [ ] When execution workflow or framework docs are touched, the design states which existing artifacts own stable rules versus variable task packets.
- [ ] When investigation or debugging support is in scope, the design states the expected hypothesis-first or minimal-exploration behavior.
- [ ] Conditional files exist when the feature needs them.
- [ ] An ADR exists in `docs/decisions/` if the design choice is cross-cutting.
