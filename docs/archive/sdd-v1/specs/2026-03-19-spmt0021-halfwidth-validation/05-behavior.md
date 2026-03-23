---
id: "2026-03-19-spmt0021-halfwidth-validation"
title: "SPMT0021 half-width validation behavior"
owner: "Kikancen Screen Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Behavior

## Detail Input Validation

- `名称（半角）` remains required and max-length-limited, but its character validation now accepts all half-width characters.
- `カナ住所（上段）` remains required and max-length-limited, but its character validation now accepts all half-width characters.
- `カナ住所（下段）` remains optional and max-length-limited, but when populated it now accepts all half-width characters.
- Invalid non-half-width input in any of these fields continues to surface as an inline field error under the same input and blocks register/update.

## Examples Covered By The Fix

- Half-width kana input such as small kana and dakuten is accepted.
- Numeric half-width input mixed into the same field is accepted.
- Existing half-width ASCII symbols remain accepted within the half-width-character rule.

## Behavior Not Changed

- No new auto-conversion is added.
- Search behavior, result grid behavior, and modal behavior are unchanged.
- Non-targeted field validation continues to use the existing rules.
