# Spec Pack

## 1. Feature Overview

Màn hình `仕入先発注入力` dùng để tìm kiếm, xem, chọn, cập nhật trạng thái, mở chi tiết nhập liệu, đăng ký mới, và xác nhận dữ liệu `仕入先発注` dựa trên các dữ liệu `ANAC発注依頼`.
Đây là 1 base screen có các trạng thái chính sau:

- Init state: mở màn hình lần đầu hoặc sau `クリア`
- Search state: đã bấm `表示` và hiển thị danh sách kết quả
- Trash search state: đang xem tập dữ liệu `ゴミ箱`
- Existing detail edit state: mở 1 dòng từ link `発注番号` để sửa ở vùng `【入力】`
- New detail state: bấm `新規` để nhập mới ở vùng `【入力】`

Condition: nghiệp vụ chỉ được dùng đầy đủ khi người dùng có quyền `更新可能`.
Condition: người dùng có quyền `閲覧のみ` chỉ được xem màn hình và thực hiện lọc/tìm kiếm.
Condition: người dùng có quyền `使用不能` không được phép mở màn hình.

## 2. Background

Màn hình này nằm trong luồng `発注メニュー/納品予定入力` và phục vụ xử lý `個別発注` cho nhà cung cấp.
Workbook cho thấy màn hình vừa có vùng tìm kiếm danh sách, vừa có vùng `【入力】` để thao tác trên 1 bản ghi hiện hành.

Các rule trọng yếu có bằng chứng trong source:

- Condition: `【検索条件】` yêu cầu bắt buộc `工場`, toàn bộ 3 cặp ngày `発注依頼日`, `発注日`, `納品日`
- Condition: `表示区分 = 締切解除中のみ` thì chỉ lấy các dòng có `グループマスタ.締切解除有効時間 >= 現在日時`
- Condition: sau `表示`, nếu thời điểm hiện tại vượt `名称マスタ(3033)` `承認締め切り時間`, toàn bộ vùng nhập mặc định bị khóa; riêng các dòng đang nằm trong `締切解除` vẫn có thể thao tác
- Condition: dòng kết quả đang `締切解除中` phải được đưa lên đầu danh sách và hiển thị màu đỏ
- Condition: dòng có `ANAC発注依頼ファイル.アラーム内容 != NULL` phải hiển thị màu đỏ
- Condition: nút `ゴミ箱` có 2 ngữ nghĩa nghiệp vụ: chuyển vào `ゴミ箱` khi không ở view `ゴミ箱`, hoặc khôi phục về `仕入先発注画面` khi đang ở view `ゴミ箱`
- Condition: ở vùng `【入力】`, khi mở từ link `発注番号` của kết quả tìm kiếm thì chỉ `発注数` được sửa
- Condition: ở vùng `【入力】`, khi bấm `新規` thì chỉ các trường có khả năng nhập mới mới được mở nhập
- Condition: `発注金額 = 発注数 x 発注単価`
- Condition: nút `更新` không phải update đơn giản vùng nhập; đây là xử lý chọn nhiều dòng để tạo `ANAC発注` / `納品予定ファイル` và cập nhật trạng thái `発注済`
- Condition: nút `確定` là lưu bản ghi hiện hành của vùng `【入力】` vào `TAOR59_ANACORDERREQUEST` theo nhánh update hoặc insert

Boundary: workbook không cung cấp SQL text hoàn chỉnh; chỉ cung cấp `テーブル編集仕様` và điều kiện lọc/cập nhật theo bảng.
Boundary: nội dung message text không được cung cấp; chỉ có message code và điều kiện sử dụng.

## 3. Scope

### In Scope

- Khởi tạo toàn bộ `【検索条件】` và vùng `【入力】`
- Tìm kiếm dữ liệu `ANAC発注依頼`
- Hiển thị kết quả, phân trang, tổng hợp `アラート件数`, `支払予定額（税抜）`
- Hiển thị trạng thái `締切解除`
- Chọn toàn bộ / chọn từng dòng
- Mở `セクション検索`, `グループ検索`, `仕入先検索`, `調達品検索`, calendar
- Chuyển dữ liệu vào `ゴミ箱` hoặc khôi phục khỏi `ゴミ箱`
- Xử lý `更新` để tạo dữ liệu phát sinh từ các dòng đã chọn
- Mở chi tiết 1 dòng từ link `発注番号`
- `新規`
- `確定` cho nhánh update hiện có hoặc insert mới
- Validation, alarm, message code, khóa nhập theo deadline, và phân quyền hiển thị

### Out of Scope

- SQL thực thi chi tiết đầy đủ cho mọi event; workbook chỉ cho `テーブル編集仕様`
- Message text của các code
- Kích thước trang phân trang cụ thể
- Cấu trúc vật lý hoặc tên bảng kỹ thuật của đối tượng nghiệp vụ `ANAC発注`
- Quy tắc transaction/rollback mức kỹ thuật chi tiết cho `更新`
- Quy tắc service/API boundary chi tiết giữa UI, application service, repository
- Thiết kế UI cho nút `計算`; nguồn hiện tại cho thấy đã bị xóa khỏi layout nhưng chưa được gỡ hoàn toàn khỏi item/event sheet

## 4. Glossary

| Term | Meaning |
|---|---|
| `工場` | Mã nhà máy/cửa hàng. Trong technical mapping xuất hiện như `店舗コード` / `STORECD`. |
| `セクション` | Bộ phận/section. |
| `グループ` | Group vận hành. Có liên quan `締切解除有効時間`. |
| `発注番号` | Số yêu cầu phát hành trên màn hình. Có ambiguity về format `R` hay `P`. |
| `ステータス` | Nhãn trên item sheet; workbook event/query lại dùng khái niệm gần với `検索対象`. |
| `表示区分` | Radio hiển thị trên layout: `全て` hoặc `締切解除中のみ`. Không có dòng định nghĩa item tương ứng nhưng có dấu vết ở sheet khởi tạo `RCDKBN=3070`. |
| `締切解除` | Trạng thái cho phép thao tác sau giờ deadline nếu `グループマスタ.締切解除有効時間 >= 現在日時`. |
| `ゴミ箱` | Nhóm dữ liệu bị chuyển tạm ra khỏi view thông thường; có thể khôi phục. |
| `ANAC発注依頼ファイル` | Nguồn dữ liệu yêu cầu phát hành chính, technical table: `TAOR59_ANACORDERREQUEST`. |
| `ANAC仕入伝票明細` | Chi tiết nhập hàng; technical table: `TAPR11_ANACPURCHASESLIPDETAIL`. |
| `納品予定ファイル` | Bảng lịch giao hàng; technical table: `TAPR04_SCHEDULEDFORDELIVERYFILE`. |
| `諸口コード対象` | Cờ lấy từ `調達品マスタ`/hợp đồng điều phối, ảnh hưởng nhiều validation và alarm. |
| `依頼区分 = 07` | Giá trị `サンプル`; nhiều validation master/alarm không áp dụng khi giá trị này được chọn. |
| `更新可能 / 閲覧のみ / 使用不能` | 3 mức quyền được mô tả ở layout. |
| `版数` | Version number. Khi update hiện có phải tăng `版数 + 1`; khi insert mới phải set `1`. |

## 5. Base Screen Structure

### 5.1 Screen Identity

- Function ID: `FPOR0110AC`
- Screen ID: `SPOR01101AC`
- Screen Name: `仕入先発注入力`
- Navigation origin: `発注メニュー/納品予定入力`
- Runtime environment: `PC`

### 5.2 Layout Regions

1. Header / Title
2. Search Condition Area `【検索条件】`
3. Search Result Area `【検索結果】`
4. Result Summary Area
5. Result Action Area
6. Input Detail Area `【入力】`

### 5.3 Shared State Variables

| State | Meaning |
|---|---|
| `permissionMode` | `更新可能` / `閲覧のみ` / `使用不能` |
| `factoryCode` | Giá trị `工場` |
| `sectionCode` / `sectionName` | Cặp giá trị section |
| `groupCode` / `groupName` | Cặp giá trị group |
| `searchTargetOrStatus` | Dropdown item sheet gọi là `ステータス`; event/query lại sử dụng như `検索対象` |
| `orderType` | `発注種別` |
| `supplierCode` / `supplierName` | Cặp giá trị supplier |
| `productCode` / `productName` | Cặp giá trị product |
| `requestDateFrom` / `requestDateTo` | Range `発注依頼日` |
| `orderDateFrom` / `orderDateTo` | Range `発注日` |
| `deliveryDateFrom` / `deliveryDateTo` | Range `納品日` |
| `displayDivision` | `全て` / `締切解除中のみ` |
| `deadlineReleaseStatusText` | Nội dung nhãn `締切解除ステータス` |
| `resultRows` | Danh sách kết quả hiện hành |
| `resultCount` | Số lượng kết quả hiện hành |
| `alertCountAllMatched` | Tổng số alert trên toàn bộ tập dữ liệu phù hợp điều kiện, không phụ thuộc page |
| `paymentPlannedExTaxAllMatched` | Tổng `発注全額` của toàn bộ tập dữ liệu phù hợp điều kiện, không phụ thuộc page |
| `currentPage` | Trang hiện hành |
| `selectedRowIds` | Danh sách dòng được chọn qua checkbox |
| `inputMode` | `none`, `existing_detail`, `new_detail` |
| `inputForm` | Tập giá trị vùng `【入力】` |
| `currentOrderRequestNo` | `発注番号` hiện đang mở ở vùng `【入力】` |
| `isInputLockedByDeadline` | Cờ khóa nhập do quá giờ deadline |
| `isDeadlineReleaseOverride` | Cờ mở thao tác do `締切解除` |

### 5.4 Shared Actions

| UI Action | Business Event |
|---|---|
| `初期表示` | `initialize_screen` |
| `セクション検索` | `open_section_search` |
| `グループ検索` | `open_group_search` |
| `仕入先検索` | `open_supplier_search` |
| `調達品検索` | `open_product_search` |
| calendar buttons | `select_calendar_date` |
| `表示` | `search_order_requests` |
| `クリア` | `reset_screen` |
| paging links | `change_result_page` |
| result header `全選択` | `toggle_select_all_results` |
| result row checkbox | `toggle_result_selection` |
| result row `発注番号` link | `open_request_detail` |
| `ゴミ箱` | `move_or_restore_trash_records` |
| `更新` | `process_selected_requests_to_orders` |
| `新規` | `start_new_request` |
| `確定` | `confirm_input_request` |

## 6. Shared Data Context

### 6.1 UI Fields

| Area | Field | Type | Required | Behavior |
|---|---|---|---:|---|
| Search | `工場` | List | Yes | Initial value = login user factory. Display text from `店舗マスタ`. |
| Search | `セクションコード` | Text | No | Editable, can be returned from `セクション検索`. |
| Search | `セクション検索ボタン` | Button | No | Opens modal `セクション検索`. |
| Search | `セクション名` | Label | No | Returned from modal. |
| Search | `グループコード` | Text | No | Editable, can be returned from `グループ検索`. |
| Search | `グループ検索ボタン` | Button | No | Opens modal `グループ検索`. |
| Search | `グループ名` | Label | No | Returned from modal. |
| Search | `発注番号` | Text | No | Max length 14; search by ambiguous pattern `YYYYMMDD+R+99999` per search/result sheets. |
| Search | `ステータス` | List | No | Item sheet name. Query/event sheets imply this is a search target selector. |
| Search | `発注種別` | List | No | Name master `3054`. |
| Search | `仕入先コード` | Text | No | Can be returned from supplier modal. |
| Search | `仕入先検索ボタン` | Button | No | Opens `仕入先検索`. |
| Search | `仕入先名` | Label | No | Returned from modal. |
| Search | `調達品コード` | Text | No | Can be returned from product modal. |
| Search | `調達品検索ボタン` | Button | No | Opens `調達品検索`. |
| Search | `調達品名` | Label | No | Returned from modal. |
| Search | `発注依頼日_開始日` | Date text | Yes | Must satisfy date format and range logic. |
| Search | `発注依頼日_終了日` | Date text | Yes | Must satisfy date format and range logic. |
| Search | `発注日_開始日` | Date text | Yes | Must satisfy date format and range logic. |
| Search | `発注日_終了日` | Date text | Yes | Must satisfy date format and range logic. |
| Search | `納品日_開始日` | Date text | Yes | Must satisfy date format and range logic. |
| Search | `納品日_終了日` | Date text | Yes | Must satisfy date format and range logic. |
| Search | `依頼区分` | List | No | Name master `3031`. |
| Search | `調達品メモ` | Text | No | Fuzzy match. |
| Search | `締切解除ステータス` | Label | No | After `表示`, if group release valid time >= now then show `締切解除中明細あり HH時MM分 まで`, else blank. |
| Search | `表示区分` | Radio | No | Visible in layout only. Options: `全て`, `締切解除中のみ`. |
| Result | `件数` | Label | No | Default `0件`. |
| Result | `ページング` | Link | No | Supports page movement. Page size is non-inferable. |
| Result | `ゴミ箱` | Button | No | Enabled by permission and selected rows or current trash view rule. |
| Result | `全選択` | Checkbox | No | Syncs all row checkboxes on current page. |
| Result | row checkbox | Checkbox | No | Disabled when `発注区分 = 1(発注済)`. |
| Result | `更新` | Button | No | Enabled when at least one result row selected and user has update permission. |
| Result | `アラート件数` | Label | No | Count all matched alarm rows, not page-limited. |
| Result | `支払予定額（税抜）` | Label | No | Sum all matched `発注全額`, not page-limited. |
| Input | `発注番号` | Text/Label | No | Auto-generated for new, read-only. |
| Input | `工場` | List | Yes | Defaults from login user factory for new. |
| Input | `セクションコード` / button / name | Mixed | Yes | Selectable by modal. |
| Input | `グループコード` / button / name | Mixed | Yes | Selectable by modal. |
| Input | `勘定科目` | Label | No | Derived from `グループマスタ` or `名称マスタ(3031)` depending on `依頼区分`. |
| Input | `ロケーション` | Label | No | Derived from `セクション別在庫マスタ`. |
| Input | `依頼区分` | List | Yes | Affects account/profit center derivation and validation scope. |
| Input | `調達品コード` / button / name | Mixed | Yes | Selectable by modal. |
| Input | `諸口コード対象` | Checkbox | No | Derived from product master by selected product. |
| Input | `調達品メモ` | Text | Yes | Must equal agreement master under specific conditions on confirm. |
| Input | `仕入先コード` / button / name | Mixed | Yes | Required. |
| Input | `納期` | Date text | Yes | Has calendar modal. Must satisfy deadline and past-date validations. |
| Input | `納品LT` | Label | No | Derived from agreement master. |
| Input | `納品区分` | List | Yes | Must satisfy agreement-based validation under conditions. |
| Input | `発注数` | Text | Yes | Editable; in existing detail mode this is the only editable business field. |
| Input | `発注単位` | List | Yes | Must satisfy agreement-based validation under conditions. |
| Input | `発注単価` | Text | No | Editable and used in amount calculation. |
| Input | `課税区分` | List | Yes | Must satisfy agreement-based validation under conditions. |
| Input | `発注金額` | Text | No | Derived/calculated from quantity x unit price. |
| Input | `備考` | Text | No | Free text. |
| Input | `アラート` | Label | No | Alarm content derived from alarm checks. |
| Input | `新規` | Button | No | Enabled after display for update-permitted users. |
| Input | `確定` | Button | No | Enabled after display for update-permitted users. |

### 6.2 Result Columns

| Column | Source / Behavior |
|---|---|
| `No.` | Page-relative ordinal display. |
| row checkbox | Select row for `ゴミ箱` / `更新`. |
| `発注番号` | Link from `ANAC発注依頼ファイル.発注依頼番号`. |
| `ステータス` | Derived label from `データ区分`, `承認ステータス`, `発注区分`, and presence of `ANAC仕入伝票明細`. |
| `依頼区分` | Name from `名称マスタ(3031)`. |
| `依頼作成区分` | Derived from `データ区分`; `3(取下げ)` -> `1(キャンセル)`, otherwise `0(登録)` then translate via `名称マスタ(3080)`. |
| `セクション` | `セクションマスタ.セクション名`. |
| `グループ` | `グループマスタ.グループ名`. |
| `調達品コード` | `商品コード`. |
| `調達品名` | `基本商品マスタ.商品名称（全角）`. |
| `調達品メモ` | `基本商品マスタ` or request-held memo as shown in item definition. |
| `仕入先名` | `取引先マスタ.名称`. |
| `仕入先確認日` | `納品予定ファイル.仕入先確認日`; blank if schedule file absent. |
| `発注依頼日` | Request date. |
| `納期` | Delivery date / requested due date. |
| `納品区分` | Name from `名称マスタ(3024)`. |
| `発注数` | Request quantity. |
| `単位` | Name from `名称マスタ(3012)`. |
| `発注単価` | Unit price. |
| `発注全額` | Order price. |
| `送信区分` | Fixed display `WEBEDI`. |
| `発注日` | Order date. |
| `発注担当者` | Name from `ユーザマスタ`. |
| `版数` | Edition number. |

### 6.3 Main Data Sources

| Object | Role |
|---|---|
| `TAOR59_ANACORDERREQUEST` | Nguồn chính cho tìm kiếm, mở chi tiết, lưu `確定`, chuyển `ゴミ箱`, và cập nhật trạng thái `発注済`. |
| `TAPR11_ANACPURCHASESLIPDETAIL` | Xác định trạng thái `入荷済` và lọc khi search target = `入荷済`. |
| `TAMT029_GROUP` | Tra cứu `グループ名`, `勘定科目`, `利益センタ`, `締切解除有効時間`. |
| `TMT050_NAME` | Từ điển các list và alarm/rule name master: `3053`, `3054`, `3031`, `3070`, `3024`, `3012`, `3016`, `3047`, `3033`, `3078`, `3080`, `3081`, `3082`. |
| `TAPR04_SCHEDULEDFORDELIVERYFILE` | Lấy `仕入先確認日`; được insert khi `更新`. |
| `TAMT026_PRODUCTAGREEMENT` | Master kiểm tra `調達品メモ`, `発注単位`, `発注単価`, `発注ロット数`, `納品回数`, `納品LT`, `課税区分`, supplier fallback. |
| `TAMT024_PARTNERSTORE` | Kiểm tra supplier-store combination hợp lệ. |
| `TMT003_STORE` | Khởi tạo list `工場`. |
| `セクションマスタ` | Trả về `セクション名`. Technical table name non-inferable from current artifacts. |
| `取引先マスタ` | Trả về supplier name. Technical table name non-inferable from current artifacts. |
| `基本商品マスタ` | Trả về product name và một phần data tham chiếu. Technical table name non-inferable from current artifacts. |
| `セクション別在庫マスタ` | Tính `ロケーション`. Technical table name non-inferable from current artifacts. |
| `ユーザマスタ` | Trả về `発注担当者`. Technical table name non-inferable from current artifacts. |
| `ANAC発注` | Đối tượng nghiệp vụ được tạo ở event `更新`. Technical table name non-inferable from current artifacts. |

### 6.4 Persistence / Update Targets

| Object | Purpose |
|---|---|
| `TAOR59_ANACORDERREQUEST` | Update `ORDERCATEGORY` khi `ゴミ箱` / restore; insert mới hoặc update khi `確定`; update status `発注済` sau `更新`. |
| `ANAC発注` | Insert order data ở event `更新`. Technical table/location unknown. |
| `TAPR04_SCHEDULEDFORDELIVERYFILE` | Insert schedule record ở event `更新`. |
| `TAOR71_REQUESTNOCONTROL` | Dùng để cấp phát `発注依頼番号` cho insert mới. |

## 7. Shared Events

### 7.1 `initialize_screen`

**UI Trigger**
- Mở màn hình lần đầu
- Sau `クリア`

**Preconditions**
- Condition: người dùng có quyền hiển thị màn hình

**Validation**
- None

**Processing**
1. Khởi tạo toàn bộ `【検索条件】` và `【入力】`
2. Set `工場` từ login user
3. Set các textbox/list search khác về blank hoặc initial list state
4. Set result area rỗng, `件数 = 0件`
5. Set `ゴミ箱`, `更新`, `新規`, `確定` về trạng thái disabled theo quyền
6. Reset input mode về `none`

**Result**
- Màn hình ở init state

**Failure Cases**
- Nếu người dùng có quyền `使用不能`, không cho mở màn hình

**Related Messages**
- Non-inferable from current artifacts

**Related Data Sources**
- `TMT003_STORE`
- `TMT050_NAME`

---

### 7.2 `open_section_search`

**UI Trigger**
- Nút `セクション検索`

**Preconditions**
- Condition: field đang editable theo quyền và state

**Validation**
- None

**Processing**
1. Mở modal `セクション検索`
2. Nhận về `工場コード`, `工場名`, `セクションコード`, `セクション名`
3. Gán lại vào đúng field ở area hiện tại (search area hoặc input area)

**Result**
- Search/input fields được cập nhật theo selection modal

**Failure Cases**
- Người dùng đóng modal mà không chọn -> giữ nguyên giá trị hiện tại

**Related Messages**
- None

**Related Data Sources**
- `セクション検索` modal
- `セクションマスタ`

---

### 7.3 `open_group_search`

**UI Trigger**
- Nút `グループ検索`

**Preconditions**
- Condition: field đang editable theo quyền và state

**Validation**
- None

**Processing**
1. Mở modal `グループ検索`
2. Nhận về `工場コード`, `工場名`, `セクションコード`, `セクション名`, `グループコード`, `グループ名`
3. Gán lại vào đúng field ở area hiện tại

**Result**
- Search/input fields được cập nhật theo selection modal

**Failure Cases**
- Đóng modal không chọn -> giữ nguyên

**Related Messages**
- None

**Related Data Sources**
- `グループ検索` modal
- `TAMT029_GROUP`

---

### 7.4 `open_supplier_search`

**UI Trigger**
- Nút `仕入先検索`

**Preconditions**
- Condition: field đang editable theo quyền và state

**Validation**
- None

**Processing**
1. Mở modal `仕入先検索`
2. Nhận về `仕入先コード`, `仕入先名`
3. Gán vào đúng field area hiện hành

**Result**
- Search/input fields được cập nhật

**Failure Cases**
- Đóng modal không chọn -> giữ nguyên

**Related Messages**
- None

**Related Data Sources**
- `仕入先検索` modal
- `取引先マスタ`

---

### 7.5 `open_product_search`

**UI Trigger**
- Nút `調達品検索`

**Preconditions**
- Condition: field đang editable theo quyền và state

**Validation**
- None

**Processing**
1. Mở modal `調達品検索`
2. Nhận về `調達品コード`, `調達品名`
3. Gán vào đúng field area hiện hành
4. Khi ở input area, tiếp tục tra cứu data liên quan như `諸口コード対象`, `納品LT`, agreement-based defaults nếu có

**Result**
- Product fields được cập nhật

**Failure Cases**
- Đóng modal không chọn -> giữ nguyên

**Related Messages**
- None

**Related Data Sources**
- `調達品検索` modal
- `基本商品マスタ`
- `TAMT026_PRODUCTAGREEMENT`

---

### 7.6 `select_calendar_date`

**UI Trigger**
- Các nút calendar của `発注依頼日`, `発注日`, `納品日`, `納期`

**Preconditions**
- Condition: field đích đang editable

**Validation**
- None

**Processing**
1. Mở calendar modal
2. Hiển thị ngày hiện tại
3. Người dùng chọn ngày
4. Gán ngày đã chọn vào field đích

**Result**
- Field ngày được set

**Failure Cases**
- Đóng modal không chọn -> giữ nguyên

**Related Messages**
- None

**Related Data Sources**
- Calendar modal

---

### 7.7 `search_order_requests`

**UI Trigger**
- Nút `表示`

**Preconditions**
- Condition: người dùng có quyền `更新可能` hoặc `閲覧のみ`

**Validation**
- Required checks for `工場`, `発注依頼日_開始日`, `発注依頼日_終了日`, `発注日_開始日`, `発注日_終了日`, `納品日_開始日`, `納品日_終了日`
- Max length checks for `セクションコード`, `グループコード`, `発注番号`, `仕入先コード`, `調達品コード`, `調達品メモ`
- Date format checks for the 3 date ranges
- Start/end logical checks for the 3 date ranges

**Processing Logic**
1. Validate search conditions
2. Build query on `TAOR59_ANACORDERREQUEST`
3. Apply exact/fuzzy/date range filters from search area
4. Apply `表示区分` filter when set to `締切解除中のみ`
5. Join supporting masters for labels, `締切解除` status, `入荷済` existence, and `仕入先確認日`
6. Derive display status label and row color
7. Sort by `締切解除` priority and the workbook-defined sequence
8. Compute `件数`
9. Compute `アラート件数` and `支払予定額（税抜）` on all matched rows, not page-limited
10. Load page 1 of results
11. Enable/disable result area buttons according to permission and selected-state rule
12. Update `締切解除ステータス`

**Result**
- Search state is shown with result rows and summaries
- Search conditions stay on screen

**Failure Cases**
- Validation error -> keep current conditions and do not query
- No data -> show `MI000001`, keep conditions, clear rows

**Related Messages**
- `ME000116`
- `ME000050`
- `ME000006`
- `MEA00006`
- `MI000001`

**Related Data Sources**
- `TAOR59_ANACORDERREQUEST`
- `TAPR11_ANACPURCHASESLIPDETAIL`
- `TAMT029_GROUP`
- `TMT050_NAME`
- `TAPR04_SCHEDULEDFORDELIVERYFILE`

---

### 7.8 `reset_screen`

**UI Trigger**
- Nút `クリア`

**Preconditions**
- None

**Validation**
- None

**Processing Logic**
1. Run the same behavior as `initialize_screen`

**Result**
- Return to init state

**Failure Cases**
- None

**Related Messages**
- None

**Related Data Sources**
- Same as `initialize_screen`

---

### 7.9 `change_result_page`

**UI Trigger**
- Paging links

**Preconditions**
- Condition: current result set already exists

**Validation**
- Requested page must be within available page range

**Processing Logic**
1. Keep current search conditions
2. Reload requested page from current matched dataset
3. Preserve row sort and summary totals

**Result**
- Same search state with different page rows

**Failure Cases**
- Page out of range handling is non-inferable from current artifacts

**Related Messages**
- Non-inferable from current artifacts

**Related Data Sources**
- `TAOR59_ANACORDERREQUEST` and joined search dataset

---

### 7.10 `toggle_select_all_results`

**UI Trigger**
- Header checkbox `全選択`

**Preconditions**
- Condition: result grid exists

**Validation**
- None

**Processing Logic**
1. When header checkbox changes, synchronize all row checkboxes on the current page
2. Rows whose row checkbox is disabled because `発注区分 = 1(発注済)` must remain unselected

**Result**
- `selectedRowIds` synchronized with current page selectable rows

**Failure Cases**
- None

**Related Messages**
- None

**Related Data Sources**
- Current result dataset

---

### 7.11 `toggle_result_selection`

**UI Trigger**
- Row checkbox in result list

**Preconditions**
- Condition: target row is selectable

**Validation**
- Condition: if `発注区分 = 1(発注済)`, checkbox must stay disabled

**Processing Logic**
1. Toggle selection state of the current row
2. Re-evaluate `ゴミ箱` and `更新` enablement

**Result**
- Button state reflects selection state

**Failure Cases**
- Disabled row cannot be selected

**Related Messages**
- None

**Related Data Sources**
- Current result dataset

---

### 7.12 `open_request_detail`

**UI Trigger**
- Link `発注番号` in result row

**Preconditions**
- Condition: result row exists

**Validation**
- None explicitly described

**Processing Logic**
1. Load the selected request record into `【入力】`
2. Load related derived labels such as `勘定科目`, `ロケーション`, `納品LT`, `諸口コード対象`
3. Set `inputMode = existing_detail`
4. Condition: in existing detail mode, only `発注数` is editable; other business fields remain read-only unless separately clarified
5. Keep current search result state on screen

**Result**
- Existing detail edit state

**Failure Cases**
- If selected request cannot be loaded, handling is non-inferable from current artifacts

**Related Messages**
- Non-inferable from current artifacts

**Related Data Sources**
- `TAOR59_ANACORDERREQUEST`
- `TAMT029_GROUP`
- `TAMT026_PRODUCTAGREEMENT`
- `TAMT024_PARTNERSTORE`
- `TMT050_NAME`

---

### 7.13 `move_or_restore_trash_records`

**UI Trigger**
- Nút `ゴミ箱`

**Preconditions**
- Condition: user has `更新可能`
- Condition: at least one selectable row is checked, unless a future clarified behavior says otherwise
- Condition: when not in trash view, selected rows intended for move must have `発注区分 = 0(未発注)` to enable the button
- Condition: when current search target/view is `ゴミ箱`, action meaning changes to restore

**Validation**
- If no row selected -> `ME000070`
- If current view is non-trash -> show action confirm `MQA00015`
- If current view is trash -> show action confirm `MQA00019`

**Processing Logic**
1. Check selected-row existence
2. Branch by current search target/view
3. If user chooses `いいえ`, close confirm and stop
4. If user chooses `はい`
   - Condition: non-trash view -> update selected `TAOR59_ANACORDERREQUEST.ORDERCATEGORY = 2`
   - Condition: trash view -> update selected `TAOR59_ANACORDERREQUEST.ORDERCATEGORY = 0`
5. Re-run search with current conditions

**Result**
- Current view refreshed after move or restore

**Failure Cases**
- No selection -> no DB change
- User cancels confirm -> no DB change
- Technical rollback rule is non-inferable from current artifacts

**Related Messages**
- `ME000070`
- `MQA00015`
- `MQA00019`

**Related Data Sources**
- `TAOR59_ANACORDERREQUEST`

---

### 7.14 `process_selected_requests_to_orders`

**UI Trigger**
- Nút `更新`

**Preconditions**
- Condition: user has `更新可能`
- Condition: at least one row selected
- Condition: selected rows are intended processing targets from result list

**Validation**
- Selected-row existence check
- Deadline check when order date is the same day
- Approval status check
- Past delivery date check
- Unit master check under conditional scope
- Delivery division master check under conditional scope
- Supplier-store master check
- Alarm checks for order lot, delivery LT, and maximum order amount
- Confirmation message before DB processing

**Processing Logic**
1. Validate selected rows
2. Condition: if `グループマスタ.締切解除有効時間 < 現在日時` and `名称マスタ(3033).承認締め切り時間 < システム時刻`, block processing
3. Condition: if selected request approval status is not `承認済`, block processing
4. Condition: if `業務日付 > 納期`, block processing
5. Condition: when `諸口コード対象 = 0` and `依頼区分 != 07(サンプル)`, validate `発注単位`, `納品区分`, supplier-store existence and compute alarms
6. If `取引先コード` on request is NULL, use `調達品契約マスタ.取引先コード` for subsequent supplier validations
7. Show confirmation `MQ000031`
8. If user chooses `いいえ`, stop
9. If user chooses `はい`, build grouped `ANAC発注` records from selected request rows using the grouping key:
   - `工場`
   - `セクション`
   - `グループ`
   - `依頼区分`
   - `勘定科目`
   - `仕入先`
   - `調達品コード`
   - `納期`
   - `納品区分`
   - `利益センタ`
   - `セクション別在庫マスタ.入庫ロケーションコード`
10. Aggregate `発注数`
11. Apply alarm checks again on aggregated result and set `ANAC発注.アラーム内容`
12. Register `ANAC発注`
13. Register `納品予定ファイル`
14. Update selected `ANAC発注依頼ファイル` to `発注済`
15. Re-run search with current conditions

**Result**
- Searched rows are refreshed and processed rows move to the appropriate post-update state

**Failure Cases**
- Any validation failure -> do not process
- User cancels confirmation -> do not process
- Technical transaction scope among order insert, schedule insert, and request status update is non-inferable from current artifacts

**Related Messages**
- `ME000070`
- `MEA00020`
- `MEA00012`
- `MEA00015`
- `ME000014`
- `MQ000031`
- Delivery division master / supplier master error codes are partially non-inferable in this event

**Related Data Sources**
- `TAOR59_ANACORDERREQUEST`
- `TAMT029_GROUP`
- `TMT050_NAME`
- `TAMT026_PRODUCTAGREEMENT`
- `TAMT024_PARTNERSTORE`
- `ANAC発注`
- `TAPR04_SCHEDULEDFORDELIVERYFILE`

---

### 7.15 `start_new_request`

**UI Trigger**
- Nút `新規`

**Preconditions**
- Condition: user has `更新可能`
- Condition: button enabled after `表示`

**Validation**
- If there is in-progress input, show confirmation `MQ000018`

**Processing Logic**
1. If no in-progress input, move directly to new mode
2. If there is in-progress input, ask user to confirm reset
3. If user chooses `はい`, initialize `【入力】` fields to new-entry defaults
4. If user chooses `いいえ`, keep current input untouched
5. Set `inputMode = new_detail`

**Result**
- New detail state

**Failure Cases**
- Cancel confirm -> no state change

**Related Messages**
- `MQ000018`

**Related Data Sources**
- `TMT003_STORE`
- `TMT050_NAME`

---

### 7.16 `confirm_input_request`

**UI Trigger**
- Nút `確定`

**Preconditions**
- Condition: user has `更新可能`
- Condition: button enabled after `表示`
- Condition: current `inputMode` is `existing_detail` or `new_detail`

**Validation**
- Required check for required input fields in `【入力】`
- Deadline check when order date is the same day
- Existing-detail only: approval status check for current record
- Past delivery date check
- Agreement-based validation for unit, product memo, tax, unit price, lot, delivery division under scope:
  - Condition: `諸口コード対象 = 0`
  - Condition: `依頼区分 != 07(サンプル)`
- Supplier-store master existence check
- Alarm checks
- Final confirmation `MQ000004`

**Processing Logic**
1. Validate current input form
2. Compute/update `発注金額`
3. Derive or refresh alarm content
4. Show final confirmation
5. If user chooses `いいえ`, stop
6. Branch by `inputMode`
   - Condition: `existing_detail`
     1. Update only allowed fields in `TAOR59_ANACORDERREQUEST`
     2. Set `ORDERREQUESTQTYCHANGES = 発注数`
     3. Update `調達品メモ`, `取引先コード`, `発注単位コード`, `納品区分`, `発注単価`, `発注金額`, `備考`
     4. Update `ALARMKBN`, `ALARM`
     5. Set `版数 = 版数 + 1`
     6. Update audit fields
   - Condition: `new_detail`
     1. Get new `発注依頼番号` from `TAOR71_REQUESTNOCONTROL`
     2. Insert new row into `TAOR59_ANACORDERREQUEST`
     3. Set constants:
        - `発注種別 = 2(個別発注)`
        - `発注分類区分 = 3(その他発注依頼)`
        - `データ区分 = 1(発注依頼)`
        - `承認ステータス = 2(承認)`
        - `発注区分 = 0(未発注)`
        - `版数 = 1`
        - `削除フラグ = 0`
     4. Set generated/system values:
        - request date = current date
        - request user = login user
        - approval user = login user
        - approval date = current date
        - audit fields = current user / program
7. Re-run search with current conditions

**Result**
- Current request persisted and search result refreshed

**Failure Cases**
- Validation failure -> no save
- User cancels confirmation -> no save
- Technical transaction rule is non-inferable from current artifacts

**Related Messages**
- `ME000116`
- `MEA00020`
- `MEA00012`
- `ME000014`
- `ME000023`
- `ME000024`
- `ME000025`
- `ME000026`
- `MEA00028`
- `MQ000004`

**Related Data Sources**
- `TAOR59_ANACORDERREQUEST`
- `TAOR71_REQUESTNOCONTROL`
- `TMT050_NAME`
- `TAMT029_GROUP`
- `TAMT026_PRODUCTAGREEMENT`
- `TAMT024_PARTNERSTORE`

## 8. Mode Variants

### Variant A - Init State

**Trigger**
- Mở màn hình
- Sau `クリア`

**UI Changes**
- Search conditions ở trạng thái initial
- Result area trống
- Input area trống
- `ゴミ箱`, `更新`, `新規`, `確定` disabled theo quyền và state
- `表示区分` hiển thị theo layout; default value non-inferable from current artifacts

**Input Fields**
- `工場` = login user factory
- `セクションコード`, `グループコード`, `発注番号`, `仕入先コード`, `調達品コード`, `調達品メモ` = blank
- `ステータス` / `検索対象` = initial value ambiguous
- `発注種別`, `依頼区分` = unselected
- 3 cặp range date = blank
- Input form = reset

**Result Display**
- `件数 = 0件`
- Không có result rows
- `アラート件数` và `支払予定額（税抜）` chưa có giá trị nghiệp vụ

**Wireframe (ASCII only)**
```text
+--------------------------------------------------------------------------------+
| Supplier Purchase Order Input                                                  |
+--------------------------------------------------------------------------------+
| [Search Conditions]                                                            |
| Factory * [login factory v]      Supplier [code ] [Find] [name.............]  |
| Section [code ] [Find] [name...] Product  [code ] [Find] [name.............]  |
| Group   [code ] [Find] [name...] Req Date * [yyyy/mm/dd] [CAL] [yyyy/mm/dd]   |
| Req No  [              ]         Ord Date * [yyyy/mm/dd] [CAL] [yyyy/mm/dd]   |
| Status  [select v]               Del Date * [yyyy/mm/dd] [CAL] [yyyy/mm/dd]   |
| OrdType [select v]               Display   ( ) All  ( ) Release Only           |
| ReqCat  [select v]               Prod Memo [..............................]     |
| Release Status [.........................................................]      |
|                                                       [Show] [Clear]           |
+--------------------------------------------------------------------------------+
| [Results]                                                                      |
| Count: 0                         Alert Count: 0          Planned Pay ExTax: 0  |
| +----+--+--------------+----------+----------+----------+--------------------+ |
| |No. |S |Req No        |Status    |Req Cat   |Made By   |Section / Group     | |
| +----+--+--------------+----------+----------+----------+--------------------+ |
| |    |  |              |          |          |          |                    | |
| +----+--+--------------+----------+----------+----------+--------------------+ |
| [Trash] [Update]                                                             |
+--------------------------------------------------------------------------------+
| [Input]                                                                        |
| Req No [readonly.................]                                             |
| Factory * [factory v]   Section * [code ] [Find] [name.............]          |
| Group   * [code ] [Find] [name...]  Account [label........] Loc [label....]   |
| ReqCat  * [select v]               Product * [code ] [Find] [name.........]   |
| MultiCd [ ]                        Prod Memo * [............................]  |
| Supplier* [code ] [Find] [name...] Due Date * [yyyy/mm/dd] [CAL] LT [ddd]     |
| Del Kbn * [select v]               Qty * [      ] Unit * [select v]            |
| UnitPrice [      ]                 Tax * [select v] Amount [calculated....]    |
| Remarks [.................................................................]    |
| Alert   [.................................................................]    |
|                                                          [New] [Confirm]       |
+--------------------------------------------------------------------------------+
```

Wireframe status: inferred from Excel layout and ASCII alias labels are used to satisfy strict ASCII-only output.

**Acceptance Criteria**
AC-SUPORD-001: Khi mở màn hình lần đầu với quyền hiển thị hợp lệ, vùng `【検索条件】` và `【入力】` được khởi tạo lại toàn bộ, `工場` nhận từ login user, result area rỗng, `件数` hiển thị `0件`, và `inputMode = none`.
AC-SUPORD-002: Ở init state, các button phụ thuộc kết quả như `ゴミ箱` và `更新` phải không thao tác được do chưa có dòng nào được chọn.
AC-SUPORD-003: Ở init state, `新規` và `確定` chỉ được enable khi workbook-evidenced condition sau `表示` đã thỏa; không được enable mặc định nếu chưa có bằng chứng khác.

---

### Variant B - Search State

**Trigger**
- Bấm `表示`
- Validation OK
- Có dữ liệu

**UI Changes**
- Result table hiển thị rows
- Summary `アラート件数` và `支払予定額（税抜）` hiển thị giá trị tổng trên toàn bộ matched rows
- Paging xuất hiện
- `新規`, `確定` có thể enable theo quyền sau `表示`
- `締切解除中` rows được đưa lên trước và hiển thị màu đỏ
- Rows có `アラーム内容 != NULL` hiển thị màu đỏ

**Input Fields**
- Search conditions giữ nguyên giá trị vừa search
- Input area vẫn trống cho đến khi mở detail hoặc bấm `新規`

**Result Display**
- Cột hiển thị theo layout
- Row checkbox disabled cho `発注区分 = 1(発注済)`

**Wireframe (ASCII only)**
```text
+--------------------------------------------------------------------------------+
| Supplier Purchase Order Input                                                  |
+--------------------------------------------------------------------------------+
| [Search Conditions]                                    [Show] [Clear]          |
| Factory * [A001 v] Section [S01] Group [G02] Status [Open v] Display (x) All  |
| Supplier [P001] Product [PRD0001] ReqCat [Cat v] Prod Memo [memo.....]        |
| Req Date * [2026/02/01] [CAL] [2026/02/28]   Ord Date * [2026/02/01] [CAL]    |
| Del Date * [2026/02/05] [CAL] [2026/02/28]   Release Status [....12:00....]   |
+--------------------------------------------------------------------------------+
| [Results]                                                                      |
| Count: 128                       Alert Count: 9         Planned Pay ExTax: ... |
| Page: 1 2 3 >                                                               |
| +----+--+--------------+----------+----------+----------+--------------------+ |
| |No. |S |Req No        |Status    |Req Cat   |Made By   |Section / Group     | |
| +----+--+--------------+----------+----------+----------+--------------------+ |
| |1   |x |20260201R00001|Not Order |General   |Create    |SecA / GrpA         | |
| |2   |  |20260201R00002|Release   |Sample    |Create    |SecB / GrpB         | |
| +----+--+--------------+----------+----------+----------+--------------------+ |
| [Trash] [Update]                                                             |
+--------------------------------------------------------------------------------+
| [Input]                                                                        |
| No detail loaded                                                              |
|                                                          [New] [Confirm]       |
+--------------------------------------------------------------------------------+
```

Wireframe status: inferred from Excel layout and ASCII alias labels are used to satisfy strict ASCII-only output.

**Acceptance Criteria**
AC-SUPORD-004: Sau search thành công, danh sách kết quả phải giữ nguyên search conditions trên màn hình và hiển thị `件数` đúng với tổng số bản ghi phù hợp.
AC-SUPORD-005: `アラート件数` phải đếm toàn bộ matched rows có `発注アラーム区分 = 01`, không chỉ đếm các dòng của page hiện tại.
AC-SUPORD-006: `支払予定額（税抜）` phải cộng toàn bộ `発注全額` của matched rows, không phụ thuộc page hiện tại.
AC-SUPORD-007: Kết quả phải được sort theo `締切解除時間 DESC -> 納期 ASC -> 納品区分 ASC -> 承認依頼日 ASC -> 発注依頼番号 ASC`.
AC-SUPORD-008: Dòng có `アラーム内容 != NULL` hoặc dòng đang trong trạng thái `締切解除中` phải hiển thị màu đỏ.
AC-SUPORD-009: Row checkbox của dòng có `発注区分 = 1(発注済)` phải ở trạng thái disabled và không được chọn qua `全選択`.
AC-SUPORD-010: Khi đổi page, search conditions, sort, `アラート件数`, và `支払予定額（税抜）` phải được giữ nguyên ngữ nghĩa của cùng tập điều kiện search.

---

### Variant C - Trash Search State

**Trigger**
- Search với `検索対象/ステータス = ゴミ箱` theo logic workbook

**UI Changes**
- Result rows là tập dữ liệu `ゴミ箱`
- Nút `ゴミ箱` chuyển nghĩa nghiệp vụ sang khôi phục
- Điều kiện search khác giữ nguyên

**Input Fields**
- Giống search state

**Result Display**
- Result list theo filter `ORDERCATEGORY = 2`

**Wireframe (ASCII only)**
```text
+--------------------------------------------------------------------------------+
| Supplier Purchase Order Input                                                  |
+--------------------------------------------------------------------------------+
| [Search Conditions] Status [Trash v] Display (x) All         [Show] [Clear]   |
+--------------------------------------------------------------------------------+
| [Results]                                                                      |
| Count: 12                                                                       |
| +----+--+--------------+----------+------------------------------------------+ |
| |No. |S |Req No        |Status    |Memo                                      | |
| +----+--+--------------+----------+------------------------------------------+ |
| |1   |x |20260201R00008|Trash     |...                                       | |
| |2   |x |20260201R00009|Trash     |...                                       | |
| +----+--+--------------+----------+------------------------------------------+ |
| [Trash]  Action meaning: Restore to normal request view                        |
+--------------------------------------------------------------------------------+
```

Wireframe status: inferred from Excel layout and ASCII alias labels are used to satisfy strict ASCII-only output.

**Acceptance Criteria**
AC-SUPORD-011: Khi đang ở trash view, nút `ゴミ箱` phải thực hiện logic khôi phục khỏi `ゴミ箱`, không được tiếp tục set `ORDERCATEGORY = 2`.
AC-SUPORD-012: Search trash view phải dùng current search conditions kết hợp với condition `ORDERCATEGORY = 2`.

---

### Variant D - Existing Detail Edit State

**Trigger**
- Người dùng click link `発注番号` từ result row

**UI Changes**
- Vùng `【入力】` được nạp dữ liệu bản ghi hiện có
- Chỉ `発注数` được phép chỉnh sửa theo note của workbook
- Các label dẫn xuất như `勘定科目`, `ロケーション`, `納品LT`, `アラート` hiển thị tương ứng

**Input Fields**
- Existing record values
- `発注番号` read-only

**Result Display**
- Result list vẫn giữ nguyên trên màn hình

**Wireframe (ASCII only)**
```text
+--------------------------------------------------------------------------------+
| [Input - Existing Detail]                                                      |
+--------------------------------------------------------------------------------+
| Req No [20260201R00012..................... readonly ]                         |
| Factory * [A001 v ro]  Section * [S01 ro]  Group * [G02 ro]                   |
| Account [label ro]    Location [label ro]                                      |
| ReqCat * [General ro] Product * [PRD0001 ro] MultiCd [x ro]                   |
| Prod Memo * [memo from record............................ ro]                  |
| Supplier* [P001 ro] Due Date * [2026/02/15 ro] LT [003 ro]                    |
| Del Kbn * [2nd ro]   Qty * [000120 edit] Unit * [PC ro]                       |
| UnitPrice [001200 ro] Tax * [Tax1 ro] Amount [000144000 ro]                   |
| Remarks [text ro]                                                              |
| Alert   [alarm text ro]                                                        |
|                                                          [New] [Confirm]       |
+--------------------------------------------------------------------------------+
```

Wireframe status: inferred from item definition note that only quantity is editable.

**Acceptance Criteria**
AC-SUPORD-013: Khi mở chi tiết từ link `発注番号`, vùng `【入力】` phải nạp đúng dữ liệu của dòng được chọn.
AC-SUPORD-014: Ở existing detail state, chỉ `発注数` được editable; các field business khác phải read-only trừ khi có evidence mới hơn.
AC-SUPORD-015: `確定` ở existing detail state phải update bản ghi hiện có, tăng `版数 + 1`, và không được insert bản ghi mới.

---

### Variant E - New Detail State

**Trigger**
- Bấm `新規`
- User xác nhận reset input nếu có dữ liệu dở dang

**UI Changes**
- Vùng `【入力】` chuyển sang form new entry
- Các field có thể nhập mới được mở nhập
- `発注番号` read-only chờ generated on save

**Input Fields**
- `工場` = login user factory
- Các field required còn lại theo initial/new defaults từ item sheet
- Các derived labels để trống cho đến khi đủ dữ liệu lookup

**Result Display**
- Result list giữ nguyên

**Wireframe (ASCII only)**
```text
+--------------------------------------------------------------------------------+
| [Input - New Detail]                                                           |
+--------------------------------------------------------------------------------+
| Req No [generated on save........................ readonly ]                   |
| Factory * [login factory v]  Section * [code ] [Find] [name.............]     |
| Group   * [code ] [Find] [name...] Account [label........] Location [label.]  |
| ReqCat  * [select v] Product * [code ] [Find] [name.................]         |
| MultiCd [ ]                Prod Memo * [..............................]        |
| Supplier* [code ] [Find] [name.............] Due Date * [yyyy/mm/dd] [CAL]    |
| LT [ddd ro]                Del Kbn * [select v]                               |
| Qty * [      ]             Unit * [select v]                                  |
| UnitPrice [      ]         Tax * [select v] Amount [auto calc........]        |
| Remarks [.................................................................]    |
| Alert   [derived after validation........................................]     |
|                                                          [New] [Confirm]       |
+--------------------------------------------------------------------------------+
```

Wireframe status: inferred from layout, item defaults, and update-confirm insert mapping.

**Acceptance Criteria**
AC-SUPORD-016: Khi bấm `新規` trong lúc đang có dữ liệu dở dang, hệ thống phải hiển thị confirm `MQ000018`; chọn `いいえ` thì giữ nguyên input, chọn `はい` thì reset input về new mode.
AC-SUPORD-017: Ở new detail state, `発注番号` không được nhập tay và chỉ được gán khi lưu thành công.
AC-SUPORD-018: `確定` ở new detail state phải insert vào `TAOR59_ANACORDERREQUEST` với các hằng số và giá trị hệ thống đúng như mapping workbook.

## 9. Query Rules

### 9.1 Initial Lookup Rules

Condition: khi khởi tạo màn hình, hệ thống phải chuẩn bị các nguồn dữ liệu tra cứu tối thiểu cho:

- `工場` từ `TMT003_STORE`
- `ステータス/検索対象` từ `TMT050_NAME` record group `3053`
- `発注種別` từ `TMT050_NAME` record group `3054`
- `依頼区分` từ `TMT050_NAME` record group `3031`
- `表示区分` nhiều khả năng từ `TMT050_NAME` record group `3070`

Nếu các lookup không có dữ liệu:
- `TBD based on source artifacts`
- Không có rule fallback được mô tả

### 9.2 Search Dataset Rules

**Query purpose**
- Tìm các bản ghi `ANAC発注依頼` phù hợp điều kiện màn hình để hiển thị danh sách xử lý.

**Primary source**
- `TAOR59_ANACORDERREQUEST`

**Joins / supporting lookups**
- `TAPR11_ANACPURCHASESLIPDETAIL` để xác định `入荷済`
- `TAMT029_GROUP` để lấy group info và `締切解除有効時間`
- `TMT050_NAME` để chuyển code sang name cho `依頼区分`, `納品区分`, `単位`, `勘定科目`, `課税区分`, `依頼作成区分`, alarm rules
- `TAPR04_SCHEDULEDFORDELIVERYFILE` để lấy `仕入先確認日`
- `セクションマスタ`, `取引先マスタ`, `基本商品マスタ`, `ユーザマスタ` cho các label hiển thị

**Filters**
- `ORDERREQUESTNO` fuzzy search bằng `LIKE %発注番号%`
- `STORECD = 工場`
- `SECTIONCD = セクションコード` nếu có nhập
- `GROUPCD = グループコード` nếu có nhập
- `ORDERTYPE = 発注種別` nếu có chọn
- `REQUESTCATEGORY = 依頼区分` nếu có chọn
- `ORDERREQUESTDATE >= 発注依頼日_開始日`
- `ORDERREQUESTDATE <= 発注依頼日_終了日`
- `ORDERDATE >= 発注日_開始日`
- `ORDERDATE <= 発注日_終了日`
- `DELIVERYDATE >= 納品日_開始日`
- `DELIVERYDATE <= 納品日_終了日`
- `PRODUCTCD = 調達品コード` nếu có nhập
- `PRODUCTMEMO LIKE %調達品メモ%`
- `PARTNERCD = 仕入先コード` nếu có nhập

**Search target / status branching**
- Condition: search target = `ゴミ箱` -> filter `ORDERCATEGORY = 2`
- Condition: search target = `発注済` -> filter `ORDERCATEGORY = 1`
- Condition: search target = `入荷済` -> chỉ lấy dòng có `TAPR11_ANACPURCHASESLIPDETAIL` tồn tại
- Unresolved ambiguity: workbook không cung cấp đầy đủ mapping branch cho toàn bộ giá trị của dropdown `ステータス/検索対象`
- Handling: ưu tiên áp dụng những branch có bằng chứng trực tiếp; các branch còn thiếu phải để `Unresolved ambiguity`
- Risk: implement sai search-target mapping có thể làm lọc sai tập dữ liệu

**Display division**
- Condition: `表示区分 = 締切解除中のみ` -> chỉ lấy dòng có `グループマスタ.締切解除有効時間 >= 現在日時`

**Derived status display**
- Condition: nếu có bản ghi tương ứng ở `ANAC仕入伝票明細` -> hiển thị `入荷済み`
- Condition: nếu `発注区分 = 1` -> hiển thị `発注済み`
- Condition: nếu `発注区分 = 0` -> hiển thị `未発注`
- Condition: nếu `承認ステータス = 1` -> hiển thị `差戻`
- Condition: nếu `承認ステータス = 0` và `データ区分 = 1` -> hiển thị `依頼済み`
- Condition: nếu `データ区分 in (0,2)` -> hiển thị `一時保存`
- Unresolved ambiguity: source không nêu rõ precedence tuyệt đối khi nhiều condition cùng đúng
- Handling: dùng precedence theo trình tự item definition đã mô tả
- Risk: hiển thị trạng thái lệch business nếu precedence thực tế khác

**Sort**
- Condition: `締切解除中` rows first
- Then `グループマスタ.締切解除時間 DESC`
- Then `納期 ASC`
- Then `納品区分 ASC`
- Then `承認依頼日 ASC`
- Then `発注依頼番号 ASC`

**Result aggregates**
- `アラート件数`: count tất cả matched rows có `発注アラーム区分 = 01`
- `支払予定額（税抜）`: sum `発注全額` của tất cả matched rows

**Paging**
- Paging exists
- Page size: `Non-inferable from current artifacts`

### 9.3 Detail Load Rules

Condition: khi mở 1 dòng qua link `発注番号`, hệ thống phải load bản ghi hiện có từ `TAOR59_ANACORDERREQUEST` và tra cứu thêm:

- `勘定科目`
  - Condition: new mode hoặc existing mode có `依頼区分` -> tra `TMT050_NAME(3031)` lấy `予備1 = 勘定科目`, `予備2 = 利益センタ`
  - Condition: không có `依頼区分` -> dùng `TAMT029_GROUP.勘定科目コード`, `利益センタ`
  - Sau đó chuyển code sang name qua `TMT050_NAME(3016)`
- `ロケーション`
  - Từ `セクション別在庫マスタ` theo `工場`, `セクション`, `グループ`, `調達品コード`
- `納品LT`, `調達品メモ`, `発注単位`, `発注単価`, `発注ロット数`, `納品回数`, `課税区分`
  - Từ `TAMT026_PRODUCTAGREEMENT`
- `仕入先確認日`
  - Từ `TAPR04_SCHEDULEDFORDELIVERYFILE`, nếu nhiều record thì lấy `分納回数` nhỏ nhất

### 9.4 Update / Confirm Validation Lookup Rules

Condition: nhiều validation và alarm chỉ áp dụng khi:
- `諸口コード対象 = 0`
- `依頼区分 != 07(サンプル)`

Trong trường hợp này hệ thống phải dùng `TAMT026_PRODUCTAGREEMENT` để kiểm tra:

- `発注単位`
- `調達品メモ`
- `課税区分`
- `発注単価`
- `発注ロット数`
- `納品回数`
- `納品LT`

Condition: nếu `仕入先コード` trên request rỗng trong event `更新`, dùng fallback từ `TAMT026_PRODUCTAGREEMENT.取引先コード`.

Condition: kiểm tra supplier-store tồn tại ở `TAMT024_PARTNERSTORE` theo `取引先コード + 店舗コード + 会社コード`.

### 9.5 Numbering Rules

Condition: insert mới qua `確定` phải cấp phát `発注依頼番号` bằng `TAOR71_REQUESTNOCONTROL`.

Unresolved ambiguity:
Impact:
Handling:
Risk:
- Ambiguity: item definition của `【入力】.発注番号` ghi format `YYYYMMDD+P+99999`, trong khi search/result sheet và insert mapping ghi `YYYYMMDD+R+99999`.
- Impact: nếu implement sai prefix sẽ gây mismatch giữa search, display, và insert.
- Handling: ưu tiên prefix `R` vì được hỗ trợ bởi search/result/query sheet; ghi rõ cần business xác nhận lại.
- Risk: medium

## 10. Output Specification

### 10.1 External Output

- `TBD based on source artifacts`
- Workbook hiện tại không mô tả file output, export, download, print, hoặc batch output.

### 10.2 Processing Outputs by Event

**Event `move_or_restore_trash_records`**
- Output type: DB update
- Condition: non-trash view -> set `TAOR59_ANACORDERREQUEST.ORDERCATEGORY = 2`
- Condition: trash view -> set `TAOR59_ANACORDERREQUEST.ORDERCATEGORY = 0`
- Regeneration rule: sau update phải search lại theo current conditions

**Event `process_selected_requests_to_orders`**
- Output type: nghiệp vụ tạo order
- Pre-checks: selected rows, deadline, approval status, past due, master checks, alarms
- Confirm popup: required by message `MQ000031`
- Processing outputs:
  - create `ANAC発注`
  - create `納品予定ファイル`
  - update source requests to ordered state
- Regeneration rule: sau xử lý phải search lại theo current conditions
- Transaction notes: `Non-inferable from current artifacts`
- Rollback behavior: `Non-inferable from current artifacts`

**Event `confirm_input_request`**
- Output type: DB insert/update on `TAOR59_ANACORDERREQUEST`
- Pre-checks: required + deadline + master + alarm checks
- Confirm popup: required by message `MQ000004`
- Update branch:
  - update selected fields only
  - increment `版数`
- Insert branch:
  - auto numbering
  - set workbook constants
- Regeneration rule: sau lưu phải search lại current conditions

### 10.3 Forbidden External Behavior

Condition: không được tự bổ sung file output/export feature cho màn hình này nếu chỉ dựa trên workbook hiện tại.
Condition: không được dùng dataset của page hiện tại để thay thế cho search/query lại trong các event update nếu event yêu cầu xử lý selected persisted rows.

## 11. Validation Rules

### 11.1 Blocking Validation and Message Mapping

| Event | Condition | Message Code | Notes |
|---|---|---|---|
| `表示` | `工場` trống | `ME000116` | Search required check |
| `表示` | Một trong 6 field ngày bắt buộc bị trống | `ME000116` | Search required check |
| `表示` | `セクションコード`, `グループコード`, `発注番号`, `仕入先コード`, `調達品コード`, `調達品メモ` vượt max length | `ME000050` | Search max length |
| `表示` | Bất kỳ field ngày nào sai format | `ME000006` | Search date format |
| `表示` | `開始日 > 終了日` cho một trong 3 cặp ngày | `MEA00006` | Search range logic |
| `表示` | Không có dữ liệu phù hợp | `MI000001` | Search no-data |
| `ゴミ箱` | Chưa chọn dòng nào | `ME000070` | Applies before move/restore |
| `ゴミ箱` | Chuyển vào trash cần confirm | `MQA00015` | Message text non-inferable |
| `ゴミ箱` | Khôi phục khỏi trash cần confirm | `MQA00019` | Message text non-inferable |
| `更新` | Chưa chọn dòng nào | `ME000070` | Processing target check |
| `更新` | Quá giờ deadline khi không có release override | `MEA00020` | Deadline check |
| `更新` | Selected request chưa ở trạng thái `承認済` | `MEA00012` | Approval status check |
| `更新` | `業務日付 > 納期` | `MEA00015` | Past delivery date check |
| `更新` | Unit master check fail | `ME000014` | Under conditional scope |
| `更新` | Delivery division master check fail | `Non-inferable from current artifacts` | Error sheet has no code in this row |
| `更新` | Supplier-store master check fail | `Non-inferable from current artifacts` | Error sheet has no code in this row |
| `更新` | User confirms processing | `MQ000031` | Confirmation before DB processing |
| `新規` | Có input dở dang, reset cần confirm | `MQ000018` | Confirmation only |
| `確定` | Field bắt buộc ở vùng `【入力】` trống | `ME000116` | Input required check |
| `確定` | Quá giờ deadline khi không có release override | `MEA00020` | Deadline check |
| `確定` | Existing detail không ở `承認済` | `MEA00012` | Existing-detail only |
| `確定` | Unit master check fail | `ME000014` | Conditional scope |
| `確定` | Product memo check fail | `ME000023` | Conditional scope |
| `確定` | Tax category check fail | `ME000024` | Conditional scope |
| `確定` | Unit price check fail | `ME000025` | Conditional scope |
| `確定` | Order lot check fail | `ME000026` | Conditional scope |
| `確定` | Delivery division master check fail | `MEA00028` | Per error sheet mapping |
| `確定` | Supplier-store master check fail | `ME000014` | Workbook reuses same code in error sheet; keep as-is |
| `確定` | Final confirm before save | `MQ000004` | Confirmation only |

### 11.2 Alarm Rules

Condition: các alarm dưới đây không mô tả rõ là blocking; workbook mô tả là `アラーム内容` để hiển thị và lưu.

| Alarm Rule | Condition | Source |
|---|---|---|
| Order lot alarm | `発注依頼数 % 発注ロット数 != 0` | `名称マスタ(3081)` |
| Delivery LT alarm | `納期 - 納品LT - 受注受付無しの日数 < 基準日` | `名称マスタ(3082)` |
| Max order amount alarm | `発注金額 >= 発注依頼最大金額` | `名称マスタ(3078)` |
| Alarm composition | Nhiều alarm phải nối bằng `・` trong `アラーム内容` | Event sheet IV0010 / IV0013 |
| Alarm row color | Nếu `アラーム内容 != NULL` thì row màu đỏ | Item definition row for result area |

Condition: `基準日` cho delivery LT alarm = ngày hiện tại; nếu `締切解除有効時間 < システム日時` thì dùng `ngày hiện tại + 1`.

### 11.3 Permission Rules

| Permission Mode | Behavior |
|---|---|
| `更新可能` | Dùng được toàn bộ chức năng màn hình |
| `閲覧のみ` | Chỉ xem và lọc/tìm kiếm; update-related behaviors phải bị chặn |
| `使用不能` | Không được mở màn hình |

## 12. Acceptance Criteria

### 12.1 Initialization and Permission

AC-SUPORD-019: Khi người dùng có quyền `更新可能`, màn hình phải hiển thị đầy đủ search area, result area, và input area.
AC-SUPORD-020: Khi người dùng có quyền `閲覧のみ`, màn hình phải cho phép xem và tìm kiếm nhưng không được thực hiện update-related nghiệp vụ.
AC-SUPORD-021: Khi người dùng có quyền `使用不能`, màn hình không được phép mở.
AC-SUPORD-022: `工場` ở search area và input area phải default theo login user factory khi khởi tạo/new mode theo item definition.

### 12.2 Search Field Behavior

AC-SUPORD-023: Modal `セクション検索`, `グループ検索`, `仕入先検索`, `調達品検索` phải trả dữ liệu về đúng field mục tiêu của area đang thao tác.
AC-SUPORD-024: Calendar modal phải gán ngày được chọn về đúng field target và không được thay đổi field khác.
AC-SUPORD-025: Search phải chặn khi thiếu `工場` hoặc thiếu một trong các ngày bắt buộc và hiển thị `ME000116`.
AC-SUPORD-026: Search phải chặn khi bất kỳ date field nào sai format và hiển thị `ME000006`.
AC-SUPORD-027: Search phải chặn khi một range có `開始日 > 終了日` và hiển thị `MEA00006`.
AC-SUPORD-028: Search phải chặn khi search text vượt max length và hiển thị `ME000050`.

### 12.3 Search Results and Summaries

AC-SUPORD-029: Search phải áp dụng exact match cho `工場`, `セクションコード`, `グループコード`, `発注種別`, `依頼区分`, `仕入先コード`, `調達品コード` khi các field này có giá trị.
AC-SUPORD-030: Search phải áp dụng fuzzy match cho `発注番号` và `調達品メモ`.
AC-SUPORD-031: Khi `表示区分 = 締切解除中のみ`, search chỉ được trả về các dòng có `締切解除有効時間 >= 現在日時`.
AC-SUPORD-032: Khi không có dữ liệu phù hợp, search phải hiển thị `MI000001`, giữ nguyên conditions, và không hiển thị row dữ liệu.
AC-SUPORD-033: Cột kết quả phải hiển thị đúng thứ tự theo layout gồm `発注番号`, `ステータス`, `依頼区分`, `依頼作成区分`, `セクション`, `グループ`, `調達品コード`, `調達品名`, `調達品メモ`, `仕入先名`, `仕入先確認日`, `発注依頼日`, `納期`, `納品区分`, `発注数`, `単位`, `発注単価`, `発注全額`, `送信区分`, `発注日`, `発注担当者`, `版数`.
AC-SUPORD-034: `仕入先確認日` phải lấy từ `納品予定ファイル`; nếu không có dữ liệu tương ứng thì hiển thị trống.
AC-SUPORD-035: `送信区分` phải hiển thị giá trị cố định `WEBEDI`.
AC-SUPORD-036: `アラート件数` và `支払予定額（税抜）` không được phụ thuộc vào page hiện tại.
AC-SUPORD-037: `全選択` chỉ được check các dòng có row checkbox đang selectable.
AC-SUPORD-038: `ゴミ箱` button phải chỉ enable khi có điều kiện enable theo workbook.
AC-SUPORD-039: `更新` button phải chỉ enable khi có ít nhất 1 row được chọn và người dùng có quyền `更新可能`.

### 12.4 Deadline, Sorting, and Visual State

AC-SUPORD-040: Sau `表示`, nếu `グループマスタ.締切解除有効時間 >= 現在日時`, `締切解除ステータス` phải hiển thị text có chứa thời điểm hết hiệu lực; nếu không thỏa thì để trống.
AC-SUPORD-041: Các dòng `締切解除中` phải đứng trước các dòng khác trong kết quả tìm kiếm.
AC-SUPORD-042: Dòng `締切解除中` phải hiển thị màu đỏ.
AC-SUPORD-043: Dòng có `アラーム内容 != NULL` phải hiển thị màu đỏ.

### 12.5 Trash Processing

AC-SUPORD-044: Khi đang không ở trash view, bấm `ゴミ箱` với selected rows hợp lệ phải hiển thị confirm `MQA00015`; chọn `はい` thì set `ORDERCATEGORY = 2` cho các dòng được chọn và refresh search.
AC-SUPORD-045: Khi đang ở trash view, bấm `ゴミ箱` với selected rows hợp lệ phải hiển thị confirm `MQA00019`; chọn `はい` thì khôi phục `ORDERCATEGORY = 0` cho các dòng được chọn và refresh search.
AC-SUPORD-046: Nếu không có dòng nào được chọn trước khi bấm `ゴミ箱`, hệ thống phải hiển thị `ME000070` và không thay đổi DB.

### 12.6 Existing Detail and New Detail

AC-SUPORD-047: Click link `発注番号` phải mở đúng dữ liệu bản ghi vào vùng `【入力】`.
AC-SUPORD-048: Trong existing detail state, chỉ `発注数` được editable.
AC-SUPORD-049: Bấm `新規` khi đang có dữ liệu dở dang phải yêu cầu confirm `MQ000018`.
AC-SUPORD-050: Ở new detail state, các field required phải được kiểm tra trước khi `確定`.
AC-SUPORD-051: `発注金額` phải được tính bằng `発注数 x 発注単価` và phản ánh đúng trên màn hình trước khi lưu.
AC-SUPORD-052: Khi `諸口コード対象 = 0` và `依頼区分 != 07`, `確定` phải thực hiện các master checks theo agreement table trước khi lưu.

### 12.7 Confirm Save

AC-SUPORD-053: `確定` phải hiển thị confirm `MQ000004`; chọn `いいえ` thì không được ghi DB.
AC-SUPORD-054: Ở update branch của `確定`, hệ thống chỉ được update các field được mapping là editable/updateable, đồng thời tăng `版数 + 1`.
AC-SUPORD-055: Ở insert branch của `確定`, hệ thống phải cấp phát mới `発注依頼番号`, insert bản ghi mới, và set các constant như `発注種別 = 2`, `発注分類区分 = 3`, `データ区分 = 1`, `承認ステータス = 2`, `発注区分 = 0`, `版数 = 1`.
AC-SUPORD-056: Sau `確定` thành công, hệ thống phải search lại theo current conditions.

### 12.8 Update Processing to Orders

AC-SUPORD-057: `更新` phải chặn khi không có selected row và hiển thị `ME000070`.
AC-SUPORD-058: `更新` phải chặn khi selected row không ở trạng thái `承認済` và hiển thị `MEA00012`.
AC-SUPORD-059: `更新` phải chặn khi quá giờ deadline mà không có `締切解除` hợp lệ và hiển thị `MEA00020`.
AC-SUPORD-060: `更新` phải chặn khi `業務日付 > 納期` và hiển thị `MEA00015`.
AC-SUPORD-061: `更新` phải hiển thị confirm `MQ000031`; chọn `いいえ` thì không tạo `ANAC発注`, không tạo `納品予定ファイル`, và không đổi trạng thái request.
AC-SUPORD-062: `更新` phải nhóm selected request rows theo grouping key workbook-defined trước khi tạo `ANAC発注`.
AC-SUPORD-063: `更新` phải tạo `ANAC発注`, tạo `納品予定ファイル`, update selected request rows sang `発注済`, rồi refresh search.
AC-SUPORD-064: Khi `取引先コード` trên request rỗng, `更新` phải dùng fallback supplier code từ `調達品契約マスタ` cho các validation tiếp theo.

### 12.9 Alarm Behavior

AC-SUPORD-065: Khi có nhiều alarm cùng lúc, `アラーム内容` phải nối các message bằng ký tự `・`.
AC-SUPORD-066: Alarm `発注ロット数`, `納品LT`, và `最大発注金額` phải được đánh giá theo workbook rule trước khi `更新` hoặc `確定`.
AC-SUPORD-067: Alarm phải được lưu lại vào `ALARMKBN`, `ALARM` trên `TAOR59_ANACORDERREQUEST` trong event `確定` theo mapping workbook.

### 12.10 Ambiguity Boundaries

AC-SUPORD-068: Hệ thống không được tự hiển thị nút `計算` nếu build theo layout hiện tại, vì layout không còn hiển thị nút này dù item/event sheet còn dấu vết.
AC-SUPORD-069: Hệ thống không được tự áp đặt mapping hoàn chỉnh cho mọi giá trị `ステータス/検索対象` vượt quá các branch có bằng chứng trực tiếp trong workbook.
AC-SUPORD-070: Hệ thống không được sử dụng prefix `P` cho `発注番号` nếu chưa có xác nhận business bổ sung, vì evidence hiện hành nghiêng về prefix `R`.

## 13. Test Scenarios

SC-SUPORD-001
- Input:
  - Login user có quyền `更新可能`
- Steps:
  - Mở màn hình
- Expected Result:
  - Màn hình vào init state, `工場` lấy theo login user, result area rỗng, input area reset, `件数 = 0件`

SC-SUPORD-002
- Input:
  - Bỏ trống một field bắt buộc trong 3 cặp ngày
- Steps:
  - Bấm `表示`
- Expected Result:
  - Hệ thống chặn search và hiển thị `ME000116`

SC-SUPORD-003
- Input:
  - `発注日_開始日 = 2026/03/10`
  - `発注日_終了日 = 2026/03/01`
- Steps:
  - Bấm `表示`
- Expected Result:
  - Hệ thống chặn search và hiển thị `MEA00006`

SC-SUPORD-004
- Input:
  - Search conditions hợp lệ
  - `表示区分 = 締切解除中のみ`
- Steps:
  - Bấm `表示`
- Expected Result:
  - Chỉ các dòng có `締切解除有効時間 >= 現在日時` được hiển thị

SC-SUPORD-005
- Input:
  - Search conditions hợp lệ có nhiều hơn 1 page dữ liệu
- Steps:
  - Bấm `表示`
  - Chuyển sang page 2
- Expected Result:
  - Search conditions giữ nguyên, sort không đổi, summary totals vẫn đại diện toàn bộ matched rows

SC-SUPORD-006
- Input:
  - Kết quả tìm kiếm có dòng `発注区分 = 1`
- Steps:
  - Kiểm tra row checkbox của dòng đó
- Expected Result:
  - Checkbox disabled và không bị chọn bởi `全選択`

SC-SUPORD-007
- Input:
  - Search conditions trả về có row `アラーム内容 != NULL`
- Steps:
  - Bấm `表示`
- Expected Result:
  - Dòng có alarm hiển thị màu đỏ

SC-SUPORD-008
- Input:
  - Search trong normal view, chọn ít nhất 1 dòng `未発注`
- Steps:
  - Bấm `ゴミ箱`
  - Chọn `はい`
- Expected Result:
  - Hệ thống cập nhật `ORDERCATEGORY = 2` cho các dòng đã chọn và refresh kết quả

SC-SUPORD-009
- Input:
  - Search trong trash view, chọn ít nhất 1 dòng
- Steps:
  - Bấm `ゴミ箱`
  - Chọn `はい`
- Expected Result:
  - Hệ thống khôi phục `ORDERCATEGORY = 0` cho các dòng đã chọn và refresh kết quả

SC-SUPORD-010
- Input:
  - Search thành công có ít nhất 1 dòng
- Steps:
  - Click link `発注番号` của 1 dòng
- Expected Result:
  - Vùng `【入力】` nạp đúng dữ liệu bản ghi; chỉ `発注数` editable

SC-SUPORD-011
- Input:
  - Vùng `【入力】` đang có dữ liệu chưa lưu
- Steps:
  - Bấm `新規`
  - Chọn `いいえ`
- Expected Result:
  - Dữ liệu đang nhập không bị reset

SC-SUPORD-012
- Input:
  - Vùng `【入力】` ở new mode với đầy đủ field required hợp lệ
- Steps:
  - Bấm `確定`
  - Chọn `はい`
- Expected Result:
  - Hệ thống insert mới vào `TAOR59_ANACORDERREQUEST`, cấp phát `発注依頼番号`, set constants đúng, rồi refresh search

SC-SUPORD-013
- Input:
  - Vùng `【入力】` ở existing detail mode, sửa `発注数`
- Steps:
  - Bấm `確定`
  - Chọn `はい`
- Expected Result:
  - Hệ thống update bản ghi hiện có, tăng `版数 + 1`, cập nhật `ORDERREQUESTQTYCHANGES = 発注数`, refresh search

SC-SUPORD-014
- Input:
  - Chọn nhiều dòng hợp lệ để `更新`
- Steps:
  - Bấm `更新`
  - Chọn `はい`
- Expected Result:
  - Hệ thống tạo `ANAC発注`, tạo `納品予定ファイル`, update request sang `発注済`, và refresh search

SC-SUPORD-015
- Input:
  - Chọn 1 dòng chưa `承認済`
- Steps:
  - Bấm `更新`
- Expected Result:
  - Hệ thống chặn xử lý và hiển thị `MEA00012`

SC-SUPORD-016
- Input:
  - `発注数`, `発注単価` được nhập ở vùng `【入力】`
- Steps:
  - Thay đổi `発注数`
  - Quan sát `発注金額`
- Expected Result:
  - `発注金額` được cập nhật bằng `発注数 x 発注単価`

SC-SUPORD-017
- Input:
  - Search conditions hợp lệ nhưng không có dữ liệu
- Steps:
  - Bấm `表示`
- Expected Result:
  - Hệ thống hiển thị `MI000001`, không hiển thị result rows

SC-SUPORD-018
- Input:
  - User có quyền `閲覧のみ`
- Steps:
  - Mở màn hình
  - Thực hiện `表示`
  - Thử thao tác `更新`
- Expected Result:
  - Search được phép chạy; `更新` không được phép thực hiện

## 14. Trace Mapping

| Requirement ID | Logic / rule | SQL / condition / table liên quan nếu có | Expected implementation location |
|---|---|---|---|
| `REQ-SUPORD-001` | Khởi tạo search/input area và reset result | `TMT003_STORE`, `TMT050_NAME`, initial defaults | UI screen initializer / page load handler |
| `REQ-SUPORD-002` | Required check cho `工場` và 3 cặp ngày search | `ME000116` | Search form validator |
| `REQ-SUPORD-003` | Max length search fields | `ME000050` | Search form validator |
| `REQ-SUPORD-004` | Date format và start/end logic cho search | `ME000006`, `MEA00006` | Search form validator |
| `REQ-SUPORD-005` | Search filter by `表示区分 = 締切解除中のみ` | `TAMT029_GROUP.REQORDDEADLINETM >= now` | Search query builder |
| `REQ-SUPORD-006` | Search target branch `ゴミ箱`, `発注済`, `入荷済` | `TAOR59_ANACORDERREQUEST.ORDERCATEGORY`, `TAPR11_ANACPURCHASESLIPDETAIL` | Search query builder |
| `REQ-SUPORD-007` | Result sort and red-row display | sort keys from item note; `ALARM != NULL`; release rows | Search result presenter / UI renderer |
| `REQ-SUPORD-008` | `アラート件数` and `支払予定額（税抜）` are global matched summaries | `発注アラーム区分`, `発注全額` on matched dataset | Search summary aggregator |
| `REQ-SUPORD-009` | `ゴミ箱` move to trash | `TAOR59_ANACORDERREQUEST.ORDERCATEGORY = 2`, confirm `MQA00015` | Trash action service |
| `REQ-SUPORD-010` | `ゴミ箱` restore from trash | `TAOR59_ANACORDERREQUEST.ORDERCATEGORY = 0`, confirm `MQA00019` | Trash action service |
| `REQ-SUPORD-011` | Open existing detail from result link | Load `TAOR59_ANACORDERREQUEST` + derived masters | Detail load handler |
| `REQ-SUPORD-012` | Existing detail only allows qty edit | input control note in item sheet | Input state controller |
| `REQ-SUPORD-013` | New mode reset and confirm before discard | `MQ000018` | Input state controller |
| `REQ-SUPORD-014` | Save existing detail updates selected fields and increments version | `TAOR59_ANACORDERREQUEST`, `EDITIONNUMBER = old + 1` | Confirm save service |
| `REQ-SUPORD-015` | Save new detail inserts request row with constants and numbering | `TAOR59_ANACORDERREQUEST`, `TAOR71_REQUESTNOCONTROL` | Confirm save service |
| `REQ-SUPORD-016` | Update selected rows validates deadline/approval/master checks | `MEA00020`, `MEA00012`, `ME000014`, related masters | Update processing validator |
| `REQ-SUPORD-017` | Update selected rows groups requests to create `ANAC発注` | grouping key from event sheet | Order creation application service |
| `REQ-SUPORD-018` | Update selected rows creates schedule records | `TAPR04_SCHEDULEDFORDELIVERYFILE` | Delivery schedule service |
| `REQ-SUPORD-019` | Update selected rows marks source requests as ordered | `TAOR59_ANACORDERREQUEST` status / ordered flag update | Order creation application service |
| `REQ-SUPORD-020` | Alarm composition and persistence | `TMT050_NAME(3078,3081,3082)`, `ALARMKBN`, `ALARM` | Alarm rule service |
| `REQ-SUPORD-021` | Permission modes `更新可能 / 閲覧のみ / 使用不能` | Layout notes rows 77-79 | Authorization guard / UI permission controller |
| `REQ-SUPORD-022` | Amount calculation `発注金額 = 発注数 x 発注単価` | `ORDERPRICE` | Input calculation handler |
| `REQ-SUPORD-023` | Supplier fallback when request supplier blank during `更新` | `TAMT026_PRODUCTAGREEMENT.PARTNERCD` | Update processing validator |
| `REQ-SUPORD-024` | `発注番号` format prefix ambiguity | `TAOR71_REQUESTNOCONTROL`, item/query sheets | unknown |

## 15. Forbidden Behavior

FB-SUPORD-001: Không được cho phép người dùng `閲覧のみ` thực thi `ゴミ箱`, `更新`, hoặc `確定`.
FB-SUPORD-002: Không được cho phép row checkbox selectable khi `発注区分 = 1(発注済)`.
FB-SUPORD-003: Không được cập nhật `ORDERCATEGORY = 2` khi người dùng đang ở trash view; trash view phải dùng logic restore.
FB-SUPORD-004: Không được insert bản ghi mới khi người dùng đang ở existing detail mode và bấm `確定`.
FB-SUPORD-005: Không được update bản ghi hiện có khi đang ở new mode và chưa có `発注依頼番号` được cấp phát.
FB-SUPORD-006: Không được bỏ qua deadline check khi `締切解除` không còn hiệu lực.
FB-SUPORD-007: Không được bỏ qua `承認済` check trong event `更新`.
FB-SUPORD-008: Không được tính `アラート件数` hay `支払予定額（税抜）` chỉ trên page hiện tại.
FB-SUPORD-009: Không được áp dụng suy đoán tự do cho các giá trị `ステータス/検索対象` không có branch rõ ràng trong workbook.
FB-SUPORD-010: Không được đưa nút `計算` vào layout hiện hành nếu chỉ bám theo layout sheet; workbook cho thấy dấu vết cũ nhưng button không còn hiện trong layout.
FB-SUPORD-011: Không được để người dùng nhập tay `発注番号` trong new mode.
FB-SUPORD-012: Không được sử dụng prefix `P` cho `発注番号` nếu chưa có xác nhận business bổ sung.
FB-SUPORD-013: Không được bỏ qua supplier-store master check khi validation scope yêu cầu.
FB-SUPORD-014: Không được giả định transaction behavior chi tiết vượt quá phần đã có trong artifacts; phải đánh dấu `unknown` nếu tầng implementation chưa rõ.

## 16. Open Questions / Assumptions

### Confirmed assumptions

- Assumption: `更新` là xử lý nghiệp vụ tạo order/schedule từ selected result rows, không phải nút save trực tiếp vùng `【入力】`.
- Assumption: `確定` là save của vùng `【入力】` vào `TAOR59_ANACORDERREQUEST`.
- Assumption: page size tồn tại nhưng không xác định được từ current artifacts.
- Assumption: message text không có trong source; chỉ message code và điều kiện sử dụng mới là nguồn sự thật.

### Unresolved ambiguities

Ambiguity:
- Layout có field `表示区分` với 2 radio option, nhưng sheet `【画面項目定義】` không có row định nghĩa field này.
Impact:
- Thiếu item metadata cho default value, required flag, event ID, và source binding.
Handling:
- Giữ field trong spec vì layout thể hiện rõ; map tạm sang `TMT050_NAME` group `3070` dựa trên sheet khởi tạo; implementation location để `unknown` nếu codebase chưa có binding.
Risk:
- medium

Ambiguity:
- `ステータス` trong item sheet và layout nhiều khả năng chính là `検索対象` trong event/query sheets, nhưng tên gọi không thống nhất.
Impact:
- Sai mapping có thể làm sai filter search và sai enablement logic của `ゴミ箱`.
Handling:
- Trong spec, dùng cụm `ステータス/検索対象` và ưu tiên logic của event/query sheet cho xử lý nghiệp vụ.
Risk:
- high

Ambiguity:
- `【入力】.発注番号` có format `YYYYMMDD+P+99999` ở item sheet, trong khi search/result/query insert mapping lại dùng `YYYYMMDD+R+99999`.
Impact:
- Có nguy cơ inconsistency giữa search, display, save, và numbering service.
Handling:
- Ưu tiên `R` vì có nhiều bằng chứng hơn; giữ ambiguity để business xác nhận.
Risk:
- high

Ambiguity:
- Event `open_request_detail` không có event ID riêng trong `【イベント一覧】`, dù item note và input control thể hiện hành vi này tồn tại.
Impact:
- Thiếu nguồn chính thức cho preconditions, validation, và refresh rule của hành vi click link.
Handling:
- Dựng event như inferred business event từ item definition và layout; đánh dấu nguồn chính là note vùng `【入力】`.
Risk:
- medium

Ambiguity:
- Nút `計算` còn tồn tại trong item/event sheet (`IV0011`) nhưng note cho biết đã bị xóa, và layout hiện hành không hiển thị nút này.
Impact:
- Dễ gây implement dư thừa 1 control không còn nằm trong UI mục tiêu.
Handling:
- Không đưa `計算` thành active visible action trong spec chính; ghi rõ forbidden behavior không tự thêm lại.
Risk:
- medium

Ambiguity:
- Một số validation của event `更新` có mô tả trong error sheet nhưng không có message code tại đúng dòng.
Impact:
- Không thể map đầy đủ message catalog cho implementation-ready validator.
Handling:
- Giữ validation rule, nhưng message code để `Non-inferable from current artifacts`.
Risk:
- medium

### Non-inferable items

- Non-inferable from current artifacts: SQL text hoàn chỉnh cho search/update/insert
- Non-inferable from current artifacts: technical table name của `ANAC発注`
- Non-inferable from current artifacts: page size
- Non-inferable from current artifacts: transaction scope/rollback chi tiết cho `更新`
- Non-inferable from current artifacts: message text cho các message code
- Non-inferable from current artifacts: exact default value của `ステータス/検索対象`
- Non-inferable from current artifacts: exact default value của `表示区分`

### Explicit boundaries

- Boundary: spec không tự tạo branch search target ngoài các branch có evidence rõ.
- Boundary: spec không tự đưa file output/export vào màn hình này.
- Boundary: spec không tự thêm event invisible/deleted vào layout hiện hành.
- Boundary: nơi triển khai technical cụ thể của `ANAC発注` để `unknown` trong trace cho đến khi có source bổ sung.

## 17. Developer Notes

- Ưu tiên source priority: user instruction > workbook > layout > knowledge example.
- Tách rõ 3 flow khác nhau:
  1. search/list flow
  2. detail save flow (`確定`)
  3. selected-row order processing flow (`更新`)
- Với `更新`, cần xử lý aggregation key đúng workbook; không được coi mỗi selected row luôn tạo 1 order riêng.
- Với `確定`, phân nhánh insert/update theo `inputMode`, không theo việc button `新規` có từng được bấm hay không.
- `締切解除` ảnh hưởng cả UI ordering, display color, và permission-like override; cần gom rule ở một domain service hoặc policy layer.
- `ステータス/検索対象` là khu vực rủi ro cao do workbook dùng thuật ngữ không thống nhất; nên đóng gói enum/mapping tại 1 chỗ có test đầy đủ.
- `発注番号` prefix cũng là vùng rủi ro cao; không hard-code prefix khác `R` nếu chưa được chốt bổ sung.
- `TBD based on source artifacts` cần giữ nguyên ở những chỗ thiếu message text, SQL text, transaction detail, hoặc technical table name.

## Appendix A. Source Mapping

| Spec Area | Source Artifact | Sheet / Row / Note |
|---|---|---|
| Screen identity | Excel workbook | `【画面レイアウト】仕入先発注入力` rows 3-6 |
| Permission rules | Excel workbook | `【画面レイアウト】仕入先発注入力` rows 75-79 |
| Search fields | Excel workbook | `【画面項目定義】仕入先発注入力` rows 8-40 |
| Result area rules | Excel workbook | `【画面項目定義】仕入先発注入力` rows 41-72 |
| Input area fields | Excel workbook | `【画面項目定義】仕入先発注入力` rows 73-106 |
| Layout presence of `表示区分` | Excel workbook | `【画面レイアウト】仕入先発注入力` row 24 |
| Search event | Excel workbook | `【イベント一覧】仕入先発注入力` rows 29-36 |
| Clear event | Excel workbook | `【イベント一覧】仕入先発注入力` row 37 |
| Paging event | Excel workbook | `【イベント一覧】仕入先発注入力` row 38 |
| Trash move/restore event | Excel workbook | `【イベント一覧】仕入先発注入力` rows 39-49 |
| Update selected to order event | Excel workbook | `【イベント一覧】仕入先発注入力` rows 51-109 |
| New event | Excel workbook | `【イベント一覧】仕入先発注入力` rows 113-115 |
| Confirm save event | Excel workbook | `【イベント一覧】仕入先発注入力` rows 116-170 |
| Search validations and message codes | Excel workbook | `【エラーチェック】個別発注依頼入力` rows 7-26 |
| Trash/update/confirm message codes | Excel workbook | `【エラーチェック】個別発注依頼入力` rows 27-50 |
| Initial lookup tables | Excel workbook | `テーブル編集仕様(仕入先発注入力)（初期表示）` rows 6-43 |
| Search table filters | Excel workbook | `テーブル編集仕様((仕入先発注入力)（データ取得）` rows 6-135 |
| Trash update mapping | Excel workbook | `テーブル編集仕様((仕入先発注入力)（データ更新(ゴミ箱))` rows 5-102 |
| Confirm update mapping | Excel workbook | `テーブル編集仕様(仕入先発注入力)（データ更新(確定))` rows 5-54 |
| Confirm insert mapping | Excel workbook | `テーブル編集仕様(仕入先発注入力)（データ更新(確定))` rows 55-143 |
| Shared event naming convention | Knowledge file | `04_event_normalization_dictionary.md` |
| ASCII wireframe constraint | Knowledge file | `05_ascii_wireframe_standard.md` |
| Acceptance criteria writing style | Knowledge file | `03_acceptance_criteria_catalog.md` |
| Ambiguity handling style | Knowledge file | `07_source_mapping_and_assumption_rules.md` |
| Output structure baseline | Knowledge file | `01_target_output_template.md` |
| Example tone and sectioning | Reference markdown | `spec_pack_FPKH5260HS (1).md` |

## Appendix B. SQL / Table Reference

### B.1 SQL Availability

- SQL text hoàn chỉnh: `Non-inferable from current artifacts`
- Available source type: `テーブル編集仕様` by table, field, and filter condition
- Implementation boundary: query text phải được technical team dựng dựa trên table edit sheets, không tự suy luận thêm hidden filter

### B.2 Table Reference Summary

| Table / Object | Usage |
|---|---|
| `TMT003_STORE` | Initial lookup for `工場` |
| `TMT050_NAME` | Lookup for search lists, input lists, code-to-name translation, account/tax/alarm rules |
| `TAOR59_ANACORDERREQUEST` | Primary source and persistence target |
| `TAPR11_ANACPURCHASESLIPDETAIL` | Purchase slip detail existence for `入荷済` |
| `TAMT029_GROUP` | Group info and deadline release window |
| `TAPR04_SCHEDULEDFORDELIVERYFILE` | Supplier confirmation date and insert target on `更新` |
| `TAMT026_PRODUCTAGREEMENT` | Agreement-based validation and fallback data |
| `TAMT024_PARTNERSTORE` | Supplier-store existence validation |
| `TAOR71_REQUESTNOCONTROL` | Number control for new request number |
| `ANAC発注` | Order target created on `更新`; technical table name unknown |

### B.3 Condition Reference

Condition: search by `発注番号` uses fuzzy match.
Condition: search by `調達品メモ` uses fuzzy match.
Condition: date ranges on `発注依頼日`, `発注日`, `納品日` are inclusive from/to comparisons.
Condition: `表示区分 = 締切解除中のみ` requires `REQORDDEADLINETM >= current datetime`.
Condition: search target `ゴミ箱` uses `ORDERCATEGORY = 2`.
Condition: search target `発注済` uses `ORDERCATEGORY = 1`.
Condition: search target `入荷済` requires matching `ANAC仕入伝票明細`.
Condition: `ゴミ箱` move updates `ORDERCATEGORY = 2`.
Condition: restore from `ゴミ箱` updates `ORDERCATEGORY = 0`.
Condition: `確定` insert sets `発注種別 = 2`, `発注分類区分 = 3`, `データ区分 = 1`, `承認ステータス = 2`, `発注区分 = 0`, `版数 = 1`, `削除フラグ = 0`.
Condition: `確定` update increments `版数 + 1`.
Condition: `更新` groups selected request rows before creating `ANAC発注`.
Condition: `更新` also inserts `納品予定ファイル` and updates request status to ordered.

### B.4 Non-inferable SQL Areas

- Non-inferable from current artifacts: exact SELECT list and JOIN syntax for result query
- Non-inferable from current artifacts: exact INSERT statement for `ANAC発注`
- Non-inferable from current artifacts: exact UPDATE statement that marks request rows as ordered
- Non-inferable from current artifacts: exact transaction boundary and rollback SQL
