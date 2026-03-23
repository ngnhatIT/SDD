---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC observed edge cases and gaps"
owner: "Unassigned"
status: "draft"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "03-data-model.md"
  - "04-api-contract.md"
  - "05-behavior.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/common/process/MasterCheckExclusionProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateNewProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateSaveProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acupdate/process/spor00701acUpdateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acdelete/process/spor00701acDeleteProcess.java"
test_refs:
  - "09-test-cases.md"
---

# Edge Cases

## Confirmed From Code

- `confirmed` The backend search API does not enforce the UI-required fields `storeCd`, `sectionCd`, `groupCd`, and `requestType`; direct API callers can broaden the search scope.
- `confirmed` The UI exposes six status filters, but the backend can still return status `04` pullback and `08` drop rows.
- `confirmed` `MasterCheckExclusionProcess.checkExclusion(...)` only emits deleted or stale-row errors when a row is found; if the query returns no row, no error is added.
- `confirmed` The delete success callback currently shows `ME000063`, whose repo text means the row has already been deleted.
- `confirmed` `spor00701acCreateProcess.validateProductCdExistsMaster(...)` calls `MasterNameGetProcess.getProductAgreementNm(...)`, and that helper does not filter by the submitted `PRODUCTCD`.
- `confirmed` `CreateNew` binds `alarmInput` into column `AIRLN`, binds `alarmKbnInput` into `ALARMKBN`, and leaves `ALARM` empty.
- `confirmed` `CreateSave` insert clears all three alarm-related columns `AIRLN`, `ALARMKBN`, and `ALARM`.
- `confirmed` `Update` ignores request fields `alarmInput` and `alarmKbnInput`.
- `confirmed` `CreateCopy` copies source `ALARM` but clears `ALARMKBN`.
- `confirmed` `CreateCopy` preserves source `ORDERREQUESTDATE`, source `ORDERREQUESTUSER`, source `ENTPRG`, and source `UPDPRG`.
- `confirmed` Warning evaluation is skipped entirely when `TMT026_PRODUCT.SHOGUCHIKBN = '1'`.
- `confirmed` Several backend flows call `.toString()` or `.isEmpty()` on request fields without null guards, which makes direct API calls less resilient than Angular-driven calls.

## Inferred From Context

- `inferred` `SHOGUCHIKBN = '1'` likely means a product category that is exempt from warning checks.
- `inferred` Pullback and drop statuses may exist for cross-screen lifecycle reasons but were intentionally hidden from the filter UI.
- `inferred` The alarm columns may be legacy fields that the screen only partially supports today.

## Unresolved Questions

- `unresolved` Should the backend reject search requests that omit UI-required fields?
- `unresolved` Should missing rows during check-link, update, or delete return `ME000063` instead of falling through?
- `unresolved` Should successful delete use a dedicated success or info message instead of an error-style deleted-data message?
- `unresolved` Should product validation check the exact submitted `PRODUCTCD` plus effective date range, or is current store and partner scoping sufficient?
- `unresolved` Should copy create new request metadata rather than preserving the source request date and request user?
- `unresolved` Should warning text and warning flags be part of the durable contract for all mutation paths?
- `unresolved` Which of the currently visible oddities are approved legacy behavior versus defects to be fixed before future feature work?

## Recommended Review Focus

- Confirm the intended ownership and meaning of `AIRLN`, `ALARMKBN`, and `ALARM`.
- Confirm whether the missing-row behavior in shared exclusion checking is acceptable for this screen.
- Confirm whether search status coverage should include pullback and drop in the UI.
- Confirm whether the current product validation helper is sufficient for business risk.
- Confirm whether direct API consumers exist and therefore require stronger server-side validation.
