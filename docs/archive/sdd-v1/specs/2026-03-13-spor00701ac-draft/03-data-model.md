---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC observed data model"
owner: "Unassigned"
status: "draft"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "04-api-contract.md"
  - "06-edge-cases.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spor00701acsearch/process/Spor00701acSearchAllProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acsearch/process/Spor00701acSearchCntProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateNewProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateSaveProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateCopyProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acupdate/process/spor00701acUpdateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acdelete/process/spor00701acDeleteProcess.java"
test_refs:
  - "09-test-cases.md"
---

# Data Model

## Schema Evidence Status

- No `SPOR00701AC`-owned migration, DDL, ERD, or machine-readable schema artifact was found in this repository.
- Table and field semantics below are reconstructed from inline SQL only.
- Stored procedure `SP_GET_ORDER_NO` is called by the feature, but its implementation was not found in the repository.

## Observed Entities And Dependencies

| Entity | Kind | Observed use | Basis | Notes |
| --- | --- | --- | --- | --- |
| `TAOR59_ANACORDERREQUEST` | Durable transaction table | Search source; create new; temporary save; copy; update; soft delete; optimistic-lock target | `confirmed` | Central business table for this screen |
| `TMT003_STORE` | Master table | Init store dropdown | `confirmed` | Filtered by `CMPNYCD` and valid `DELFLG` |
| `TAMT029_GROUP` | Master table | Group name join; deadline lookup | `confirmed` | Search-count deadline query depends on selected store, section, and group |
| `TMT002_USER` | Master table | Order request user name join | `confirmed` | Joined by `ORDERREQUESTUSER` |
| `TMT023_PARTNER` | Master table | Partner name join and warning or focus-out support | `confirmed` | Used both directly and through shared master lookup flows |
| `TMT026_PRODUCT` | Master table | Warning bypass check through `SHOGUCHIKBN` | `confirmed` | Meaning of `SHOGUCHIKBN = '1'` is inferred only |
| `TAMT026_PRODUCTAGREEMENT` | Master or agreement table | Warning end-date lookup; product validation helper | `confirmed` | Validation helper behavior is questionable; see edge cases |
| `VMT050_ALL` | Code master view | Request category, unit, delivery type, status display, warning parameter lookup | `confirmed` | Language-sensitive joins in search and warning flows |
| `TAPR11_ANACPURCHASESLIPDETAIL` | Durable transaction table | Status derivation for `received` rows | `confirmed` | Presence of related purchase-slip detail changes the derived row status |
| `SP_GET_ORDER_NO` | Stored procedure | Generates new `ORDERREQUESTNO` | `confirmed` | Number-generation rules remain unresolved because procedure body is missing |

## Observed State Transitions On `TAOR59_ANACORDERREQUEST`

| Action | Confirmed mutation | Notes |
| --- | --- | --- |
| `CreateNew` | Inserts a new row with generated `ORDERREQUESTNO`, `DATAPARTITION = '1'`, `APPROVALSTATUS = '0'`, `ORDERCATEGORY = '0'`, `ORDERREQUESTDATE = SYSDATE(6)`, `ORDERREQUESTUSER = current user`, `DELFLG = valid`, `EDITIONNUMBER = '1'` | `confirmed` Warning text currently binds into `AIRLN`, while `ALARM` is left empty |
| `CreateSave` new row | Inserts a new row with generated `ORDERREQUESTNO`, `DATAPARTITION = '0'`, empty `APPROVALSTATUS`, `ORDERCATEGORY = '0'`, `ORDERREQUESTDATE = SYSDATE(6)`, `ORDERREQUESTUSER = current user`, `DELFLG = valid`, `EDITIONNUMBER = '1'` | `confirmed` Alarm-related columns are all inserted as empty |
| `CreateSave` existing row | Updates an existing row by `SYSTEMSLIPNO` and valid `DELFLG`, sets edited fields, `UPDUSRCD`, `UPDDATETIME = SYSDATE(6)`, `UPDPRG`, `ORDERPRICE`, `DATAPARTITION = '0'`, empty `APPROVALSTATUS` | `confirmed` Does not increment `EDITIONNUMBER` and does not update `ORDERREQUESTDATE` or `ORDERREQUESTUSER` |
| `Update` | Updates an existing row by `SYSTEMSLIPNO`, `CMPNYCD`, and valid `DELFLG`; sets edited fields; sets `ORDERREQUESTDATE = SYSDATE(6)`; `ORDERREQUESTUSER = current user`; `DATAPARTITION = '1'`; `APPROVALSTATUS = '0'`; increments `EDITIONNUMBER` by `1` | `confirmed` Does not update `REQUESTCATEGORY`, `STORECD`, `SECTIONCD`, `GROUPCD`, `ALARM`, or `ALARMKBN` |
| `CreateCopy` | Inserts a new row by `INSERT ... SELECT` from the source row, using a new `ORDERREQUESTNO`, `NULL` `SYSTEMSLIPNO`, `DATAPARTITION = '0'`, `ORDERCATEGORY = '0'`, `ORDERUSER = current user`, new entry and update timestamps | `confirmed` Preserves source `ORDERREQUESTDATE`, source `ORDERREQUESTUSER`, source `ALARM`, source `ENTPRG`, and source `UPDPRG` |
| `Delete` | Soft deletes by setting `DELFLG = deleted`, `UPDUSRCD`, `UPDDATETIME = SYSDATE(6)`, and `UPDPRG` | `confirmed` No hard delete path observed |

## Observed Read Model For Search Rows

Search rows expose:

- identity and lifecycle: `SYSTEMSLIPNO`, derived `STATUS`, `ORDERREQUESTNO`, `UPDDATETIME`
- request context: request-category name, order-request date, delivery date, order-request user name
- product and partner context: product code, name, memo, partner code, partner name, group name
- quantity and pricing: request quantity, change quantity, unit name and code, unit price, order price
- notes and downstream fields: remarks, internal notes, reason for return, purchase order number

## Confirmed State-Derivation Rules

- `confirmed` `STATUS = '07'` when a non-deleted purchase-slip detail row exists for the order's `PURCHASEORDERNUMBER`
- `confirmed` `STATUS = '06'` when `ORDERCATEGORY = '1'`
- `confirmed` `STATUS = '05'` when `APPROVALSTATUS = '2'` and `ORDERCATEGORY = '0'`
- `confirmed` `STATUS = '04'` when `DATAPARTITION = '2'` and `ORDERCATEGORY = '0'`
- `confirmed` `STATUS = '03'` when `APPROVALSTATUS = '1'` and `ORDERCATEGORY = '0'`
- `confirmed` `STATUS = '02'` when `DATAPARTITION = '1'`, `APPROVALSTATUS = '0'`, and `ORDERCATEGORY = '0'`
- `confirmed` `STATUS = '01'` when `DATAPARTITION = '0'` and `ORDERCATEGORY = '0'`
- `confirmed` `STATUS = '08'` when `DATAPARTITION = '3'` and `ORDERCATEGORY = '0'`

## Unresolved Data Questions

- `unresolved` Whether `SYSTEMSLIPNO` is guaranteed globally unique across companies
- `unresolved` Whether `AIRLN`, `ALARMKBN`, and `ALARM` are all relevant fields for this feature or legacy carryovers
- `unresolved` Whether the warning-related code-master values are configuration-only or part of the durable business contract
- `unresolved` Whether copy is intended to preserve source request-date metadata
