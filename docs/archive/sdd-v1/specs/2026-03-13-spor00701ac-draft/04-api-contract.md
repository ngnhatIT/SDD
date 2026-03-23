---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC observed API contract"
owner: "Unassigned"
status: "draft"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "03-data-model.md"
  - "06-edge-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spor00701acinit/dto/Spor00701acInitRequest.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acsearch/dto/Spor00701acSearchRequest.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/dto/Spor00701acCreateRequest.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acupdate/dto/Spor00701acUpdateRequest.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acdelete/dto/Spor00701acDeleteRequest.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accheckWarning/dto/Spor00701accheckWarningRequest.java"
test_refs:
  - "09-test-cases.md"
---

# API Contract

## Contract Ownership Status

- No feature-owned `contracts/` directory, OpenAPI file, or schema artifact was found for `SPOR00701AC`.
- All request and response shapes below are reconstructed from Java DTOs and Angular callers.
- The shared `accessInfo` envelope is required in practice, but its full machine-readable contract is unresolved because it is owned outside this feature.

## Endpoint Inventory

| Endpoint | Purpose | Request | Success response | Basis |
| --- | --- | --- | --- | --- |
| `POST /kikancen/Spor00701acInit` | Bootstrap store list | `accessInfo` | `storeList[]`, unused `orderRequestNo` field | `confirmed` |
| `POST /kikancen/Spor00701acSearchCnt` | Count matching rows and fetch deadline | `accessInfo`, `pageInfo`, `spor00701acSearchCondition` | `dataCnt`, `deadline` | `confirmed` |
| `POST /kikancen/Spor00701acSearch` | Fetch paged matching rows | `accessInfo`, `pageInfo`, `spor00701acSearchCondition` | `rows[]` | `confirmed` |
| `POST /kikancen/Spor00701acChecklink` | Check optimistic lock before opening a row | `accessInfo`, `systemSlipNo`, `updateTime`, `orderRequestNo` | Empty success body | `confirmed` |
| `POST /kikancen/Spor00701acCheckWarning` | Compute warning messages before confirm or temporary save | `accessInfo`, `productCdInput`, `deliveryDateInput`, `remarksInput`, `orderPriceInput`, `storeCdInput` | `msgEndSale`, `msgMaxAmount`, `msgRemark` | `confirmed` |
| `POST /kikancen/Spor00701acCreateNew` | Insert a confirmed request row | `accessInfo`, `spor00701acCreateCondition` | Empty success body | `confirmed` |
| `POST /kikancen/Spor00701acCreateSave` | Insert or update a temporary-save row | `accessInfo`, `spor00701acCreateCondition` | Empty success body | `confirmed` |
| `POST /kikancen/Spor00701acCreateCopy` | Copy a source row into a new temporary-save row | `accessInfo`, `spor00701acCreateCondition` | `orderRequestNoInput`, `systemSlipNoInput`, `updateTimeInput` | `confirmed` |
| `POST /kikancen/Spor00701acUpdate` | Update an existing row into requested state | `accessInfo`, `spor00701acUpdateCondition` | Empty success body | `confirmed` |
| `POST /kikancen/Spor00701acDelete` | Soft delete an existing row | `accessInfo`, `spor00701acDeleteCondition` | Empty success body in practice; DTO also has unused `dataCnt` and `rows` | `confirmed` |

## Shared Request Envelope

| Field | Observed use | Basis |
| --- | --- | --- |
| `accessInfo.CMPNYCD` | Company scoping in nearly every SQL statement | `confirmed` |
| `accessInfo.USRCD` | Audit fields, request-user assignment, and number-generation procedure calls | `confirmed` |
| `accessInfo.LANG` | Language-sensitive code-master lookup | `confirmed` |
| `accessInfo.STORECD` | Default store on screen init | `confirmed` |
| Other `accessInfo` members | Potential shared auth or tenant data | `inferred` |

## Request DTOs

### `spor00701acSearchCondition`

Fields:

- `storeCd`
- `sectionCd`
- `groupCd`
- `requestType`
- `productCd`
- `partnerCd`
- `orderRequestDateFrom`
- `orderRequestDateTo`
- `deliveryDateFrom`
- `deliveryDateTo`
- `userCd`
- `orderListKBNStatus[]`

Notes:

- `confirmed` Angular treats `storeCd`, `sectionCd`, `groupCd`, and `requestType` as required.
- `confirmed` The backend does not enforce those required rules and will build a broader search when fields are empty.

### `pageInfo`

Fields:

- `pageNum`
- `dispNum`

Notes:

- `confirmed` Search rows use `pageNum` and `dispNum` for paging and row numbering.
- `confirmed` Search count ignores paging for count, but still receives the structure.

### `spor00701acCreateCondition`

Fields:

- context and keys: `storeCdInput`, `sectionCdInput`, `groupCdInput`, `requestCategoryInput`, `systemSlipNoInput`, `orderRequestNoInput`, `updateTimeInput`
- product and partner: `productCdInput`, `productNameInput`, `productMemoInput`, `partnerCdInput`
- dates and quantities: `deliveryDateInput`, `orderRequestQtyInput`, `changeQtyInput`, `unitKBNInput`, `deliveryTypeKBNInput`, `orderUnitPriceInput`, `orderPriceInput`
- notes and warnings: `remarksInput`, `internalNoteInput`, `alarmInput`, `alarmKbnInput`

Notes:

- `confirmed` Angular always sends numeric fields as numbers or `0`.
- `confirmed` Backend create validation calls `toString()` on several numeric fields without null guards.

### `spor00701acUpdateCondition`

Fields:

- `orderRequestNoInput`
- `systemSlipNoInput`
- `updateTimeInput`
- `productCdInput`
- `productNameInput`
- `productMemoInput`
- `partnerCdInput`
- `deliveryDateInput`
- `orderRequestQtyInput`
- `changeQtyInput`
- `unitKBNInput`
- `deliveryTypeKBNInput`
- `orderUnitPriceInput`
- `remarksInput`
- `internalNoteInput`
- `orderPriceInput`
- `alarmInput`
- `alarmKbnInput`

Notes:

- `confirmed` `alarmInput` and `alarmKbnInput` are present in the request DTO but are not persisted by the update SQL.

### `spor00701acDeleteCondition`

Fields:

- `orderRequestNoInput`
- `systemSlipNoInput`
- `updateTimeInput`

### `Checklink` request

Fields:

- `orderRequestNo`
- `systemSlipNo`
- `updateTime`

### `CheckWarning` request

Fields:

- `productCdInput`
- `deliveryDateInput`
- `remarksInput`
- `orderPriceInput`
- `storeCdInput`

## Response DTOs

### `Spor00701acInitResponse`

Fields:

- `storeList[] { storeCd, storeNm }`
- `orderRequestNo`

Notes:

- `confirmed` `orderRequestNo` exists in the DTO but is not populated by the init process.

### `Spor00701acSearchResponse`

Fields:

- `dataCnt`
- `deadline`
- `rows[] { no, systemSlipNo, status, requestCategoryNm, orderRequestNo, orderRequestDate, deliveryDate, productCd, productNm, orderRequestQty, orderRequestQtyChanges, orderQtyOldNm, orderQtyOldCd, deliveryKbnNm, deliveryKbnCd, partnerUsrNm, partnerCd, groupNm, orderUsrNm, productMemo, orderUnitPrice, orderPrice, remarks, internalNotes, reasonForReturn, purchaseOrderNumber, isRedFlag, updateTime }`

Notes:

- `confirmed` `isRedFlag` is computed from `status == '03'`.
- `unresolved` No observed consumer uses `isRedFlag` in the screen template.

### `Spor00701acCreateResponse`

Fields:

- `systemSlipNoInput`
- `orderRequestNoInput`
- `updateTimeInput`

Notes:

- `confirmed` Only copy fills these fields.
- `confirmed` Create-new and create-save return an otherwise empty success body.

### `Spor00701acUpdateResponse`

- Empty success body

### `Spor00701acDeleteResponse`

Fields:

- `dataCnt`
- `rows[]`

Notes:

- `confirmed` The delete process does not populate these fields.

### `Spor00701accheckWarningResponse`

Fields:

- `msgEndSale`
- `msgMaxAmount`
- `msgRemark`

### `Spor00701acChecklinkResponse`

- Empty success body

## Shared Error Contract

- `confirmed` The screen consistently checks `response.fatalError` after webservice calls.
- `confirmed` Shared exclusion logic can emit `ME000063` for deleted data and `ME000144` for stale `UPDDATETIME`.
- `unresolved` The exact machine-readable error-body schema is not owned by this feature package.
