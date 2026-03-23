---
id: "2026-03-19-spmt0021-halfwidth-validation"
title: "SPMT0021 half-width validation alignment"
owner: "Kikancen Screen Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "05-behavior.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
  - "10-rollout.md"
  - "11-implementation-report.md"
---

# Feature Summary

Fix `SPMT0021` so `名称（半角）`, `カナ住所（上段）`, and `カナ住所（下段）` accept all half-width characters during register/update validation.

# Request Source

- User bug note: `SPMT0021 : 名称（半角）、カナ住所（上段）、カナ住所（下段）に半角文字が入らない。 ｶﾅ文字（カナ小文字、カナ濁点、数字なども入力できない） このフィールドは半角文字全てOKとして下さい。`

# Scope

- In scope: frontend validation behavior for the three SPMT0021 detail fields, plus the minimum shared `BaseComponent.validateFields(...)` support needed to express the half-width-character rule.
- Out of scope: backend DTO/webservice/process contract changes, SQL changes, layout changes, and validation changes for any other field.

# Artifact Status

| Artifact | Status |
| --- | --- |
| `01-requirements.md` | required |
| `02-design.md` | required |
| `03-data-model.md` | n/a |
| `04-api-contract.md` | n/a |
| `05-behavior.md` | required |
| `06-edge-cases.md` | n/a |
| `07-tasks.md` | required |
| `08-acceptance-criteria.md` | required |
| `09-test-cases.md` | required |
| `10-rollout.md` | required |
| `11-implementation-report.md` | required |
| `12-review-report.md` | n/a |
| `contracts/` | n/a |
| `spec-pack.manifest.yaml` | n/a |
| `changelog.md` | required |

# Traceability

| Requirement | Design | Task | Acceptance | Test Case |
| --- | --- | --- | --- | --- |
| `REQ-01` | `DES-01`, `DES-02` | `TASK-01`, `TASK-02` | `AC-01`, `AC-02` | `TC-01`, `TC-02` |
| `REQ-02` | `DES-02` | `TASK-02` | `AC-02` | `TC-02` |
| `REQ-03` | `DES-03` | `TASK-03` | `AC-03` | `TC-03` |
