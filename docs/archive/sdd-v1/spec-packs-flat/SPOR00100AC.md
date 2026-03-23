# Spec Pack – FPOR0000AC: 発注依頼マスタ作成処理 (Xử Lý Tạo Master Phiếu Yêu Cầu Đặt Hàng)

> **Nguồn sự thật duy nhất** cho change này. Mọi implementation, test, review đều tham chiếu file này.
> Tham chiếu gốc: `_PSY刷新__SPOR00101AC_購買_発注_画面設計書_発注依頼マスタ作成処理.xlsx` (Ver 1, 2026-01-09)
> Ngày tạo Spec Pack: 2026-03-11
> **Cập nhật v2: 2026-03-16** – Bổ sung đáp án BRC về 排他制御 (質問1〜6)
> **Cập nhật v2.1: 2026-03-16** – Resolve OI-006: DB Design TAOR83 đã bổ sung cột ORDERCLASSIFICATION ✅

---

## Changelog

### v2.1 – 2026-03-16
| Mục | Thay đổi | Nguồn |
|---|---|---|
| 5.4.1 Lock Unit | Xóa cảnh báo OI-006 BLOCKER; lock key chính thức gồm đủ 4 trường | DB Design TAOR83 cập nhật |
| 5.4.3 SQL TAOR83 | Bổ sung `ORDERCLASSIFICATION` vào tất cả câu SQL (SELECT / INSERT / DELETE) | DB Design TAOR83 cập nhật |
| 11 Open Issues | OI-006 ✅ Resolved | DB Design TAOR83 cập nhật |
| 12 Risks | Xóa risk "TAOR83 schema thiếu ORDERCLASSIFICATION" | Resolved |
| Quyết định cuối | Nâng lên **✅ CÓ THỂ BẮT ĐẦU NGAY** – không còn BLOCKER | - |
| ⚠️ **IMPL NOTE** | `impl_*_menu_addition.md` và `impl_*_chotatsu_henkou.md`: OI-004 đã resolved – xóa cảnh báo BLOCKER lock, bổ sung `ORDERCLASSIFICATION` vào SQL TAOR83 | DB Design TAOR83 cập nhật |

### v2 – 2026-03-16
| Mục | Thay đổi | Nguồn |
|---|---|---|
| 5.2.6 IV0005 – Lock conflict | Cập nhật: いいえ → **全処理中断 (0 dòng)**; はい → **强制排他 toàn bộ** | 質問2 |
| 5.4 排他制御 (mới) | Bổ sung toàn bộ spec lock: unit, acquisition, release | 質問2〜5 |
| 9 AC-16, AC-17 (mới) | Thêm AC cho lock conflict và force-lock | 質問2〜5 |
| 10 Test cases | Thêm Lock-1 ~ Lock-4 | 質問2〜5 |
| 11 Open Issues | OI-001 ✅; OI-002 ✅; thêm OI-006 BLOCKER TAOR83 | Q01, 質問2〜6 |
| 12 Risks | Xóa risk màn hình ID (resolved); thêm risk lock unit DB mismatch | - |
| ⚠️ **IMPL NOTE** | `impl_*_menu_addition.md` Mục 8.2: Xóa dòng "Giải phóng khi search lại (IV0003)" – không đúng theo 質問5 | 質問5 |

---

## 1. Bối Cảnh / Mục Tiêu

**Chức năng**: 発注依頼マスタ作成処理 – Xử lý tạo Master Phiếu Yêu cầu Đặt hàng

**Mục tiêu**:
- Cho phép người dùng (nhân viên bộ phận bếp hàng không) tạo và cập nhật Master Phiếu Yêu cầu Đặt hàng từ dữ liệu cấu thành nguyên vật liệu sản xuất
- Hỗ trợ 2 chế độ: **メニュー追加** (Thêm menu mới) và **調達品変更** (Cập nhật thay đổi vật tư)
- Người dùng tìm kiếm, lọc danh sách, chọn checkbox và xác nhận để đăng ký/cập nhật vào cơ sở dữ liệu

**Thông tin nhận dạng**:
- **Mã chức năng (機能ID)**: `FPOR0000AC`
- **Mã màn hình (画面ID)**: `SPOR00100AC`
- **Tên chức năng**: 発注依頼マスタ作成処理
- **Nghiệp vụ**: 購買・発注 (Mua sắm / Đặt hàng)
- **Tác giả**: BRC 田代 / BRC増子
- **Phiên bản tài liệu**: Ver 1 (2026-01-09)

---

## 2. Phạm Vi (Scope)

### Trong phạm vi (In Scope)
- Màn hình `SPOR00100AC`: Tìm kiếm, hiển thị danh sách và xác nhận đăng ký
- Chế độ **メニュー追加**: Thêm mới các menu (レシピ) vào 発注依頼マスタ
- Chế độ **調達品変更**: Hiển thị danh sách vật tư có sự thay đổi (追加/変更/削除) và cập nhật vào 発注依頼マスタ
- Modal tìm kiếm Section (セクション検索) và Group (グループ検索)
- Backend: Tất cả xử lý SELECT, INSERT, UPDATE liên quan đến 発注依頼マスタ
- Frontend: Component cho màn hình `SPOR00100AC`

### Ngoài phạm vi (Out of Scope)
- Màn hình tạo 配合構成 (Recipe) – chỉ *sử dụng* dữ liệu từ bảng 配合構成ヘッダ
- Màn hình quản lý 生産指示 (Production Instructions) – chỉ *đọc* dữ liệu từ 生産用材料構成
- Import/Export CSV
- Phân quyền chi tiết theo role

---

## 3. Bảng Thuật Ngữ (Glossary)

| Thuật ngữ (JP) | Thuật ngữ (VN) | Giải thích |
|---|---|---|
| 発注依頼マスタ | Master Phiếu YC Đặt hàng | Bảng master lưu thông tin yêu cầu đặt hàng nguyên vật liệu |
| 照会区分 | Loại tra cứu | Radio button chọn chế độ: メニュー追加 hoặc 調達品変更 |
| メニュー追加 | Thêm menu | Chế độ thêm mới các cặp (レシピ × 調達品) vào master |
| 調達品変更 | Thay đổi vật tư | Chế độ hiển thị vật tư có diff (追加/変更/削除) để cập nhật master |
| セクション | Section | Đơn vị tổ chức theo bộ phận chế biến trong nhà bếp |
| グループ | Group | Nhóm con trong Section |
| エアライン | Hãng hàng không | Thông tin khách hàng từ bảng メニュー企画 |
| レシピ | Công thức (Recipe) | Từ bảng 配合構成ヘッダ |
| 調達品 | Vật tư / Nguyên liệu | Nguyên liệu được đặt hàng |
| 発注分類 | Phân loại đặt hàng | Lấy từ 名称マスタ (レコード区分=3034) |
| 生産用材料構成 | Cấu thành nguyên liệu SX | Bảng `TAOR57_PRODUCTIONMATERIALCOMPOSITION` |
| 発注依頼マスタ作成済生産用材料構成 | Cấu thành NL đã tạo master | Bảng lưu trạng thái đã tạo 発注依頼マスタ (= TAOR69) |
| ステータス | Trạng thái diff | 追加 (Thêm mới) / 変更 (Thay đổi) / 削除 (Đã xóa) |
| 最終更新日時 | Ngày giờ cập nhật cuối | Dùng để kiểm soát concurrency |
| 排他制御 | Exclusive lock | Kiểm soát đồng thời khi 確定; dùng TAOR83_TABLELOCK |

---

## 4. Hiện Trạng / Trạng Thái Mới (As-Is / To-Be)

### As-Is (Hiện tại)
- Hệ thống PSY đang được refresh (PSY刷新)
- Chức năng `FPOR0000AC` là tính năng được triển khai trong đợt refresh này
- Các bảng nguồn (`TAOR57_PRODUCTIONMATERIALCOMPOSITION`, `配合構成ヘッダ`, `メニュー企画`) đã tồn tại

### To-Be (Sau thay đổi)
- Màn hình `SPOR00100AC` hoạt động đầy đủ với 2 chế độ: メニュー追加 và 調達品変更
- Backend xử lý SELECT dữ liệu từ nhiều bảng JOIN, INSERT/UPDATE vào 発注依頼マスタ
- Hỗ trợ tìm kiếm theo 工場・セクション・グループ・発注分類 và hiển thị kết quả dạng danh sách có checkbox

---

## 5. Chi Tiết Spec

### 5.1 Màn Hình / UI (SPOR00100AC)

#### 5.1.1 Cấu Trúc Màn Hình

```
┌──────────────────────────────────────────────────────────────┐
│  発注依頼マスタ作成処理                                          │
├──────────────────────────────────────────────────────────────┤
│ 【検索条件】                                                   │
│ 照会区分: (●) メニュー追加  ( ) 調達品変更                       │
│                                                              │
│ 拠点: [ドロップダウン ▼]  (必須)                               │
│ セクションコード: [________] [🔍]  セクション名: ___________    │
│ グループコード:   [________] [🔍]  グループ名:   ___________    │
│ 発注分類:        [ドロップダウン ▼]                             │
│                                                              │
│ 最終更新者: _______________  最終更新日時: ____/___/___ __:__:_ │
│                                                              │
│ [表示]  [クリア]                                              │
├──────────────────────────────────────────────────────────────┤
│ 【検索結果】                                                   │
│ 件数: XX件                                                    │
│                                                              │
│ ┌──┬────┬──────────┬──────────┬──────────┬──────────┬──────┐ │
│ │☑ │No. │セクション│グループ  │エアライン│レシピ名  │調達品│ │
│ │  │    │コード/名 │コード/名 │          │          │  数  │ │
│ └──┴────┴──────────┴──────────┴──────────┴──────────┴──────┘ │
│ [□ 全チェック]                                                │
│                                                              │
│                                           [確定]             │
└──────────────────────────────────────────────────────────────┘
```

> **Chú ý**: Cột danh sách thay đổi theo chế độ:
> - **メニュー追加**: Hiển thị No./チェック/セクション/グループ/エアライン/レシピ名/調達品数
> - **調達品変更**: Thêm cột **ステータス** (追加/変更/削除) và **調達品名**, **発注分類**, **提供期間(FROM/TO)**

> **Lưu ý thuật ngữ**: Trên UI và spec từ nay thống nhất dùng **「拠点」** (không dùng「工場」).
> `工場` là thuật ngữ cũ từ hệ thống Ribbon; cả hai đều map vào `STORECD` trong DB. (Q10)

#### 5.1.2 Điều Kiện Hiển Thị / Active

| Trường / Thành phần | Chế độ メニュー追加 | Chế độ 調達品変更 |
|---|---|---|
| セクションコード (input) | **Vô hiệu hóa** (non-active) | Nhập được |
| セクション検索ボタン (🔍) | **Vô hiệu hóa** | Kích hoạt |
| グループコード (input) | **Vô hiệu hóa** | Nhập được |
| グループ検索ボタン (🔍) | **Vô hiệu hóa** | Kích hoạt |
| 発注分類 (dropdown) | **Vô hiệu hóa** | Nhập được (tùy chọn) |
| Cột ステータス trong danh sách | Không hiển thị | **Hiển thị** |
| Cột 調達品名 / 発注分類 / 提供期間 | Không hiển thị | **Hiển thị** |

#### 5.1.3 Danh Sách Cột Theo Chế Độ

**Chế độ メニュー追加**:

| Cột | Nguồn dữ liệu | Ghi chú |
|---|---|---|
| No. | SEQ | Số thứ tự trong danh sách |
| チェック | - | Checkbox chọn dòng |
| セクションコード | `生産用材料構成.HT_SECTION_CD` | - |
| セクション名 | `セクションマスタ.セクション名` | JOIN theo 拠点コード + セクションコード |
| グループコード | `生産用材料構成.HT_GROUP_CD` | - |
| グループ名 | `グループマスタ.グループコード名` | JOIN theo 拠点コード + セクションコード + グループコード |
| エアライン | `メニュー企画` | 得意先コード + '/' + メニュー企画分類 + ':' + メニュー企画分類名称 + '/' + 内際区分 + ':' + 内際区分名称 |
| レシピ名 | `配合構成ヘッダ.レシピ名` | - |
| 調達品数 | `生産用材料構成` | COUNT per セクション×グループ×エアライン×レシピ×調達品 |

**Chế độ 調達品変更** (thêm vào so với メニュー追加):

| Cột | Nguồn dữ liệu | Ghi chú |
|---|---|---|
| ステータス | Logic so sánh | `追加` / `変更` / `削除` (xem 5.2.4) |
| 調達品名 | `生産用材料構成.CHOTATSU_NM` | - |
| 発注分類 | `基本商品マスタ (TMT026_PRODUCT)` | STOCKKBN=0→日配品; STOCKKBN=1→問屋品. UI hiển thị **label** |
| 提供期間 FROM | `TAOR56_MENUPLANNING.MENU_PLAN_DT_FROM` | `MIN` trong cùng SORTキー (Q28) |
| 提供期間 TO | `TAOR56_MENUPLANNING.MENU_PLAN_DT_TO` | `MAX` trong cùng SORTキー (Q28) |

---

### 5.2 Luồng Xử Lý

#### 5.2.1 Khởi Động Màn Hình (初期表示)

1. Khởi tạo toàn bộ vùng 検索条件 và 検索結果 về trạng thái ban đầu
2. Lấy dữ liệu khởi tạo:
   - **2-1.** Lấy danh sách 拠点 từ `TMT003_STORE`, mặc định chọn 拠点 của user đăng nhập (`MAINSTORECD`)
   - **2-2.** Lấy danh sách 発注分類 từ `TMT050_NAME` (RCDKBN=3034)
   - **2-3.** Lấy 最終更新者 và 最終更新日時 từ `TAOR65_ORDERREQUESTMASTER` (bản ghi có `UPDDATETIME` lớn nhất theo 拠点コード; JOIN `TMT002_USER` ON `USRCD = UPDUSRCD`) (Q26)

#### 5.2.2 Event IV0001 – セクション検索ボタン押下 (Modal)

1. Chuyển đến màn hình modal **セクション検索** (chỉ active ở chế độ 調達品変更)
2. Giá trị trả về từ modal: 拠点コード, 拠点名, セクションコード, セクション名 → điền vào trường tương ứng

#### 5.2.3 Event IV0002 – グループ検索ボタン押下 (Modal)

1. Chuyển đến màn hình modal **グループ検索** (chỉ active ở chế độ 調達品変更)
2. Giá trị trả về từ modal: 拠点コード, 拠点名, セクションコード, セクション名, グループコード, グループ名 → điền vào trường tương ứng

#### 5.2.4 Event IV0003 – 表示ボタン押下 (Tìm kiếm & Hiển thị)

1. **Validation bắt buộc theo mode** (Q06):

   | Trường | メニュー追加 | 調達品変更 |
   |---|---|---|
   | 拠点 | ✅ ME000116 nếu trống | ✅ ME000116 nếu trống |
   | セクション | ❌ Disabled – không validate | ✅ ME000116 nếu trống |
   | グループ | ❌ Disabled – không validate | ✅ ME000116 nếu trống |
   | 発注分類 | ❌ Disabled – không validate | ⬜ Tùy chọn – không validate |

2. **Lấy dữ liệu** theo điều kiện đã nhập:
   - JOIN `TAOR57` + `TAOR69` + `TAOR56` + `TAOR55` (và các bảng master)
   - Lọc theo khoảng thời gian: `判定開始日 = CURRENT_DATE - N` (N từ `TMT050_NAME` RCDKBN=3059)
   - Chế độ メニュー追加: chỉ lấy dòng `AH.CHOTATSU_CD IS NULL`
   - Chế độ 調達品変更: lấy tất cả, tính ステータス sau query

3. **Hiển thị kết quả**, kèm tổng số 件数

4. Nếu không có dữ liệu: dialog **MI000001** "該当データが存在しません。" (không giữ grid cũ) (Q08)

> **Logic ステータス cho 調達品変更** (tính sau query ở backend, không trong SQL):
> - `AH.CHOTATSU_CD IS NULL` → **追加**
> - `AH.DEL_FLG = '1'` → **削除** (màu đỏ trên grid)
> - Còn lại → **変更**

#### 5.2.5 Event IV0004 – クリアボタン押下 (Reset)

1. Thực hiện lại toàn bộ xử lý như 初期表示

> **Khi đổi 照会区分** (Q03 – resolved một phần):
> - Grid xóa sạch, 件数 reset về 0件, 確定 về disabled
> - ⚠️ **Còn mở (OI-003)**: các trường điều kiện (セクション/グループ/発注分類) có bị clear giá trị hay không – chưa xác nhận

#### 5.2.6 Event IV0005 – 確定ボタン押下 (Xác nhận & Lưu)

```
[1] Validate checkbox
    └─ Không có dòng nào được check
       → ME000070 "追加対象が1件も選択されていません。"
       → Dừng

[2] Kiểm tra lock (TAOR83_TABLELOCK) – theo từng unit 拠点+セクション+グループ+発注分類
    ├─ Có user khác đang lock ≥ 1 unit
    │   → Dialog MQA00024
    │         "他のユーザーが発注依頼マスタ作成画面または、
    │          発注依頼マスタ画面を使用中です。"
    │         [はい] → Toàn bộ dòng: DELETE lock cũ → INSERT lock mới
    │                  → Xử lý TẤT CẢ dòng được check (bao gồm cả dòng conflict)
    │         [いいえ] → 全処理中断（0 dòng được update）
    │                   → Disable 確定, hiện tên user đang lock → Dừng
    └─ Không có ai lock → INSERT lock mới cho từng unit → [3]

[3] Dialog xác nhận
    MQ000004 "確定します。よろしいですか？"
    ├─ [いいえ] → Dừng (lock giữ nguyên cho đến khi rời màn hình)
    └─ [はい] → [4]

[4] Ghi dữ liệu theo ステータス (xem mục 8)
    └─ Tất cả INSERT/UPDATE/DELETE trong một transaction; rollback nếu fail

[5] Kết quả
    → MI000002 "確定しました。"
    → Chạy lại IV0003 với cùng điều kiện tìm kiếm
    → Grid refresh, checkbox reset toàn bộ
    (Lock KHÔNG giải phóng ở đây – chỉ giải phóng khi rời màn hình)
```

> ⚠️ **Thay đổi quan trọng so với v1**: Khi lock conflict + いいえ → **0 dòng được xử lý** (全処理中断),
> không phải "chỉ dừng dòng conflict". (質問2)

---

### 5.3 Validation (Kiểm Tra Đầu Vào)

| # | Trigger | Đối tượng | Điều kiện lỗi | Code | Nội dung |
|---|---|---|---|---|---|
| 1 | IV0003 | 拠点 | Trống | `ME000116` | 入力必須です。入力して下さい。 |
| 2 | IV0003 (調達品変更 only) | セクション | Trống | `ME000116` | 入力必須です。入力して下さい。 |
| 3 | IV0003 (調達品変更 only) | グループ | Trống | `ME000116` | 入力必須です。入力して下さい。 |
| 4 | IV0003 | Kết quả | Không có dữ liệu | `MI000001` | 該当データが存在しません。 |
| 5 | IV0005 | Checkbox | Không có dòng nào check | `ME000070` (%1=追加対象) | %1が1件も選択されていません。 |
| 6 | IV0005 | Lock | User khác đang lock | `MQA00024` | (xem 5.4) |
| 7 | IV0005 | Xác nhận | - | `MQ000004` | 確定します。よろしいですか？ |
| 8 | IV0005 | Kết quả | Thành công | `MI000002` | 確定しました。 |

---

### 5.4 排他制御 (Exclusive Lock) ★ MỚI v2

> **Căn cứ**: BRC 質問2〜5 (2026-03-16); DB Design TAOR83 cập nhật (2026-03-16)

#### 5.4.1 Lock Unit

Lock được tạo và kiểm tra theo đơn vị:

```
CMPNYCD + STORECD (拠点コード) + SECTIONCD + GROUPCD + ORDERCLASSIFICATION (発注分類)
```

> ✅ **OI-006 RESOLVED**: DB Design `TAOR83_TABLELOCK` đã bổ sung cột `ORDERCLASSIFICATION`.
> Lock key chính thức gồm đủ 5 trường trên. Có thể implement đầy đủ.

Khi người dùng check và 確定 nhiều dòng thuộc các unit khác nhau:
→ **Tạo nhiều lock riêng biệt**, 1 lock per unit (質問3)

#### 5.4.2 Thời Điểm Lock

| Hành động | Lock |
|---|---|
| 確定 → [2] kiểm tra | Kiểm tra từng unit của các dòng được check |
| 確定 → không có conflict | INSERT lock cho từng unit |
| 確定 → có conflict → はい | DELETE lock cũ → INSERT lock mới cho toàn bộ unit |
| 確定 → có conflict → いいえ | Không làm gì với lock; 全処理中断 |
| Rời màn hình (destroy/unmount) | **DELETE toàn bộ lock của user này từ màn hình này** |

> ⚠️ **Lock KHÔNG giải phóng khi search lại (IV0003)**. Chỉ giải phóng khi rời màn hình. (質問5)
> Đây là thay đổi so với thiết kế trước – cần cập nhật impl docs.

#### 5.4.3 SQL Thao Tác TAOR83

```sql
-- Kiểm tra lock theo unit (5-key PK)
SELECT ENTUSRCD, ENTUSRNM
FROM TAOR83_TABLELOCK
WHERE CMPNYCD=:c AND STORECD=:s AND SECTIONCD=:sec AND GROUPCD=:g
  AND ORDERCLASSIFICATION=:orderclassification
;

-- Lấy lock (INSERT mới)
INSERT INTO TAOR83_TABLELOCK (
    CMPNYCD, STORECD, SECTIONCD, GROUPCD,
    ORDERCLASSIFICATION,
    ENTUSRCD, ENTUSRNM, ENTDATETIME, ENTPRG, ENTSCREENNM
) VALUES (
    :c, :s, :sec, :g,
    :orderclassification,
    :USRCD, :USRNM, SYSDATE(6), 'FPOR0000AC', '発注依頼マスタ作成処理'
);

-- Force-lock: xóa lock cũ của user khác (user chọn はい)
DELETE FROM TAOR83_TABLELOCK
WHERE CMPNYCD=:c AND STORECD=:s AND SECTIONCD=:sec AND GROUPCD=:g
  AND ORDERCLASSIFICATION=:orderclassification
  AND ENTUSRCD != :current_user;

-- Giải phóng khi rời màn hình (Angular fnDestroy / IV0006)
-- ⚠️ KHÔNG giải phóng khi search lại IV0003
DELETE FROM TAOR83_TABLELOCK
WHERE ENTUSRCD=:current_user AND ENTPRG='FPOR0000AC';
```

> **Lưu ý mapping `:orderclassification`**:
> Lấy từ `TMT026_PRODUCT.STOCKKBN` của từng 調達品 đang được check.
> `STOCKKBN='0'` → `ORDERCLASSIFICATION='1'` (日配品);
> `STOCKKBN='1'` → `ORDERCLASSIFICATION='2'` (問屋品)

---

## 6. Luồng Dữ Liệu (Data Flow)

### 6.1 Các Bảng DB Liên Quan

| Bảng | Tên (JP) | Quyền | Ghi chú |
|---|---|---|---|
| `TAOR57_PRODUCTIONMATERIALCOMPOSITION` | 生産用材料構成 | SELECT | Nguồn dữ liệu chính |
| `TAOR69_PRODUCTIONMATERIALCOMPOSITION` | 発注依頼マスタ作成済生産用材料構成 | SELECT | So sánh diff |
| `TAOR65_ORDERREQUESTMASTER` | 発注依頼マスタ | SELECT / INSERT / UPDATE | Bảng đích |
| `TAOR55_COMBINATIONHEADER` | 配合構成ヘッダ | SELECT | Lấy レシピ名, 期間フィルタ |
| `TAOR56_MENUPLANNING` | メニュー企画 | SELECT | Lấy エアライン, 提供期間FROM/TO |
| `TAOR83_TABLELOCK` | テーブルロック | SELECT / INSERT / DELETE | 排他制御 |
| `TMT003_STORE` | 店舗マスタ | SELECT | Dropdown 拠点 |
| `TAMT030_SECTION` | セクションマスタ | SELECT | Lọc 拠点, tên セクション |
| `TAMT029_GROUP` | グループマスタ | SELECT | Tên グループ |
| `TAMT026_PRODUCTAGREEMENT` | 調達品協定マスタ | SELECT | DELIVERIES, PARTNERCD khi INSERT |
| `TMT026_PRODUCT` | 基本商品マスタ | SELECT | STOCKKBN → 発注分類 label |
| `TMT002_USER` | ユーザーマスタ | SELECT | Tên user cho 最終更新者 |
| `TMT050_NAME` | 名称マスタ | SELECT | 発注分類 (3034), 判定開始日N (3059) |

### 6.2 Quy Tắc Lọc Khoảng Thời Gian Hiển Thị

```
判定開始日 = CURRENT_DATE - N
N = TMT050_NAME.DATANM WHERE RCDKBN = '3059'

Điều kiện lọc:
(HAIGO_KOSEI_ST_YMD >= 判定開始日 AND HAIGO_KOSEI_ST_YMD <= CURRENT_DATE)
OR
(HAIGO_KOSEI_ED_YMD >= 判定開始日 AND HAIGO_KOSEI_ED_YMD <= CURRENT_DATE)
```

### 6.3 Đơn Vị Xử Lý Khi 確定

**Mode メニュー追加** (質問1 – confirmed):
- 1 dòng grid = 1 nhóm セクション×グループ×エアライン×レシピ
- Khi 確定 1 dòng → xử lý **toàn bộ 調達品 thuộc nhóm đó** (= 調達品数 nguyên liệu)
- Số bản ghi INSERT = 調達品数 × DELIVERIES per 調達品

**Mode 調達品変更**:
- 1 dòng grid = 1 調達品 cụ thể
- Khi 確定 → xử lý đúng 1 調達品 đó theo ステータス (INSERT / UPDATE / logical DELETE)

---

## 7. Màn Hình Modal

### 7.1 セクション検索 (Modal)
- Trigger: Nhấn 🔍 tại セクションコード (chỉ active khi 照会区分 = 調達品変更)
- Trả về: 拠点コード, 拠点名, セクションコード, セクション名

### 7.2 グループ検索 (Modal)
- Trigger: Nhấn 🔍 tại グループコード (chỉ active khi 照会区分 = 調達品変更)
- Trả về: 拠点コード, 拠点名, セクションコード, セクション名, グループコード, グループ名

---

## 8. Xử Lý DB (処理詳細)

### 8.1 SELECT – メニュー追加 (IV0003)

```sql
SELECT
    SECTION.STORECD,
    A.HT_SECTION_CD  AS SECTIONCD,  SECTION.SECTIONNM,
    A.HT_GROUP_CD    AS GROUPCD,    GRP.GROUPNM,
    B.CUSTOMER_CD, B.MENU_PLAN_CLS, B.MENU_PLAN_CLS_NM,
    B.DI_CLS, B.DI_CLS_NM,
    A.CHOTATSU_CD, A.CHOTATSU_NM, A.CHOTATSU_KOJO_CD,
    C.HAIGO_KOSEI_ST_YMD, C.HAIGO_KOSEI_ED_YMD,
    C.RECIPE_NM, C.DISH_CD
FROM TAOR57_PRODUCTIONMATERIALCOMPOSITION A
LEFT JOIN TAOR69_PRODUCTIONMATERIALCOMPOSITION AH
    ON  A.SH_KOJO_CD=AH.SH_KOJO_CD AND A.SEIHIN_CD=AH.SEIHIN_CD
    AND A.MENU_KIKAKU_CD=AH.MENU_KIKAKU_CD
    AND A.KOTEI_TEKIYO_ST_YMD=AH.KOTEI_TEKIYO_ST_YMD
    AND A.H_KOSEI_LINE_SEQ_NO=AH.H_KOSEI_LINE_SEQ_NO
LEFT JOIN TAMT030_SECTION SECTION
    ON  A.HT_SECTION_CD=SECTION.SECTIONCD AND SECTION.CMPNYCD=:会社コード AND SECTION.DELFLG='0'
LEFT JOIN TAMT029_GROUP GRP
    ON  A.HT_GROUP_CD=GRP.GROUPCD AND GRP.CMPNYCD=:会社コード
LEFT JOIN TAOR56_MENUPLANNING B ON A.MENU_KIKAKU_CD=B.MENU_PLAN_CD
LEFT JOIN TAOR55_COMBINATIONHEADER C
    ON  A.MENU_KIKAKU_CD=C.MENU_KIKAKU_CD AND A.SEIHIN_CD=C.SEIHIN_CD
WHERE
    SECTION.STORECD = :拠点コード    -- ⚠️ KHÔNG dùng A.SH_KOJO_CD
    AND A.DEL_FLG != '1'
    AND (
        (C.HAIGO_KOSEI_ST_YMD >= :判定開始日 AND C.HAIGO_KOSEI_ST_YMD <= CURRENT_DATE)
        OR (C.HAIGO_KOSEI_ED_YMD >= :判定開始日 AND C.HAIGO_KOSEI_ED_YMD <= CURRENT_DATE)
    )
    AND AH.CHOTATSU_CD IS NULL   -- chỉ lấy chưa có trong TAOR69
ORDER BY A.MENU_KIKAKU_CD, SECTION.STORECD, A.HT_SECTION_CD, A.HT_GROUP_CD, A.CHOTATSU_CD
```

Xử lý sau query: bỏ HAIGO_KOSEI fields khỏi result → deduplicate → JOIN lại TAOR55 lấy metadata → tính 調達品数 per nhóm.

### 8.2 SELECT – 調達品変更 (IV0003)

Tương tự 8.1 nhưng:
- Không filter `AH.CHOTATSU_CD IS NULL` – lấy tất cả
- Thêm SELECT `AH.CHOTATSU_CD AS AH_CHOTATSU_CD`, `AH.DEL_FLG AS AH_DEL_FLG`
- Thêm JOIN `TMT026_PRODUCT` để lấy `STOCKKBN`
- Thêm điều kiện `AND A.HT_SECTION_CD=:セクションコード AND A.HT_GROUP_CD=:グループコード`
- Thêm `[AND PRODUCT.STOCKKBN=:mapped_stockkbn]` nếu 発注分類 được chọn
- GROUP BY để tính `MIN(B.MENU_PLAN_DT_FROM)` và `MAX(B.MENU_PLAN_DT_TO)` theo SORTキー

### 8.3 INSERT – メニュー追加 (確定)

**Bước A**: Tra cứu TAMT026 lấy DELIVERIES và PARTNERCD

```sql
SELECT DELIVERIES, PARTNERCD
FROM TAMT026_PRODUCTAGREEMENT
WHERE STORECD=:CHOTATSU_KOJO_CD  -- ⚠️ KHÔNG phải 拠点コード
  AND PRODUCTCD=:CHOTATSU_CD
  AND STARTDATE<=CURRENT_DATE AND ENDDATE>=CURRENT_DATE
  AND CMPNYCD=:会社コード AND DELFLG='0'
```

**Bước B**: INSERT vào TAOR65 – số lần = DELIVERIES (1/2/3 bản ghi per 調達品)

```sql
INSERT INTO TAOR65_ORDERREQUESTMASTER (
    STORECD, SECTIONCD, GROUPCD, CMPNYCD, PRODUCTCD,
    DELIVERYKBN,            -- '01' / '02' / '03' theo DELIVERIES
    DELETIONJUDGMENT,       -- '1' (cố định)
    HAIGO_KOSEI_ST_YMD, HAIGO_KOSEI_ED_YMD,
    PARTNERCD,
    ORDERCLASSIFICATION,    -- STOCKKBN '0'→'1'(日配品); '1'→'2'(問屋品)
    ORDERCLASSIFICATIONINPUT,
    DELETE_FLG,             -- '0'
    ENTUSRCD, ENTDATETIME, ENTPRG,
    UPDUSRCD, UPDDATETIME, UPDPRG
) VALUES (
    :拠点コード, :SECTIONCD, :GROUPCD, :会社コード, :CHOTATSU_CD,
    :DELIVERYKBN, '1',
    :HAIGO_KOSEI_ST_YMD, :HAIGO_KOSEI_ED_YMD,
    :PARTNERCD, :ORDERCLASSIFICATION, :ORDERCLASSIFICATIONINPUT,
    '0',
    :USRCD, SYSDATE(6), 'FPOR0000AC',
    :USRCD, SYSDATE(6), 'FPOR0000AC'
)
```

> **Case đặc biệt – HAIGO_KOSEI_ST_YMD thay đổi**:
> Physical DELETE bản ghi cũ trước khi INSERT mới (xem impl_menu_addition.md mục 7.1)

### 8.4 INSERT / UPDATE / Logical DELETE – 調達品変更 (確定)

| ステータス | SQL | Ghi chú |
|---|---|---|
| **追加** | INSERT như 8.3 | Giống hệt mode メニュー追加 |
| **変更** | UPDATE TAOR65 | Chỉ update các trường thay đổi; **không update ORDERCLASSIFICATIONINPUT** (Q27) |
| **削除** | UPDATE `DELETE_FLG='1'` | Logical delete; KHÔNG physical delete. Tên cột là `DELETE_FLG` (khác `DEL_FLG`) |

```sql
-- 変更:
UPDATE TAOR65_ORDERREQUESTMASTER
SET HAIGO_KOSEI_ED_YMD=:new, PARTNERCD=:new, ORDERCLASSIFICATION=:new,
    UPDUSRCD=:USRCD, UPDDATETIME=SYSDATE(6), UPDPRG='FPOR0000AC'
WHERE STORECD=:s AND SECTIONCD=:sec AND GROUPCD=:g AND CMPNYCD=:c
  AND PRODUCTCD=:CHOTATSU_CD AND DELIVERYKBN=:kbn
  AND DELETIONJUDGMENT=:dj AND HAIGO_KOSEI_ST_YMD=:st;

-- 削除 (logical delete):
UPDATE TAOR65_ORDERREQUESTMASTER
SET DELETE_FLG='1', UPDUSRCD=:USRCD, UPDDATETIME=SYSDATE(6), UPDPRG='FPOR0000AC'
WHERE STORECD=:s AND SECTIONCD=:sec AND GROUPCD=:g AND CMPNYCD=:c
  AND PRODUCTCD=:CHOTATSU_CD AND DELETE_FLG='0';
```

> ⚠️ Toàn bộ INSERT/UPDATE/DELETE phải trong **một transaction**. Rollback nếu bất kỳ thao tác nào fail.

---

## 9. AC – Acceptance Criteria (Tiêu Chí Chấp Nhận)

### AC-FPOR0000AC-1-v1: Khởi Động Màn Hình
- Dropdown 拠点 hiển thị từ TMT003_STORE, mặc định = 拠点 của user đăng nhập
- Dropdown 発注分類 lấy từ TMT050_NAME (RCDKBN=3034)
- 最終更新者 / 最終更新日時 lấy từ TAOR65 (UPDDATETIME lớn nhất theo 拠点コード) + JOIN TMT002_USER

### AC-FPOR0000AC-2-v1: Trạng Thái Theo Chế Độ
- メニュー追加: セクション/グループ/発注分類 input + nút 🔍 bị **vô hiệu hóa**
- 調達品変更: tất cả được **kích hoạt**
- Đổi 照会区分: grid xóa sạch, 件数 = 0件, 確定 disabled

### AC-FPOR0000AC-3-v1: Modal セクション検索
- Nhấn 🔍 (chế độ 調達品変更): modal mở → chọn → điền セクションコード/セクション名

### AC-FPOR0000AC-4-v1: Modal グループ検索
- Nhấn 🔍 (chế độ 調達品変更): modal mở → chọn → điền cả セクション và グループ fields

### AC-FPOR0000AC-5-v1: Validation Bắt Buộc Theo Mode
- メニュー追加: 拠点 trống → ME000116
- 調達品変更: 拠点/セクション/グループ bất kỳ trống → ME000116

### AC-FPOR0000AC-6-v1: Hiển Thị Kết Quả メニュー追加
- Grid hiển thị cột: No./チェック/セクション/グループ/エアライン/レシピ名/調達品数
- Sort: セクションコード → グループコード → エアライン → レシピ名

### AC-FPOR0000AC-7-v1: Hiển Thị Kết Quả 調達品変更
- Grid thêm cột: ステータス/調達品名/発注分類(label)/提供期間FROM/TO
- 削除 status hiển thị màu đỏ
- Logic ステータス: IS NULL=追加, DEL_FLG=1→削除, else→変更

### AC-FPOR0000AC-8-v1: Không Tìm Thấy Dữ Liệu
- Dialog MI000001 "該当データが存在しません。" – không giữ grid cũ

### AC-FPOR0000AC-9-v1: 全チェック
- Nhấn 全チェック: tất cả dòng được check; nhấn lại: uncheck hết
- Áp dụng cho **toàn bộ** danh sách (không có pagination)

### AC-FPOR0000AC-10-v1: Validation Checkbox
- Nhấn 確定 không check dòng nào → ME000070 "追加対象が1件も選択されていません。"

### AC-FPOR0000AC-11-v1: Confirm メニュー追加 – Happy Path
- Check ≥1 dòng → 確定 → MQ000004 → はい
- INSERT TAOR65: số bản ghi = 調達品数 × DELIVERIES per 調達品
- MI000002, grid refresh, checkbox reset

### AC-FPOR0000AC-12-v1: Confirm 調達品変更 – Happy Path
- Check ≥1 dòng → 確定 → MQ000004 → はい
- INSERT / UPDATE / logical DELETE đúng theo ステータス
- MI000002, grid refresh, checkbox reset

### AC-FPOR0000AC-13-v1: Nút クリア
- Nhấn クリア → reset như 初期表示

### AC-FPOR0000AC-14-v1: Tính 調達品数
- 調達品数 = COUNT CHOTATSU_CD khác nhau trong cùng nhóm セクション×グループ×エアライン×レシピ

### AC-FPOR0000AC-15-v1: 最終更新情報
- 最終更新者: USRNM từ TMT002_USER join với UPDUSRCD có UPDDATETIME lớn nhất (theo 拠点)
- 最終更新日時: UPDDATETIME lớn nhất trong TAOR65 theo 拠点コード

### AC-FPOR0000AC-16-v2: Lock Conflict → いいえ ★ MỚI
- Nhấn 確定 → phát hiện user khác đang lock → MQA00024 → **いいえ**
- **Không có dòng nào được INSERT/UPDATE/DELETE** (全処理中断)
- Nút 確定 bị disable; hiển thị tên user đang lock

### AC-FPOR0000AC-17-v2: Lock Conflict → はい (Force-Lock) ★ MỚI
- Nhấn 確定 → phát hiện user khác đang lock → MQA00024 → **はい**
- Hệ thống DELETE lock cũ → INSERT lock mới cho **toàn bộ unit** bị conflict
- Tiếp tục xử lý **tất cả dòng** được check (bao gồm cả dòng đã conflict)
- Sau khi ghi xong: MI000002, grid refresh

### AC-FPOR0000AC-18-v2: Lock Release ★ MỚI
- Lock chỉ được giải phóng khi user **rời khỏi màn hình** (Angular destroy/unmount)
- Search lại (IV0003) **KHÔNG giải phóng** lock

---

## 10. Ví Dụ Test Cases (Tham Khảo Nhanh)

| Loại | Input | Kết Quả Mong Đợi |
|---|---|---|
| Normal-1 | 拠点, mode メニュー追加, 表示 | Grid hiển thị: No/チェック/セクション/グループ/エアライン/レシピ/調達品数 |
| Normal-2 | 拠点+セクション+グループ, mode 調達品変更, 表示 | Grid thêm ステータス/調達品名/発注分類(label)/提供期間 |
| Normal-3 | Check 1 dòng (調達品数=3, DELIVERIES=2) → 確定 → はい | INSERT 6 bản ghi TAOR65, MI000002, refresh |
| Normal-4 | ステータス=削除 dòng → 確定 → はい | UPDATE DELETE_FLG='1', KHÔNG physical delete |
| Error-1 | メニュー追加: 拠点 trống → 表示 | ME000116 |
| Error-2 | 調達品変更: セクション trống → 表示 | ME000116 |
| Error-3 | Không check dòng → 確定 | ME000070 |
| Info-1 | Điều kiện không có dữ liệu → 表示 | MI000001, grid trắng |
| Confirm-1 | 確定 → MQ000004 → いいえ | Dialog đóng, không có thay đổi |
| **Lock-1** | 確定 → lock conflict → **いいえ** | **0 dòng** được xử lý; 確定 disabled; hiện tên user |
| **Lock-2** | 確定 → lock conflict → **はい** | Force-lock toàn bộ unit; **TẤT CẢ** dòng được xử lý; MI000002 |
| **Lock-3** | Search lại (IV0003) trong khi đang giữ lock | Lock **KHÔNG** bị giải phóng |
| **Lock-4** | Rời màn hình (navigate away) | Lock **ĐƯỢC** giải phóng (DELETE TAOR83) |
| Mode-1 | Chọn メニュー追加 | セクション/グループ/発注分類 + 🔍 bị disable |
| Mode-2 | Đổi 照会区分 | Grid xóa, 件数=0件, 確定 disabled |
| Sort-1 | Click header ▲▼ sau khi check 3 dòng | Dữ liệu sort client-side, **checkbox state giữ nguyên** |
| Data-1 | エアライン format | "ANA/001:フライトケータリング/2:国際" |
| Bound-1 | 調達品数=3 trong cùng nhóm | Hiển thị "3" |

---

## 11. Open Issues (Chưa Giải Quyết)

| # | Câu hỏi | Trạng thái | Quyết định / Nguồn |
|---|---|---|---|
| ~~OI-001~~ | ~~Mã màn hình SPOR00101AC vs SPOR00100AC~~ | ✅ **Resolved** | SPOR00100AC là chính thức. (Q01) |
| ~~OI-002~~ | ~~Logic exclusive control: có cần kiểm soát concurrency không?~~ | ✅ **Resolved** | Cần; spec đầy đủ tại mục 5.4. (質問2〜5) |
| OI-003 | Khi đổi 照会区分: các trường セクション/グループ/発注分類 có bị clear giá trị không? | ⏳ Chờ xác nhận | - |
| OI-004 | Giới hạn số bản ghi tối đa trong danh sách kết quả | ⏳ Chờ xác nhận | - |
| OI-005 | Quyền `閲覧のみ`: nút 確定 ẩn hay disabled? | ⏳ Chờ xác nhận | - |
| ~~OI-006~~ | ~~TAOR83_TABLELOCK không có cột ORDERCLASSIFICATION trong DB Design~~ | ✅ **Resolved** | DB Design đã bổ sung `ORDERCLASSIFICATION`. Lock key 5 trường đầy đủ. SQL TAOR83 đã cập nhật tại mục 5.4.3. |

> ✅ **Không còn BLOCKER**. OI-003, OI-004, OI-005 là non-blocking – có thể xử lý song song trong quá trình implementation.

---

## 12. Rủi Ro

| Rủi ro | Mức độ | Biện pháp |
|---|---|---|
| JOIN nhiều bảng (6+ tables) gây chậm khi dữ liệu lớn | Cao | Index trên SH_KOJO_CD, MENU_KIKAKU_CD, HT_SECTION_CD |
| Logic tính ステータス phức tạp dễ sai | Trung bình | Unit test riêng cho logic so sánh NULL / DEL_FLG |
| Lock logic phức tạp: full-stop vs force-continue | Trung bình | Test kỹ Lock-1 ~ Lock-4 trước release |
| impl docs cũ ghi "giải phóng lock khi IV0003" – sai | Cao | **Cập nhật impl docs ngay**: xóa dòng "Giải phóng khi search lại (IV0003)" khỏi TAOR83 section |
| impl docs cũ có OI-004 BLOCKER comment về TAOR83 | Trung bình | **Cập nhật impl docs**: xóa cảnh báo OI-004, bổ sung ORDERCLASSIFICATION vào SQL TAOR83 |
| Dữ liệu 生産用材料構成 chưa tồn tại ở timing sớm | Thấp | Chỉ hiển thị khi bảng đã tồn tại (xem mục 6 bảng timing) |
| Thời gian hiển thị N ngày chưa được config trong TMT050 | Thấp | Kiểm tra dữ liệu TMT050_NAME RCDKBN=3059 trong môi trường test |

---

## 13. Bảng Traceability

| AC | Màn hình (FE) | API/Backend | DB | Log | UT (FE) | UT (BE) | IT | E2E |
|---|---|---|---|---|---|---|---|---|
| AC-1-v1 | 初期表示 | GET /init | SELECT TMT003, TMT050, TAOR65 | - | ✓ | ✓ | ✓ | ✓ |
| AC-2-v1 | Radio 照会区分 | - | - | - | ✓ | - | ✓ | ✓ |
| AC-3-v1 | Modal セクション | GET /section-search | SELECT TAMT030 | - | ✓ | ✓ | ✓ | - |
| AC-4-v1 | Modal グループ | GET /group-search | SELECT TAMT029 | - | ✓ | ✓ | ✓ | - |
| AC-5-v1 | Validation FE | POST /search validation | - | - | ✓ | ✓ | ✓ | - |
| AC-6-v1 | Grid メニュー追加 | GET /search | SELECT JOIN TAOR57~69~55~56 | - | ✓ | ✓ | ✓ | ✓ |
| AC-7-v1 | Grid 調達品変更 | GET /search | SELECT JOIN + diff logic | - | ✓ | ✓ | ✓ | ✓ |
| AC-8-v1 | Thông báo rỗng | GET /search | SELECT | - | ✓ | ✓ | ✓ | - |
| AC-9-v1 | 全チェック | - | - | - | ✓ | - | - | ✓ |
| AC-10-v1 | Validation checkbox | POST /confirm | - | - | ✓ | ✓ | ✓ | - |
| AC-11-v1 | Confirm メニュー追加 | POST /confirm | INSERT TAOR65 | CRUD | ✓ | ✓ | ✓ | ✓ |
| AC-12-v1 | Confirm 調達品変更 | POST /confirm | INSERT/UPDATE/DELETE TAOR65 | CRUD | ✓ | ✓ | ✓ | ✓ |
| AC-13-v1 | クリア | - | - | - | ✓ | - | - | ✓ |
| AC-14-v1 | 調達品数 display | GET /search | SELECT COUNT | - | - | ✓ | ✓ | - |
| AC-15-v1 | 最終更新情報 | GET /init | SELECT MAX TAOR65+TMT002 | - | ✓ | ✓ | ✓ | - |
| **AC-16-v2** | Lock conflict いいえ | POST /confirm lock-check | SELECT/- TAOR83 | - | ✓ | ✓ | ✓ | ✓ |
| **AC-17-v2** | Lock conflict はい | POST /confirm force-lock | DELETE/INSERT TAOR83 + DML TAOR65 | CRUD | ✓ | ✓ | ✓ | ✓ |
| **AC-18-v2** | Lock release on destroy | DELETE /lock (fnDestroy) | DELETE TAOR83 | - | ✓ | ✓ | ✓ | - |

---

**Quyết định: Có thể bắt đầu implementation không?**

> ✅ **CÓ THỂ BẮT ĐẦU NGAY** – Không còn BLOCKER.
>
> Việc cần làm trước khi code:
> 1. **Cập nhật impl docs** (`impl_*_menu_addition.md`, `impl_*_chotatsu_henkou.md`):
>    - Xóa cảnh báo `OI-004 BLOCKER` về TAOR83
>    - Bổ sung `ORDERCLASSIFICATION` vào tất cả SQL thao tác TAOR83 (SELECT / INSERT / DELETE)
>    - Xóa dòng "Giải phóng khi search lại (IV0003)" trong TAOR83 section
> 2. OI-003 (clear fields khi đổi mode), OI-004 (giới hạn bản ghi), OI-005 (閲覧のみ) – xử lý song song, non-blocking
