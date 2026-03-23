---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
implementation_refs:
  - "11-implementation-report.md"
---

# Feature Summary

Align `BTCC0080AC` shared import validation with the reported BCC0080AC API-sheet behavior so omitted optional fields do not raise required-control errors.

# Request Source

- User bug note dated `2026-03-19`
- Reported phenomena:
  - `レスポンス_Btcc0080ac(0件)20260318NG.txt`
  - `レスポンス_Btcc0080ac20260318NG.txt`

# Classification

- Governed path: `reduced-path`
- Task profile: `fix-from-bug`

# Scope

## In Scope

- `BTCC0080AC` shared validation-rule calibration in `StaticApiCheckConfig`
- `BTCC0080AC` process-level validation only where shared field-name rules cannot express the required per-list behavior safely
- Governed evidence for the bug fix

## Out Of Scope

- Route or DTO shape changes
- SQL DML changes
- Response-envelope changes
- Frontend changes
- Message-catalog rewrites

# Raw Input Normalization

## Facts

- The user reported that omitted fields not marked required in the BCC0080AC API sheet are still validated.
- The user reported that `templateFlg` appears in menu validation errors even though that field is not part of the intended request payload.
- The current repository implementation loads `BTCC0080AC` shared rules from `src/main/java/jp/co/brycen/kikancen/api/common/validator/config/StaticApiCheckConfig.java`.
- The current shared validator emits `Please enter data into required control` through `ConstantValue.VALIDATE_REQUIRED_ERRORMSG`.
- `docs/sdd/context/schema_database.yaml` shows many `TAOR55_COMBINATIONHEADER`, `TAOR56_MENUPLANNING`, and `TAOR57_PRODUCTIONMATERIALCOMPOSITION` columns mapped by the request DTOs are nullable, including `TEMPLATE_FLG`.

## Open Questions

- The exact BCC0080AC API-sheet field-by-field required marker matrix is not stored in the repository.

## Non-Changes

- Do not change `BTCC0080AC` request or response DTO shape.
- Do not change `BTCC0080AC` SQL write or delete logic.
- Do not change existing date-range or non-negative custom validation behavior outside the minimal calibration needed for this bug.

## Approval Gaps

- Do not remove DTO fields or change shared error messages without separate approval because those would be externally visible contract changes.

