# Behavior

## User Flow

1. User opens `SPPM00061`.
2. The screen restores saved conditions, including `expiredOnly` when one was saved.
3. User turns on the `expiredOnly` filter and runs search.
4. Search count and result list show only expired attachment rows.
5. User exports the result set through the shared CSV export flow.
6. Export uses the same `expiredOnly` condition as the on-screen search.

## Screen Rules

- The new filter defaults to `false`.
- Zero-result behavior stays the same as the current screen.
- Expired rows are visually distinguishable using the existing row data, not a separate secondary fetch.

## Messaging

- No new message family is introduced.
- Existing validation and fatal-error routing stays in place.
