# Manual SDD Cho Người Mới

Tài liệu này là hướng dẫn onboarding bằng tiếng Việt cho người chưa biết gì về SDD trong repository này.

Mục tiêu của file này:

- giúp bạn hiểu SDD là gì
- biết phải đọc file nào trước
- biết khi nào dùng prompt nào
- biết cách route một yêu cầu vào đúng workflow
- tránh những lỗi rất hay gặp khi làm việc với AI agent

Quan trọng:

- file này là tài liệu hướng dẫn hỗ trợ
- nếu có điểm nào trong file này khác với `AGENTS.md`, `docs/sdd/`, hoặc `docs/specs/`, thì tài liệu canonical thắng

---

## 1. SDD Là Gì Trong Repo Này?

SDD ở đây là viết tắt của `Spec-Driven Development`.

Hiểu đơn giản:

- không bắt đầu làm việc lớn chỉ từ prompt tự do
- không coi prompt là nguồn sự thật
- không đoán hành vi hệ thống nếu chưa có spec hoặc governance cho phép
- mọi thay đổi không-trivial phải đi qua spec, routing, contract, checklist, và evidence

Nói ngắn hơn:

- `spec` quyết định phải làm gì
- `governance` quyết định được phép làm đến đâu
- `execution contract` quyết định phải đọc gì và phải xuất ra gì
- `agent profile` quyết định Codex, Claude, Copilot nên hành xử thế nào
- `report/checklist` quyết định cách chứng minh là đã làm xong

---

## 2. 6 Khái Niệm Phải Nắm Trước

### 2.1 Canonical

`Canonical` nghĩa là nguồn chính thức.

Trong repo này, canonical path là:

1. `AGENTS.md`
2. `docs/sdd/context/`
3. `docs/sdd/governance.md` và `docs/sdd/governance/`
4. `docs/sdd/execution/`
5. `docs/specs/`

Nếu có xung đột:

- canonical thắng
- prompt, brief, spec-pack, support example, archive đều thua

### 2.2 Governed Work

`Governed work` là công việc cần bị kiểm soát bởi spec và governance.

Ví dụ:

- làm feature mới
- sửa bug không nhỏ
- review một thay đổi quan trọng
- thay đổi behavior bên ngoài
- thay đổi contract, schema, route, DTO, response

### 2.3 Feature Package

Đây là thư mục spec chuẩn dưới:

`docs/specs/<feature-id>/`

Đây là approval source cho governed work.

Bạn có thể hiểu nó là:

- hồ sơ thiết kế
- hồ sơ phạm vi
- hồ sơ traceability
- hồ sơ rollout
- hồ sơ test
- hồ sơ review/implementation evidence

### 2.4 Execution Contract

Execution contract nằm ở:

`docs/sdd/execution/contracts/`

Nó trả lời các câu hỏi:

- task này cần input gì?
- phải đọc file nào?
- được phép giả định gì và không được giả định gì?
- output bắt buộc là gì?
- khi nào phải dừng?

### 2.5 Agent Profile

Agent profile nằm ở:

`docs/sdd/execution-profiles/`

Nó nói rõ:

- Codex nên làm gì
- Claude nên làm gì
- Copilot nên làm gì

Đây không phải governance.

Nó chỉ là cách thích nghi hành vi của từng agent với cùng một hệ thống.

### 2.6 Support Và Archive

Không phải cái gì trong `docs/` cũng là nguồn chính thức.

Phân biệt:

- `docs/specs/`: package canonical cho governed work
- `docs/specs-support/`: example và fixture, chỉ để tham khảo hoặc phục vụ tooling
- `docs/spec-packs/`: artifact sinh tự động, chỉ để hỗ trợ execution
- `docs/archive/`: lịch sử, evidence cũ, không dùng để route công việc hiện tại

---

## 3. Bản Đồ Thư Mục Quan Trọng

### 3.1 Nếu bạn chỉ nhớ 5 nơi, hãy nhớ 5 nơi này

| Nơi | Vai trò |
| --- | --- |
| `AGENTS.md` | luật gốc và stop rules |
| `docs/sdd/README.md` | bản đồ hệ thống SDD |
| `docs/sdd/execution/task-routing.md` | chọn route cho task |
| `docs/sdd/execution/task-input-header.md` | mẫu header để route deterministic |
| `docs/specs/README.md` | luật cho feature package canonical |

### 3.2 Khi nào dùng thư mục nào

| Thư mục | Dùng khi nào |
| --- | --- |
| `docs/sdd/context/` | cần hiểu bối cảnh repo, loading order, authority |
| `docs/sdd/governance/` | cần biết policy, gates, stop rules |
| `docs/sdd/execution/` | cần route task, chọn contract |
| `docs/sdd/execution-profiles/` | cần biết agent hiện tại nên làm việc kiểu gì |
| `docs/sdd/spec-authoring/` | cần tạo spec mới hoặc update spec trước khi code |
| `docs/specs/` | cần thực thi hoặc review governed work |
| `docs/specs-support/` | cần ví dụ hoặc fixture, không phải approval source |
| `docs/spec-packs/` | cần pack/brief hỗ trợ AI làm việc |
| `docs/archive/` | cần tra lịch sử, không dùng cho work hiện tại |

---

## 4. Luồng Làm Việc Chuẩn Cho Người Mới

Đây là flow mặc định nếu bạn nhận một yêu cầu mới.

### Bước 1. Xác định đây là loại việc gì

Tự hỏi:

- đây là implement?
- review?
- fix bug?
- tạo spec?
- tạo spec-pack?
- chỉ cần khôi phục context?

### Bước 2. Xác định có phải governed work không

Nếu là thay đổi không-trivial, mặc định coi là governed work.

Lúc đó phải kiểm tra:

- đã có `docs/specs/<feature-id>/` chưa?
- package đó có đủ shape chưa?
- có cần viết spec trước khi code không?

### Bước 3. Chọn route

Mở:

`docs/sdd/execution/task-routing.md`

Chọn:

- `implement-new`
- `fix-from-pack`
- `fix-from-bug`
- `review-from-pack`
- `review-from-rules`

Hoặc practical mode:

- `docs-only`
- `review-only`
- `audit-only`
- `tiny-fix`
- `hotfix`
- `recovery`

### Bước 4. Nạp contract và profile

Sau khi route xong:

1. mở execution contract tương ứng trong `docs/sdd/execution/contracts/`
2. mở agent profile tương ứng trong `docs/sdd/execution-profiles/`
3. mở `docs/specs/README.md` hoặc `docs/sdd/spec-authoring/README.md`
4. mở feature package canonical nếu có

### Bước 5. Thực thi đúng phạm vi

Trong lúc làm:

- không được tự ý đoán behavior
- không được dùng support package thay cho canonical package
- không được dùng spec-pack thay cho feature package
- không được dùng archive để làm nguồn thật

### Bước 6. Ghi evidence

Sau khi làm xong:

- update `11-implementation-report.md` nếu có implement
- update `12-review-report.md` nếu có review
- update `changelog.md`
- nếu có spec package thì giữ traceability sống

---

## 5. Prompt Routing Là Gì?

Prompt routing là cách bạn nói với AI:

- đây là loại task gì
- feature nào là canonical
- có spec-pack hay không
- đang review theo spec hay theo rules
- agent profile nào nên dùng

Thay vì viết prompt mơ hồ như:

> sửa giúp tôi cái này

bạn nên route bằng header chuẩn.

---

## 6. Header Routing Chuẩn

Header canonical hiện tại là:

```md
Task Profile: implement-new | fix-from-pack | fix-from-bug | review-from-pack | review-from-rules
Feature: docs/specs/<feature-id>/ | n/a
Spec Pack: docs/spec-packs/<feature-id>.pack.md | n/a
Backend Spec: <path> | alias:backend-spec | n/a
Bug Source: <ticket/path/markdown/text> | n/a
Review Scope: spec | rules | spec+rules | n/a
Agent Profile: codex | claude | copilot | auto
```

### Ý nghĩa từng dòng

| Field | Ý nghĩa |
| --- | --- |
| `Task Profile` | route chính của công việc |
| `Feature` | package canonical đang govern công việc |
| `Spec Pack` | pack hỗ trợ execution, không phải approval source |
| `Backend Spec` | tài liệu backend helper-only nếu có |
| `Bug Source` | nguồn bug nếu đang fix theo bug |
| `Review Scope` | review theo spec, rules, hay cả hai |
| `Agent Profile` | chọn cách hành xử của agent |

### Quy tắc cực kỳ quan trọng

- `Task Profile` quyết định workflow
- `Agent Profile` chỉ quyết định cách hành xử
- `Feature` phải trỏ vào `docs/specs/<feature-id>/` nếu là governed work
- `Spec Pack` không thay được `Feature`
- nếu header thiếu, phải route lại qua `docs/sdd/execution/task-routing.md`

---

## 7. Chọn Prompt Nào Cho Đúng?

Thư viện prompt nằm ở:

`docs/sdd/prompts/`

Nhưng nhớ:

- prompt chỉ là adapter
- contract và governance mới là nguồn thao tác chính

### 7.1 Nhóm prompt điều hướng

| Prompt | Dùng khi nào | Vai trò thật |
| --- | --- | --- |
| `MASTER_ROUTINE.md` | muốn một entrypoint tổng quát | chỉ để chọn route |
| `daily-operator-guide.md` | muốn route ngắn nhất | chỉ để chọn route |
| `quick-guide.md` | route đã gần rõ, cần chọn prompt | chỉ để chọn prompt phù hợp |
| `HEADER_TEMPLATE.md` | cần viết header routing | mẫu header |

### 7.2 Nhóm prompt chính

| Prompt | Dùng khi nào | Contract đứng sau |
| --- | --- | --- |
| `create-spec.md` | tạo spec mới hoặc update spec | `execution/contracts/create-spec.md` |
| `implement-feature.md` | implement từ feature package | `execution/contracts/implement-feature.md` |
| `review-feature.md` | review theo spec hoặc rules | `execution/contracts/review-feature.md` |
| `fix-from-review-report.md` | sửa theo findings đã có | `execution/contracts/fix-from-review.md` |
| `generate-spec-pack.md` | tạo hoặc refresh spec-pack | `execution/contracts/generate-spec-pack.md` |
| `generate-execution-brief.md` | tạo brief theo task | `execution/contracts/generate-execution-brief.md` |
| `recover-context.md` | mất context, cần resume | `execution/contracts/recover-context.md` |
| `self-review.md` | tự review trước khi kết thúc | `docs/sdd/process/05-self-review.md` |

### 7.3 Cách hiểu đúng về prompt

Prompt không nói:

- “hãy làm theo cảm giác”
- “hãy tự quyết định authority”

Prompt đúng ở repo này là:

- lớp hướng dẫn ngắn
- chỉ đường tới contract và template
- không lặp lại governance dài dòng

---

## 8. Bảng Route Nhanh Theo Mục Tiêu

| Mục tiêu của bạn | Route nên dùng | Prompt nên dùng | Output mong đợi |
| --- | --- | --- | --- |
| Tạo spec cho feature mới | `create-spec` | `docs/sdd/prompts/create-spec.md` | `docs/specs/<feature-id>/` |
| Implement feature đã có spec | `implement-new` | `docs/sdd/prompts/implement-feature.md` | code + `11-implementation-report.md` |
| Fix issue dựa trên spec-pack | `fix-from-pack` | `docs/sdd/prompts/implement-feature.md` hoặc `fix-from-review-report.md` tùy nguồn issue | fix + evidence |
| Fix bug nhưng chưa có pack | `fix-from-bug` | route qua `create-spec` trước nếu work không-trivial | spec + fix |
| Review theo spec-pack | `review-from-pack` | `docs/sdd/prompts/review-feature.md` | findings + `12-review-report.md` |
| Review theo rules | `review-from-rules` | `docs/sdd/prompts/review-feature.md` | findings-first review |
| Tạo spec-pack | execution-aid route | `docs/sdd/prompts/generate-spec-pack.md` | `docs/spec-packs/<feature-id>.pack.md` |
| Tạo execution brief | execution-aid route | `docs/sdd/prompts/generate-execution-brief.md` | `docs/spec-packs/<feature-id>.<task-profile>.brief.md` |
| Bị mất context | `recovery` | `docs/sdd/prompts/recover-context.md` | grounded next-step note |

---

## 9. Prompt Mẫu Thực Tế

### 9.1 Mẫu implement feature

```md
Task Profile: implement-new
Feature: docs/specs/2026-03-18-sdd-multi-agent-os-upgrade/
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Review Scope: spec
Agent Profile: codex

Hãy implement theo feature package, bám đúng execution contract, cập nhật implementation evidence, và không dùng support docs làm approval source.
```

### 9.2 Mẫu review theo rules

```md
Task Profile: review-from-rules
Feature: docs/specs/2026-03-18-sdd-multi-agent-os-upgrade/
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Review Scope: rules
Agent Profile: claude

Hãy review theo rules trước, findings-first, và chỉ dùng canonical docs.
```

### 9.3 Mẫu tạo spec từ input thô

```md
Agent Profile: codex

Hãy route task này theo create-spec.
Raw input là ticket, note thiết kế, và mô tả nghiệp vụ bằng JP/VN.
Hãy chuẩn hóa input, xác định scope, tạo feature package canonical, và dừng nếu approval chưa đủ.
```

### 9.4 Mẫu tạo spec-pack

```md
Task Profile: implement-new
Feature: docs/specs/2026-03-18-sdd-multi-agent-os-upgrade/
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Review Scope: spec
Agent Profile: codex

Hãy generate hoặc refresh spec-pack cho feature package này theo contract generate-spec-pack.
```

### 9.5 Mẫu khôi phục context

```md
Agent Profile: auto

Tôi bị mất context. Hãy route theo recovery, đọc canonical path tối thiểu, xác định bước tiếp theo an toàn, và nêu rõ tôi phải đọc file nào tiếp theo.
```

---

## 10. Nếu Bạn Muốn Tạo Hoặc Cập Nhật Spec

Đây là workflow ngắn gọn:

1. mở `docs/sdd/spec-authoring/README.md`
2. mở `docs/sdd/execution/contracts/create-spec.md`
3. chuẩn hóa raw input
4. tạo `docs/specs/<feature-id>/`
5. fill các file numbered theo thứ tự
6. điền `Source Base Anchors` trong `02-design.md`
7. viết `07-tasks.md`, `08-acceptance-criteria.md`, `09-test-cases.md`
8. chạy qua checklist authoring
9. chỉ sau đó mới implement hoặc review

### Người mới hay nhầm ở bước này

- nhảy thẳng vào code khi chưa có feature package
- coi note backend hoặc ticket là approval source
- dùng example trong `docs/specs-support/` làm spec thật

---

## 11. Nếu Bạn Muốn Implement

Luồng chuẩn:

1. xác nhận feature package canonical đã tồn tại
2. mở `docs/specs/README.md`
3. mở execution contract `implement-feature.md`
4. mở agent profile hiện tại
5. đọc feature package
6. chỉ đọc thêm standards/checklists đúng scope
7. implement
8. cập nhật `11-implementation-report.md`

### Checklist cực ngắn cho implement

- feature package có thật
- scope rõ
- source base anchors rõ
- không dùng support/example/archive làm approval
- có traceability `REQ -> DES -> TASK -> AC -> TC`
- có implementation evidence

---

## 12. Nếu Bạn Muốn Review

Có 2 đường:

### Review theo spec-pack

Dùng khi:

- muốn review với spec-pack là aid
- nhưng feature package vẫn là nguồn chính

### Review theo rules

Dùng khi:

- review rules-first
- spec-pack là optional
- vẫn không được bỏ qua feature package nếu đây là governed work

### Rule review quan trọng

- findings-first
- không mở đầu bằng summary dài
- nêu issue trước, summary sau
- nếu không có findings thì nói rõ không có findings

---

## 13. Phân Biệt 4 Loại Tài Liệu Rất Dễ Nhầm

### 13.1 `docs/specs/`

Đây là package thật.

Dùng khi:

- cần approval source
- cần implement/review governed work

### 13.2 `docs/specs-support/`

Đây là ví dụ hoặc fixture.

Dùng khi:

- cần xem form chuẩn
- cần test generator/validator

Không dùng khi:

- quyết định behavior thật của feature hiện tại

### 13.3 `docs/spec-packs/`

Đây là output sinh ra để giúp AI đọc nhanh hơn.

Dùng khi:

- cần execution aid
- cần brief gọn cho agent

Không dùng khi:

- có conflict với feature package canonical

### 13.4 `docs/archive/`

Đây là lịch sử.

Dùng khi:

- truy lịch sử cleanup
- truy review-only evidence

Không dùng khi:

- route task mới
- quyết định behavior hiện tại

---

## 14. Chọn Agent Profile Thế Nào?

### Chọn `codex`

Dùng khi:

- cần execute end-to-end
- cần sửa file thật
- cần giữ nhịp triển khai rõ ràng

### Chọn `claude`

Dùng khi:

- cần reasoning sâu
- cần review
- cần phân tích nhiều nguồn và tránh sửa vội

### Chọn `copilot`

Dùng khi:

- cần hỗ trợ nhỏ trong IDE
- scope hẹp
- đã có packet rất rõ

### Rule nhớ nhanh

- Codex: execute mạnh
- Claude: analyze mạnh
- Copilot: inline assist mạnh nhưng context repo-wide yếu hơn

---

## 15. Những Sai Lầm Người Mới Gần Như Chắc Chắn Sẽ Gặp

### Sai lầm 1. Đọc prompt trước governance

Đúng phải là:

- route trước
- contract sau
- prompt cuối cùng

### Sai lầm 2. Dùng `docs/spec-packs/` như approval source

Sai.

Pack chỉ là execution aid.

### Sai lầm 3. Dùng `docs/specs-support/` như canonical package

Sai.

Support example và fixture không govern feature hiện tại.

### Sai lầm 4. Dùng archive cho việc hiện tại

Sai.

Archive chỉ để truy lịch sử.

### Sai lầm 5. Viết code khi chưa có feature package cho governed work

Sai.

Nếu work không-trivial mà chưa có spec, phải route sang `create-spec`.

### Sai lầm 6. Không update evidence

Sai.

Làm xong mà không update report thì completion claim yếu.

---

## 16. Quick Start 10 Phút Cho Người Hoàn Toàn Mới

Nếu bạn chỉ có 10 phút, làm đúng thứ tự này:

1. đọc `AGENTS.md`
2. đọc `docs/sdd/README.md`
3. đọc `docs/sdd/execution/task-routing.md`
4. đọc `docs/sdd/execution/task-input-header.md`
5. xác định task của bạn là gì
6. nếu là governed work, tìm `docs/specs/<feature-id>/`
7. mở contract tương ứng trong `docs/sdd/execution/contracts/`
8. mở agent profile tương ứng
9. chỉ sau đó mới dùng prompt trong `docs/sdd/prompts/`
10. khi xong, update evidence

Nếu chưa biết feature package nào govern task:

- dừng
- không đoán
- quay lại route và spec-authoring

---

## 17. Một Câu Nhớ Dễ

Nếu bạn quên hết mọi thứ trong file này, hãy nhớ câu này:

> Route trước, spec trước, contract trước, prompt sau; canonical thắng support, support thắng nothing, archive không dùng để làm việc hiện tại.

---

## 18. Nên Đọc Tiếp File Nào Sau Manual Này?

Nếu bạn mới hoàn toàn:

1. `AGENTS.md`
2. `docs/sdd/README.md`
3. `docs/sdd/execution/task-routing.md`
4. `docs/sdd/execution/task-input-header.md`
5. `docs/specs/README.md`

Nếu bạn sắp tạo spec:

1. `docs/sdd/spec-authoring/README.md`
2. `docs/sdd/execution/contracts/create-spec.md`

Nếu bạn sắp implement:

1. `docs/sdd/execution/contracts/implement-feature.md`
2. `docs/sdd/execution-profiles/<agent>.md`
3. `docs/specs/<feature-id>/`

Nếu bạn sắp review:

1. `docs/sdd/execution/contracts/review-feature.md`
2. `docs/sdd/governance/04-review-rules.md`
3. `docs/specs/<feature-id>/`

---

## 19. Kết Luận

SDD trong repo này không phải là “nhiều tài liệu để đọc cho vui”.

Nó là một operating system cho delivery với AI.

Bạn sẽ làm đúng hơn rất nhiều nếu nhớ 4 điều:

1. luôn route task trước
2. luôn xác định canonical source
3. chỉ dùng prompt như adapter
4. luôn để lại evidence sau khi làm

Nếu làm được 4 điều này, bạn đã hiểu đúng 80% SDD của repo.
