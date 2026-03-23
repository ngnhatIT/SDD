---
id: "SPMT00141"
title: "SPMT00141 edge cases"
owner: "WMS Delivery Team"
status: "blocked"
last_updated: "2026-03-18"
related_specs:
  - "02-design.md"
  - "05-behavior.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spmt00141register/process/Spmt00141RegisterProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141update/process/Spmt00141UpdateProcess.java"
test_refs:
  - "09-test-cases.md"
---

# Edge Cases

## Numbering And Transaction Safety

- If the backend increments the numbering source and the insert fails, the entire transaction must roll back.
- Register and copy share the same numbering rule.
- Implementation is blocked until the authoritative numbering table and selector rules are approved.

## Legacy Manual-Code Data

- Historical rows may already contain `PRODUCTCDHANDMADE`.
- The current request hides manual-code behavior from the UI.
- Update must preserve historical values already stored in the database.
- Register and copy must write `NULL` for that field.

## Copy Isolation

- Copy must create only one new `TMT026_PRODUCT` row.
- Copy must not duplicate related-table rows.
- Copy must not mutate the source row.

## Validation Parity

- If frontend validation is bypassed, backend validation still must reject invalid conditional states.
- If backend validation is stronger than frontend validation, the frontend must be updated to match before release.

## Schema Conflict

- The requested feature cannot safely progress to implementation while the numbering-row selector remains unresolved.
- Existing code traces outside schema authority are evidence of drift, not permission to implement.

## Out-Of-Scope Stability

- CSV behavior stays untouched.
- Unspecified join behavior, including `TAMT049_BASEGROUP`, stays untouched.
- Delete behavior stays untouched.
