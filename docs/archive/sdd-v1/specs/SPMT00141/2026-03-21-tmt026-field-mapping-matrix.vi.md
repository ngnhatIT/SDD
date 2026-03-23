---
title: "Ma tran mapping field SPMT00141 voi TMT026_PRODUCT moi"
date: "2026-03-21"
feature: "SPMT00141"
status: "completed"
scope: "Doi chieu field dang dung trong code hien tai voi DDL TMT026_PRODUCT nguoi dung cung cap"
note: "Khong bao gom PRODUCTCD va PRODUCTCDHANDMADE theo yeu cau. Chi ghi nhan cac diem lech o nhung field ma code hien tai thuc su dang dung."
---

# Ma Tran Mapping SPMT00141 va TMT026_PRODUCT moi

## 1. Pham vi doi chieu

Tai lieu nay chi tra loi cau hoi:

- trong code hien tai cua `SPMT00141`, ngoai `PRODUCTCD` va `PRODUCTCDHANDMADE`, field nao dang duoc dung nhung chua mapping dung voi DDL moi
- cot nao trong DDL moi chua co field tuong ung trong `SPMT00141`

Nguon doi chieu:

- code hien tai cua `SPMT00141`
- `C:/Users/nk_nhat.BRYCENVN/Desktop/CREATE_TABLE_TMT026_PRODUCT.sql`

## 2. Cac field dang dung trong code va da xac nhan bi lech voi DDL moi

| Field trong code hien tai | Dang map vao cot nao trong code | DDL moi co cot nao | Trang thai | Ghi chu |
| --- | --- | --- | --- | --- |
| `reserveType` | `STRKBN` | `OBLIGATIONTOPURCHASE` | `Lech mapping` | man hinh CRUD van dung `STRKBN`, trong khi DDL moi va nhanh `csvimport` cua cung family da dung `OBLIGATIONTOPURCHASE` |
| `reserveTypeSearch` | `STRKBN` | `OBLIGATIONTOPURCHASE` | `Lech mapping` | search filter hien tai van where theo `TMT026.STRKBN` |
| `gMainClassRnmTypeA` | `GMIDCLASSCD2` va dong thoi `GSMALLCLASSCD3` | `GMIDCLASSCD2`, `GSMALLCLASSCD3`, `GSUBCLASSCD4` | `Partial / sai hinh` | 1 field UI hien map vao 2 cot khac nhau; `GSMALLCLASSCD3` khong co field rieng |
| `gMainClassRnmTypeB` | `GSUBCLASSCD4` | `GSUBCLASSCD4` | `Dang map` | field nay van co mapping ro rang |
| `reserveType1` | `STRRSRV1` | `STRKBN1` | `Lech mapping` | trong `csvimport` cung family, field nay da duoc map vao `STRKBN1` |
| `reserveType2` | `STRRSRV2` | `STRKBN2` | `Lech mapping` | trong `csvimport` cung family, field nay da duoc map vao `STRKBN2` |
| `reserveType3` | `STRRSRV3` | `STRKBN3` | `Lech mapping` | trong `csvimport` cung family, field nay da duoc map vao `STRKBN3` |

## 3. Chung cu code cho cac diem lech chinh

### 3.1. `reserveType` / `reserveTypeSearch`

- Register ghi `STRKBN`:
  - `Spmt00141RegisterProcess.java:361`
- Update ghi `STRKBN`:
  - `Spmt00141UpdateProcess.java:175`
- Get detail doc `STRKBN`:
  - `Spmt00141GetDetailProcess.java:159`
  - `Spmt00141GetDetailProcess.java:56`
- Search loc theo `STRKBN`:
  - `Spmt00141SearchAllRecProcess.java:320`
  - `Spmt00141SearchAllRecProcess.java:518`
- Trong DDL moi:
  - `OBLIGATIONTOPURCHASE`: `CREATE_TABLE_TMT026_PRODUCT.sql:35`
- Chung cu cung family:
  - `Spmt00141CsvImportRowDto.java` dung field `obligationToPurchase`
  - `Spmt00141CsvImportProcess.java:342`
  - `Spmt00141CsvImportProcess.java:431`

### 3.2. `gMainClassRnmTypeA`

- Register bind `gMainClassRnmTypeA` vao 2 cot:
  - `Spmt00141RegisterProcess.java:106`
  - `Spmt00141RegisterProcess.java:107`
- Update bind `gMainClassRnmTypeA` vao 2 cot:
  - `Spmt00141UpdateProcess.java:111`
  - `Spmt00141UpdateProcess.java:112`
- DDL moi tach rieng:
  - `GMIDCLASSCD2`: `CREATE_TABLE_TMT026_PRODUCT.sql:5`
  - `GSMALLCLASSCD3`: `CREATE_TABLE_TMT026_PRODUCT.sql:6`
  - `GSUBCLASSCD4`: `CREATE_TABLE_TMT026_PRODUCT.sql:7`

### 3.3. `reserveType1/2/3`

- Register ghi:
  - `STRRSRV1`: `Spmt00141RegisterProcess.java:326`
  - `STRRSRV2`: `Spmt00141RegisterProcess.java:327`
  - `STRRSRV3`: `Spmt00141RegisterProcess.java:328`
- Update ghi:
  - `STRRSRV1`: `Spmt00141UpdateProcess.java:178`
  - `STRRSRV2`: `Spmt00141UpdateProcess.java:179`
  - `STRRSRV3`: `Spmt00141UpdateProcess.java:180`
- Get detail doc:
  - `STRRSRV1`: `Spmt00141GetDetailProcess.java:160`
  - `STRRSRV2`: `Spmt00141GetDetailProcess.java:161`
  - `STRRSRV3`: `Spmt00141GetDetailProcess.java:162`
- DDL moi:
  - `STRKBN1`: `CREATE_TABLE_TMT026_PRODUCT.sql:36`
  - `STRKBN2`: `CREATE_TABLE_TMT026_PRODUCT.sql:37`
  - `STRKBN3`: `CREATE_TABLE_TMT026_PRODUCT.sql:38`
- Chung cu cung family:
  - `Spmt00141CsvImportRowDto.java` dung `strKbn1`, `strKbn2`, `strKbn3`
  - `Spmt00141CsvImportProcess.java:343`
  - `Spmt00141CsvImportProcess.java:344`
  - `Spmt00141CsvImportProcess.java:345`
  - `Spmt00141CsvImportProcess.java:432`
  - `Spmt00141CsvImportProcess.java:433`
  - `Spmt00141CsvImportProcess.java:434`

## 4. Cac field dang dung trong code van con mapping voi DDL moi

Cac field sau van thay cot tuong ung trong DDL moi, nen khong xep vao nhom "chua mapping":

- `productNm` -> `PRODUCTNM`
- `productNmEng` -> `PRODUCTNMEN`
- `keyword` -> `KEYWORD`
- `purchaseType` -> `PURCHASEKBN`
- `category` -> `CATEGORYCD`
- `productType` -> `PRODUCTKBN`
- `shoguchiKbn` -> `SHOGUCHIKBN`
- `orderUnit` -> `ORDERUNIT`
- `weightConvOrder` -> `WEIGHTCONVORDER`
- `stockKbn` -> `STOCKKBN`
- `stockUnit` -> `STOCKUNIT`
- `weightConvoStock` -> `WEIGHTCONVOSTOCK`
- `mixCompositionCollaborationKbn` -> `MIXCOMPOSITIONCOLLABORATIONKBN`
- `grossWait` -> `GROSSWAIT`
- `specificationAcquisitionInf` -> `SPECIFICATIONACQUISITIONINF`
- `specificationAcquisitionDt` -> `SPECIFICATIONACQUISITIONDT`
- `unitsPerPackage` -> `STANDARDPIECE`
- `cookingPiece` -> `COOKINGPIECE`
- `tojPlaceOfOrigin` -> `TOJPLACEOFORIGIN`

## 5. Ket luan ngan

Neu bo `PRODUCTCD` va `PRODUCTCDHANDMADE` ra, thi cac diem can uu tien check/fix dau tien la:

1. `reserveType`
2. `reserveTypeSearch`
3. `gMainClassRnmTypeA` do dang map gap vao `GMIDCLASSCD2` va `GSMALLCLASSCD3`
4. `reserveType1`
5. `reserveType2`
6. `reserveType3`
