# Spec Pack – FPMT0010AC / SPMT00101AC: セクションマスタ (Quản lý Master Section)

> **Nguồn sự thật duy nhất** cho phạm vi change của màn hình này.  
> Spec này được tổng hợp từ layout màn hình, các sheet thiết kế Excel, các spec-pack mẫu và phần trả lời làm rõ của stakeholder.
> Ngày tạo: 2026-03-13

---

## 1. Feature Overview

**Chức năng**: セクションマスタ – màn hình bảo trì master Section thuộc nghiệp vụ 購買  
**Function ID**: `FPMT0010AC`  
**Screen ID**: `SPMT00101AC`

### Mục tiêu
- Tìm kiếm và hiển thị danh sách section theo **拠点** và **セクション**
- Thêm mới section
- Cập nhật section đang hiệu lực
- Xóa logic section
- Xuất CSV toàn bộ tập kết quả của lần search gần nhất
- Hỗ trợ hiển thị dữ liệu đã xóa khi người dùng bật option tương ứng

### Kết luận thiết kế cấp cao
Màn hình được mô hình hóa là **1 base screen** với **4 trạng thái/biến thể hiển thị chính**:
1. Khởi tạo / sẵn sàng tìm kiếm
2. Thêm mới
3. Chỉnh sửa record đang hiệu lực
4. Danh sách có hiển thị record đã xóa nhưng record đã xóa **không được chọn để sửa**

---

## 2. Background

Màn hình này quản lý dữ liệu bảng `TAMT030_SECTION`.  
Thiết kế hiện tại cho thấy ngoài các trường section cơ bản còn có các thuộc tính mở rộng:

- エリア (`OFFICEAREACD`)
- 管理組織 (`MANAGEMENTORGANIZATION`)
- 仕入計上集約単位 (`AGGREGATIONUNIT`)
- 在庫管理対象フラグ (`ZAIKOFLG`)
- 生産管理対象フラグ (`SEISANFLG`)

Ngoài ra, CSV export còn bao gồm thêm các trường thay đổi dự kiến và ngày áp dụng:
- `MANAGEMENTORGANIZATIONCHANGEOFPLANS`
- `MANAGEMENTORGANIZATIONAPPLICABLEDATE`
- `AGGREGATIONUNITCHANGEOFPLANS`
- `AGGREGATIONUNITAPPLICATIONDATE`

Các trường này **không xuất hiện trên UI nhập liệu hiện tại**, nhưng vẫn tồn tại trong thiết kế bảng và định nghĩa CSV. Vì vậy spec này phân biệt rõ:
- **UI editable fields**
- **DB fields tồn tại nhưng không editable trên màn hình**

---

## 3. Scope

### In Scope
- Khởi tạo màn hình và load danh sách **拠点** cho dropdown
- Khôi phục điều kiện tìm kiếm bằng cơ chế common base của hệ thống
- Tìm kiếm section theo điều kiện hiện tại của vùng 検索条件
- Hiển thị danh sách kết quả, phân trang **25 record / page**
- Mở modal **セクション検索** từ vùng 検索条件
- Chọn 1 row đang hiệu lực trong kết quả để nạp xuống vùng 入力
- Thêm mới section vào `TAMT030_SECTION`
- Cập nhật section đang hiệu lực trong `TAMT030_SECTION`
- Xóa logic bằng `DELFLG = '1'`
- Xuất CSV theo định nghĩa sheet `【CSV項目定義】セクションマスタ`
- Hiển thị thông tin audit: 登録ユーザー名 / 登録日時 / 更新ユーザー名 / 更新日時
- Hỗ trợ quyền **更新可能** và **閲覧のみ** theo ghi chú item definition

### Out of Scope
- Khôi phục record đã xóa
- Import CSV
- Thay đổi cấu trúc bảng DB
- Đổi naming / giá trị file CSV vì tên file được cấu hình ở DB
- Định nghĩa chi tiết common framework cho search-condition persistence
- Thay đổi logic của modal セクション検索 (chỉ dùng như dependency)

---

## 4. Glossary

| Thuật ngữ JP | Thuật ngữ VN | Cột / Ý nghĩa kỹ thuật |
|---|---|---|
| 拠点 | Cơ sở / Factory-Site | `STORECD` |
| セクション | Section / Phân khu | Đơn vị master đang được bảo trì |
| セクションコード | Mã section | `SECTIONCD` |
| セクション名 | Tên section | `SECTIONNM` |
| セクション名（略称） | Tên rút gọn section | `SECTIONRYAKUNM` |
| エリア | Khu vực | `OFFICEAREACD` |
| 管理組織 | Tổ chức quản lý | `MANAGEMENTORGANIZATION` |
| 仕入計上集約単位 | Đơn vị tập hợp hạch toán mua hàng | `AGGREGATIONUNIT` |
| 在庫管理対象 | Đối tượng quản lý tồn kho | `ZAIKOFLG`, checkbox boolean |
| 生産管理対象 | Đối tượng quản lý sản xuất | `SEISANFLG`, checkbox boolean |
| 削除データ表示 | Hiển thị dữ liệu đã xóa | Radio/toggle cho search |
| 削除フラグ | Cờ xóa logic | `DELFLG`, `0`=active, `1`=deleted |
| 排他制御 | Kiểm soát đồng thời | Assumed optimistic locking qua `UPDDATETIME` cho update/delete |
| 画面初期値スナップショット | Snapshot điều kiện search lúc init | Dùng cho nút clear của vùng search |
| 最終検索条件 | Điều kiện của lần search gần nhất | Dùng cho paging + CSV export |

---

## 5. Base Screen Structure

### 5.1 Screen Identity
- **Tên màn hình**: セクションマスタ
- **Screen ID**: `SPMT00101AC`
- **Nghiệp vụ**: 購買 / マスタ
- **Layout model**: 3 vùng cố định
  - 検索条件
  - 検索結果
  - 入力

### 5.2 Layout Regions

#### A. 検索条件 (Search Condition Area)
Thành phần chính:
- 拠点 dropdown
- セクションコード input
- セクション検索 button (kính lúp)
- セクション名 label
- 削除データ表示 option
- CSV出力
- 表示
- クリア

#### B. 検索結果 (Result Area)
Thành phần chính:
- 件数
- paging link
- grid kết quả

Cột grid quan sát được từ artifact:
- No.
- 削除
- 拠点コード
- 拠点名
- セクションコード
- セクション名
- セクション名（略称）

#### C. 入力 (Input Area)
Thành phần chính:
- Audit labels: 登録ユーザー名 / 登録日時 / 更新ユーザー名 / 更新日時
- 新規
- 拠点
- セクションコード
- セクション名
- セクション名（略称）
- エリア
- 管理組織
- 仕入計上集約単位
- 在庫管理対象
- 生産管理対象
- 確定
- 削除

### 5.3 Core Components

#### Search Area Components
| Field | Type | Editable | Ghi chú |
|---|---|---|---|
| 拠点 | Dropdown | Yes | Init lấy danh sách từ `TMT003_STORE`; mặc định blank |
| セクションコード | Text | Yes | Có thể nhập tay hoặc set từ modal |
| セクション検索 | Button | Yes | Mở modal tra cứu section |
| セクション名 | Label | No | Được set bởi modal |
| 削除データ表示 | Toggle/Radio | Yes | Mặc định không hiển thị dữ liệu đã xóa |
| CSV出力 | Button | Yes | Visible cho 更新可能 và 閲覧のみ |
| 表示 | Button | Yes | Execute search |
| クリア | Button | Yes | Restore search-condition snapshot tại thời điểm init |

#### Result Grid Components
| Cột | Nguồn | Ghi chú |
|---|---|---|
| No. | FE generated sequence | Hiển thị số thứ tự trong trang |
| 削除 | `DELFLG` | `○` nếu `DELFLG='1'`, ngược lại blank |
| 拠点コード | `STORECD` | Từ `TAMT030_SECTION` |
| 拠点名 | Store short name | Từ `TMT003_STORE` |
| セクションコード | `SECTIONCD` | Link chỉ cho row active |
| セクション名 | `SECTIONNM` | |
| セクション名（略称） | `SECTIONRYAKUNM` | |

#### Input Area Components
| Field | Type | Required | Insert | Update | Ghi chú |
|---|---|---:|---|---|---|
| 拠点 | Dropdown | Yes | Editable | Disabled | Mặc định blank khi vào mode new |
| セクションコード | Text | Yes | Editable | Disabled | Business key cùng với CMPNYCD + STORECD |
| セクション名 | Text | Yes | Editable | Editable | |
| セクション名（略称） | Text | Yes | Editable | Editable | |
| エリア | Dropdown | Yes | Editable | Editable | Value source: `TAMT048_OFFICEAREA` |
| 管理組織 | Dropdown | Yes | Editable | Editable | Value source: `TMT050_NAME`, `RCDKBN=3022`, rule group by |
| 仕入計上集約単位 | Dropdown | Yes | Editable | Editable | Value source: `TMT050_NAME`, `RCDKBN=3102` |
| 在庫管理対象 | Checkbox | No | Editable | Editable | Default = checked (`1`) |
| 生産管理対象 | Checkbox | No | Editable | Editable | Default = unchecked (`0`) |
| 確定 | Button | - | Visible | Visible | Hidden/disabled với 閲覧のみ |
| 削除 | Button | - | Hidden | Visible | Chỉ active với row active; hidden/disabled với 閲覧のみ |
| 新規 | Button | - | Visible | Visible | Reset input area để vào mode insert |

### 5.4 Shared Actions
- Search conditions có thể được chỉnh trước khi bấm **表示**
- Paging và CSV luôn bám theo **điều kiện của lần search gần nhất**, không bám theo giá trị hiện đang sửa trên form search nếu user chưa bấm search lại
- Input area và Result area độc lập với search-area clear
- CSV export không giới hạn ở current page; xuất toàn bộ result set của last executed search

### 5.5 Result Area Rules
- Page size cố định: **25 records / page**
- Row deleted (`DELFLG='1'`) vẫn có thể xuất hiện khi user bật option hiển thị dữ liệu đã xóa
- Row deleted **không được click để load detail**
- Với row active, click `セクションコード` sẽ load detail xuống input area

### 5.6 State Variables
Các state bắt buộc ở frontend/backend orchestration:

| State | Mô tả |
|---|---|
| `searchConditionCurrent` | Giá trị hiện đang hiển thị ở search area |
| `searchConditionInitSnapshot` | Snapshot của search area tại thời điểm init sau khi common-base restore xong |
| `lastSearchedCondition` | Điều kiện của lần bấm 表示 gần nhất; paging/CSV dùng state này |
| `includeDeletedLastSearch` | Cờ hiển thị dữ liệu xóa của lần search gần nhất |
| `resultList` | Data grid hiện tại |
| `selectedRowKey` | Key record đang load ở input area (`CMPNYCD + STORECD + SECTIONCD`) |
| `formMode` | `INS` hoặc `UPD` |
| `formDirty` | Có thay đổi chưa lưu trong input area hay không |
| `selectedRecordDeleted` | Cờ record đang chọn có bị delete hay không; thực tế dự kiến luôn false vì deleted row không được click |
| `selectedRecordUpdDateTime` | Hidden timestamp để phục vụ optimistic locking khi update/delete (assumption) |


### 5.7 Wireframe (tham chiếu layout)

**Nguồn wireframe**: artifact layout do user cung cấp trong phiên làm việc này.  
**File tham chiếu**: `wireframe_spmt00101ac.png`

![Wireframe tham chiếu](wireframe_spmt00101ac.png)

#### 5.7.1 Wireframe mô tả dạng khối

```text
+--------------------------------------------------------------------------------------+
| 検索条件                                                                             |
| [拠点* ▼] [セクションコード____][🔍] [セクション名(label)]                           |
| [削除データ表示]                                                       [CSV出力][表示][クリア] |
+--------------------------------------------------------------------------------------+

+--------------------------------------------------------------------------------------+
| 検索結果                                                                             |
| 件数: n件                                                             [1][2][3]...   |
| +----+----+----------+----------+--------------+------------------+----------------+ |
| |No. |削除|拠点コード|拠点名     |セクションコード|セクション名       |セクション名略称| |
| +----+----+----------+----------+--------------+------------------+----------------+ |
| | ... kết quả từng hàng, scroll dọc/ngang, セクションコード là link khi row active ... |
+--------------------------------------------------------------------------------------+

+--------------------------------------------------------------------------------------+
| 入力                                                                  [新規]         |
| 登録ユーザー名  登録日時  更新ユーザー名  更新日時                                      |
| [拠点* ▼]                                                                              |
| [セクションコード*____]                                                                 |
| [セクション名*__________________________]                                               |
| [セクション名(略称)*____________________]                                               |
| [エリア* ▼]                                                                            |
| [管理組織* ▼]                                                                          |
| [仕入計上集約単位* ▼]                                                                   |
| [在庫管理対象 □/☑]                                                                     |
| [生産管理対象 □/☑]                                                                     |
| [確定]                                                                        [削除]   |
+--------------------------------------------------------------------------------------+
```

#### 5.7.2 Những gì wireframe xác nhận trực tiếp
- Màn hình đúng là mô hình **1 base screen / 3 vùng chính**: 検索条件, 検索結果, 入力.
- Nút **CSV出力**, **表示**, **クリア** nằm ở phía phải của vùng search.
- Grid kết quả có tối thiểu các cột nhìn thấy trực tiếp trên layout:
  `No.`, `削除`, `拠点コード`, `拠点名`, `セクションコード`, `セクション名`, `セクション名（略称）`.
- Vùng 入力 có nút **新規** riêng, tách khỏi cụm nút của search area.
- Trong wireframe, các field **エリア / 管理組織 / 仕入計上集約単位** hiển thị dưới dạng **dropdown**, và điều này đã được stakeholder xác nhận.
- Hai field **在庫管理対象 / 生産管理対象** trên layout hiển thị theo kiểu checkbox.

#### 5.7.3 Mapping vùng highlight trên wireframe
- **Khung đỏ ở vùng 検索条件 – bên trái**: xác nhận field bắt buộc trọng tâm của search là `拠点`.
- **Khung đỏ ở vùng 検索条件 – bên phải**: nhấn mạnh cụm action chính `CSV出力 / 表示 / クリア`.
- **Khung đỏ ở header grid**: nhấn mạnh các cột kinh doanh quan trọng nhất mà user dùng để nhận diện record.
- **Khung đỏ ở vùng 入力 – bên trái**: nhấn mạnh các field bắt buộc và các dropdown nghiệp vụ.
- **Nút 新規 / 確定 / 削除** được tách góc phải để thể hiện đây là action ở cấp form nhập liệu, không phải action của search.

#### 5.7.4 Quy tắc dùng wireframe trong implement
- Wireframe là **nguồn xác nhận bố cục và loại control nhìn thấy được**.
- Các rule nghiệp vụ chi tiết như validation, khóa nghiệp vụ, CSV scope, last-searched-condition, quyền thao tác vẫn phải bám các mục ở phần event/data context của spec này.
- Khi wireframe và sheet Excel mâu thuẫn về **control type**, ưu tiên:
  1. câu trả lời xác nhận của stakeholder,
  2. wireframe trực quan,
  3. item definition / note kỹ thuật còn lại.
- Wireframe **không đủ để suy ra** sort mặc định, locking detail, message code ngoài các câu trả lời đã được xác nhận.


#### 5.7.5 Wireframe theo trạng thái – Init

**Mục đích**: mô tả trạng thái ngay sau khi mở màn hình và hoàn tất API init.  
**Đặc điểm chính**:
- Chỉ gọi API init để lấy danh sách **拠点**
- **Không auto search**
- Search area được restore theo cơ chế common-base của hệ thống, sau đó snapshot thành `searchConditionInitSnapshot`
- Input area ở trạng thái **chưa chọn record / chưa vào add mode**

```text
INIT STATE
Ký hiệu: [E] editable | [D] disabled | [L] label/read-only

+--------------------------------------------------------------------------------------+
| 検索条件                                                                             |
| [拠点 ▼][E] [セクションコード____][E] [🔍][E] [セクション名][L]                      |
| [削除データ表示 OFF][E]                                            [CSV出力][E][表示][E][クリア][E] |
+--------------------------------------------------------------------------------------+

+--------------------------------------------------------------------------------------+
| 検索結果                                                                             |
| 件数: 0件 hoặc rỗng (chưa search)                                      paging hidden |
| [grid rỗng / chưa bind dữ liệu]                                                      |
+--------------------------------------------------------------------------------------+

+--------------------------------------------------------------------------------------+
| 入力                                                                  [新規][E]      |
| 登録ユーザー名 [L]  登録日時 [L]  更新ユーザー名 [L]  更新日時 [L]                    |
| [拠点 ▼][D]                                                                            |
| [セクションコード____][D]                                                              |
| [セクション名________________________][D]                                              |
| [セクション名(略称)__________________][D]                                              |
| [エリア ▼][D]                                                                          |
| [管理組織 ▼][D]                                                                        |
| [仕入計上集約単位 ▼][D]                                                                 |
| [在庫管理対象 □][D]                                                                     |
| [生産管理対象 □][D]                                                                     |
| [確定][D]                                                                  [削除][D]  |
+--------------------------------------------------------------------------------------+
```

**Rule triển khai cho Init state**
- Nếu common-base có giá trị search đã lưu từ lần trước, hiển thị lại ở vùng 検索条件.
- Giá trị restore ở search area **chưa tạo search result** cho tới khi user bấm **表示**.
- `lastSearchedCondition` chưa tồn tại hoặc ở trạng thái empty.
- CSV出力 ở trạng thái init:
  - nếu hệ thống yêu cầu chỉ export sau khi đã search thì disable;
  - nếu common-base/framework vẫn cho bấm nhưng backend cần `lastSearchedCondition` thì phải chặn bằng validation/message phù hợp.  
  **Assumption đề xuất**: disable trước lần search đầu tiên để tránh ambiguity.
- Input area chỉ cho thao tác **新規**; chưa cho 確定/削除.

#### 5.7.6 Wireframe theo trạng thái – Insert

**Trigger**: user bấm **新規** tại vùng 入力 và xác nhận message `MQ000008` nếu form đang có dữ liệu.  
**Mục đích**: vào mode đăng ký mới 1 section.

```text
INSERT STATE
Ký hiệu: [E] editable | [D] disabled | [L] label/read-only | * required

+--------------------------------------------------------------------------------------+
| 検索条件                                                                             |
| [giữ nguyên giá trị search/result hiện có; không bị reset bởi nút 新規]              |
+--------------------------------------------------------------------------------------+

+--------------------------------------------------------------------------------------+
| 検索結果                                                                             |
| [giữ nguyên danh sách của lần search gần nhất, nếu có]                               |
+--------------------------------------------------------------------------------------+

+--------------------------------------------------------------------------------------+
| 入力                                                                  [新規][E]      |
| 登録ユーザー名 [L: blank]  登録日時 [L: blank]  更新ユーザー名 [L: blank]  更新日時 [L: blank] |
| [拠点* ▼][E: default = blank]                                                         |
| [セクションコード*____][E: blank]                                                     |
| [セクション名*________________________][E: blank]                                     |
| [セクション名(略称)*__________________][E: blank]                                     |
| [エリア* ▼][E: blank]                                                                 |
| [管理組織* ▼][E: blank]                                                               |
| [仕入計上集約単位* ▼][E: blank]                                                        |
| [在庫管理対象 ☑][E: default checked=1]                                                |
| [生産管理対象 □][E: default unchecked=0]                                              |
| [確定][E]                                                                  [削除][D/Hidden] |
+--------------------------------------------------------------------------------------+
```

**Rule triển khai cho Insert state**
- `formMode = INS`
- Các field required phải validate trước khi call API đăng ký:
  - 拠点
  - セクションコード
  - セクション名
  - セクション名（略称）
  - エリア
  - 管理組織
  - 仕入計上集約単位
- Khóa nghiệp vụ kiểm tra duplicate theo: `CMPNYCD + STORECD + SECTIONCD`
- `拠点` là required nhưng option **blank** vẫn là giá trị mặc định khi vừa vào mode thêm mới; user phải chọn giá trị hợp lệ trước khi xác nhận.
- Nút **削除** không dùng trong mode insert.
- Sau khi đăng ký thành công:
  - khuyến nghị reload result bằng `lastSearchedCondition` nếu record mới phù hợp điều kiện search hiện tại;
  - nếu chưa từng search, có thể chỉ refresh input state và hiển thị message thành công.  
  **Assumption**: refresh list theo `lastSearchedCondition` khi state này tồn tại.

#### 5.7.7 Wireframe theo trạng thái – Update

**Trigger**: user click vào `セクションコード` của 1 row active (`DELFLG='0'`) trong grid kết quả.  
**Mục đích**: chỉnh sửa section đang hiệu lực.

```text
UPDATE STATE
Ký hiệu: [E] editable | [D] disabled | [L] label/read-only | * required

+--------------------------------------------------------------------------------------+
| 検索条件                                                                             |
| [giữ nguyên giá trị search hiện tại / last searched condition]                       |
+--------------------------------------------------------------------------------------+

+--------------------------------------------------------------------------------------+
| 検索結果                                                                             |
| [row được chọn nằm trong danh sách kết quả; row deleted không click được]            |
+--------------------------------------------------------------------------------------+

+--------------------------------------------------------------------------------------+
| 入力                                                                  [新規][E]      |
| 登録ユーザー名 [L: loaded]  登録日時 [L: loaded]  更新ユーザー名 [L: loaded]  更新日時 [L: loaded] |
| [拠点* ▼][D: loaded từ record]                                                        |
| [セクションコード*____][D: loaded từ record]                                          |
| [セクション名*________________________][E: loaded]                                    |
| [セクション名(略称)*__________________][E: loaded]                                    |
| [エリア* ▼][E: loaded]                                                                |
| [管理組織* ▼][E: loaded]                                                              |
| [仕入計上集約単位* ▼][E: loaded]                                                       |
| [在庫管理対象 ☑/□][E: loaded]                                                         |
| [生産管理対象 ☑/□][E: loaded]                                                         |
| [確定][E]                                                                  [削除][E]  |
+--------------------------------------------------------------------------------------+
```

**Rule triển khai cho Update state**
- `formMode = UPD`
- `拠点` và `セクションコード` là thành phần của business key nên **disable** trong update mode.
- Row deleted (`DELFLG='1'`) không được phép click, nên update mode chỉ xảy ra với record active.
- Cần giữ hidden key / locking token tối thiểu:
  - `CMPNYCD`
  - `STORECD`
  - `SECTIONCD`
  - `UPDDATETIME` hoặc equivalent concurrency token  
  Phần concurrency vẫn là **open question cần QA xác nhận**.
- Nút **削除** thực hiện logical delete.
- Sau update/delete thành công, khuyến nghị refresh result theo `lastSearchedCondition` để giữ đồng nhất giữa grid và input area.

#### 5.7.8 So sánh nhanh 3 wireframe trạng thái

| Thành phần | Init | Insert | Update |
|---|---|---|---|
| Auto search | Không | Không | Không |
| Input area editable | Không | Có | Có một phần |
| 新規 | Enable | Enable | Enable |
| 確定 | Disable | Enable | Enable |
| 削除 | Disable | Hidden/Disable | Enable |
| 拠点 (input area) | Disable | Editable | Disable |
| セクションコード | Disable | Editable | Disable |
| Audit info | Blank | Blank | Loaded |
| Default checkbox | N/A | 在庫=1, 生産=0 | Theo record |
| Result list | Rỗng nếu chưa search | Giữ nguyên | Giữ nguyên |

---

## 6. Shared Data Context

### 6.1 UI Field Mapping

#### Search Context
| UI Field | DB/Source | Mô tả |
|---|---|---|
| 拠点 | `TMT003_STORE.STORECD` + display `STORERNM/STORENM` | Dropdown init data |
| セクションコード | Search input | Không bắt buộc |
| セクション名 | Modal return value | Chỉ display |
| 削除データ表示 | UI state | Ẩn/hiện DELFLG=1 |
| CSV出力 / 表示 / クリア | UI actions | Không lưu DB trực tiếp |

#### Result Row Context
| UI Column | DB/Source |
|---|---|
| No. | FE generated |
| 削除 | `TAMT030_SECTION.DELFLG` |
| 拠点コード | `TAMT030_SECTION.STORECD` |
| 拠点名 | `TMT003_STORE.STORERNM` hoặc configured short-name field |
| セクションコード | `TAMT030_SECTION.SECTIONCD` |
| セクション名 | `TAMT030_SECTION.SECTIONNM` |
| セクション名（略称） | `TAMT030_SECTION.SECTIONRYAKUNM` |

#### Input Context
| UI Field | Persisted Column | Source / Notes |
|---|---|---|
| 拠点 | `STORECD` | Required |
| セクションコード | `SECTIONCD` | Required |
| セクション名 | `SECTIONNM` | Required |
| セクション名（略称） | `SECTIONRYAKUNM` | Required |
| エリア | `OFFICEAREACD` | Required, dropdown from `TAMT048_OFFICEAREA` |
| 管理組織 | `MANAGEMENTORGANIZATION` | Required, dropdown from `TMT050_NAME` RCDKBN=3022 |
| 仕入計上集約単位 | `AGGREGATIONUNIT` | Required, dropdown from `TMT050_NAME` RCDKBN=3102 |
| 在庫管理対象 | `ZAIKOFLG` | Checkbox, default `1` |
| 生産管理対象 | `SEISANFLG` | Checkbox, default `0` |
| 登録ユーザー名 | user master display | Read-only |
| 登録日時 | `ENTDATETIME` | Read-only |
| 更新ユーザー名 | user master display | Read-only |
| 更新日時 | `UPDDATETIME` | Read-only |

### 6.2 Reference Data Sources

| Nguồn | Dùng cho | Rule |
|---|---|---|
| `TMT003_STORE` | Dropdown 拠点 / result-area store name | Chỉ lấy active store (`DELFLG=0`) |
| `TAMT048_OFFICEAREA` | Dropdown エリア | Lookup theo PK; chỉ lấy active row |
| `TMT050_NAME` (`RCDKBN=3022`) | Dropdown 管理組織 | Group by `STRRSRV1`, `DATANM`; chỉ lấy `STRRSRV5=1`, active rows |
| `TMT050_NAME` (`RCDKBN=3102`) | Dropdown 仕入計上集約単位 | Lookup active rows |
| User master (tên bảng không được nêu rõ trong artifact) | Audit user name | Join theo `ENTUSRCD`, `UPDUSRCD` |

### 6.3 Persistence Model – `TAMT030_SECTION`

#### Business Key
- `CMPNYCD + STORECD + SECTIONCD`

#### Columns editable trực tiếp từ UI
- `STORECD`
- `SECTIONCD`
- `SECTIONNM`
- `SECTIONRYAKUNM`
- `OFFICEAREACD`
- `MANAGEMENTORGANIZATION`
- `AGGREGATIONUNIT`
- `ZAIKOFLG`
- `SEISANFLG`

#### Columns tồn tại nhưng không editable trên UI hiện tại
- `MANAGEMENTORGANIZATIONCHANGEOFPLANS`
- `MANAGEMENTORGANIZATIONAPPLICABLEDATE`
- `AGGREGATIONUNITCHANGEOFPLANS`
- `AGGREGATIONUNITAPPLICATIONDATE`

#### Audit / Control
- `DELFLG`
- `ENTUSRCD`
- `ENTDATETIME`
- `ENTPRG`
- `UPDUSRCD`
- `UPDDATETIME`
- `UPDPRG`

### 6.4 Value / Validation Length Policy
Artifact không cung cấp DB schema SQL đầy đủ.  
Theo chỉ đạo của stakeholder, **không dùng tuyệt đối các `桁数` của sheet item definition** nếu mâu thuẫn với schema thực tế.

Vì chưa có file SQL/schema đính kèm trong phiên làm việc này, spec áp dụng nguyên tắc:
1. **Business key** dùng length đáng tin cậy từ thiết kế: `SECTIONCD <= 5`, `STORECD <= 5`
2. Với các cột còn lại, UI phải ưu tiên length theo DB schema thực tế nếu team có sẵn DDL
3. Nếu dev chưa có DDL tại thời điểm implement, tạm dùng assumption sau:
   - `SECTIONNM <= 30`
   - `SECTIONRYAKUNM <= 30`
   - `OFFICEAREACD <= 5`
   - `MANAGEMENTORGANIZATION <= 5`
   - `AGGREGATIONUNIT <= 5`

---

## 7. Shared Events

### 7.1 Event Normalization Table

| UI Trigger | Business Event | Preconditions | Processing Logic | Result | Failure Cases |
|---|---|---|---|---|---|
| Init screen | `initialize_screen` | User vào được màn hình | Load dropdown 拠点; restore common-base search condition; capture init snapshot; init input area; không auto-search | Màn hình ở trạng thái search-ready | Nếu init API lỗi → hiển thị lỗi hệ thống |
| Click セクション検索 | `select_section_for_search_condition` | Search-area đang usable | Mở modal section search có filter theo 拠点 đang chọn; khi chọn 1 row, set 拠点/拠点名/セクションコード/セクション名 vào search area | Search area được điền từ modal | Modal cancel → không đổi gì |
| Click 表示 | `search_sections` | Search area hợp lệ | Persist current search condition thành `lastSearchedCondition`; query count + query list; apply include-deleted flag; render page 1 | Hiển thị result list | Không có data → `MI000001`; validation lỗi → guidance + message phù hợp |
| Click 検索条件 クリア | `restore_search_conditions_to_init_snapshot` | Không | Revert search area về snapshot tại thời điểm init; không gọi search; không reset input/result area | Search area quay về state init snapshot | Không có |
| Click page link | `paginate_sections` | Đã có `lastSearchedCondition` | Query page N bằng condition của lần search gần nhất | Grid đổi trang | Nếu condition cũ không còn data → refresh về empty/result theo backend |
| Click row link セクションコード | `load_section_detail` | Row active (`DELFLG=0`) | Nếu input dirty → hỏi `MQ000018`; nếu user đồng ý, load detail record + audit info vào input area; set mode UPD | Input area hiển thị detail, key fields disabled | Row deleted → event bị disable; dialog No → không đổi |
| Click 新規 | `prepare_new_section` | Không | Nếu input dirty → hỏi `MQ000008`; nếu đồng ý hoặc form clean thì reset input area về mode INS | Input area trống, defaults được áp dụng | User chọn No → giữ nguyên input |
| Click 確定 | `save_section` | User có quyền update; form valid | Validate required + length + master selection; phân nhánh INSERT/UPDATE; confirm dialog; write DB; refresh result theo `lastSearchedCondition`; reset input area | `MI000002`, list được làm mới | Required/format lỗi; duplicate key; optimistic lock fail; DB error |
| Click 削除 | `delete_section` | User có quyền update; đang ở UPD mode của active row | Hiện `MQ000006`; nếu Yes → update `DELFLG='1'`, refresh result, reset input area | `MI000003`, record biến mất hoặc còn hiện với dấu ○ nếu include deleted | Optimistic lock fail; DB error |
| Click CSV出力 | `export_section_csv` | Đã từng search ít nhất 1 lần | Xuất toàn bộ result set theo `lastSearchedCondition`; include deleted theo last search; dùng CSV definition sheet | Common CSV flow / file export được khởi tạo | Chưa search lần nào → hành vi theo common export rule (assumption: export với lastSearchedCondition rỗng nếu framework cho phép) |

### 7.2 Detailed Event Rules

#### E01. initialize_screen
1. Gọi API init để lấy dropdown **拠点**
2. Khôi phục search condition bằng common-base mechanism của hệ thống
3. Capture `searchConditionInitSnapshot`
4. Khởi tạo input area:
   - mode = `INS`
   - 拠点 = blank
   - セクションコード = blank
   - セクション名 = blank
   - セクション名（略称） = blank
   - エリア = blank
   - 管理組織 = blank
   - 仕入計上集約単位 = blank
   - 在庫管理対象 = checked (`1`)
   - 生産管理対象 = unchecked (`0`)
   - audit labels = blank
   - 削除 button hidden
5. Không tự động search

#### E02. select_section_for_search_condition
1. Modal mở với filter **拠点 hiện đang chọn**
2. User chọn 1 section trong modal
3. Set trả về vào search area:
   - 拠点コード / 拠点名
   - セクションコード
   - セクション名
4. Không tự động trigger search

#### E03. search_sections
1. Lấy condition hiện tại từ search area
2. Apply rule include deleted:
   - non-display → chỉ lấy `DELFLG='0'`
   - display → lấy cả `DELFLG='0'` và `DELFLG='1'`
3. Persist condition thành `lastSearchedCondition`
4. Reset current page = 1
5. Query total count
6. Nếu count = 0:
   - hiển thị `MI000001`
   - clear grid
   - giữ nguyên input area
7. Nếu có data:
   - query page 1
   - render grid
   - row deleted hiển thị dấu `○`
   - row deleted không render as clickable link
8. Kết quả search là basis cho:
   - paging
   - CSV export

#### E04. restore_search_conditions_to_init_snapshot
1. Nút này **không tương đương IV0003 trong sheet event**
2. Đây là common-base behavior của hệ thống:
   - search area quay về giá trị đã có lúc init
   - không reset full screen
   - không clear input area
   - không clear result area
   - không tự động search
3. `lastSearchedCondition` không đổi cho đến khi user bấm **表示** lại

#### E05. paginate_sections
1. Dùng `lastSearchedCondition`
2. Query page được chọn
3. Không thay đổi input area
4. Không dùng giá trị search-area đang chỉnh nếu user chưa bấm search lại

#### E06. load_section_detail
1. Chỉ áp dụng cho row active
2. Nếu input area đang dirty:
   - hiển thị `MQ000018` – 変更内容を破棄します。よろしいですか？
   - chọn `いいえ` → dừng
   - chọn `はい` → tiếp tục
3. Load detail của key:
   - `CMPNYCD` từ header/session
   - `STORECD`
   - `SECTIONCD`
4. Load thêm label data:
   - store name
   - area name
   - management organization name
   - aggregation unit name
   - audit user names
5. Chuyển form sang `UPD`
6. Disable:
   - 拠点
   - セクションコード
7. Hiển thị 削除 button

#### E07. prepare_new_section
1. Nếu input area dirty:
   - hiển thị `MQ000008` – 表示内容をクリアします。よろしいですか？
   - chọn `いいえ` → dừng
   - chọn `はい` → reset input
2. Nếu input area clean → reset trực tiếp
3. Sau reset:
   - mode = `INS`
   - key fields editable
   - 削除 hidden
   - checkbox defaults: 在庫=1, 生産=0

#### E08. save_section
**Validation trước confirm**
- Required:
  - 拠点
  - セクションコード
  - セクション名
  - セクション名（略称）
  - エリア
  - 管理組織
  - 仕入計上集約単位
- Master selection phải là value hợp lệ trong dropdown source
- Length validation theo mục 6.4
- Nếu có lỗi required → `ME000116`
- Nếu có lỗi length → `ME000050`

**Confirm dialog**
- Insert mode → `MQ000004` – 確定します。よろしいですか？
- Update mode → `MQ000031` – 更新します。よろしいですか？

**Insert branch**
1. Check duplicate theo business key `CMPNYCD + STORECD + SECTIONCD`
2. Assumption hiện tại: nếu key đã tồn tại dù active hay deleted thì reject insert
3. INSERT business fields
4. Set non-UI future-change fields theo DB default / null (assumption)
5. Set audit:
   - `DELFLG='0'`
   - `ENTUSRCD`, `UPDUSRCD` = current user
   - `ENTDATETIME`, `UPDDATETIME` = current server timestamp
   - `ENTPRG`, `UPDPRG` = current program id

**Update branch**
1. Tìm record theo business key
2. Assumed optimistic locking bằng `UPDDATETIME`
3. Chỉ update các field editable trên UI:
   - `SECTIONNM`
   - `SECTIONRYAKUNM`
   - `OFFICEAREACD`
   - `MANAGEMENTORGANIZATION`
   - `AGGREGATIONUNIT`
   - `ZAIKOFLG`
   - `SEISANFLG`
   - audit update fields
4. Preserve nguyên trạng:
   - `STORECD`
   - `SECTIONCD`
   - `ENT*`
   - non-UI future-change fields
   - `DELFLG`

**Sau khi save thành công**
1. Hiển thị `MI000002` – 確定しました。
2. Re-run search bằng `lastSearchedCondition`
3. Reset input area về mode `INS`

#### E09. delete_section
1. Chỉ khả dụng ở mode `UPD` của row active
2. Hiển thị `MQ000006` – 削除します。よろしいですか？
3. Nếu `いいえ` → dừng
4. Nếu `はい`:
   - Assumed optimistic locking bằng `UPDDATETIME`
   - Update:
     - `DELFLG='1'`
     - `UPDUSRCD`
     - `UPDDATETIME`
     - `UPDPRG`
   - Giữ nguyên các cột khác
5. Hiển thị `MI000003` – 削除しました。
6. Re-run search bằng `lastSearchedCondition`
7. Reset input area về mode `INS`

#### E10. export_section_csv
1. CSV bám theo **điều kiện của lần bấm Search gần nhất**
2. Nếu user đổi search area nhưng chưa bấm Search lại, CSV **không** dùng giá trị vừa đổi
3. Export **toàn bộ records phù hợp**, không chỉ current page
4. Nếu lần search gần nhất có `削除データも表示`, CSV xuất cả row deleted
5. Layout CSV theo sheet `【CSV項目定義】セクションマスタ`

---

## 8. Mode Variants

### Variant A — Initial / Search-Ready
**Trigger**
- Sau `initialize_screen`
- Hoặc sau save/delete/new reset thành công

**UI Changes**
- Input area trống
- 削除 hidden
- Key fields editable
- Search result giữ nguyên hoặc rỗng tùy luồng trước đó

**Input Fields**
- 拠点 = blank
- セクションコード = blank
- セクション名 = blank
- セクション名（略称） = blank
- エリア = blank
- 管理組織 = blank
- 仕入計上集約単位 = blank
- 在庫管理対象 = checked
- 生産管理対象 = unchecked

**Result Display**
- Không auto-search tại init
- Grid chỉ có data sau khi user bấm 表示

**Event Logic**
- User có thể search, export CSV (nếu đã search trước đó), hoặc vào mode new

### Variant B — New Registration Mode
**Trigger**
- Bấm 新規 từ state clean hoặc sau khi xác nhận `MQ000008`

**UI Changes**
- Input area reset
- 拠点 và セクションコード editable
- 削除 hidden

**Input Fields**
- Toàn bộ required fields phải nhập/chọn lại
- Checkbox defaults được áp dụng

**Result Display**
- Result area không bị clear tự động

**Event Logic**
- 確定 đi theo nhánh INSERT
- Search-area clear không ảnh hưởng input area

### Variant C — Update Mode (Active Record Selected)
**Trigger**
- Click `セクションコード` của row active trong result grid

**UI Changes**
- Input area load detail + audit info
- 拠点 disabled
- セクションコード disabled
- 削除 visible

**Input Fields**
- Editable:
  - セクション名
  - セクション名（略称）
  - エリア
  - 管理組織
  - 仕入計上集約単位
  - 在庫管理対象
  - 生産管理対象

**Result Display**
- Grid vẫn giữ nguyên page hiện tại cho đến khi save/delete/search lại

**Event Logic**
- 確定 đi theo nhánh UPDATE
- 削除 thực hiện logical delete
- Bấm 新規 trong lúc dirty → `MQ000008`
- Click link khác trong lúc dirty → `MQ000018`

### Variant D — Deleted Rows Visible in Grid
**Trigger**
- Bật `削除データも表示` rồi bấm 表示

**UI Changes**
- Grid có thể chứa mix active + deleted
- Deleted row hiển thị `○` ở cột 削除

**Input Fields**
- Không có variant edit riêng cho deleted row vì click bị disable

**Result Display**
- Deleted row vẫn nằm trong count, paging và CSV của last search

**Event Logic**
- `セクションコード` của deleted row không gọi `load_section_detail`
- User chỉ có thể tham chiếu row deleted qua grid / CSV, không sửa và không khôi phục

---

## 9. Acceptance Criteria

### AC-FPMT0010AC-01 — Khởi tạo màn hình
- Khi mở `SPMT00101AC`, hệ thống chỉ gọi init API để lấy danh sách 拠点
- Màn hình không tự động search
- Search area được khôi phục theo common-base behavior của hệ thống
- Snapshot init của search area được lưu để dùng cho nút search clear
- Input area ở mode `INS`, 削除 hidden, 在庫管理対象=checked, 生産管理対象=unchecked

### AC-FPMT0010AC-02 — Search happy path
- Bấm 表示 với điều kiện hợp lệ → render result grid và count
- Khi `削除データ非表示` → chỉ có row `DELFLG='0'`
- Khi `削除データも表示` → có cả row `DELFLG='1'`
- Row deleted hiển thị dấu `○` tại cột 削除
- Page size là 25

### AC-FPMT0010AC-03 — Không có dữ liệu
- Khi search không có record phù hợp → hiển thị `MI000001`
- Grid bị clear
- Input area không bị reset cưỡng bức

### AC-FPMT0010AC-04 — Modal section search ở vùng search
- Click kính lúp mở modal có filter theo 拠点 đang chọn
- Chọn 1 row từ modal sẽ set đúng:
  - 拠点コード / 拠点名
  - セクションコード
  - セクション名
- Không tự động search sau khi chọn từ modal

### AC-FPMT0010AC-05 — Search clear là common-base behavior
- Bấm search-area クリア không reset full screen
- Search area quay về snapshot tại thời điểm init
- Result area và input area giữ nguyên
- `lastSearchedCondition` chưa thay đổi cho đến khi bấm 表示 lại

### AC-FPMT0010AC-06 — Click row active để sửa
- Click `セクションコード` của row active sẽ load detail xuống input area
- 拠点 và セクションコード ở input area bị disable
- 削除 button visible
- Nếu input area đang dirty, hệ thống hiển thị `MQ000018`

### AC-FPMT0010AC-07 — Deleted row không được chọn
- Khi danh sách đang hiển thị row deleted, click vào row deleted không được phép mở detail
- Hệ thống không cho sửa/xóa/khôi phục record deleted từ màn hình này

### AC-FPMT0010AC-08 — Nút 新規
- Khi input area clean, bấm 新規 sẽ reset input area trực tiếp
- Khi input area dirty, bấm 新規 sẽ hỏi `MQ000008`
- Chọn `はい` → reset input area và về mode insert
- Chọn `いいえ` → giữ nguyên dữ liệu đang nhập

### AC-FPMT0010AC-09 — Validation required
- Bấm 確定 khi thiếu 1 trong các field required sẽ hiển thị `ME000116`
- Danh sách field required:
  - 拠点
  - セクションコード
  - セクション名
  - セクション名（略称）
  - エリア
  - 管理組織
  - 仕入計上集約単位

### AC-FPMT0010AC-10 — Validation length / format
- `SECTIONCD` vượt quá 5 ký tự sẽ bị lỗi
- Các field manual input khác validate theo DB schema thực tế; nếu chưa có DDL thì theo assumption ở mục 6.4
- Giá trị dropdown phải thuộc tập master hợp lệ

### AC-FPMT0010AC-11 — Insert happy path
- Ở mode `INS`, nhập/chọn đầy đủ field bắt buộc rồi bấm 確定
- Hệ thống hiển thị `MQ000004`
- Chọn `はい` → insert thành công vào `TAMT030_SECTION`
- `DELFLG='0'`
- `MI000002` hiển thị
- Result grid được search lại theo `lastSearchedCondition`
- Input area reset về mode `INS`

### AC-FPMT0010AC-12 — Update happy path
- Ở mode `UPD`, user chỉ sửa được các field non-key
- Bấm 確定 → hiển thị `MQ000031`
- Chọn `はい` → update business fields + audit update fields
- `STORECD` và `SECTIONCD` không đổi
- `MI000002` hiển thị
- Result grid được search lại theo `lastSearchedCondition`

### AC-FPMT0010AC-13 — Delete happy path
- Ở mode `UPD`, bấm 削除 → hiển thị `MQ000006`
- Chọn `はい` → update `DELFLG='1'`
- `MI000003` hiển thị
- Result grid được search lại theo `lastSearchedCondition`
- Nếu last search không hiển thị deleted thì record biến mất khỏi grid
- Nếu last search có hiển thị deleted thì record vẫn còn trong grid với dấu `○`

### AC-FPMT0010AC-14 — CSV export
- CSV export dùng đúng **điều kiện của lần bấm Search gần nhất**
- User đổi search area nhưng chưa bấm Search lại thì CSV vẫn dùng condition cũ
- CSV xuất toàn bộ record phù hợp, không chỉ current page
- Nếu last search có include deleted thì CSV cũng có row deleted
- Mapping field của CSV bám theo sheet `【CSV項目定義】セクションマスタ`

### AC-FPMT0010AC-15 — Phân quyền
- Quyền **更新可能**: thấy Search / Clear / CSV / New / Confirm / Delete theo mode
- Quyền **閲覧のみ**: thấy Search / Clear / CSV
- Với **閲覧のみ**, New / Confirm / Delete không được hiển thị
- Assumption: user 閲覧のみ vẫn có thể xem detail active record ở read-only mode

---

## 10. Open Questions / Assumptions

### A. Assumptions đã dùng để hoàn thiện spec
1. **Default sort của kết quả search** được giả định là:
   - `STORECD ASC`
   - `SECTIONCD ASC`  
   Lý do: phù hợp với thứ tự sort được mô tả trong sheet CSV.
2. **Optimistic locking** cho update/delete được giả định dùng `UPDDATETIME`, dù artifact chưa nêu message code cụ thể.
3. **Insert duplicate key** được giả định là reject nếu business key đã tồn tại, kể cả record deleted, vì màn hình không có restore flow.
4. **Read-only role** được giả định vẫn được click row active để xem chi tiết ở dạng read-only.
5. **Các field non-UI future-change** (`...CHANGEOFPLANS`, `...APPLICABLEDATE`) được giả định:
   - insert: theo DB default hoặc null
   - update/delete từ màn hình này: preserve nguyên trạng
6. **ENTDATETIME / UPDDATETIME** dùng current server timestamp; giá trị `'0000-00-00 00:00:00'` trong sheet table-edit được hiểu là placeholder.
7. Sheet table-edit ghi `ENTPRG/UPDPRG = SPMT01101AC`; spec giả định implementation dùng **program id thực tế của màn hình/config runtime**, không hardcode nếu đây là typo tài liệu.
8. Tên bảng cụ thể của **user master** không có trong artifact; spec chỉ yêu cầu join sang common user master theo user code.

### B. QA cần xác nhận thêm
1. Default sort search-result có đúng là `STORECD ASC, SECTIONCD ASC` hay không
2. Message code khi duplicate business key
3. Message code khi optimistic lock fail trên update/delete
4. Giá trị default chính xác của các cột future-change khi insert nếu DB không có default
5. Table name và join rule chính xác để lấy 登録ユーザー名 / 更新ユーザー名

---

## Appendix — CSV Fields Summary

Các trường CSV được xác nhận từ sheet `【CSV項目定義】セクションマスタ` gồm:
- 拠点コード
- 拠点名
- セクションコード
- セクション名
- セクション名(略称)
- 在庫管理対象フラグ
- 生産管理対象フラグ
- エリアコード
- エリア名
- 管理組織
- 管理組織名
- 管理組織変更予定
- 管理組織変更予定名
- 管理組織適用日
- 集約単位
- 集約単位名
- 集約単位変更予定
- 集約単位変更予定名
- 集約単位適用日

CSV layout details:
- Header: có
- Delimiter: comma
- Line break: CRLF
- Quote: double quote
- Encoding: Shift-JIS
- Tên file: được cấu hình ở DB nên không đặc tả cứng trong spec này