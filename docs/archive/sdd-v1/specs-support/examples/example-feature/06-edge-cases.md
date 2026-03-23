# Edge Cases

## Saved Condition Compatibility

- If older saved conditions do not contain `expiredOnly`, restore it as `false`.
- If a corrupted saved condition contains a non-boolean value, reject it through the existing validation path and do not silently guess.

## Date Boundary

- A row is considered expired only when its expiry date is before the current business date.
- A row expiring on the current business date remains visible when `expiredOnly = false` and excluded when the business rule still treats it as active.

## Missing Expiry Date

- Rows with no expiry date are not treated as expired.

## Search Parity

- Any change to the expired-only predicate must be applied to search count, search list, and CSV export in the same branch.
