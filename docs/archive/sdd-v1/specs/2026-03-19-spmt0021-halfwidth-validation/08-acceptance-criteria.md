---
id: "2026-03-19-spmt0021-halfwidth-validation"
title: "SPMT0021 half-width validation acceptance criteria"
owner: "Kikancen Screen Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "05-behavior.md"
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Criteria | Requirement Links |
| --- | --- | --- |
| `AC-01` | When a user enters half-width kana, small kana, dakuten, numbers, or other half-width symbols into `名称（半角）`, `カナ住所（上段）`, or `カナ住所（下段）`, `SPMT0021` register/update validation does not reject the value for character-pattern reasons. | `REQ-01` |
| `AC-02` | When any of the three targeted fields contains non-half-width characters, `SPMT0021` keeps the existing inline field-error behavior and blocks register/update. | `REQ-02` |
| `AC-03` | Validation and behavior outside the three targeted fields, plus backend register/update processing, remain unchanged. | `REQ-03` |
