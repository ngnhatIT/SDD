# Data Model

## Overview

- The feature reuses the current attachment search data model and expiry-related fields already returned by the `SPPM00061` search family.
- No new durable table, column, or file shape is introduced.

## State Rules

- `expiredOnly = false` returns the existing mixed result set.
- `expiredOnly = true` returns only rows whose expiry date is before the current business date.
- Rows with no expiry date remain visible only when `expiredOnly = false`.

## Persistence Notes

- The feature may extend the existing saved-condition payload to remember the `expiredOnly` flag.
- No new persistence family is introduced by this example.
