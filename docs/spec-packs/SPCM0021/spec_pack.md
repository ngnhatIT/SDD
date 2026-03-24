# Spec Pack

## 1. Feature Overview

Tính năng `汎用CSV取込` thuộc chức năng `FPCM0002` dùng để tiếp nhận file CSV cho nhiều loại master data, thực hiện `事前チェック` theo layout định nghĩa, lưu kết quả kiểm tra vào work tables, cho phép người dùng rà soát lỗi/cảnh báo, và sau đó thực hiện `Upload` dữ liệu hợp lệ vào bảng đích hoặc bảng staging theo target được chọn.

Phạm vi workbook hiện tại thể hiện 3 UI surface có liên kết chặt chẽ:

- Main screen `SPCM00021` - `汎用CSV取込`
- Popup `デフォルト設定` - modal phục vụ thiết lập `取込形式` và rule xử lý khi có lỗi/cảnh báo trước khi chạy `事前チェック`
- Inquiry screen `SPVW00081` - `汎用CSV取込照会`

Các outcome chính:

- Chọn `取込対象データ` và file CSV để chạy `事前チェック`
- Ghi nhận header/detail của kết quả kiểm tra vào `TWK003_CSVIMPHISTORYHEADER` và `TWK004_CSVIMPHISTORYDETAIL`
- Hiển thị lỗi/cảnh báo chi tiết theo từng lần import
- `Upload` dữ liệu đã được precheck vào bảng đích đúng theo target và rule branch của target đó
- Tra cứu lịch sử import và drill-down chi tiết lỗi/cảnh báo

Condition: Precheck và upload phải đi qua dữ liệu staging/work table; source artifact không cho phép import trực tiếp từ raw CSV vào bảng đích mà bỏ qua `事前チェック`.

Condition: `⑨ユーザーマスタ` và `⑩組織マスタ` không được phản ánh trực tiếp vào final master trong màn hình này; workbook chỉ thể hiện lưu tạm vào bảng staging để batch đêm xử lý sau.

---

## 2. Background

Workbook cho thấy đây là cơ chế import CSV tổng quát cho nhiều loại master dùng chung một màn hình chính, một popup thiết lập, và một màn hình tra cứu lịch sử. Màn hình chính không có nút `表示`; việc chọn `取込対象データ` đóng vai trò trigger để tải danh sách kết quả precheck đã có cho target hiện tại.

Các rule nghiệp vụ quan trọng rút ra từ source:

Condition: Khi mở main screen hoặc khi đổi `取込対象データ`, hệ thống phải lấy danh sách target từ `CSV画面名マスタ (TMT331_CSVSCREEN)` và lấy danh sách kết quả `事前チェック` từ `CSVワークヘッダ (TWK003_CSVIMPHISTORYHEADER)` theo target hiện tại.

Condition: `データファイル名` là field hiển thị file đã chọn, không nhập tay; việc chọn file phải đi qua event `IV0001` và hiển thị file name sau khi attach.

Condition: Nút `事前チェック` chỉ được phép mở popup khi file name đã có và file có phần mở rộng `.csv`.

Condition: Popup `デフォルト設定` phải cho phép chọn 2 chiều thiết lập:
- `取込形式`: `UPDATE + INSERT` hoặc `DELETE`
- Rule xử lý khi có lỗi/cảnh báo: `一切データ反映しない` / `エラーのみデータ反映しない` / `エラーと警告をデータ反映しない`

Condition: Nút `実行` trong popup thực hiện precheck và ghi kết quả vào work tables; đây chưa phải upload vào bảng đích.

Condition: Upload chỉ được phép khi record precheck thỏa đồng thời `エラー数 = 0`, `警告数 = 0`, `更新ステータス = 未完了`.

Condition: Màn hình `汎用CSV取込照会` cho phép tìm lịch sử theo target, `取込番号`, `取込形式`, `取込ステータス`, `取込実施者`, và khoảng `取込日時`.

Condition: Người có quyền `使用不可` không được phép chuyển vào màn hình. Người có quyền `更新可能` được sử dụng toàn bộ chức năng. Người có quyền `閲覧のみ` chỉ được phép hiển thị/thao tác lọc, không được phép dùng chức năng làm thay đổi dữ liệu.

---

## 3. Scope

### In Scope

- Khởi tạo main screen `SPCM00021`
- Khởi tạo popup `デフォルト設定`
- Khởi tạo inquiry screen `SPVW00081`
- Chọn file CSV và hiển thị file name
- Mở inquiry screen từ main screen
- Mở popup `デフォルト設定`
- Chạy `事前チェック`
- Ghi kết quả precheck vào `TWK003_CSVIMPHISTORYHEADER`
- Ghi chi tiết row-level error/warning vào `TWK004_CSVIMPHISTORYDETAIL`
- Hiển thị `事前チェック結果`
- Drill-down `エラー数` / `警告数` sang `明細領域`
- `Upload` dữ liệu đã precheck vào bảng đích / bảng staging theo target
- Search/clear/paging trên inquiry screen
- Rule đặc thù theo từng target import ①-⑩
- Message handling theo message code có trong workbook
- Permission boundary ở mức `使用不可` / `更新可能` / `閲覧のみ`

### Out of Scope

- Batch đêm phản ánh dữ liệu từ `TAMT002_USERCSV` và `TAMT039_ORGANIZATIONCSV` sang final master
- SQL literal hoàn chỉnh; workbook hiện chủ yếu mô tả mapping table/field và rule, không cung cấp full SQL statement
- File parsing implementation detail ở mức library/framework
- File naming, temp file cleanup, retry strategy
- Chi tiết message text của từng code nếu workbook chỉ cung cấp code mà không có message body
- Cơ chế phân quyền nội bộ ngoài 3 mức quyền đã được mô tả
- Paging size, default sort order chính xác nếu source không ghi rõ

---

## 4. Glossary

| Term | Meaning |
|---|---|
| `汎用CSV取込` | Màn hình chính để chọn target, file, chạy precheck và upload. |
| `汎用CSV取込照会` | Màn hình tra cứu lịch sử import và xem chi tiết lỗi/cảnh báo. |
| `デフォルト設定` | Popup cấu hình `取込形式` và rule phản ánh dữ liệu khi có lỗi/cảnh báo trước khi precheck. |
| `事前チェック` | Bước kiểm tra file CSV theo layout/rule trước khi cho phép upload. |
| `CSVワークヘッダ` | `TWK003_CSVIMPHISTORYHEADER`, lưu header của một lần precheck/import. |
| `CSVワーク明細` | `TWK004_CSVIMPHISTORYDETAIL`, lưu chi tiết lỗi/cảnh báo theo từng dòng CSV. |
| `CSV画面名マスタ` | `TMT331_CSVSCREEN`, danh mục target data theo screen. |
| `CSVレイアウトマスタ` | `TMT332_CSVLAYOUT`, định nghĩa field/layout/default/reference cho popup và rule precheck. |
| `取込形式` | Hướng xử lý import, gồm `UPDATE + INSERT` hoặc `DELETE`. |
| `更新設定` | Giá trị rule xử lý khi có lỗi/cảnh báo; source item definition map cột `状態` về trường này. |
| `更新ステータス` | Trạng thái kết quả của một lần import/precheck. Workbook mô tả `0: 正常完了`, `1: 異常完了`, `2: 未完了`. |
| `発生区分` | Phân loại row detail là `エラー` hoặc `警告`; nếu vừa có error vừa có warning thì hiển thị `エラー`. |
| `有効なデータ` | Dòng dữ liệu đủ điều kiện để được phản ánh theo rule popup; exact branching phụ thuộc `更新設定`. |
| `Upload` | Action trên main screen để phản ánh dữ liệu đã precheck từ work tables sang bảng đích. Label/placement cụ thể là unresolved ambiguity nhưng event tồn tại rõ trong workbook. |

---

## 5. Base Screen Structure

### 5.1 Screen Identity

- Function ID: `FPCM0002`
- Primary Screen ID: `SPCM00021`
- Primary Screen Name: `汎用CSV取込`
- Related Inquiry Screen ID: `SPVW00081`
- Related Inquiry Screen Name: `汎用CSV取込照会`
- Related Popup Screen ID: `SPCM00021`
- Related Popup Screen Name: `デフォルト設定`

### 5.2 Layout Regions

1. Header / Title
2. Main Search Condition Area
   - `取込対象データ`
   - `データファイル名`
   - `データファイル名_ファイル選択`
   - `取込履歴表示`
   - `事前チェック`
   - `Upload` (inferred from event sheet and state note)
3. Main `【事前チェック結果】` Area
4. Main `【明細領域】`
5. Popup `【データ反映領域】`
6. Popup `【エラー発生時領域】`
7. Popup `【デフォルト値領域】`
8. Popup footer actions `戻る` / `実行`
9. Inquiry Search Condition Area
10. Inquiry `【事前チェック結果】`
11. Inquiry `【明細領域】`

### 5.3 Shared State Variables

| State | Meaning |
|---|---|
| `selectedTarget` | Target data hiện đang chọn trong `取込対象データ`. |
| `selectedTargetScreenId` | Internal ID/value tương ứng target, lấy từ `TMT331_CSVSCREEN`. |
| `selectedFileName` | File name đã chọn qua dialog; chỉ hiển thị, không nhập tay. |
| `mainHeaderRows` | Danh sách precheck history hiện trên main screen. |
| `mainHeaderCount` | Số lượng row ở `【事前チェック結果】` trên main screen. |
| `selectedImportNo` | `取込番号` đang được dùng để drill-down chi tiết hoặc upload. Exact selection mechanism là unresolved ambiguity. |
| `selectedOccurrenceType` | `エラー` hoặc `警告` khi click `エラー数` / `警告数`. |
| `detailRows` | Danh sách row chi tiết từ `TWK004_CSVIMPHISTORYDETAIL`. |
| `detailCount` | Số lượng row chi tiết. |
| `popupImportType` | `UPDATE + INSERT` hoặc `DELETE`. |
| `popupErrorPolicy` | `0/1/2` tương ứng rule xử lý khi có error/warning. |
| `uploadEnabled` | Cờ enable/disable nút `Upload`. |
| `historyConditions` | Bộ filter trên inquiry screen. |
| `historyHeaderRows` | Danh sách history result trên inquiry screen. |
| `historyDetailRows` | Chi tiết row trên inquiry screen. |
| `currentPage` | Paging của grid header. |
| `detailPage` | Paging của grid detail nếu có. |

### 5.4 Shared Actions

| UI Action | Business Event |
|---|---|
| Screen open `汎用CSV取込` | `initialize_main_screen` |
| `取込対象データ` change | `change_import_target` |
| `データファイル名_ファイル選択` | `select_csv_file` |
| `取込履歴表示` | `open_import_history` |
| `事前チェック` | `open_default_settings` |
| Popup open | `initialize_default_settings` |
| Popup `戻る` | `close_default_settings` |
| Popup `実行` | `run_precheck` |
| `エラー数` click | `open_error_detail` |
| `警告数` click | `open_warning_detail` |
| `Upload` | `upload_csv_data` |
| Screen open `汎用CSV取込照会` | `initialize_history_screen` |
| Inquiry `表示` | `search_import_history` |
| Inquiry `クリア` | `reset_history_conditions` |
| Inquiry `エラー数` / `警告数` click | `open_history_detail` |
| Paging link click | `change_page` |

---

## 6. Shared Data Context

### 6.1 UI Fields

#### 6.1.1 Main screen `SPCM00021`

| Field | Type | Required | Behavior |
|---|---|---:|---|
| `取込対象データ` | List | Yes | Default `発注依頼マスタ`; load from `TMT331_CSVSCREEN` by screen condition; changing value refreshes `【事前チェック結果】`. |
| `データファイル名` | Text | Yes | Read-only / non-active; displays selected file name only. |
| `データファイル名_ファイル選択` | Button | No | Opens file dialog and sets `データファイル名`. |
| `取込履歴表示` | Button | No | Navigates to `SPVW00081`; auto-fills matching search conditions where possible. |
| `事前チェック` | Button | No | Validates file input and opens popup `デフォルト設定`. |
| `Upload` | Button | No | Inferred main action; enabled only under upload-ready condition. |
| `件数` | Label | No | Count of main precheck history header rows. |
| `ページング` | Link | No | Common paging function. |
| `取込番号` | Label | No | From `CSVワークヘッダ`.`取込番号`. |
| `取込実施者` | Label | No | From `CSVワークヘッダ`.`取込ユーザー`. |
| `ファイル行数` | Label | No | From `CSVワークヘッダ`.`取込件数`. |
| `UPDATE行数` | Label | No | From `CSVワークヘッダ`.`更新件数`. |
| `INSERT行数` | Label | No | From `CSVワークヘッダ`.`挿入件数`. |
| `DELETE行数` | Label | No | From `CSVワークヘッダ`.`削除件数`. |
| `エラー数` | Link | No | From `CSVワークヘッダ`.`エラー件数`; click opens detail for error rows. |
| `警告数` | Link | No | From `CSVワークヘッダ`.`警告件数`; click opens detail for warning rows. |
| `更新ステータス` | Label | No | `0: 正常完了`, `1: 異常完了`, `2: 未完了`. |
| `状態` | Label | No | Source maps to `CSVワークヘッダ`.`更新設定`; display semantics partially ambiguous. |
| `開始日時` | Label | No | From `CSVワークヘッダ`.`登録日時` or process start field in layout sample. |
| `終了日時` | Label | No | From `CSVワークヘッダ`.`更新日時` or process end field in layout sample. |

#### 6.1.2 Main / inquiry detail area

| Field | Type | Required | Behavior |
|---|---|---:|---|
| `発生行` | Label | No | From `CSVワーク明細`.`CSV行番号`. |
| `発生区分` | Label | No | `エラー` / `警告`; if both exist, display `エラー`. |
| `レイアウトエラー` | Label | No | Count/flag of layout mismatch. |
| `キー重複エラー` | Label | No | Count/flag of duplicate key. |
| `必須抜けエラー` | Label | No | Count/flag of missing required value. |
| `データ型不正エラー` | Label | No | Count/flag of datatype mismatch. |
| `桁数不正エラー` | Label | No | Count/flag of length mismatch. |
| `フォーマットエラー` | Label | No | Count/flag of format mismatch; item definition shows this column even though layout sample visibility is ambiguous. |
| `参照マスタ不在警告` | Label | No | Count/flag of parent/reference master absent. |

#### 6.1.3 Popup `デフォルト設定`

| Field | Type | Required | Behavior |
|---|---|---:|---|
| `UPDATE + INSERT` | Radio | No | Default ON; value `1`. Key match -> update; otherwise insert. |
| `DELETE` | Radio | No | Value `2`; key match -> delete. |
| `一切データ反映しない` | Radio | No | Default ON; value `0`; if at least 1 error or warning then do not reflect any data. |
| `エラーのみデータ反映しない` | Radio | No | Value `1`; reflect normal + warning, skip error rows. |
| `エラーと警告をデータ反映しない` | Radio | No | Value `2`; reflect only normal rows. |
| `必須` | Label | No | From `CSVレイアウトマスタ`.`必須フラグ`. |
| `項目名` | Link | No | From `CSVレイアウトマスタ`.`項目名称`. |
| `デフォルト` | Label | No | From `CSVレイアウトマスタ`.`デフォルト値`. |
| `データ型` | Label | No | From `CSVレイアウトマスタ`.`データ型`. |
| `最大桁数` | Label | No | From `CSVレイアウトマスタ`.`桁数`. |
| `キー項目` | Label | No | From `CSVレイアウトマスタ`.`キー区分`. |
| `参照データ名` | Label | No | From `CSVレイアウトマスタ`.`参照テーブル`. |
| `参照項目` | Label | No | From `CSVレイアウトマスタ`.`参照項目`. |
| `フォーマット` | Label | No | From `CSVレイアウトマスタ`.`フォーマット`. |
| `戻る` | Button | No | Close popup and return main screen. |
| `実行` | Button | No | Run precheck and persist result to work tables. |

#### 6.1.4 Inquiry screen `SPVW00081`

| Field | Type | Required | Behavior |
|---|---|---:|---|
| `取込対象データ` | List | No | Default `発注依頼マスタ`; values loaded from `TMT331_CSVSCREEN` by inquiry screen condition. |
| `取込番号` | Text | No | Search by import number. Matching type not explicitly defined; likely exact match. |
| `取込形式` | List | No | Default `-- 選択 --`; load from `TMT050_NAME` where `RCDKBN = 0126`. |
| `取込ステータス` | List | No | Default `-- 選択 --`; load from `TMT050_NAME` where `RCDKBN = 0125`. |
| `取込実施者` | Text | No | Partial match search. |
| `取込日時（from）` | Calendar | No | Default today. |
| `取込日時（to）` | Calendar | No | Default today. |
| `表示` | Button | No | Search `CSVワークヘッダ`. |
| `クリア` | Button | No | Reset all fields to default values. |

### 6.2 Result Columns

#### 6.2.1 Main / inquiry header result

| Column | Source / Behavior |
|---|---|
| `取込番号` | `TWK003_CSVIMPHISTORYHEADER.CSVIMPNO` |
| `データファイル名` | `TWK003_CSVIMPHISTORYHEADER.IMPFILENM` |
| `取込実施者` | `TWK003_CSVIMPHISTORYHEADER.IMPUSERNM` |
| `ファイル行数` | `TWK003_CSVIMPHISTORYHEADER.TOTALCNT` |
| `UPDATE行数` | `TWK003_CSVIMPHISTORYHEADER.UPDATECNT` |
| `INSERT行数` | `TWK003_CSVIMPHISTORYHEADER.INSERTCNT` |
| `DELETE行数` | `TWK003_CSVIMPHISTORYHEADER.DELETECNT` |
| `エラー数` | `TWK003_CSVIMPHISTORYHEADER.ERRORCNT` |
| `警告数` | `TWK003_CSVIMPHISTORYHEADER.WARNINGCNT` |
| `更新ステータス` | `TWK003_CSVIMPHISTORYHEADER.IMPSTATUS` |
| `状態` | `TWK003_CSVIMPHISTORYHEADER.IMPSETTING` |
| `開始日時` | Header timestamp field shown on layout / item definition mapping to process time fields |
| `終了日時` | Header timestamp field shown on layout / item definition mapping to process time fields |

#### 6.2.2 Detail result

| Column | Source / Behavior |
|---|---|
| `発生行` | `TWK004_CSVIMPHISTORYDETAIL.CSVROWNO` |
| `発生区分` | Derived from row error/warning flags or stored `STATUS` |
| `レイアウトエラー` | `TWK004_CSVIMPHISTORYDETAIL.LAYOUTERR` |
| `キー重複エラー` | `TWK004_CSVIMPHISTORYDETAIL.KEYDUPLICATEERR` |
| `必須抜けエラー` | `TWK004_CSVIMPHISTORYDETAIL.NULLERR` |
| `データ型不正エラー` | `TWK004_CSVIMPHISTORYDETAIL.DATATYPEERR` |
| `データフォーマット不正エラー` | `TWK004_CSVIMPHISTORYDETAIL.DATAFORMATERR` |
| `桁数不正エラー` | `TWK004_CSVIMPHISTORYDETAIL.DATALENGTHERR` |
| `参照マスタ不在エラー` | `TWK004_CSVIMPHISTORYDETAIL.MASTERNULLERR` |
| `ラジオチェックボックス不在エラー` | Table schema có field nhưng UI visibility is non-inferable from current artifacts |
| `その他エラー` | Table schema có field nhưng UI visibility is non-inferable from current artifacts |

### 6.3 Main Data Sources

| Object | Role |
|---|---|
| `TMT331_CSVSCREEN` | Danh mục target data theo screen. |
| `TMT332_CSVLAYOUT` | Định nghĩa layout/rule/default/reference cho target được chọn. |
| `TWK003_CSVIMPHISTORYHEADER` | Work header cho precheck/import history. |
| `TWK004_CSVIMPHISTORYDETAIL` | Work detail cho row-level validation result. |
| `TMT050_NAME` | Danh mục `取込形式`, `取込ステータス`, và một số target direct import. |
| `TAOR65_ORDERREQUESTMASTER` | Target table của `①発注依頼マスタ`. |
| `TMT026_PRODUCT` | Target table của `③調達品マスタ`. |
| `TAMT026_PRODUCTAGREEMENT` | Target table của `④調達品契約マスタ`. |
| `TMT023_PARTNER`, `TMT067_PAYMENTINFO`, `TMT002_USER`, `TMT210_FNCAUTH`, `TSM110_FNCAUTHGROUP`, `TAMT042_EMAILBODY`, `TMT077_EMAILDESTINATIONSETTO`, `TMT078_EMAILDESTINATIONSETCC`, `TMT079_EMAILDESTINATIONSETBCC` | Multi-table target set cho `⑤仕入先マスタ`. |
| `TAMT024_PARTNERSTORE`, `TMT068_SHOPACCOUNT` | Multi-table target set cho `⑥仕入先工場マスタ`. |
| `TAMT030_SECTION` | Target table của `⑦セクションマスタ`. |
| `TAMT029_GROUP` | Target table của `⑧グループマスタ`. |
| `TAMT002_USERCSV` | Staging target của `⑨ユーザーマスタ`. |
| `TAMT039_ORGANIZATIONCSV` | Staging target của `⑩組織マスタ`. |

### 6.4 Persistence / Update Targets

| Object | Purpose |
|---|---|
| `TWK003_CSVIMPHISTORYHEADER` | Lưu summary của lần precheck/import. |
| `TWK004_CSVIMPHISTORYDETAIL` | Lưu chi tiết lỗi/cảnh báo từng row. |
| `TAOR65_ORDERREQUESTMASTER` | Reflect trực tiếp dữ liệu của target ①. |
| `TMT050_NAME` | Reflect trực tiếp dữ liệu của target ②; generic delete sheet cũng tham chiếu table này. |
| `TMT026_PRODUCT` | Reflect trực tiếp dữ liệu của target ③. |
| `TAMT026_PRODUCTAGREEMENT` | Reflect trực tiếp dữ liệu của target ④. |
| `⑤仕入先マスタ` target tables | Reflect theo branch multi-table tùy effective date / payment account / password changes. |
| `⑥仕入先工場マスタ` target tables | Reflect theo branch multi-table tùy effective date / payment account changes. |
| `TAMT030_SECTION` | Reflect trực tiếp dữ liệu của target ⑦. |
| `TAMT029_GROUP` | Reflect trực tiếp dữ liệu của target ⑧. |
| `TAMT002_USERCSV` | Lưu tạm dữ liệu ⑨ để batch đêm phản ánh sau. |
| `TAMT039_ORGANIZATIONCSV` | Lưu tạm dữ liệu ⑩ để batch đêm phản ánh sau. |

### 6.5 Target-dependent Differences

| Target | Input Field Count | Primary Table(s) | Reflection Type |
|---|---:|---|---|
| `①発注依頼マスタ` | 14 | `TAOR65_ORDERREQUESTMASTER` | Direct import |
| `②利益センタマスタ` | 4 | `TMT050_NAME` | Direct import |
| `③調達品マスタ` | 30 | `TMT026_PRODUCT` | Direct import |
| `④調達品契約マスタ` | 34 | `TAMT026_PRODUCTAGREEMENT` | Direct import |
| `⑤仕入先マスタ` | 22 | Multi-table | Branch import |
| `⑥仕入先工場マスタ` | 44 | Multi-table | Branch import |
| `⑦セクションマスタ` | 7 | `TAMT030_SECTION` | Direct import |
| `⑧グループマスタ` | 10 | `TAMT029_GROUP` | Direct import |
| `⑨ユーザーマスタ` | 59 | `TAMT002_USERCSV` | Staging only |
| `⑩組織マスタ` | 31 | `TAMT039_ORGANIZATIONCSV` | Staging only |

Condition: Workbook note ở main screen ghi `⑪個別権限` đã bị xóa; spec này chỉ coi ①-⑩ là target active.

---

## 7. Shared Events

### 7.1 `initialize_main_screen`

**UI Trigger**

- Mở screen `SPCM00021`

**Preconditions**

- User có quyền truy cập màn hình

**Validation**

- Không có validation input tại thời điểm open

**Processing**

1. Load target list từ `TMT331_CSVSCREEN`
2. Set default `取込対象データ = 発注依頼マスタ`
3. Dựa trên target đang chọn, lấy data để hiển thị ở `【事前チェック結果】`
4. Initialize toàn bộ `【明細領域】`
5. Set `データファイル名` ở trạng thái trống/non-active

**Result**

- Main screen ở init state
- Có danh sách precheck history của target mặc định
- Detail area rỗng

**Failure Cases**

- Quyền `使用不可` -> không cho phép điều hướng vào màn hình
- Message code cụ thể cho quyền không được nêu trong workbook

---

### 7.2 `change_import_target`

**UI Trigger**

- User đổi giá trị `取込対象データ`

**Preconditions**

- Main screen đã load target list

**Validation**

- Không có validation riêng ngoài việc target phải là giá trị hợp lệ trong list

**Processing**

1. Resolve display value sang internal key/screen value theo `TMT331_CSVSCREEN`
2. Tải lại `【事前チェック結果】` từ `TWK003_CSVIMPHISTORYHEADER` theo target hiện tại
3. Reset `【明細領域】`
4. Reset paging của detail area

**Result**

- Header result area phản ánh target mới
- Detail area trở về trống

**Failure Cases**

- Nếu target không resolve được -> `Unresolved ambiguity`; handling phụ thuộc implementation lookup

---

### 7.3 `select_csv_file`

**UI Trigger**

- Button `データファイル名_ファイル選択`

**Preconditions**

- User có quyền update

**Validation**

- Không validate nội dung file ở bước mở dialog

**Processing**

1. Hiển thị dialog chọn file
2. User chọn file
3. System attach file vào session/request context
4. Set `データファイル名` = tên file vừa chọn

**Result**

- File name hiển thị tại field read-only `データファイル名`

**Failure Cases**

- User cancel dialog -> giữ nguyên `データファイル名`

---

### 7.4 `open_import_history`

**UI Trigger**

- Button `取込履歴表示`

**Preconditions**

- Screen hiện tại đang mở

**Validation**

- Không có validation bắt buộc

**Processing**

1. Navigate tới `SPVW00081`
2. Auto-fill các search condition tương ứng trên inquiry screen từ main screen khi có thể
3. Inquiry screen khởi tạo các dữ liệu master/filter cần thiết

**Result**

- Inquiry screen hiển thị và sẵn sàng search

**Failure Cases**

- Mapping field auto-fill chi tiết ngoài `取込対象データ` là non-inferable from current artifacts

---

### 7.5 `open_default_settings`

**UI Trigger**

- Button `事前チェック`

**Preconditions**

- User có quyền update

**Validation**

Condition: `データファイル名` chưa được chỉ định -> show `ME000005` với argument `CSVファイル`.

Condition: File extension không phải `.csv` -> show `MEA00003`.

**Processing**

1. Validate input file presence
2. Validate file extension
3. Carry `取込対象データ` và selected file sang popup context
4. Open popup `デフォルト設定`

**Result**

- Popup mở ra nếu validation OK

**Failure Cases**

- Validation error -> không mở popup và giữ nguyên main screen state

---

### 7.6 `initialize_default_settings`

**UI Trigger**

- Popup `デフォルト設定` được mở

**Preconditions**

- Có `selectedTarget` và attached file từ main screen

**Validation**

- Không có validation riêng tại thời điểm open

**Processing**

1. Load target-specific layout rows từ `TMT332_CSVLAYOUT`
2. Hiển thị grid `【デフォルト値領域】`
3. Set default radio:
   - `UPDATE + INSERT` = ON
   - `一切データ反映しない` = ON

**Result**

- Popup hiển thị đầy đủ radio options và default-value grid

**Failure Cases**

- Nếu không tìm thấy layout rows cho target -> `Unresolved ambiguity`; UI handling không được source mô tả

---

### 7.7 `run_precheck`

**UI Trigger**

- Button `実行` trên popup

**Preconditions**

- Popup đang mở
- Có selected file và selected target
- Layout metadata từ `TMT332_CSVLAYOUT` đã load

**Validation**

Condition: CSV file không có data -> show `ME100042`.

Condition: Sau precheck không có `有効なデータ` -> show `ME200031`.

Condition: CSV chứa error/warning và selected policy không cho phép phản ánh các row đó -> show `ME200030` hoặc `ME000122` tùy outcome; exact branch between these two codes là partially non-inferable.

**Processing**

1. Đọc toàn bộ data trong file CSV
2. Kiểm tra tồn tại data
3. Chạy row-level validation cho từng dòng:
   - layout error
   - key duplicate warning
   - required missing error
   - datatype error
   - length error
   - format error
   - reference master missing warning
4. Tính tổng error count và warning count
5. Xác định row classification `正常` / `警告` / `エラー`
6. Tạo/ghi `TWK003_CSVIMPHISTORYHEADER`
7. Tạo/ghi `TWK004_CSVIMPHISTORYDETAIL`
8. Return về main screen
9. Main screen refresh `【事前チェック結果】`

**Result**

- Có history header/detail mới cho lần precheck hiện tại
- Main screen hiển thị row summary mới nhất
- `Upload` enable state được đánh giá lại

**Failure Cases**

- File empty -> `ME100042`
- No valid data -> `ME200031`
- Error/warning not accepted by selected policy -> `ME200030` / `ME000122`
- Popup không được đóng với trạng thái success nếu persist work tables thất bại; transaction detail chưa được source mô tả

---

### 7.8 `close_default_settings`

**UI Trigger**

- Button `戻る` trên popup

**Preconditions**

- Popup đang mở

**Validation**

- Không có validation

**Processing**

1. Đóng popup
2. Return về main screen mà không tạo precheck result mới

**Result**

- Main screen được hiển thị lại
- Dữ liệu precheck hiện có trên main không đổi

**Failure Cases**

- Không có

---

### 7.9 `open_error_detail`

**UI Trigger**

- Click link `エラー数`

**Preconditions**

- Có row header hợp lệ trên main hoặc inquiry screen

**Validation**

- `selectedImportNo` phải xác định được

**Processing**

1. Lấy `取込番号`
2. Set occurrence filter = `エラー`
3. Query `TWK004_CSVIMPHISTORYDETAIL`
4. Hiển thị detail rows trong `【明細領域】`

**Result**

- Chỉ hiển thị row detail thuộc import number đã chọn và occurrence type `エラー`

**Failure Cases**

- Không có row detail phù hợp -> hiển thị detail rỗng; message explicit chưa được source mô tả

---

### 7.10 `open_warning_detail`

**UI Trigger**

- Click link `警告数`

**Preconditions**

- Có row header hợp lệ trên main hoặc inquiry screen

**Validation**

- `selectedImportNo` phải xác định được

**Processing**

1. Lấy `取込番号`
2. Set occurrence filter = `警告`
3. Query `TWK004_CSVIMPHISTORYDETAIL`
4. Hiển thị detail rows trong `【明細領域】`

**Result**

- Chỉ hiển thị row detail thuộc import number đã chọn và occurrence type `警告`

**Failure Cases**

- Không có row detail phù hợp -> detail rỗng

---

### 7.11 `upload_csv_data`

**UI Trigger**

- Button `Upload` trên main screen

**Preconditions**

Condition: User có quyền update.

Condition: Precheck result hiện tại phải thỏa `エラー数 = 0`, `警告数 = 0`, `更新ステータス = 未完了`.

Condition: Upload phải dùng dữ liệu đã đi qua precheck/work tables; không được import trực tiếp từ raw file.

**Validation**

- Không có message code explicit cho disabled upload trong workbook
- Enable/disable được điều khiển bằng state rule ở item definition

**Processing**

1. Xác định precheck dataset đích theo `取込番号`/context hiện tại
2. Đọc data từ work tables và target configuration
3. Branch theo `selectedTarget`
4. Branch tiếp theo `popupImportType` và target-specific edit spec
5. Reflect data vào bảng đích hoặc bảng staging tương ứng
6. Update `更新ステータス` của lần import

**Result**

- Dữ liệu được import vào bảng đích/staging đúng target
- Main result area phản ánh lại import status mới nhất

**Failure Cases**

- Khi target-specific processing fail -> `更新ステータス` chuyển `異常完了` theo business intent; exact rollback granularity là non-inferable from current artifacts

---

### 7.12 `initialize_history_screen`

**UI Trigger**

- Mở `SPVW00081`

**Preconditions**

- User có quyền truy cập màn hình

**Validation**

- Không có validation tại thời điểm open

**Processing**

1. Load target list từ `TMT331_CSVSCREEN` với điều kiện screen của inquiry
2. Load `取込形式` list từ `TMT050_NAME` với `RCDKBN = 0126`
3. Load `取込ステータス` list từ `TMT050_NAME` với `RCDKBN = 0125`
4. Set default conditions:
   - `取込対象データ = 発注依頼マスタ`
   - `取込番号 = 空白`
   - `取込形式 = -- 選択 --`
   - `取込ステータス = -- 選択 --`
   - `取込実施者 = 空白`
   - `取込日時（from） = 当日`
   - `取込日時（to） = 当日`
5. Initialize header/detail areas

**Result**

- Inquiry screen ở init state

**Failure Cases**

- Không có

---

### 7.13 `search_import_history`

**UI Trigger**

- Button `表示`

**Preconditions**

- Inquiry screen đang mở

**Validation**

- Workbook không định nghĩa validation bắt buộc riêng cho inquiry filters

**Processing**

1. Query `TWK003_CSVIMPHISTORYHEADER` theo điều kiện search hiện tại
2. Hiển thị `【事前チェック結果】`
3. Reset `【明細領域】`
4. Apply common paging

**Result**

- Inquiry header result phản ánh filter hiện tại

**Failure Cases**

Condition: Không có data phù hợp -> show `MI000001`.

---

### 7.14 `reset_history_conditions`

**UI Trigger**

- Button `クリア`

**Preconditions**

- Inquiry screen đang mở

**Validation**

- Không có validation

**Processing**

1. Reset toàn bộ search conditions theo initial values
2. Clear header result
3. Clear detail result
4. Reset paging

**Result**

- Inquiry screen trở về init state

**Failure Cases**

- Không có

---

### 7.15 `open_history_detail`

**UI Trigger**

- Click `エラー数` hoặc `警告数` trong inquiry header result

**Preconditions**

- Có row header hợp lệ

**Validation**

- `CSVIMPNO` phải xác định được

**Processing**

1. Xác định `CSVIMPNO`
2. Xác định occurrence filter theo link được click
3. Query `TWK004_CSVIMPHISTORYDETAIL`
4. Display detail result

**Result**

- Inquiry `【明細領域】` hiển thị detail rows tương ứng

**Failure Cases**

- Không có row detail -> detail rỗng

---

## 8. Mode Variants

### Variant A - Main Init State

**Trigger**

- Open `SPCM00021`
- Sau khi chọn target lần đầu và chưa chạy precheck mới trong session hiện tại

**UI Changes**

- `取込対象データ` có default value
- `データファイル名` trống/non-active
- `【事前チェック結果】` hiển thị history theo target mặc định
- `【明細領域】` trống
- `Upload` disabled

**Input Fields**

- `取込対象データ`
- `データファイル名_ファイル選択`

**Result Display**

- Header area có thể có dữ liệu lịch sử
- Detail area rỗng

**Wireframe (ASCII only)**

```text
+--------------------------------------------------------------------------------+
| Generic CSV Import                                                             |
+--------------------------------------------------------------------------------+
| [Search Conditions]                                                            |
| Import Target * [Order Request Master v]                                       |
| Data File Name * [                                      ] [Select File]        |
|                                                    [History] [Precheck]        |
+--------------------------------------------------------------------------------+
| [Precheck Result]                                                              |
| Count: n                                                                       |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| | No     | File Name            | User      | Total  | Upd    | Ins    |Err | |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| | ...                                                                       | |
| +----------------------------------------------------------------------------+ |
| Upload: [disabled]                                                            |
+--------------------------------------------------------------------------------+
| [Detail]                                                                      |
| Count: 0                                                                       |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| | Row  | Type      | Layout    | Key Dup   | Required  | Datatype  | Ref M  | |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| |                                                                            | |
| +----------------------------------------------------------------------------+ |
+--------------------------------------------------------------------------------+
```

**Acceptance Criteria**

- Related AC: `AC-MAIN-001`, `AC-MAIN-002`, `AC-MAIN-003`

---

### Variant B - Main Precheck Result State

**Trigger**

- Popup `実行` success
- Main screen refresh sau precheck

**UI Changes**

- `【事前チェック結果】` có row mới cho lần precheck hiện tại
- `エラー数` / `警告数` trở thành drill-down link
- `【明細領域】` vẫn trống cho tới khi click detail link
- `Upload` enabled/disabled tùy rule

**Input Fields**

- `取込対象データ`
- `データファイル名`
- `事前チェック`
- `Upload`

**Result Display**

- Count, file row count, insert/update/delete count, status hiển thị theo `TWK003`

**Wireframe (ASCII only)**

```text
+--------------------------------------------------------------------------------+
| Generic CSV Import                                                             |
+--------------------------------------------------------------------------------+
| [Search Conditions]                                                            |
| Import Target * [Order Request Master v]                                       |
| Data File Name * [sample.csv                           ] [Select File]         |
|                                                    [History] [Precheck]        |
+--------------------------------------------------------------------------------+
| [Precheck Result]                                                              |
| Count: 1                                                                       |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| | No     | File Name            | User      | Total  | Upd    | Ins    |Err | |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| | 12     | sample.csv           | admin     | 120    | 80     | 40     |  2 | |
| +----------------------------------------------------------------------------+ |
| Upload: [disabled or enabled by rule]                                          |
+--------------------------------------------------------------------------------+
| [Detail]                                                                      |
| Count: 0                                                                       |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| | Row  | Type      | Layout    | Key Dup   | Required  | Datatype  | Ref M  | |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| |                                                                            | |
| +----------------------------------------------------------------------------+ |
+--------------------------------------------------------------------------------+
```

**Acceptance Criteria**

- Related AC: `AC-POPUP-004`, `AC-POPUP-005`, `AC-MAIN-006`, `AC-UPLOAD-001`

---

### Variant C - Main Upload Ready State

**Trigger**

- Có precheck result với `エラー数 = 0`, `警告数 = 0`, `更新ステータス = 未完了`

**UI Changes**

- `Upload` enabled
- Header row hiển thị trạng thái đủ điều kiện import
- Detail drill-down vẫn hoạt động

**Input Fields**

- `Upload`

**Result Display**

- Có tối thiểu một row precheck đủ điều kiện upload

**Wireframe (ASCII only)**

```text
+--------------------------------------------------------------------------------+
| Generic CSV Import                                                             |
+--------------------------------------------------------------------------------+
| [Search Conditions]                                                            |
| Import Target * [Order Request Master v]                                       |
| Data File Name * [clean_file.csv                       ] [Select File]         |
|                                                    [History] [Precheck]        |
+--------------------------------------------------------------------------------+
| [Precheck Result]                                                              |
| Count: 1                                                                       |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| | No     | File Name            | User      | Total  | Upd    | Ins    |Err | |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| | 13     | clean_file.csv       | admin     | 100    | 60     | 40     |  0 | |
| +----------------------------------------------------------------------------+ |
| Upload: [Upload]                                                               |
+--------------------------------------------------------------------------------+
| [Detail]                                                                      |
| Count: 0                                                                       |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| | Row  | Type      | Layout    | Key Dup   | Required  | Datatype  | Ref M  | |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| |                                                                            | |
| +----------------------------------------------------------------------------+ |
+--------------------------------------------------------------------------------+
```

**Acceptance Criteria**

- Related AC: `AC-UPLOAD-001`, `AC-UPLOAD-002`, `AC-UPLOAD-003`

---

### Variant D - Popup `デフォルト設定`

**Trigger**

- Main button `事前チェック`
- File validation OK

**UI Changes**

- Modal opens over main screen
- Default radios are preselected
- Default-value grid loads per target

**Input Fields**

- `UPDATE + INSERT`
- `DELETE`
- `一切データ反映しない`
- `エラーのみデータ反映しない`
- `エラーと警告をデータ反映しない`

**Result Display**

- Dynamic grid from `TMT332_CSVLAYOUT`

**Wireframe (ASCII only)**

```text
+------------------------------------------------------------+
| Default Settings                                           |
+------------------------------------------------------------+
| Change settings before Execute.                            |
|                                                            |
| [Data Reflection]                                          |
| (*) Update + Insert                                        |
| ( ) Delete                                                 |
|                                                            |
| [On Error or Warning]                                      |
| (*) Reflect none if any error or warning                   |
| ( ) Skip errors only                                       |
| ( ) Skip errors and warnings                               |
|                                                            |
| [Default Value Area]                                       |
| Req | Item | Default | Type | Len | Key | Ref Table | Ref |
| ...                                                        |
|                                                            |
|                                            [Back] [Exec]   |
+------------------------------------------------------------+
```

**Acceptance Criteria**

- Related AC: `AC-POPUP-001`, `AC-POPUP-002`, `AC-POPUP-003`, `AC-POPUP-004`

---

### Variant E - Inquiry Init State

**Trigger**

- Open `SPVW00081`
- Sau `クリア`

**UI Changes**

- Search conditions theo initial values
- Header/detail results rỗng

**Input Fields**

- `取込対象データ`
- `取込番号`
- `取込形式`
- `取込ステータス`
- `取込実施者`
- `取込日時（from）`
- `取込日時（to）`

**Result Display**

- `【事前チェック結果】` empty
- `【明細領域】` empty

**Wireframe (ASCII only)**

```text
+--------------------------------------------------------------------------------+
| Generic CSV Import Inquiry                                                     |
+--------------------------------------------------------------------------------+
| [Search Conditions]                                                            |
| Target [Order Request Master v] No [      ] Type [--Select-- v]               |
| Status [--Select-- v] User [                ] Date [today] to [today]         |
|                                                          [Show] [Clear]        |
+--------------------------------------------------------------------------------+
| [History Result]                                                               |
| Count: 0                                                                       |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| | No     | File Name            | User      | Total  | Upd    | Ins    |Err | |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| |                                                                            | |
| +----------------------------------------------------------------------------+ |
+--------------------------------------------------------------------------------+
| [Detail] Count: 0                                                              |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| | Row  | Type      | Layout    | Key Dup   | Required  | Datatype  | Ref M  | |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| |                                                                            | |
| +----------------------------------------------------------------------------+ |
+--------------------------------------------------------------------------------+
```

**Acceptance Criteria**

- Related AC: `AC-HIST-001`, `AC-HIST-002`

---

### Variant F - Inquiry Result and Detail State

**Trigger**

- Button `表示`
- Optional drill-down on `エラー数` / `警告数`

**UI Changes**

- Header result grid hiển thị rows
- Detail grid hiển thị khi click error/warning link
- Paging có thể hoạt động ở cả header và detail

**Input Fields**

- Search conditions giữ nguyên sau search

**Result Display**

- Header result theo `TWK003`
- Detail result theo `TWK004`

**Wireframe (ASCII only)**

```text
+--------------------------------------------------------------------------------+
| Generic CSV Import Inquiry                                                     |
+--------------------------------------------------------------------------------+
| [Search Conditions]                                                            |
| Target [Order Request Master v] No [12    ] Type [Update v]                   |
| Status [Unfinished v] User [admin           ] Date [2026/03/23] [2026/03/23]  |
|                                                          [Show] [Clear]        |
+--------------------------------------------------------------------------------+
| [History Result]                                                               |
| Count: 1                                                                       |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| | No     | File Name            | User      | Total  | Upd    | Ins    |Err | |
| +--------+----------------------+-----------+--------+--------+--------+-----+ |
| | 12     | sample.csv           | admin     | 120    | 80     | 40     |  2 | |
| +----------------------------------------------------------------------------+ |
+--------------------------------------------------------------------------------+
| [Detail] Count: 2                                                              |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| | Row  | Type      | Layout    | Key Dup   | Required  | Datatype  | Ref M  | |
| +------+-----------+-----------+-----------+-----------+-----------+---------+ |
| | 1    | Error     | Yes       | No        | Yes       | No        | No      | |
| | 2    | Error     | Yes       | Yes       | Yes       | Yes       | Yes     | |
| +----------------------------------------------------------------------------+ |
+--------------------------------------------------------------------------------+
```

**Acceptance Criteria**

- Related AC: `AC-HIST-003`, `AC-HIST-004`, `AC-HIST-005`

---

## 9. Search / Query Specification

### 9.1 Query Rules

Condition: Main screen target list phải load từ `TMT331_CSVSCREEN` với screen condition của `SPCM00021`.

Condition: Inquiry screen target list phải load từ `TMT331_CSVSCREEN` với screen condition của `SPVW00081`.

Condition: Inquiry `取込形式` phải load từ `TMT050_NAME` với `RCDKBN = 0126`.

Condition: Inquiry `取込ステータス` phải load từ `TMT050_NAME` với `RCDKBN = 0125`.

Condition: Popup default-value grid phải load từ `TMT332_CSVLAYOUT` theo target được chọn trên main screen.

Condition: Main header result phải lấy từ `TWK003_CSVIMPHISTORYHEADER` theo `selectedTarget`.

Condition: Inquiry search phải lấy từ `TWK003_CSVIMPHISTORYHEADER` và filter bởi các search conditions đang nhập.

Condition: Detail drill-down phải lấy từ `TWK004_CSVIMPHISTORYDETAIL` theo `CSVIMPNO` và occurrence type do user click.

Condition: Upload phải dùng target-specific table edit specs, không được lấy dữ liệu trực tiếp từ grid render.

### 9.2 Main Screen Query Rules

| Purpose | Data Source | Filters / Conditions | Output | Notes |
|---|---|---|---|---|
| Load target options | `TMT331_CSVSCREEN` | `SCREENID = 'SPCM00021'` | Target dropdown | Actual value/display mapping is implementation responsibility. |
| Load main precheck result | `TWK003_CSVIMPHISTORYHEADER` | `SCREENID = selectedTargetScreenId or equivalent target key` | Header grid | Exact sort order not described. |
| Load main detail on `エラー数` click | `TWK004_CSVIMPHISTORYDETAIL` | `CSVIMPNO = selectedImportNo` and occurrence = error | Detail grid | Event list also references `発生区分フラグ`. |
| Load main detail on `警告数` click | `TWK004_CSVIMPHISTORYDETAIL` | `CSVIMPNO = selectedImportNo` and occurrence = warning | Detail grid | Exact flag field name not explicitly shown on UI. |

### 9.3 Inquiry Screen Query Rules

| Purpose | Data Source | Filters / Conditions | Output | Notes |
|---|---|---|---|---|
| Load target list | `TMT331_CSVSCREEN` | `SCREENID = 'SPVW00081'` | Dropdown `取込対象データ` | |
| Load `取込形式` | `TMT050_NAME` | `RCDKBN = 0126` | Dropdown | |
| Load `取込ステータス` | `TMT050_NAME` | `RCDKBN = 0125` | Dropdown | |
| Search history | `TWK003_CSVIMPHISTORYHEADER` | `取込番号`, `selectedTarget`, `取込形式`, `取込ステータス`, `取込実施者` (partial), `取込日時 from/to` | Header grid | Date boundary inclusiveness is non-inferable. |
| Search detail | `TWK004_CSVIMPHISTORYDETAIL` | `CSVIMPNO`, occurrence type | Detail grid | Triggered from error/warning links. |

### 9.4 Popup / Precheck Query Rules

| Purpose | Data Source | Filters / Conditions | Output | Notes |
|---|---|---|---|---|
| Load field layout | `TMT332_CSVLAYOUT` | Current target | Default-value grid | Includes required flag, datatype, default, key flag, reference table, reference item, format. |
| Persist precheck header | `TWK003_CSVIMPHISTORYHEADER` | New import execution context | Header row | Generated during popup `実行`. |
| Persist precheck detail | `TWK004_CSVIMPHISTORYDETAIL` | Per CSV row | Detail rows | Generated during popup `実行`. |

### 9.5 Upload Query Rules

| Target | Tables / Conditions | Notes |
|---|---|---|
| `①発注依頼マスタ` | `TAOR65_ORDERREQUESTMASTER` insert/update path | Key-based update or insert according to `取込形式`. |
| `②利益センタマスタ` | `TMT050_NAME` insert/update path; delete references generic name-master delete sheet | Delete branch requires technical confirmation. |
| `③調達品マスタ` | `TMT026_PRODUCT` insert/update path | Update branch keeps some fields unchanged per edit spec. |
| `④調達品契約マスタ` | `TAMT026_PRODUCTAGREEMENT` insert/update path | Update branch keeps key/identity fields unchanged. |
| `⑤仕入先マスタ` | Multi-table routing across partner/payment/user/auth/mail tables | Branch condition depends on effective date and change pattern. |
| `⑥仕入先工場マスタ` | Multi-table routing across partner store/shop account tables | Branch condition depends on effective date and bank account changes. |
| `⑦セクションマスタ` | `TAMT030_SECTION` | Direct reflect. |
| `⑧グループマスタ` | `TAMT029_GROUP` | Direct reflect. |
| `⑨ユーザーマスタ` | `TAMT002_USERCSV` | Staging only. |
| `⑩組織マスタ` | `TAMT039_ORGANIZATIONCSV` | Staging only. |

### 9.6 Paging Rules

Condition: Paging action được mô tả là common function trên cả main và inquiry screen.

- Header paging: supported
- Detail paging: supported where result exceeds page size
- Exact page size: `Non-inferable from current artifacts`
- Exact sort order of header/detail grids: `TBD based on source artifacts`

### 9.7 SQL Reference Status

- Literal SQL statements: `TBD based on source artifacts`
- Workbook evidence available: table/field mapping and filter source only
- Technical team must derive SQL/ORM implementation from table edit specifications and query rules above

---

## 10. Output Specification

### 10.1 Precheck Output to Work Tables

Condition: Popup `実行` không import thẳng vào target tables; trước hết phải tạo work header/detail.

Flow:

1. Parse CSV file
2. Validate file presence and data presence
3. Resolve selected target layout từ `TMT332_CSVLAYOUT`
4. Validate từng dòng CSV
5. Tạo summary record vào `TWK003_CSVIMPHISTORYHEADER`
6. Tạo detail rows vào `TWK004_CSVIMPHISTORYDETAIL`
7. Return về main screen để hiển thị kết quả

Pre-checks:

- File attached
- Extension = CSV
- File contains data
- Có `有効なデータ` theo selected policy nếu policy yêu cầu

Popup flow:

- `戻る` -> close popup, no persistence
- `実行` -> run precheck and persist result

No-data / no-valid-data handling:

- Empty CSV data -> `ME100042`
- Không có valid row -> `ME200031`

Transaction notes:

- Transaction boundary của precheck persistence không được workbook mô tả đầy đủ
- Recommended implementation boundary: persist `TWK003` và `TWK004` cùng một transaction

Rollback behavior:

- `TBD based on source artifacts`

### 10.2 Upload to Target Tables

Condition: Upload chỉ được phép từ work data đã precheck.

Flow:

1. Xác định `selectedImportNo` / selected staged dataset
2. Xác định `selectedTarget`
3. Xác định `popupImportType`
4. Xác định target-specific branch
5. Reflect vào bảng đích / staging table
6. Update import status

Pre-checks before upload:

- `ERRORCNT = 0`
- `WARNINGCNT = 0`
- `IMPSTATUS = 未完了`

Target-specific reflection rules:

- `①`, `②`, `③`, `④`, `⑦`, `⑧`: direct reflect vào table đích
- `⑤`: multi-table branch theo effective date và change pattern
- `⑥`: multi-table branch theo effective date và bank-account change pattern
- `⑨`: save vào `TAMT002_USERCSV`, không update final user master trực tiếp
- `⑩`: save vào `TAMT039_ORGANIZATIONCSV`, không update final organization master trực tiếp

File boundary notes:

- Không có file output nào ở feature này; "output" ở đây là output vào DB tables/work tables

Transaction notes:

Condition: `⑤仕入先マスタ` và `⑥仕入先工場マスタ` có multi-table update; implementation phải coi đây là transaction-sensitive path.

- Commit/rollback granularity chi tiết: `Non-inferable from current artifacts`
- Recommended implementation location: service layer per target branch

### 10.3 Target-specific Routing Summary

| Target | Branch Summary | Expected implementation location |
|---|---|---|
| `①発注依頼マスタ` | Insert/update `TAOR65_ORDERREQUESTMASTER` | `import/order-request service` |
| `②利益センタマスタ` | Insert/update/delete `TMT050_NAME` | `import/name-master service` |
| `③調達品マスタ` | Insert/update `TMT026_PRODUCT` | `import/product service` |
| `④調達品契約マスタ` | Insert/update `TAMT026_PRODUCTAGREEMENT` | `import/product-agreement service` |
| `⑤仕入先マスタ` | Multi-table branch by effective date / account / password change | `import/partner orchestration service` |
| `⑥仕入先工場マスタ` | Multi-table branch by effective date / bank account change | `import/partner-store orchestration service` |
| `⑦セクションマスタ` | Direct reflect `TAMT030_SECTION` | `import/section service` |
| `⑧グループマスタ` | Direct reflect `TAMT029_GROUP` | `import/group service` |
| `⑨ユーザーマスタ` | Save to `TAMT002_USERCSV` only | `import/user-staging service` |
| `⑩組織マスタ` | Save to `TAMT039_ORGANIZATIONCSV` only | `import/organization-staging service` |

---

## 11. Validation & Messages

### 11.1 Validation Rules

| Event | Condition | Message | Notes |
|---|---|---|---|
| `open_default_settings` | `データファイル名` not specified | `ME000005` | Message arg = `CSVファイル` |
| `open_default_settings` | Selected file extension is not CSV | `MEA00003` | No arg |
| `run_precheck` | CSV file has no data | `ME100042` | Popup execution |
| `run_precheck` | No valid data remains after precheck outcome | `ME200031` | Popup execution |
| `run_precheck` | CSV contains error/warning and selected policy forbids reflection | `ME200030` | Exact branch partially ambiguous |
| `run_precheck` | Partial reflect path has some rows skipped due error/warning | `ME000122` | Exact branch partially ambiguous |
| `search_import_history` | No history matches filters | `MI000001` | Inquiry screen only |
| `open_error_detail` / `open_warning_detail` | Missing `selectedImportNo` | `Unresolved ambiguity` | UI selection mechanism not explicit |
| `upload_csv_data` | `ERRORCNT > 0` or `WARNINGCNT > 0` or `IMPSTATUS != 未完了` | Upload must remain disabled | No explicit message code in source |

### 11.2 Business/System Messages

| Code | Message | When Used |
|---|---|---|
| `ME000005` | `TBD based on source artifacts` | `データファイル名` not specified on `事前チェック` |
| `MEA00003` | `TBD based on source artifacts` | File extension is not CSV |
| `ME100042` | `TBD based on source artifacts` | CSV file contains no data |
| `ME200031` | `TBD based on source artifacts` | No valid data after precheck |
| `ME200030` | `TBD based on source artifacts` | Error/warning exists and selected policy forbids reflection |
| `ME000122` | `TBD based on source artifacts` | Some rows skipped / partial reflect outcome |
| `MI000001` | `TBD based on source artifacts` | Inquiry search returns no data |

### 11.3 Row-level Validation Categories

Condition: Popup `実行` phải kiểm tra tối thiểu các category sau cho từng row CSV:

1. `レイアウトエラーチェック`
2. `キー重複警告チェック`
3. `必須抜けエラーチェック`
4. `データ型不正エラーチェック`
5. `桁数不正エラーチェック`
6. `フォーマットエラーチェック`
7. `参照マスタ不在警告チェック`

Condition: Nếu một row vừa có error vừa có warning thì `発生区分` phải hiển thị `エラー`.

Condition: `ラジオチェックボックス不在エラー` và `その他エラー` tồn tại trong detail schema nhưng source event sheet không mô tả rõ điểm phát sinh; implementation phải giữ extensibility cho 2 category này.

---

## 12. Acceptance Criteria

AC-COMMON-001: Khi user có quyền `更新可能` mở `SPCM00021`, hệ thống phải load danh sách `取込対象データ` từ `TMT331_CSVSCREEN`, set default target là `発注依頼マスタ`, và khởi tạo `【明細領域】` rỗng.

AC-COMMON-002: Khi user có quyền `閲覧のみ`, hệ thống chỉ cho phép hiển thị và lọc dữ liệu; user không được phép thực hiện precheck hoặc upload làm thay đổi dữ liệu.

AC-MAIN-001: Khi user click `データファイル名_ファイル選択` và chọn file thành công, hệ thống phải hiển thị chính xác tên file tại `データファイル名` ở trạng thái read-only.

AC-MAIN-002: Khi `データファイル名` chưa có giá trị và user click `事前チェック`, hệ thống phải giữ nguyên main screen và hiển thị `ME000005`.

AC-MAIN-003: Khi file được chọn không có phần mở rộng CSV và user click `事前チェック`, hệ thống phải giữ nguyên main screen và hiển thị `MEA00003`.

AC-MAIN-004: Khi user đổi `取込対象データ`, hệ thống phải tải lại `【事前チェック結果】` theo target mới và xóa dữ liệu `【明細領域】` hiện có.

AC-MAIN-005: Khi user click `取込履歴表示`, hệ thống phải điều hướng tới `SPVW00081` và auto-fill các search condition tương ứng mà source cho phép suy ra.

AC-POPUP-001: Khi popup `デフォルト設定` mở, radio `UPDATE + INSERT` và `一切データ反映しない` phải ở trạng thái ON theo default.

AC-POPUP-002: Khi popup mở, grid `【デフォルト値領域】` phải load từ `TMT332_CSVLAYOUT` theo target đang chọn trên main screen.

AC-POPUP-003: Khi file CSV không có data và user click `実行`, hệ thống phải hiển thị `ME100042` và không tạo record precheck mới.

AC-POPUP-004: Khi popup `実行` thành công, hệ thống phải tạo một header record ở `TWK003_CSVIMPHISTORYHEADER` và các detail rows tương ứng ở `TWK004_CSVIMPHISTORYDETAIL`.

AC-POPUP-005: Khi precheck hoàn tất, hệ thống phải quay về main screen và refresh `【事前チェック結果】` để hiển thị summary của lần precheck vừa chạy.

AC-POPUP-006: Khi một row CSV đồng thời có error và warning, `発生区分` của row đó phải hiển thị `エラー`.

AC-MAIN-006: Khi user click `エラー数` hoặc `警告数` của một `取込番号`, hệ thống phải chỉ hiển thị detail rows thuộc đúng `CSVIMPNO` đó và đúng occurrence type được click.

AC-UPLOAD-001: Hệ thống chỉ được enable `Upload` khi precheck result thỏa đồng thời `エラー数 = 0`, `警告数 = 0`, và `更新ステータス = 未完了`.

AC-UPLOAD-002: Khi `Upload` được thực thi, hệ thống phải dùng dữ liệu đã lưu ở work tables của lần precheck tương ứng; không được import trực tiếp từ raw CSV mà bỏ qua staging.

AC-UPLOAD-003: Với target `①発注依頼マスタ`, `②利益センタマスタ`, `③調達品マスタ`, `④調達品契約マスタ`, `⑦セクションマスタ`, `⑧グループマスタ`, hệ thống phải phản ánh dữ liệu vào đúng bảng đích được nêu trong table edit specifications của target tương ứng.

AC-UPLOAD-004: Với target `⑤仕入先マスタ`, hệ thống phải chọn đúng branch multi-table theo điều kiện effective date và pattern thay đổi (payment account/password) như workbook đã chia section.

AC-UPLOAD-005: Với target `⑥仕入先工場マスタ`, hệ thống phải chọn đúng branch multi-table theo điều kiện effective date và việc có thay đổi振込口座 hay không như workbook đã chia section.

AC-UPLOAD-006: Với target `⑨ユーザーマスタ`, `Upload` phải ghi vào `TAMT002_USERCSV` và không cập nhật final user master trực tiếp trên màn hình này.

AC-UPLOAD-007: Với target `⑩組織マスタ`, `Upload` phải ghi vào `TAMT039_ORGANIZATIONCSV` và không cập nhật final organization master trực tiếp trên màn hình này.

AC-HIST-001: Khi mở `SPVW00081`, hệ thống phải set default `取込対象データ = 発注依頼マスタ`, `取込形式 = -- 選択 --`, `取込ステータス = -- 選択 --`, `取込日時（from） = 当日`, `取込日時（to） = 当日`.

AC-HIST-002: Khi user nhập điều kiện tìm kiếm trên inquiry screen và click `表示`, hệ thống phải search `TWK003_CSVIMPHISTORYHEADER` theo các filter hiện tại và giữ nguyên các filter đó sau search.

AC-HIST-003: Khi inquiry search không trả về bản ghi nào, hệ thống phải hiển thị `MI000001`.

AC-HIST-004: Khi user click `クリア` trên inquiry screen, hệ thống phải reset toàn bộ search conditions về initial values và xóa cả header/detail result.

AC-HIST-005: Khi user click `エラー数` hoặc `警告数` trong inquiry header result, hệ thống phải drill-down sang `TWK004_CSVIMPHISTORYDETAIL` cho đúng `CSVIMPNO` và đúng occurrence type.

AC-BOUNDARY-001: Khi source workbook không cung cấp SQL literal, implementation vẫn phải bám đúng bảng, filter logic, và target mapping đã được đặc tả trong spec này; literal SQL remains `TBD based on source artifacts`.

---

## 13. Trace Mapping

| Requirement ID | Logic / rule | SQL / condition / table related if any | Expected implementation location |
|---|---|---|---|
| `REQ-COMMON-001` | Load target list on main open | `TMT331_CSVSCREEN`, `SCREENID='SPCM00021'` | `main-screen initialization service` |
| `REQ-COMMON-002` | Load target list on inquiry open | `TMT331_CSVSCREEN`, `SCREENID='SPVW00081'` | `inquiry-screen initialization service` |
| `REQ-MAIN-001` | File selection populates read-only file name | Main UI field `データファイル名` | `main-screen UI controller` |
| `REQ-MAIN-002` | Validate file required before opening popup | Condition: file missing -> `ME000005` | `main-screen validation handler` |
| `REQ-MAIN-003` | Validate file extension is CSV | Condition: extension != csv -> `MEA00003` | `main-screen validation handler` |
| `REQ-POPUP-001` | Load popup default grid by target | `TMT332_CSVLAYOUT` | `popup initialization service` |
| `REQ-POPUP-002` | Precheck row validation categories | `TWK004_CSVIMPHISTORYDETAIL` error fields | `csv precheck engine` |
| `REQ-POPUP-003` | Persist precheck summary/detail | `TWK003_CSVIMPHISTORYHEADER`, `TWK004_CSVIMPHISTORYDETAIL` | `precheck persistence service` |
| `REQ-MAIN-004` | Upload enablement logic | Condition: `ERRORCNT=0`, `WARNINGCNT=0`, `IMPSTATUS=未完了` | `main-screen state evaluator` |
| `REQ-UPLOAD-001` | Direct target import for ①/②/③/④/⑦/⑧ | Target tables from edit specs | `target-specific import services` |
| `REQ-UPLOAD-002` | Multi-table branch for ⑤ | `TMT023_PARTNER`, `TMT067_PAYMENTINFO`, `TMT002_USER`, `TMT210_FNCAUTH`, `TSM110_FNCAUTHGROUP`, `TAMT042_EMAILBODY`, `TMT050_NAME`, `TMT077/078/079` | `partner import orchestration service` |
| `REQ-UPLOAD-003` | Multi-table branch for ⑥ | `TAMT024_PARTNERSTORE`, `TMT068_SHOPACCOUNT` | `partner-store import orchestration service` |
| `REQ-UPLOAD-004` | ⑨ staging-only reflection | `TAMT002_USERCSV` | `user-csv staging service` |
| `REQ-UPLOAD-005` | ⑩ staging-only reflection | `TAMT039_ORGANIZATIONCSV` | `organization-csv staging service` |
| `REQ-HIST-001` | Inquiry search by filters | `TWK003_CSVIMPHISTORYHEADER`, filters from `取込番号`, `取込形式`, `取込ステータス`, `取込実施者`, date range | `history search service` |
| `REQ-HIST-002` | Inquiry detail drill-down | `TWK004_CSVIMPHISTORYDETAIL`, `CSVIMPNO`, occurrence flag | `history detail service` |
| `REQ-AUTH-001` | Respect `使用不可` / `更新可能` / `閲覧のみ` | Permission master rule, exact table unknown | `authorization guard` |
| `REQ-BND-001` | Keep SQL literal TBD when source missing | `Non-inferable from current artifacts` | `technical refinement backlog` |

---

## 14. Test Scenarios

SC-MAIN-001
- Input:
  - User role = `更新可能`
  - Open `SPCM00021`
- Steps:
  1. Open main screen.
  2. Observe default field values and result areas.
- Expected Result:
  - `取込対象データ` defaults to `発注依頼マスタ`.
  - `データファイル名` is empty and read-only.
  - `【明細領域】` is empty.
  - Target list is loaded from `TMT331_CSVSCREEN`.

SC-MAIN-002
- Input:
  - `データファイル名` empty
- Steps:
  1. On main screen click `事前チェック`.
- Expected Result:
  - Popup does not open.
  - `ME000005` is shown.

SC-MAIN-003
- Input:
  - Attached file `sample.txt`
- Steps:
  1. Select `sample.txt`.
  2. Click `事前チェック`.
- Expected Result:
  - Popup does not open.
  - `MEA00003` is shown.

SC-POPUP-001
- Input:
  - Attached CSV file with at least 1 valid row
- Steps:
  1. Click `事前チェック`.
  2. Confirm popup defaults.
  3. Click `実行`.
- Expected Result:
  - Popup loads target-specific default-value grid.
  - Default radios are ON as designed.
  - `TWK003` and `TWK004` records are created.
  - Main screen refreshes and shows a new precheck result row.

SC-POPUP-002
- Input:
  - Empty CSV file
- Steps:
  1. Open popup.
  2. Click `実行`.
- Expected Result:
  - `ME100042` is shown.
  - No new precheck header/detail record is created.

SC-MAIN-004
- Input:
  - Precheck result row with `ERRORCNT > 0`
- Steps:
  1. Observe main `【事前チェック結果】`.
  2. Check `Upload` state.
  3. Click `エラー数`.
- Expected Result:
  - `Upload` remains disabled.
  - Detail grid loads only error rows for selected `取込番号`.

SC-UPLOAD-001
- Input:
  - Precheck result row with `ERRORCNT = 0`, `WARNINGCNT = 0`, `IMPSTATUS = 未完了`
- Steps:
  1. Observe main result row.
  2. Click `Upload`.
- Expected Result:
  - `Upload` is enabled before click.
  - Import runs against staged/work data, not raw CSV.
  - Status is updated after import.

SC-UPLOAD-002
- Input:
  - Target = `⑨ユーザーマスタ`
  - Clean precheck result exists
- Steps:
  1. Run `Upload`.
  2. Verify persistence target.
- Expected Result:
  - Data is written to `TAMT002_USERCSV`.
  - Final user master is not directly updated from this screen.

SC-HIST-001
- Input:
  - Open `SPVW00081`
- Steps:
  1. Open inquiry screen.
  2. Observe default filters.
  3. Click `クリア`.
- Expected Result:
  - Defaults are set as designed on initial load.
  - `クリア` returns all conditions to the same default values and clears header/detail results.

SC-HIST-002
- Input:
  - Search conditions that do not match any history
- Steps:
  1. Enter non-existing search filters.
  2. Click `表示`.
- Expected Result:
  - `MI000001` is shown.
  - Existing filter values remain on screen.

SC-HIST-003
- Input:
  - History result row with non-zero `警告数`
- Steps:
  1. Search history.
  2. Click `警告数` on a result row.
- Expected Result:
  - Detail grid loads only warning rows for that `CSVIMPNO`.

---

## 15. Forbidden Behavior

Condition: Khi user có quyền `閲覧のみ`, hệ thống không được cho phép chạy `事前チェック`, `実行` trong popup, hoặc `Upload`.

Condition: Hệ thống không được cho phép mở popup `デフォルト設定` nếu `データファイル名` chưa có hoặc file không phải CSV.

Condition: Hệ thống không được enable `Upload` khi `エラー数 > 0`, `警告数 > 0`, hoặc `更新ステータス != 未完了`.

Condition: Hệ thống không được import trực tiếp từ raw CSV vào target tables mà bỏ qua `TWK003_CSVIMPHISTORYHEADER` và `TWK004_CSVIMPHISTORYDETAIL`.

Condition: Hệ thống không được drill-down detail vượt ra ngoài `CSVIMPNO` và occurrence type mà user vừa chọn.

Condition: Với target `⑨ユーザーマスタ` và `⑩組織マスタ`, hệ thống không được update trực tiếp final master trên màn hình này.

Condition: `クリア` trên inquiry screen không được giữ lại header/detail result cũ.

Condition: `戻る` trên popup không được tạo precheck result mới hoặc cập nhật status của import trước đó.

Condition: Implementation không được bỏ qua target-specific branch logic của `⑤仕入先マスタ` và `⑥仕入先工場マスタ`.

---

## 16. Open Questions / Assumptions

### Confirmed assumptions

- Assumption: Main screen, popup, và inquiry screen thuộc cùng feature `FPCM0002`.
- Assumption: `Upload` là action tồn tại thực sự trên main screen dù item definition không có row button riêng, vì event sheet và state note đều tham chiếu tới nó.
- Assumption: `取込対象データ` display value được resolve sang internal target key/screen id thông qua `TMT331_CSVSCREEN`.

### Unresolved ambiguities

Ambiguity:
Cơ chế chọn chính xác `取込番号` nào để `Upload` khi main grid có nhiều row không được định nghĩa tường minh trong item definition/layout text.

Impact:
Nếu implementation chọn sai row context, dữ liệu staging bị import nhầm.

Handling:
Spec này giả định implementation phải ràng buộc `Upload` với precheck result hiện hành/được chọn trong context UI và phải xác minh lại ở technical refinement.

Risk:
Sai target row import, dẫn tới phản ánh nhầm dữ liệu vào bảng đích.

Ambiguity:
Nút `Upload` không có row định nghĩa riêng trong `【画面項目定義】汎用CSV取込`, nhưng event `IV0005` và note ở field `状態` lại tham chiếu `Uploadボタン`.

Impact:
Label, vị trí, selection behavior và enable/disable rendering có thể lệch giữa spec và UI thật.

Handling:
Spec vẫn mô hình hóa `Upload` là footer/main action bắt buộc vì event-level evidence mạnh hơn sự thiếu vắng của item row.

Risk:
Front-end implementation cần điều chỉnh layout chi tiết khi có source UI chính xác hơn.

Ambiguity:
Cột `状態` được map về `CSVワークヘッダ`.`更新設定`, nhưng layout sample không hiển thị value mẫu tương ứng.

Impact:
User-facing label/meaning của cột này có thể bị hiểu sai là status thay vì import setting.

Handling:
Spec giữ mapping gốc từ workbook và xem cột này là hiển thị `更新設定`; exact display text remains unresolved.

Risk:
Sai nghĩa business label ở UI hoặc API response.

Ambiguity:
Item definition có `フォーマットエラー` nhưng sample layout text của detail grid không hiển thị rõ cột này.

Impact:
UI grid detail có thể thiếu một cột so với data schema.

Handling:
Spec ưu tiên item definition và detail schema, đồng thời ghi nhận mâu thuẫn layout là unresolved ambiguity.

Risk:
Khác biệt giữa UI thiết kế và data contract.

Ambiguity:
Notes của `取込対象データ` trong một số sheet còn nhắc `⑪個別権限`, trong khi layout revision note ghi target này đã bị xóa.

Impact:
Nếu implementation vẫn giữ `⑪`, dropdown target sẽ lệch so với scope đã chỉnh sửa.

Handling:
Spec chỉ giữ ①-⑩ là active targets.

Risk:
Import target list sai phạm vi release.

### Non-inferable items

- Non-inferable from current artifacts: SQL literal cho main search, inquiry search, detail search, upload execution
- Non-inferable from current artifacts: exact page size và default sort order
- Non-inferable from current artifacts: transaction commit/rollback granularity cho từng target, đặc biệt multi-table targets
- Non-inferable from current artifacts: full message text body tương ứng các message codes
- Non-inferable from current artifacts: exact date comparison semantics for inquiry `取込日時（from/to）`

### Explicit boundaries

- Boundary: Batch phản ánh `TAMT002_USERCSV` và `TAMT039_ORGANIZATIONCSV` sang final master intentionally left outside this spec.
- Boundary: Permission master storage table/object name intentionally left `unknown`.
- Boundary: SQL generation strategy intentionally left `TBD based on source artifacts`.

---

## 17. Developer Notes

- Resolve `取込対象データ` bằng internal code/screen mapping; không hardcode theo display text.
- Tách rõ 3 lớp logic:
  - UI orchestration
  - Precheck engine + staging persistence
  - Target-specific upload services
- Dùng common paging utility cho main và inquiry để bám event description `共通関数として処理`.
- Xây validator theo metadata từ `TMT332_CSVLAYOUT` + target item definition sheets, tránh hardcode field list trong UI.
- Với `⑤仕入先マスタ` và `⑥仕入先工場マスタ`, cần orchestration service riêng vì workbook mô tả nhiều branch multi-table.
- Với `⑨` và `⑩`, service phải dừng ở staging insert; mọi direct update final master là out of scope.
- Nên lưu lại source trace theo target/sheet/row block để support maintenance và regression debugging.

---

## Appendix A. Source Mapping

| Spec Area | Source Artifact | Sheet / Row / Note |
|---|---|---|
| Main screen identity | Workbook | `【画面レイアウト】汎用CSV取込` rows 3-4 |
| Main permission rule | Workbook | `【画面レイアウト】汎用CSV取込` rows 44-47 |
| Main function summary | Workbook | `【画面レイアウト】汎用CSV取込` rows 48-62 |
| Main field definitions | Workbook | `【画面項目定義】汎用CSV取込` rows 7-40 |
| Main events | Workbook | `【イベント一覧】汎用CSV取込` rows 6-30 |
| Main validation codes | Workbook | `【エラーチェック】汎用CSV取込` rows 6-8 |
| Main init/header query mapping | Workbook | `テーブル編集仕様(汎用CSV取込) (初期表示)` rows 6-48 |
| Main detail query mapping | Workbook | `テーブル編集仕様(汎用CSV取込) (明細)` rows 6-36 |
| Inquiry screen identity | Workbook | `【画面レイアウト】汎用CSV取込照会` rows 3-4 |
| Inquiry permission/function summary | Workbook | `【画面レイアウト】汎用CSV取込照会` rows 50-67 |
| Inquiry field definitions | Workbook | `【画面項目定義】汎用CSV取込照会` rows 7-42 |
| Inquiry events | Workbook | `【イベント一覧】汎用CSV取込照会` rows 6-23 |
| Inquiry no-data message | Workbook | `【エラーチェック】汎用CSV取込照会` row 7 |
| Inquiry init master loading | Workbook | `テーブル編集仕様(汎用CSV取込照会) (初期表示)` rows 6-24 |
| Inquiry search filter mapping | Workbook | `テーブル編集仕様(汎用CSV取込照会) (データ取得)` rows 6-42 |
| Popup screen identity | Workbook | `【画面レイアウト】デフォルト設定` rows 3-4 |
| Popup function summary | Workbook | `【画面レイアウト】デフォルト設定` rows 63-69 |
| Popup field definitions | Workbook | `【画面項目定義】デフォルト設定` rows 7-28 |
| Popup events | Workbook | `【イベント一覧】デフォルト設定` rows 6-28 |
| Popup message codes | Workbook | `【エラーチェック】デフォルト設定` rows 7-10 |
| Popup layout metadata source | Workbook | `テーブル編集仕様(デフォルト設定) (初期表示)` rows 6-36 |
| Precheck persistence target | Workbook | `テーブル編集仕様(デフォルト設定) (実行)` rows 6-222 |
| Target list ①-⑩ | Workbook | `【画面項目定義】汎用CSV取込` row 8 note, `【画面項目定義】汎用CSV取込照会` row 8 note |
| Target ① direct import | Workbook | `【CSV取込項目定義】①発注依頼マスタ`, `テーブル編集仕様(汎用CSV) (①発注依頼マスタ)` |
| Target ② direct import | Workbook | `【CSV取込項目定義】②利益センタマスタ`, `テーブル編集仕様(汎用CSV) (②利益センタマスタ)` |
| Target ③ direct import | Workbook | `【CSV取込項目定義】③調達品マスタ`, `テーブル編集仕様(汎用CSV取込) (③調達品)` |
| Target ④ direct import | Workbook | `【CSV取込項目定義】④調達品契約マスタ`, `テーブル編集仕様(汎用CSV取込) (④調達品契約マスタ)` |
| Target ⑤ branch import | Workbook | `【CSV取込項目定義】⑤仕入先マスタ`, `テーブル編集仕様(汎用CSV) (⑤仕入先)` |
| Target ⑥ branch import | Workbook | `【CSV取込項目定義】⑥仕入先工場マスタ`, `テーブル編集仕様(汎用CSV) (⑥仕入先工場)` |
| Target ⑦ direct import | Workbook | `【CSV取込項目定義】⑦セクションマスタ`, `テーブル編集仕様(⑦セクションマスタ)` |
| Target ⑧ direct import | Workbook | `【CSV取込項目定義】⑧グループマスタ`, `テーブル編集仕様(⑧グループマスタ)` |
| Target ⑨ staging only | Workbook | `【CSV取込項目定義】⑨ユーザーマスタ（削除）`, `テーブル編集仕様(⑨ユーザーマスタ)` |
| Target ⑩ staging only | Workbook | `【CSV取込項目定義】⑩組織マスタ（削除）`, `テーブル編集仕様(⑩組織マスタ）` |
| Generic name master delete branch | Workbook | `テーブル編集仕様(名称マスタ）削除` |

---

## Appendix B. SQL / Table Reference

### B.1 Shared Tables

| Table | Purpose |
|---|---|
| `TMT331_CSVSCREEN` | CSV screen/target catalog for dropdown lists |
| `TMT332_CSVLAYOUT` | CSV layout metadata, default values, datatype, length, key, reference table/item |
| `TWK003_CSVIMPHISTORYHEADER` | Precheck/import history header |
| `TWK004_CSVIMPHISTORYDETAIL` | Precheck/import history detail |
| `TMT050_NAME` | Name master for `取込形式`, `取込ステータス`, and some target imports |

### B.2 Target Tables by Import Target

| Target | Table Reference |
|---|---|
| `①発注依頼マスタ` | `TAOR65_ORDERREQUESTMASTER` |
| `②利益センタマスタ` | `TMT050_NAME` |
| `③調達品マスタ` | `TMT026_PRODUCT` |
| `④調達品契約マスタ` | `TAMT026_PRODUCTAGREEMENT` |
| `⑤仕入先マスタ` | `TMT023_PARTNER`, `TMT067_PAYMENTINFO`, `TMT002_USER`, `TMT210_FNCAUTH`, `TSM110_FNCAUTHGROUP`, `TAMT042_EMAILBODY`, `TMT050_NAME`, `TMT077_EMAILDESTINATIONSETTO`, `TMT078_EMAILDESTINATIONSETCC`, `TMT079_EMAILDESTINATIONSETBCC` |
| `⑥仕入先工場マスタ` | `TAMT024_PARTNERSTORE`, `TMT068_SHOPACCOUNT` |
| `⑦セクションマスタ` | `TAMT030_SECTION` |
| `⑧グループマスタ` | `TAMT029_GROUP` |
| `⑨ユーザーマスタ` | `TAMT002_USERCSV` |
| `⑩組織マスタ` | `TAMT039_ORGANIZATIONCSV` |

### B.3 SQL Status

- SQL literal: `TBD based on source artifacts`
- Join conditions, where clauses, sort clauses, and transaction SQL need to be concretized during technical design
- This appendix intentionally preserves table references and target boundaries from workbook evidence only
