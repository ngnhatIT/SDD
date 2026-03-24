# Spec Pack

## 1. Feature Overview

Màn hình `パスワード変更` dùng để thay đổi mật khẩu của người dùng hiện tại đã đi vào luồng `ログイン/パスワード変更`.
Màn hình hiển thị ngữ cảnh người dùng gồm `ユーザーコード` và `ユーザー名`, cho phép nhập `現パスワード`, `新パスワード`, `確認パスワード`, sau đó thực hiện cập nhật `ユーザマスタ` khi người dùng bấm `確定`.

Đây là 1 base screen với 3 trạng thái UI chính:

- `Input State`: trạng thái mặc định sau khởi tạo, cho phép nhập mật khẩu.
- `Validation Error State`: trạng thái sau khi bấm `確定` nhưng có lỗi kiểm tra đầu vào.
- `Completion State`: trạng thái sau khi cập nhật thành công, hiển thị thông báo hoàn tất và chuyển về `ログイン画面` initial display.

## 2. Background

Theo workbook, màn hình này thuộc chức năng:

- `機能ID`: `FPCM0030`
- `機能名`: `パスワード変更`
- `画面ID`: `SPCM0031`
- `画面名`: `パスワード変更`
- `画面遷移`: `1 ログイン/パスワード変更`
- `動作環境`: `PC`

Mô tả sử dụng trong layout cho thấy màn hình được dùng để đổi mật khẩu cho `ユーザーID` đã nhập tại `ログイン画面`.
`ログイン画面` là initial display target và tất cả người dùng đều có thể sử dụng.
Sau khi thay đổi mật khẩu thành công, hệ thống hiển thị popup hoàn tất rồi chuyển sang `ログイン画面（初期表示）`.

Các rule quan trọng từ source artifacts:

Condition: `ユーザーコード` lấy từ `ログイン画面` đã nhập trước đó và không cho sửa trực tiếp trên màn hình này.

Condition: `ユーザー名` được lấy theo `ユーザーコード` và không cho sửa trực tiếp trên màn hình này.

Condition: `現パスワード`, `新パスワード`, `確認パスワード` đều là bắt buộc khi thực hiện `確定`.

Condition: `現パスワード` phải vượt qua `存在チェック`, tức phải phù hợp với mật khẩu hiện tại của người dùng đang thao tác.

Condition: `新パスワード` và `確認パスワード` phải vượt qua `フォーマットチェック` với thông điệp yêu cầu đủ 4 loại ký tự half-width: chữ hoa, chữ thường, số, ký hiệu.

Condition: `新パスワード` và `確認パスワード` phải vượt qua `パスワード一致チェック`.

Condition: Khi validation thành công, hệ thống cập nhật `TMT002_USER` theo mapping của sheet `テーブル編集仕様(パスワード変更)（確定）`.

## 3. Scope

### In Scope

- Khởi tạo màn hình `パスワード変更`
- Nạp `ユーザーコード` từ login context
- Hiển thị `ユーザー名` theo user hiện tại
- Nhập `現パスワード`
- Nhập `新パスワード`
- Nhập `確認パスワード`
- Validation bắt buộc
- Validation `存在チェック` cho `現パスワード`
- Validation `フォーマットチェック` cho `新パスワード` và `確認パスワード`
- Validation `パスワード一致チェック`
- Cập nhật `TMT002_USER`
- Hiển thị message hoàn tất `MI000002`
- Chuyển sang `ログイン画面（初期表示）`
- Điều hướng trực tiếp bằng action `ログイン画面`

### Out of Scope

- Chi tiết thuật toán mã hóa / hash mật khẩu
- Rule lock account, password expiry, policy reuse history ngoài những gì sheet đã thể hiện
- SQL chính xác cho bước lấy `ユーザー名`
- SQL chính xác cho bước `存在チェック`
- Error handling mức system/DB exception ngoài các message đã nêu
- Chi tiết button/UX của popup hoàn tất nếu không được mô tả trong workbook
- Bất kỳ result list, search area, export file hay batch output nào vì không có bằng chứng trong current artifacts

## 4. Glossary

| Term | Meaning |
|---|---|
| `パスワード変更` | Màn hình đổi mật khẩu người dùng hiện tại |
| `ユーザーコード` | Mã người dùng lấy từ `ログイン画面` |
| `ユーザー名` | Tên người dùng lấy theo `ユーザーコード` |
| `現パスワード` | Mật khẩu hiện tại do người dùng nhập để xác thực thay đổi |
| `新パスワード` | Mật khẩu mới sẽ ghi vào `TMT002_USER.PASSWORD` khi xác nhận thành công |
| `確認パスワード` | Giá trị xác nhận lại mật khẩu mới |
| `確定` | Action thực hiện validation và cập nhật dữ liệu |
| `ログイン画面` | Action điều hướng về login screen initial display |
| `ユーザマスタ` | Tên nghiệp vụ của nguồn dữ liệu người dùng; table edit sheet dùng `TMT002_USER` |
| `存在チェック` | Kiểm tra `現パスワード` có khớp dữ liệu hiện hành hay không |
| `フォーマットチェック` | Kiểm tra định dạng mật khẩu theo rule 4 loại ký tự |
| `パスワード一致チェック` | Kiểm tra `新パスワード` và `確認パスワード` giống nhau |
| `MI000002` | Message hoàn tất: `確定しました` |

## 5. Base Screen Structure

### 5.1 Screen Identity

- Function ID: `FPCM0030`
- Function Name: `パスワード変更`
- Screen ID: `SPCM0031`
- Screen Name: `パスワード変更`
- Route Context: `ログイン/パスワード変更`
- Environment: `PC`

### 5.2 Layout Regions

1. Header / Title Area
   - Tiêu đề màn hình `パスワード変更`

2. User Context Area
   - `ユーザーコード`
   - `ユーザー名`

3. Password Input Area
   - `現パスワード`
   - `新パスワード`
   - `確認パスワード`

4. Action Area
   - `確定`
   - `ログイン画面`

5. Popup Area
   - Popup hoàn tất sau update thành công

### 5.3 Core Components

| Component | Type | Notes |
|---|---|---|
| `ユーザーコード` | Output text | `O`, text, length `10`, non-editable |
| `ユーザー名` | Output text | `O`, text, length `40`, non-editable |
| `現パスワード` | Input text | `I`, text, length `16`, required |
| `新パスワード` | Input text | `I`, text, length `16`, required |
| `確認パスワード` | Input text | `I`, text, length `16`, required |
| `確定` | Button | Event ID `IV0001` |
| `ログイン画面` | Link | Event ID `IV0002` |

### 5.4 Result Area

Condition: Không có result grid, list, paging hoặc result counter trên màn hình này theo current artifacts.

- Result Area: Not applicable for this screen
- Handling: Giữ section này để xác nhận rõ màn hình chỉ là input/update screen, không phải search/list screen
- Evidence: `【画面項目定義】パスワード変更`, `【イベント一覧】パスワード変更`, layout image

### 5.5 Shared State Variables

| State | Meaning |
|---|---|
| `currentUserCode` | `ユーザーコード` được nhận từ login context |
| `currentUserName` | `ユーザー名` được resolve cho user hiện tại |
| `currentPasswordInput` | Giá trị người dùng nhập vào `現パスワード` |
| `newPasswordInput` | Giá trị người dùng nhập vào `新パスワード` |
| `confirmPasswordInput` | Giá trị người dùng nhập vào `確認パスワード` |
| `validationErrors` | Danh sách lỗi validation hiện tại để hiển thị guidance |
| `completionPopupVisible` | Cờ hiển thị popup `確定しました` |
| `navigationTarget` | Màn hình đích khi điều hướng, mặc định `ログイン画面` khi thành công hoặc khi user chọn link |

### 5.6 Shared Actions

| UI Action | Business Event |
|---|---|
| Screen open | `initialize_screen` |
| `確定` | `update_user_password` |
| `ログイン画面` | `navigate_login_screen` |

## 6. Shared Data Context

### 6.1 UI Fields

| Field | Type | Required | Behavior |
|---|---|---:|---|
| `ユーザーコード` | Text output | No | Giá trị lấy từ `ログイン画面` đã nhập trước đó; non-editable |
| `ユーザー名` | Text output | No | Giá trị lấy theo `ユーザーコード`; non-editable |
| `現パスワード` | Text input | Yes | Người dùng nhập trực tiếp; `存在チェック` tại `確定`; max length `16` |
| `新パスワード` | Text input | Yes | Người dùng nhập trực tiếp; `フォーマットチェック`; max length `16` |
| `確認パスワード` | Text input | Yes | Người dùng nhập trực tiếp; `フォーマットチェック` và `パスワード一致チェック`; max length `16` |
| `確定` | Button | No | Kích hoạt validation và update |
| `ログイン画面` | Link | No | Điều hướng về `ログイン画面（初期表示）` |

### 6.2 Result Columns

| Column | Source / Behavior |
|---|---|
| `None` | Screen không có result grid hoặc result columns. Non-inferable from current artifacts that any tabular result exists. |

### 6.3 Key Entities

| Object | Role |
|---|---|
| `TMT002_USER` | Persistence target chính cho cập nhật password |
| `ユーザマスタ` | Tên nghiệp vụ trong screen item definition; dùng để mô tả source của `ユーザーコード`, `ユーザー名`, `前パスワード`, `パスワード` |
| Login context | Nguồn đầu vào cho `ユーザーコード` khi mở màn hình |

### 6.4 Persistence / Update Targets

| Object | Purpose |
|---|---|
| `TMT002_USER.PASSWORD` | Ghi `新パスワード` khi update thành công |
| `TMT002_USER.BFRPASSWORD` | Ghi `現パスワード` khi update thành công |
| `TMT002_USER.PASSUPDDATE` | Ghi thời điểm thay đổi mật khẩu |
| `TMT002_USER.UPDUSRCD` | Ghi `ユーザーコード` thực hiện cập nhật |
| `TMT002_USER.UPDDATETIME` | Ghi thời điểm update |
| `TMT002_USER.UPDPRG` | Ghi cố định `SPMT01101AC` theo sheet table edit |

### 6.5 Mode-dependent Differences

| State | Difference |
|---|---|
| `Input State` | Cho phép nhập 3 field mật khẩu; chưa có guidance |
| `Validation Error State` | Hiển thị guidance tại field lỗi; không update dữ liệu |
| `Completion State` | Hiển thị popup `確定しました`; điều hướng về `ログイン画面` |

## 7. Shared Events

### 7.1 `initialize_screen`

**Business Event Name**
- `initialize_screen`

**UI Trigger**
- Mở màn hình `パスワード変更`
- Vào route `ログイン/パスワード変更`

**Preconditions**
- Có login context chứa `ユーザーコード` từ màn hình trước

**Validation**
- Không có validation business được mô tả cho screen open

**Processing Logic**
1. Khởi tạo toàn bộ item trên màn hình
2. Set `currentUserCode` từ `ログイン画面` đã nhập trước đó
3. Resolve `currentUserName` theo `currentUserCode`
4. Clear `現パスワード`
5. Clear `新パスワード`
6. Clear `確認パスワード`
7. Clear tất cả guidance/error state
8. Render `確定` và `ログイン画面`

**Result**
- Màn hình ở `Input State`
- `ユーザーコード` và `ユーザー名` hiển thị
- 3 password field ở trạng thái chờ nhập

**Failure Cases**
- Non-inferable from current artifacts cho trường hợp không resolve được `ユーザー名`

**Related Messages**
- TBD based on source artifacts

**Related Data Sources**
- Login context
- `ユーザマスタ` / `TMT002_USER`

### 7.2 `update_user_password`

**Business Event Name**
- `update_user_password`

**UI Trigger**
- Nút `確定`
- Event ID `IV0001`

**Preconditions**
- `initialize_screen` đã hoàn tất
- `currentUserCode` đã có giá trị

**Validation**
1. Required check cho `現パスワード`
2. Required check cho `新パスワード`
3. Required check cho `確認パスワード`
4. `存在チェック` cho `現パスワード`
5. `フォーマットチェック` cho `新パスワード`
6. `フォーマットチェック` cho `確認パスワード`
7. `パスワード一致チェック` cho cặp `新パスワード` và `確認パスワード`

**Processing Logic**
1. Chạy `エラーチェック`
2. Nếu có lỗi:
   1. Không cập nhật DB
   2. Hiển thị guidance tại item lỗi
   3. Giữ nguyên giá trị đã nhập để người dùng sửa
3. Nếu không có lỗi:
   1. Update `TMT002_USER`
   2. Map `PASSWORD <- 新パスワード`
   3. Map `BFRPASSWORD <- 現パスワード`
   4. Map `PASSUPDDATE <- current timestamp`
   5. Map `UPDUSRCD <- ユーザーコード`
   6. Map `UPDDATETIME <- current timestamp`
   7. Map `UPDPRG <- SPMT01101AC`
   8. Giữ nguyên các cột còn lại là `変更しない`
   9. Hiển thị popup hoàn tất với message `MI000002`
   10. Chuyển sang `ログイン画面（初期表示）`

**Result**
- Validation NG: màn hình ở `Validation Error State`
- Validation OK + update OK: màn hình sang `Completion State` rồi điều hướng `ログイン画面`

**Failure Cases**
- Validation error: stay on same screen, no DB update
- DB update failure handling: Non-inferable from current artifacts
- Popup acknowledgement timing: Unresolved ambiguity

**Related Messages**
- `ME000116`
- `ME000038`
- `ME000179`
- `追加` for password mismatch message text
- `MI000002`

**Related Data Sources**
- `TMT002_USER`
- `ユーザマスタ`

### 7.3 `navigate_login_screen`

**Business Event Name**
- `navigate_login_screen`

**UI Trigger**
- Link `ログイン画面`
- Event ID `IV0002`

**Preconditions**
- None

**Validation**
- None

**Processing Logic**
1. Hủy bỏ thao tác đang nhập trên màn hình hiện tại
2. Chuyển tới `ログイン画面（初期表示）`

**Result**
- Màn hình hiện tại đóng vai trò điều hướng, không phát sinh update dữ liệu

**Failure Cases**
- Non-inferable from current artifacts

**Related Messages**
- None

**Related Data Sources**
- None

## 8. Mode Variants

### Variant A - Input State

**Trigger**
- Screen open
- Sau khi vào route `ログイン/パスワード変更`

**UI Changes**
- Hiển thị `ユーザーコード`, `ユーザー名`
- Cho phép nhập `現パスワード`, `新パスワード`, `確認パスワード`
- Chưa hiển thị validation guidance
- Action `確定` và `ログイン画面` sẵn sàng thao tác

**Input Fields**
- `ユーザーコード`: read-only
- `ユーザー名`: read-only
- `現パスワード`: editable
- `新パスワード`: editable
- `確認パスワード`: editable

**Result Display**
- Không có result grid
- Không có result counter
- Chỉ có form input và action area

**Event Logic**
- `確定` -> `update_user_password`
- `ログイン画面` -> `navigate_login_screen`

**Wireframe (ASCII only)**
```text
+--------------------------------------------------------------------------------+
| Password Change                                                                |
+--------------------------------------------------------------------------------+
| User Code        [current user code                    ]  read-only            |
| User Name        [resolved user name                   ]  read-only            |
| Current Password [                ]                                         |
| New Password     [                ]                                         |
| Confirm Password [                ]                                         |
|                                                              [Confirm] [Login] |
+--------------------------------------------------------------------------------+
| Wireframe status: inferred from Excel structure                               |
+--------------------------------------------------------------------------------+
```

**Acceptance Criteria**
- `AC-PWD-001`
- `AC-PWD-002`
- `AC-PWD-003`
- `AC-PWD-004`
- `AC-PWD-005`

### Variant B - Validation Error State

**Trigger**
- Người dùng bấm `確定`
- Có ít nhất 1 validation error

**UI Changes**
- Hiển thị guidance tại item lỗi
- Không hiển thị popup hoàn tất
- Không điều hướng màn hình
- Giữ nguyên các input đã nhập để người dùng chỉnh sửa

**Input Fields**
- `ユーザーコード`: read-only
- `ユーザー名`: read-only
- `現パスワード`: editable
- `新パスワード`: editable
- `確認パスワード`: editable

**Result Display**
- Không có result grid
- Guidance hiển thị tại vị trí liên quan đến field lỗi

**Event Logic**
- `確定` lặp lại validation sau khi user sửa dữ liệu
- `ログイン画面` vẫn có thể điều hướng bỏ qua thao tác hiện tại

**Wireframe (ASCII only)**
```text
+--------------------------------------------------------------------------------+
| Password Change                                                                |
+--------------------------------------------------------------------------------+
| User Code        [current user code                    ]  read-only            |
| User Name        [resolved user name                   ]  read-only            |
| Current Password [                ]  <- guidance                                    |
| New Password     [                ]  <- guidance                                    |
| Confirm Password [                ]  <- guidance                                    |
|                                                              [Confirm] [Login] |
+--------------------------------------------------------------------------------+
| Wireframe status: inferred from Excel structure                               |
+--------------------------------------------------------------------------------+
```

**Acceptance Criteria**
- `AC-PWD-006`
- `AC-PWD-007`
- `AC-PWD-008`
- `AC-PWD-009`
- `AC-PWD-010`
- `AC-PWD-011`
- `AC-PWD-012`

### Variant C - Completion State

**Trigger**
- Người dùng bấm `確定`
- Tất cả validation pass
- Update `TMT002_USER` thành công

**UI Changes**
- Hiển thị popup hoàn tất
- Điều hướng sang `ログイン画面（初期表示）`

**Input Fields**
- Không còn là trạng thái chỉnh sửa sau khi popup hoàn tất

**Result Display**
- Không có result grid
- Chỉ có completion popup

**Event Logic**
- `update_user_password` thành công -> show `MI000002` -> navigate login screen

**Wireframe (ASCII only)**
```text
+--------------------------------------------------------------------------------+
| Password Change                                                                |
+--------------------------------------------------------------------------------+
| User Code        [current user code                    ]  read-only            |
| User Name        [resolved user name                   ]  read-only            |
| Current Password [                ]                                         |
| New Password     [                ]                                         |
| Confirm Password [                ]                                         |
|                                                              [Confirm] [Login] |
+--------------------------------------------------------------------------------+
|                              +-----------------------+                         |
|                              | Completion            |                         |
|                              +-----------------------+                         |
|                              | Update completed.     |                         |
|                              | Go to Login Screen.   |                         |
|                              +-----------------------+                         |
| Wireframe status: inferred from Excel structure                               |
+--------------------------------------------------------------------------------+
```

**Acceptance Criteria**
- `AC-PWD-013`
- `AC-PWD-014`
- `AC-PWD-015`

## 9. Query Rules

### 9.1 Query Rule Summary

Condition: Màn hình này không có search query hoặc result retrieval query theo kiểu list/grid.

Condition: Query chỉ xuất hiện ở 3 mục đích nghiệp vụ chính:
1. Resolve user context khi khởi tạo màn hình
2. Kiểm tra `現パスワード` tại `確定`
3. Update `TMT002_USER` khi validation thành công

### 9.2 QR-PWD-001 - Resolve current user context

- Query Purpose: lấy `ユーザー名` theo `ユーザーコード` nhận từ `ログイン画面`
- Source Table / View: `ユーザマスタ` / `TMT002_USER`
- Filters:
  - Condition: `USRCD = currentUserCode`
- Output Columns:
  - `USRCD`
  - `USRNM`
- Sort: Not applicable
- SQL / condition / table:
  - Exact SQL: Non-inferable from current artifacts
  - Table evidence: `【画面項目定義】パスワード変更` rows for `ユーザーコード`, `ユーザー名`
- Ambiguity Note:
  - Unresolved ambiguity về tên vật lý cuối cùng của source giữa `ユーザマスタ` và `TMT002_USER`

### 9.3 QR-PWD-002 - Current password existence check

- Query Purpose: xác thực `現パスワード`
- Source Table / View: `ユーザマスタ` / `TMT002_USER`
- Filters:
  - Condition: `USRCD = currentUserCode`
  - Condition: persisted current password must match input `現パスワード`
- Output Columns:
  - Tối thiểu cần trả về trạng thái tồn tại / khớp
- Sort: Not applicable
- SQL / condition / table:
  - Exact SQL: Non-inferable from current artifacts
  - Validation evidence: `エラーチェック(パスワード変更)` row block `現パスワード` + `存在チェック`
- Ambiguity Note:
  - Cách so sánh plain text / hash là Non-inferable from current artifacts

### 9.4 QR-PWD-003 - Update user password record

- Query Purpose: cập nhật password cho user hiện tại
- Source Table / View: `TMT002_USER`
- Filters:
  - Condition: `USRCD = currentUserCode`
- Output Columns:
  - Not applicable
- Update Mapping:
  - Condition: `PASSWORD <- 新パスワード`
  - Condition: `BFRPASSWORD <- 現パスワード`
  - Condition: `PASSUPDDATE <- current timestamp`
  - Condition: `UPDUSRCD <- ユーザーコード`
  - Condition: `UPDDATETIME <- current timestamp`
  - Condition: `UPDPRG <- 'SPMT01101AC'`
  - Condition: all other columns in the sheet remain unchanged
- SQL / condition / table:
  - Exact SQL: TBD based on source artifacts
  - Physical table evidence: `テーブル編集仕様(パスワード変更)（確定）`
- Ambiguity Note:
  - Sheet dùng literal timestamp placeholder `'0000-00-00 00:00:00'` nhưng semantic là `TIMESTAMP`

### 9.5 QR-PWD-004 - Navigation only action

- Query Purpose: none
- Source Table / View: none
- Filters: none
- Output Columns: none
- SQL / condition / table:
  - Condition: `ログイン画面` action chỉ điều hướng, không update
- Ambiguity Note:
  - None

## 10. Output Specification

Condition: Màn hình này không có file output, report output, search output hoặc export action theo current artifacts.

### 10.1 Screen Output Actions

- `確定`
  - Output nghiệp vụ là cập nhật `TMT002_USER`
  - Output UI là popup `MI000002: 確定しました`
  - Output navigation là chuyển sang `ログイン画面（初期表示）`

- `ログイン画面`
  - Output chỉ là điều hướng
  - Không có data mutation

### 10.2 Popup Flow

Condition: Khi update thành công, popup hoàn tất phải được hiển thị trước khi kết thúc flow trên màn hình hiện tại.

- Popup message:
  - `MI000002`
  - `確定しました`

- Popup button / close action:
  - Unresolved ambiguity
  - Handling trong spec: model popup như completion acknowledgement trước khi về login screen

### 10.3 Transaction Notes

Condition: Workbook chỉ thể hiện 1 `UPDATE` tới `TMT002_USER`.

- Single-table update: `TMT002_USER`
- Commit / rollback strategy chi tiết: Non-inferable from current artifacts
- Multi-table transaction: not evidenced
- Rollback behavior for DB exception: Non-inferable from current artifacts

## 11. Validation & Messages

### 11.1 Validation Rules

#### VR-PWD-001
Condition: Người dùng bấm `確定` khi `現パスワード` rỗng.
- Event: `IV0001`
- Target Field: `現パスワード`
- Validation Type: `必須チェック`
- Message Code: `ME000116`
- Message: `入力必須です。入力して下さい。`

#### VR-PWD-002
Condition: Người dùng bấm `確定` khi `新パスワード` rỗng.
- Event: `IV0001`
- Target Field: `新パスワード`
- Validation Type: `必須チェック`
- Message Code: `ME000116`
- Message: `入力必須です。入力して下さい。`

#### VR-PWD-003
Condition: Người dùng bấm `確定` khi `確認パスワード` rỗng.
- Event: `IV0001`
- Target Field: `確認パスワード`
- Validation Type: `必須チェック`
- Message Code: `ME000116`
- Message: `入力必須です。入力して下さい。`

#### VR-PWD-004
Condition: `現パスワード` không vượt qua `存在チェック` cho user hiện tại.
- Event: `IV0001`
- Target Field: `現パスワード`
- Validation Type: `存在チェック`
- Message Code: `ME000038`
- Message: `正しいパスワードを入力して下さい。`

#### VR-PWD-005
Condition: `新パスワード` không thỏa `フォーマットチェック`.
- Event: `IV0001`
- Target Field: `新パスワード`
- Validation Type: `フォーマットチェック`
- Message Code: `ME000179`
- Message: `半角英字(大文字・小文字)、半角数字、半角記号の4種類を入力してください。`

#### VR-PWD-006
Condition: `確認パスワード` không thỏa `フォーマットチェック`.
- Event: `IV0001`
- Target Field: `確認パスワード`
- Validation Type: `フォーマットチェック`
- Message Code: `ME000179`
- Message: `半角英字(大文字・小文字)、半角数字、半角記号の4種類を入力してください。`

#### VR-PWD-007
Condition: `新パスワード` và `確認パスワード` không giống nhau.
- Event: `IV0001`
- Target Field: `新パスワード`, `確認パスワード`
- Validation Type: `パスワード一致チェック`
- Message Code: `追加`
- Message: `新パスワードと確認パスワードが異なります。`
- Note: Actual fixed message code is Unresolved ambiguity because sheet shows `追加` instead of concrete code.

### 11.2 Business/System Messages

| Code | Message | When Used |
|---|---|---|
| `ME000116` | `入力必須です。入力して下さい。` | Required check fail cho `現パスワード`, `新パスワード`, `確認パスワード` |
| `ME000038` | `正しいパスワードを入力して下さい。` | `現パスワード` fail `存在チェック` |
| `ME000179` | `半角英字(大文字・小文字)、半角数字、半角記号の4種類を入力してください。` | `新パスワード` hoặc `確認パスワード` fail `フォーマットチェック` |
| `追加` | `新パスワードと確認パスワードが異なります。` | `パスワード一致チェック` fail; exact code unresolved |
| `MI000002` | `確定しました` | Update thành công |

## 12. Acceptance Criteria

AC-PWD-001: Khi mở màn hình `パスワード変更`, hệ thống phải khởi tạo tất cả item và lấy `ユーザーコード` từ `ログイン画面` context.

AC-PWD-002: Khi mở màn hình, `ユーザーコード` phải hiển thị ở trạng thái non-editable với length business tối đa `10`.

AC-PWD-003: Khi mở màn hình, `ユーザー名` phải hiển thị theo `ユーザーコード` ở trạng thái non-editable với length business tối đa `40`.

AC-PWD-004: Khi mở màn hình, `現パスワード`, `新パスワード`, `確認パスワード` phải ở trạng thái chờ nhập và không có validation guidance tồn đọng từ lần thao tác trước.

AC-PWD-005: Trong `Input State`, action `確定` và `ログイン画面` phải hiển thị và có thể thao tác.

AC-PWD-006: Khi bấm `確定` mà `現パスワード` rỗng, hệ thống phải hiển thị `ME000116` và không thực hiện update `TMT002_USER`.

AC-PWD-007: Khi bấm `確定` mà `新パスワード` rỗng, hệ thống phải hiển thị `ME000116` và không thực hiện update `TMT002_USER`.

AC-PWD-008: Khi bấm `確定` mà `確認パスワード` rỗng, hệ thống phải hiển thị `ME000116` và không thực hiện update `TMT002_USER`.

AC-PWD-009: Khi bấm `確定` với `現パスワード` không khớp mật khẩu hiện tại của user đang thao tác, hệ thống phải hiển thị `ME000038` và giữ nguyên màn hình nhập.

AC-PWD-010: Khi bấm `確定` với `新パスワード` hoặc `確認パスワード` không thỏa rule format 4 loại ký tự half-width, hệ thống phải hiển thị `ME000179` trên field tương ứng và không thực hiện update.

AC-PWD-011: Khi bấm `確定` với `新パスワード` và `確認パスワード` khác nhau, hệ thống phải hiển thị thông báo `新パスワードと確認パスワードが異なります。` và không thực hiện update.

AC-PWD-012: Khi có bất kỳ validation error nào, hệ thống phải hiển thị guidance tại item lỗi, giữ nguyên các giá trị người dùng đã nhập để chỉnh sửa, và không điều hướng sang `ログイン画面`.

AC-PWD-013: Khi tất cả validation pass, hệ thống phải cập nhật `TMT002_USER` theo đúng mapping: `PASSWORD`, `BFRPASSWORD`, `PASSUPDDATE`, `UPDUSRCD`, `UPDDATETIME`, `UPDPRG`.

AC-PWD-014: Khi update thành công, hệ thống phải hiển thị message `MI000002: 確定しました`.

AC-PWD-015: Sau khi hoàn tất flow thành công, hệ thống phải chuyển sang `ログイン画面（初期表示）`.

AC-PWD-016: Khi người dùng chọn action `ログイン画面`, hệ thống phải chuyển sang `ログイン画面（初期表示）` mà không cập nhật `TMT002_USER`.

AC-PWD-017: Trong update thành công, mọi cột được đánh dấu `変更しない` trong sheet `テーブル編集仕様(パスワード変更)（確定）` phải được giữ nguyên.

AC-PWD-018: Màn hình này không được hiển thị result grid, result count hoặc paging vì current artifacts không mô tả bất kỳ result area dạng danh sách nào.

## 13. Test Scenarios

SC-PWD-001
- Input:
  - Login context có `ユーザーコード = U000000001`
  - User master có `USRNM` tương ứng
- Steps:
  1. Mở màn hình `パスワード変更`
- Expected Result:
  - `ユーザーコード` hiển thị từ login context
  - `ユーザー名` hiển thị theo user hiện tại
  - 3 field mật khẩu rỗng
  - Hiển thị `確定` và `ログイン画面`

SC-PWD-002
- Input:
  - `現パスワード = blank`
  - `新パスワード = Aa1!abcd`
  - `確認パスワード = Aa1!abcd`
- Steps:
  1. Bấm `確定`
- Expected Result:
  - Hiển thị `ME000116`
  - Guidance xuất hiện tại `現パスワード`
  - Không update `TMT002_USER`

SC-PWD-003
- Input:
  - `現パスワード = current-pass`
  - `新パスワード = blank`
  - `確認パスワード = Aa1!abcd`
- Steps:
  1. Bấm `確定`
- Expected Result:
  - Hiển thị `ME000116`
  - Guidance xuất hiện tại `新パスワード`
  - Không update `TMT002_USER`

SC-PWD-004
- Input:
  - `現パスワード = current-pass`
  - `新パスワード = Aa1!abcd`
  - `確認パスワード = blank`
- Steps:
  1. Bấm `確定`
- Expected Result:
  - Hiển thị `ME000116`
  - Guidance xuất hiện tại `確認パスワード`
  - Không update `TMT002_USER`

SC-PWD-005
- Input:
  - `現パスワード = wrong-current`
  - `新パスワード = Aa1!abcd`
  - `確認パスワード = Aa1!abcd`
- Steps:
  1. Bấm `確定`
- Expected Result:
  - Hiển thị `ME000038`
  - Validation fail tại `現パスワード`
  - Không update `TMT002_USER`

SC-PWD-006
- Input:
  - `現パスワード = correct-current`
  - `新パスワード = abcdefgh`
  - `確認パスワード = abcdefgh`
- Steps:
  1. Bấm `確定`
- Expected Result:
  - Hiển thị `ME000179`
  - Validation fail do không đủ rule format 4 loại ký tự
  - Không update `TMT002_USER`

SC-PWD-007
- Input:
  - `現パスワード = correct-current`
  - `新パスワード = Aa1!abcd`
  - `確認パスワード = Aa1!abce`
- Steps:
  1. Bấm `確定`
- Expected Result:
  - Hiển thị thông báo `新パスワードと確認パスワードが異なります。`
  - Không update `TMT002_USER`

SC-PWD-008
- Input:
  - `現パスワード = correct-current`
  - `新パスワード = Aa1!abcd`
  - `確認パスワード = Aa1!abcd`
- Steps:
  1. Bấm `確定`
- Expected Result:
  - Update `TMT002_USER` thành công
  - `PASSWORD` nhận giá trị `新パスワード`
  - `BFRPASSWORD` nhận giá trị `現パスワード`
  - Hiển thị `MI000002`
  - Chuyển về `ログイン画面（初期表示）`

SC-PWD-009
- Input:
  - Màn hình đang ở `Input State`
- Steps:
  1. Chọn `ログイン画面`
- Expected Result:
  - Chuyển về `ログイン画面（初期表示）`
  - Không update `TMT002_USER`

SC-PWD-010
- Input:
  - `現パスワード = correct-current`
  - `新パスワード = Aa1!abcd`
  - `確認パスワード = Aa1!abcd`
  - Tồn tại các cột khác của `TMT002_USER` đang có dữ liệu
- Steps:
  1. Bấm `確定`
  2. Kiểm tra record sau update
- Expected Result:
  - Chỉ các cột được map trong sheet update thay đổi
  - Các cột `変更しない` vẫn giữ nguyên

## 14. Trace Mapping

| Requirement ID | Logic / rule | SQL / condition / table related | Expected implementation location |
|---|---|---|---|
| `REQ-PWD-001` | Condition: screen open phải khởi tạo item và nạp `ユーザーコード` từ login context | Login context; `【イベント一覧】パスワード変更` event `初期表示` | Screen init handler |
| `REQ-PWD-002` | Condition: `ユーザー名` phải được resolve theo `ユーザーコード` và hiển thị non-editable | `ユーザマスタ` / `TMT002_USER`; exact SQL unknown | Screen init handler or user context service |
| `REQ-PWD-003` | Condition: `現パスワード`, `新パスワード`, `確認パスワード` là bắt buộc tại `確定` | `エラーチェック(パスワード変更)` rows 7-9 | Validation service |
| `REQ-PWD-004` | Condition: `現パスワード` phải vượt qua `存在チェック` | `エラーチェック(パスワード変更)` row 10; source table `ユーザマスタ` / `TMT002_USER` | Validation service or user repository |
| `REQ-PWD-005` | Condition: `新パスワード` và `確認パスワード` phải thỏa rule format 4 loại ký tự | `エラーチェック(パスワード変更)` rows 11-12 | Validation service |
| `REQ-PWD-006` | Condition: `新パスワード` và `確認パスワード` phải giống nhau | `エラーチェック(パスワード変更)` rows 13-14 | Validation service |
| `REQ-PWD-007` | Condition: Khi có validation error, hiển thị guidance tại item lỗi và không update | `【イベント一覧】パスワード変更` rows 7-8 | Screen action controller |
| `REQ-PWD-008` | Condition: Khi validation thành công, update `TMT002_USER` theo mapping sheet table edit | `テーブル編集仕様(パスワード変更)（確定）`; table `TMT002_USER` | User repository / update service |
| `REQ-PWD-009` | Condition: `PASSWORD <- 新パスワード`, `BFRPASSWORD <- 現パスワード`, `UPDPRG <- 'SPMT01101AC'` | `テーブル編集仕様(パスワード変更)（確定）` rows 11-12, 64-66 | User repository |
| `REQ-PWD-010` | Condition: Sau update thành công hiển thị `MI000002` rồi chuyển `ログイン画面（初期表示）` | `【イベント一覧】パスワード変更` row 9; `エラーチェック(パスワード変更)` row 15 | Screen action controller |
| `REQ-PWD-011` | Condition: Action `ログイン画面` chỉ điều hướng, không update | `【イベント一覧】パスワード変更` row 10 | Navigation handler |
| `REQ-PWD-012` | Condition: Các cột `変更しない` phải giữ nguyên | `テーブル編集仕様(パスワード変更)（確定）` rows 9-10, 13-63 | User repository |

## 15. Forbidden Behavior

FB-PWD-001
Condition: Hệ thống không được cho phép người dùng chỉnh sửa trực tiếp `ユーザーコード` hoặc `ユーザー名`.

FB-PWD-002
Condition: Hệ thống không được thực hiện update `TMT002_USER` khi còn bất kỳ validation error nào tại `IV0001`.

FB-PWD-003
Condition: Hệ thống không được chuyển sang `ログイン画面` như một kết quả thành công nếu update `TMT002_USER` chưa hoàn tất thành công.

FB-PWD-004
Condition: Hệ thống không được dùng `確認パスワード` làm nguồn ghi trực tiếp vào `TMT002_USER.PASSWORD`; nguồn update phải là `新パスワード`.

FB-PWD-005
Condition: Hệ thống không được thay đổi các cột được đánh dấu `変更しない` trong sheet `テーブル編集仕様(パスワード変更)（確定）`.

FB-PWD-006
Condition: Hệ thống không được hiển thị result grid, paging hoặc count vì current artifacts không định nghĩa vùng kết quả dạng danh sách.

FB-PWD-007
Condition: Hệ thống không được ẩn validation guidance khi user chưa sửa lỗi hoặc chưa thực hiện lại `確定`.

FB-PWD-008
Condition: Action `ログイン画面` không được phát sinh update dữ liệu người dùng.

## 16. Open Questions / Assumptions

### 16.1 Ambiguity Blocks

Ambiguity: Workbook mô tả "変更できたというポップアップ表示されてログイン画面（初期表示）に遷移する" nhưng không mô tả rõ popup có nút xác nhận nào hay auto-close.
Impact: Hành vi UI sau update thành công có thể khác nhau giữa auto-redirect và redirect sau acknowledgment.
Handling: Spec model flow là hiển thị popup hoàn tất rồi chuyển `ログイン画面`; popup button detail được giữ là Unresolved ambiguity.
Risk: Implementation UI có thể khác với component thực tế của hệ thống.

Ambiguity: Sheet `エラーチェック(パスワード変更)` dùng `メッセージコード = 追加` cho `パスワード一致チェック`, không cung cấp concrete code.
Impact: Không thể map chính xác sang message catalog chuẩn chỉ bằng current artifacts.
Handling: Spec giữ nguyên giá trị `追加` và coi actual fixed code là Unresolved ambiguity.
Risk: Mapping message catalog ở implementation có thể lệch nếu code thực tế khác.

Ambiguity: Exact SQL cho bước resolve `ユーザー名` và `存在チェック` không có trong workbook.
Impact: Không thể xác nhận chính xác filter, join, hoặc strategy truy xuất dữ liệu.
Handling: Spec chỉ ghi Condition và table/source intent, đồng thời đánh dấu `Exact SQL: Non-inferable from current artifacts`.
Risk: Repository implementation có thể khác assumptions kỹ thuật của spec.

Ambiguity: Sheet table edit dùng placeholder `'0000-00-00 00:00:00'` đồng thời đánh dấu `TIMESTAMP` cho `PASSUPDDATE` và `UPDDATETIME`.
Impact: Literal placeholder không thể dùng nguyên trạng như data business thực tế.
Handling: Spec diễn giải semantic là current timestamp tại thời điểm update.
Risk: Nếu framework thực tế yêu cầu DB-generated timestamp hoặc application timestamp, cần thống nhất thêm ở implementation.

Ambiguity: `UPDPRG` cố định là `SPMT01101AC`, trong khi function/screen của current workbook là `FPCM0030` / `SPCM0031`.
Impact: Có khả năng đây là program ID chuẩn dùng chung, hoặc là copy artifact cần xác nhận.
Handling: Spec giữ nguyên `SPMT01101AC` đúng theo workbook và không tự thay bằng screen/function ID hiện tại.
Risk: Sai program ID audit nếu workbook chứa giá trị legacy chưa cập nhật.

### 16.2 Non-inferable Items

- Non-inferable from current artifacts: password masking control type có được áp dụng ở UI hay không.
- Non-inferable from current artifacts: handling cụ thể khi DB update thất bại.
- Non-inferable from current artifacts: transaction boundary chi tiết ngoài single-table update intent.
- Non-inferable from current artifacts: exact popup UI component sau `MI000002`.
- Non-inferable from current artifacts: policy hết hạn mật khẩu dù bảng có cột `PWEXPIREDDATE`, vì sheet update ghi `変更しない`.

### 16.3 Explicit Boundaries

- Boundary: Không bổ sung password policy mới ngoài rule format đã được mô tả.
- Boundary: Không bổ sung search/list/output flow vì màn hình không có bằng chứng cho các chức năng đó.
- Boundary: Không tự thay thế `TMT002_USER` bằng bảng khác dù item sheet dùng tên nghiệp vụ `ユーザマスタ`.
- Boundary: Không tự suy diễn logic hash/encryption.

## 17. Developer Notes

- Ưu tiên triển khai theo source priority: current user instruction -> workbook -> layout image -> knowledge template/example.
- Tách rõ 3 trách nhiệm:
  - screen initialization
  - validation
  - repository update
- Validation sequence nên bám theo thứ tự trong `エラーチェック(パスワード変更)` để dễ trace.
- Update mapping phải giữ nguyên rule `変更しない` cho các cột không được chỉ định là input source.
- Không thay thế `UPDPRG = 'SPMT01101AC'` nếu chưa có clarified source mới.
- Exact SQL cho resolve user context và current password check hiện chưa được cung cấp; implementation cần bổ sung ở repository layer nhưng không làm thay đổi business rule trong spec.

## Appendix A. Source Mapping

| Spec Area | Source Artifact | Sheet / Row / Note |
|---|---|---|
| Screen identity | `【PSY刷新】_SPCM0031_購買_マスタ_画面設計書_パスワード変更.xlsx` | `【画面レイアウト】パスワード変更` cells `D3`, `U3`, `AH3`, `AU3`, `D4:E4`, `D6` |
| Feature summary and usage | same workbook | `【画面レイアウト】パスワード変更` row block `45-54` |
| UI fields | same workbook | `【画面項目定義】パスワード変更` rows `7-13` |
| Read-only user context | same workbook | `【画面項目定義】パスワード変更` rows `7-8`, remarks `非活性とする。` |
| Required password fields | same workbook | `【画面項目定義】パスワード変更` rows `9-11`; `エラーチェック(パスワード変更)` rows `7-9` |
| `確定` event | same workbook | `【イベント一覧】パスワード変更` rows `7-9` |
| `ログイン画面` action | same workbook | `【イベント一覧】パスワード変更` row `10` |
| Validation messages | same workbook | `エラーチェック(パスワード変更)` rows `7-15` |
| Update target table | same workbook | `テーブル編集仕様(パスワード変更)（確定）` cell `H6` / `AD6` |
| Update column mapping | same workbook | `テーブル編集仕様(パスワード変更)（確定）` rows `11-12`, `15`, `64-66` |
| Keep unchanged columns | same workbook | `テーブル編集仕様(パスワード変更)（確定）` rows `9-10`, `13-14`, `16-63` |
| Layout / screen arrangement | same workbook | Embedded layout image on `【画面レイアウト】パスワード変更`; exact field coordinates partially inferred |

## Appendix B. SQL / Table Reference

### B.1 Table Reference

| Table / Object | Role | Evidence |
|---|---|---|
| `TMT002_USER` | Table được update khi đổi mật khẩu | `テーブル編集仕様(パスワード変更)（確定）` |
| `ユーザマスタ` | Tên nghiệp vụ của nguồn user info trong UI field definition | `【画面項目定義】パスワード変更` |

### B.2 Update Mapping Reference

| Physical Column | Japanese Name | Input Source | Notes |
|---|---|---|---|
| `PASSWORD` | `パスワード` | `新パスワード` | Updated |
| `BFRPASSWORD` | `前パスワード` | `現パスワード` | Updated |
| `PASSUPDDATE` | `パスワード最終変更日` | `TIMESTAMP` | Sheet shows placeholder literal plus semantic timestamp |
| `UPDUSRCD` | `更新ユーザコード` | `ユーザーコード` | Header/user context source |
| `UPDDATETIME` | `更新日時` | `TIMESTAMP` | Sheet shows placeholder literal plus semantic timestamp |
| `UPDPRG` | `更新プログラム` | `SPMT01101AC` | Fixed value from workbook |

### B.3 Logical Update Intent

Condition: Exact executable SQL is TBD based on source artifacts.

Logical update intent for implementation trace:

```sql
UPDATE TMT002_USER
   SET PASSWORD = :new_password,
       BFRPASSWORD = :current_password,
       PASSUPDDATE = :current_timestamp,
       UPDUSRCD = :current_user_code,
       UPDDATETIME = :current_timestamp,
       UPDPRG = 'SPMT01101AC'
 WHERE USRCD = :current_user_code;
```

Note:
- Đây là logical intent được suy ra từ sheet `テーブル編集仕様(パスワード変更)（確定）`, không phải verbatim SQL từ workbook.
- Exact SQL, locking strategy, hash/encryption handling và commit/rollback handling là TBD based on source artifacts.
