---
title: "Ma tran validation SPMT00141 doi chieu DDL TMT026_PRODUCT moi"
date: "2026-03-21"
feature: "SPMT00141"
status: "completed"
scope: "Chi doi chieu cac field ma code hien tai dang dung; khong bao gom PRODUCTCD va PRODUCTCDHANDMADE"
note: "Tap trung vao check null, check length, check decimal/date. Khong tu dong xem DB nullable la nghiep vu nullable."
---

# Ma Tran Validation SPMT00141 va DDL moi

## 1. Nguyen tac doc bang

- `DDL moi`: rang buoc the hien trong file `CREATE_TABLE_TMT026_PRODUCT.sql`
- `FE`: validation o Angular component
- `BE`: validation o register/update process
- `Ket luan`: chi danh dau lech khi co bang chung tu code hien tai

## 2. Ma tran validation

| Field | DDL moi | FE hien tai | BE hien tai | Ket luan |
| --- | --- | --- | --- | --- |
| `productNm` | `varchar(100) NOT NULL` | required, max `40` | required, max `40` | `Lech ro rang ve length` |
| `productNmEng` | `varchar(100) NULL` | max `100` | max `100` | `Khop` |
| `keyword` | `varchar(50) NULL` | required, max `50` | required, max `50` | `Code dang stricter hon DDL` |
| `purchaseType` | `varchar(2) NULL` | required | required | `Code dang stricter hon DDL` |
| `category` | `varchar(2) NULL` | required | required | `Code dang stricter hon DDL` |
| `productType` | `varchar(2) NULL` | required | required | `Code dang stricter hon DDL` |
| `gMainClassRnmTypeA` | map vao `GMIDCLASSCD2 varchar(3) NOT NULL` va `GSMALLCLASSCD3 varchar(4) NOT NULL` | required, khong thay check length | required, khong thay check length | `Lech mapping va thieu check length phong thu` |
| `gMainClassRnmTypeB` | `GSUBCLASSCD4 varchar(12) NOT NULL` | required, khong thay check length | required, khong thay check length | `Thieu check length phong thu` |
| `reserveType` | cot dung theo DDL moi la `OBLIGATIONTOPURCHASE varchar(2) NULL` | khong thay check length rieng | khong thay check length rieng | `Lech mapping va thieu check length phong thu` |
| `reserveType1` | cot dung theo DDL moi la `STRKBN1 varchar(2) NULL` | khong thay check length rieng | khong thay check length rieng | `Lech mapping va thieu check length phong thu` |
| `reserveType2` | cot dung theo DDL moi la `STRKBN2 varchar(2) NULL` | khong thay check length rieng | khong thay check length rieng | `Lech mapping va thieu check length phong thu` |
| `reserveType3` | cot dung theo DDL moi la `STRKBN3 varchar(2) NULL` | khong thay check length rieng | khong thay check length rieng | `Lech mapping va thieu check length phong thu` |
| `orderUnit` | `varchar(20) NULL` | required co dieu kien, max `20` | required co dieu kien, max `20` | `Code dang stricter hon DDL` |
| `stockUnit` | `varchar(20) NULL` | required co dieu kien, max `20` | required co dieu kien, max `20` | `Code dang stricter hon DDL` |
| `weightConvOrder` | `varchar(7) NULL` | required co dieu kien, numeric, non-negative, `4.2` | required co dieu kien, decimal toi da `9999.99` | `Validation giua FE/BE dong bo, stricter hon DDL string` |
| `weightConvoStock` | `varchar(7) NULL` | required co dieu kien, numeric, non-negative, `4.2` | required co dieu kien, decimal toi da `9999.99` | `Validation giua FE/BE dong bo, stricter hon DDL string` |
| `grossWait` | `varchar(10) NULL` | max `10`, numeric, non-negative, `7.2` | decimal toi da `9999999.99` | `Validation giua FE/BE dong bo, stricter hon DDL string` |
| `specificationAcquisitionInf` | `varchar(20) NULL` | required co dieu kien, max `20` | required co dieu kien, max `20` | `Code dang stricter hon DDL` |
| `specificationAcquisitionDt` | `varchar(10) NULL` | required co dieu kien | required co dieu kien | `Code dang stricter hon DDL` |
| `unitsPerPackage` | `STANDARDPIECE varchar(40) NULL` | max `40` | max `40` | `Khop voi cot dang dung trong code` |
| `cookingPiece` | `varchar(40) NULL` | max `40` | max `40` | `Khop` |
| `tojPlaceOfOrigin` | `varchar(15) NULL` | max `15` | max `15` | `Khop` |
| `shoguchiKbn` | `varchar(1) NULL` | boolean/flag | boolean/flag | `Khop muc do validation hien tai` |
| `stockKbn` | `varchar(1) NULL` | boolean/flag | boolean/flag | `Khop muc do validation hien tai` |
| `mixCompositionCollaborationKbn` | `varchar(1) NULL` | boolean/flag | boolean/flag | `Khop muc do validation hien tai` |

## 3. Chung cu chinh

### 3.1. Required va max length backend

- Register:
  - `Spmt00141RegisterProcess.java:198-250`
- Update:
  - `Spmt00141UpdateProcess.java:210-261`

### 3.2. Decimal backend

- Register:
  - `Spmt00141RegisterProcess.java:259-271`
- Update:
  - `Spmt00141UpdateProcess.java:266-274`

### 3.3. Validation frontend

- `spmt00141.component.ts:2234-2360`

### 3.4. DDL moi

- `CREATE_TABLE_TMT026_PRODUCT.sql:4-65`

## 4. Ket luan ngan

Neu chi xet nhom validation cho field code hien tai dang dung, thi:

- lech ro rang nhat la `productNm` do code gioi han `40` trong khi DDL moi la `100`
- nhieu field dang duoc code bat buoc du DDL moi cho phep `NULL`
- nhom `reserveType`, `reserveType1/2/3`, `gMainClassRnmTypeA/B` khong chi lech mapping ma con thieu validation length phong thu theo width cua DDL moi

## 5. Nhom can uu tien xem lai

1. `productNm`
2. `reserveType`
3. `reserveType1`
4. `reserveType2`
5. `reserveType3`
6. `gMainClassRnmTypeA`
7. `gMainClassRnmTypeB`
