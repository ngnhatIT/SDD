---
id: "2026-03-19-spmt0021-halfwidth-validation"
title: "SPMT0021 half-width validation test cases"
owner: "Kikancen Screen Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "08-acceptance-criteria.md"
  - "11-implementation-report.md"
---

# Test Cases

| ID | Acceptance Links | Scenario | Expected Result |
| --- | --- | --- | --- |
| `TC-01` | `AC-01` | In `SPMT0021` detail input, enter values such as `ｶﾞｯｺｳ123` in `名称（半角）`, `ﾄｳｷｮｳ1-2-3` in `カナ住所（上段）`, and `ﾏﾝｼｮﾝB-5` in `カナ住所（下段）`, then run register/update validation with other mandatory fields valid. | The three fields do not raise character-pattern errors and the flow proceeds past frontend validation. |
| `TC-02` | `AC-02` | Enter non-half-width input such as `ガッコウ` or `東京１－２－３` in each targeted field and run register/update validation. | Each field shows its existing inline validation error and the flow is blocked. |
| `TC-03` | `AC-03` | Recheck non-targeted fields such as postcode, phone, fax, and Kanji address/name validation during register/update, and re-inspect backend `Spmt0021RegistProcess` / `Spmt0021UpdateProcess`. | No unintended validation drift appears outside the three targeted fields and backend processing remains unchanged. |

## Verification Notes

- Manual verification is expected because the repository does not provide reliable tracked automated coverage for this screen family.
- A frontend build or compile check should be recorded when the environment allows it.
