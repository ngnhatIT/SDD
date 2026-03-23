---
id: "2026-03-19-spmt0021-halfwidth-validation"
title: "SPMT0021 half-width validation requirements"
owner: "Kikancen Screen Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "README.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Requirements

## Raw Input Normalization

### Facts

- The request explicitly targets `SPMT0021`.
- The affected fields are `名称（半角）`, `カナ住所（上段）`, and `カナ住所（下段）`.
- The request explicitly requires these fields to allow all half-width characters.
- The reported failures include half-width kana, small kana, dakuten, and numbers.
- Inspected current frontend behavior uses `checkHalfWidthKatakana` for `factoryKanaNm` and `checkAddressPattern(...KANA)` for `addrKanaLine1` and `addrKanaLine2`.
- Inspected current backend `Spmt0021RegistProcess` and `Spmt0021UpdateProcess` do not apply matching character-pattern validation before persisting the values.

### Open Questions

- None blocking after inspected-code review.

### Non-Changes

- No schema, SQL, DTO, or transport contract change.
- No change to `名称`, `略称`, `住所`, postcode, phone, or fax validation rules outside the three named fields.
- No automatic full-width to half-width conversion.
- No layout or responsive markup change is requested.

### Approval Gaps

- None. The requested visible behavior change is explicit and bounded to the three named fields.

## Requirement List

| ID | Requirement | Notes |
| --- | --- | --- |
| `REQ-01` | `SPMT0021` register/update validation must allow all half-width characters in `名称（半角）`, `カナ住所（上段）`, and `カナ住所（下段）`. | Includes half-width kana, small kana, dakuten, numbers, and other half-width symbols. |
| `REQ-02` | The three fields must continue to reject non-half-width input and show inline field-level validation errors through the existing message-binding flow. | Use the existing inline `.inputError` path, not popup-only behavior. |
| `REQ-03` | Other `SPMT0021` validation, register/update transport, backend process flow, and data persistence behavior must remain unchanged. | Keep scope bounded to the requested fix. |
