# Conflict Management

## When To Use

Use this file when a feature touches shared codes, statuses, KBN values, DATACD values, or linked screens.

## How To Use

Record the shared-value risk in the feature package before implementation and add focused review notes when another screen could be affected.

## Required Output

- linked-screen or shared-value risk documented in `README.md` or `06-edge-cases.md`
- focused review note when conflict risk is non-trivial

## Gate

If another screen can break because a shared code or status changes, the feature is not ready for implementation until the conflict is documented.

## Rules

- record linked screens and shared values in the feature `README.md` or `06-edge-cases.md` when conflict risk matters
- add a focused review note when a feature may change shared codes or statuses across multiple screens
- keep conflict review narrow: shared values, linked screens, drift risk, and required checks
