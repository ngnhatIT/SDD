---
title: "Bao cao tac dong thay doi TMT026 doi voi SPMT00141"
date: "2026-03-21"
feature: "SPMT00141"
scope: "Ra soat tac dong cau truc bang TMT026_PRODUCT"
status: "completed"
note: "Tai lieu tong hop bang tieng Viet, dung de chia se noi bo. Nguon review chinh thuc van la 12-review-report.md."
---

# Bao Cao Tac Dong TMT026 doi voi SPMT00141

## 1. Muc dich

Bao cao nay tong hop ket qua ra soat chuc nang `SPMT00141` sau khi doi chieu code hien tai voi:

- schema authority trong repo: `docs/sdd/context/schema_database.yaml`
- file thay doi bang do nguoi dung cung cap: `C:/Users/nk_nhat.BRYCENVN/Desktop/CREATE_TABLE_TMT026_PRODUCT.sql`

Muc tieu la xac dinh:

- `SPMT00141` co bi anh huong hay khong
- muc do anh huong
- nhung diem blocker can giai quyet truoc khi sua code

## 2. Ket luan tong quan

`SPMT00141` bi anh huong truc tiep boi thay doi cau truc `TMT026_PRODUCT`.

Tuy nhien, hien tai **chua the sua code an toan ngay** vi file SQL dinh kem **xung dot voi schema authority cua repo**. Theo quy tac cua du an, `docs/sdd/context/schema_database.yaml` moi la nguon su that cao nhat cho cau truc DB.

Do do:

- co the khang dinh `SPMT00141` se can sua
- nhung chua duoc chot huong sua cu the cho den khi authority cua `TMT026_PRODUCT` duoc thong nhat

## 3. Tom tat phat hien chinh

### 3.1. Xung dot schema

Qua so sanh giua `schema_database.yaml` va file `CREATE_TABLE_TMT026_PRODUCT.sql`, ghi nhan:

- `24` diem khac nhau ve type/nullability
- `2` cot chi co trong file SQL dinh kem: `PACKAGING`, `QUANTITYPERPACKAGE`
- `1` cot chi co trong schema authority: `STRKBN`

Tong cong: `27` diem lech.

Day la blocker lon nhat cua de bai.

### 3.2. SPMT00141 dang phu thuoc cot STRKBN

Code hien tai cua `SPMT00141` van dung `STRKBN` o cac luong:

- register
- update
- get detail
- search

Neu bang moi duoc ap dung dung theo file SQL dinh kem, cac SQL hien tai co nguy co loi runtime do goi cot khong ton tai.

### 3.3. PRODUCTCD dang bi gioi han 10 ky tu

Man hinh va backend validation cua `SPMT00141` hien van gioi han:

- `PRODUCTCD`: max `10`
- `PRODUCTCDHANDMADE`: max `10`

Trong khi schema authority va file SQL dinh kem deu dang de `PRODUCTCD` la `varchar(13)`.

He qua:

- ma hang hop le dai `11` den `13` ky tu se khong di qua duoc UI/validation hien tai

### 3.4. Chua map cac field moi / field doi dang

Code hien tai cua `SPMT00141` chua carry end-to-end cac field dang duoc de bai thay doi hoac bo sung, gom:

- `EXPIRATIONDATEMANAGEMENT`
- `INVENTORYMANAGEMENTPATTERN`
- `INVENTORYUNITCONVERSION`
- `URGENTDEADLINECATEGORY`
- `PACKAGING`
- `QUANTITYPERPACKAGE`

Ngoai ra, logic hien tai van di theo du lieu cu nhu `STANDARDPIECE`.

He qua:

- detail khong doc day du
- request DTO khong mang day du
- register/update khong ghi day du
- frontend khong co field/validation tuong ung

### 3.5. Init master data van la bo cu

Luong init hien tai van nap cac code group cu:

- `3011`
- `3012`
- `3013`
- `3014`

Trong khi package `SPMT00141` dang huong den cac bo ma moi nhu:

- `3062`
- `3063`
- `3064`
- `3087`
- `3096`
- `3097`

Backend init hien tai cung gan nhu de trong, nen chua san sang cho schema moi.

## 4. Danh gia muc do anh huong

### Muc do

`Cao`

### Ly do

- anh huong truc tiep den CRUD chinh cua `SPMT00141`
- anh huong den ca frontend, DTO, process, SQL va validation
- co blocker o tang schema authority
- neu sua dua tren file SQL dinh kem ngay luc nay thi de dan den sua sai huong

## 5. Pham vi du kien phai sua sau khi authority duoc chot

Khi authority cua `TMT026_PRODUCT` duoc thong nhat, du kien phai xu ly it nhat cac nhom sau:

- cap nhat validation do dai `PRODUCTCD`
- cap nhat DTO request/response cua `SPMT00141`
- cap nhat SQL cho register/update/get detail/search
- bo sung field va validation tren frontend
- cap nhat init master data theo code group dung
- xu ly quy tac giu/bo `STRKBN` tuy theo schema chinh thuc

## 6. Blocker hien tai

Blocker can xu ly truoc:

1. Chot authority chinh thuc cua `TMT026_PRODUCT`
2. Lam ro:
   - `STRKBN` con ton tai hay khong
   - `PACKAGING`, `QUANTITYPERPACKAGE` co chinh thuc duoc them hay khong
   - type va do dai chuan cua cac cot moi
3. Sau khi authority duoc cap nhat, moi danh lai pham vi fix code `SPMT00141`

## 7. Khuyen nghi

Khuyen nghi xu ly theo thu tu sau:

1. Xac nhan file nao la schema chinh thuc cho `TMT026_PRODUCT`
2. Neu file SQL dinh kem la dung, cap nhat `schema_database.yaml` truoc
3. Sau do mo task fix `SPMT00141` theo schema da duoc chot
4. Chay review lai toan bo luong:
   - search
   - detail
   - register
   - update
   - copy neu nam trong pham vi

## 8. Tai lieu lien quan

- review chinh thuc: `docs/specs/SPMT00141/12-review-report.md`
- feature package: `docs/specs/SPMT00141/`
- input SQL: `C:/Users/nk_nhat.BRYCENVN/Desktop/CREATE_TABLE_TMT026_PRODUCT.sql`

## 9. Ket luan

`SPMT00141` chac chan bi anh huong boi thay doi bang `TMT026_PRODUCT`, nhung hien tai dang o trang thai:

- **da xac dinh duoc tac dong**
- **chua du dieu kien de sua code an toan**

Buoc tiep theo khong phai la fix ngay trong code, ma la **chot schema authority** truoc.
