---
id: "SPMT00141"
title: "SPMT00141 tasks"
owner: "WMS Delivery Team"
status: "in_progress"
last_updated: "2026-03-18"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spmt00141register"
  - "src/main/java/jp/co/brycen/kikancen/spmt00141update"
  - "src/main/webapp/angular/src/app/components/spmt00141"
test_refs:
  - "09-test-cases.md"
---

# Tasks

| Task | Description | Requirement Links | Design Links | Verification |
| --- | --- | --- | --- | --- |
| `TASK-01` | Resolve the approved `KANRIKBN` selector rule for `TAMT050_PRODUCTNUMBERING`. | `REQ-08` | `DES-08` | `TC-09` |
| `TASK-02` | Update init constants, master loading, and affected DTO/response shapes for corrected reserve-type codes and the new field master data. | `REQ-01`, `REQ-05`, `REQ-07` | `DES-01`, `DES-05` | `TC-01`, `TC-02` |
| `TASK-03` | Update backend register, update, and detail flows for new fields and `PRODUCTCDHANDMADE` preservation rules now; defer generated `PRODUCTCD` and transactional numbering until `TASK-01` is resolved. | `REQ-02`, `REQ-04`, `REQ-05`, `REQ-06`, `REQ-08` | `DES-02`, `DES-04`, `DES-05`, `DES-07` | `TC-03`, `TC-04`, `TC-05` |
| `TASK-04` | Add one family-consistent copy action that inserts one new row only and reloads the inserted record into update mode. | `REQ-03`, `REQ-04`, `REQ-08` | `DES-02`, `DES-03`, `DES-04` | `TC-06` |
| `TASK-05` | Update the frontend detail form, validation, and success handling for hidden manual code, four new fields, and corrected master data now; defer readonly/generated `PRODUCTCD` behavior and copy enablement until `TASK-01` is resolved. | `REQ-01`, `REQ-02`, `REQ-03`, `REQ-05`, `REQ-06`, `REQ-07` | `DES-01`, `DES-03`, `DES-05`, `DES-07` | `TC-01`, `TC-02`, `TC-06`, `TC-07`, `TC-08` |
| `TASK-06` | Run verification, record implementation evidence, and complete implementation and review reports after the blocker is cleared and code changes land. | `REQ-01` to `REQ-08` | `DES-01` to `DES-08` | `TC-01` to `TC-09` |

## Sequencing

1. `TASK-02`
2. non-numbering slice of `TASK-03`
3. non-numbering slice of `TASK-05`
4. `TASK-01`
5. numbering-dependent remainder of `TASK-03`, `TASK-04`, and `TASK-05`
6. `TASK-06`

## Notes

- `TASK-02` plus the non-numbering slices of `TASK-03` and `TASK-05` may proceed while `KANRIKBN` remains unresolved.
- The numbering-dependent slices of `TASK-03`, all of `TASK-04`, and the generated-code or copy slices of `TASK-05` remain blocked until `TASK-01` is resolved.
- The package intentionally stops short of freezing a copy endpoint token while authority conflicts remain open.
