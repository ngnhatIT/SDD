# SonarQube Scan Manual

Tài liệu này chỉ tập trung vào trường hợp chạy SonarQube scan cho repository này.

Mục tiêu của file này:

- hướng dẫn cách chạy scan SonarQube từ repo hiện tại
- ghi rõ prerequisite cần có trước khi scan
- đưa ra lệnh PowerShell cụ thể
- phân biệt rõ scan với triage/fix

Quan trọng:

- file này chỉ nói về bước scan
- file này không thay thế `sonar_manual.md`
- nếu scan xong và muốn xử lý findings theo workflow mới, quay lại `sonar_manual.md`

---

## 1. Scan SonarQube Trong Repo Này Là Gì?

`Scan` là bước gửi source code hiện tại của repo lên SonarQube để Sonar phân tích và sinh issue report.

Scan không phải là:

- triage
- fix
- approval

Hiểu ngắn gọn:

- scan chỉ tạo ra findings
- findings đó chưa được phép fix mù
- muốn xử lý findings thì phải đi qua workflow triage trong `sonar_manual.md`

---

## 2. Repo Này Đang Cấu Hình Sonar Ra Sao

Theo [sonar-project.properties](C:/Users/nk_nhat.BRYCENVN/Documents/kikancen/sonar-project.properties), repo hiện tại dùng:

- `sonar.projectKey=jp.brycen.webapp:kikancen`
- `sonar.projectName=kikancen`
- `sonar.projectVersion=0.0.1-SNAPSHOT`
- `sonar.sources=src/main/java,src/main/webapp/angular/src`
- `sonar.tests=src/main/webapp/angular/src`
- `sonar.test.inclusions=src/main/webapp/angular/src/**/*.spec.ts`
- `sonar.java.source=8`
- `sonar.java.binaries=target/classes`
- `sonar.java.test.binaries=target/test-classes`
- `sonar.typescript.tsconfigPaths=src/main/webapp/angular/tsconfig.json`

Điều này có nghĩa là:

- Sonar sẽ scan cả backend Java và frontend Angular source
- Java scan cần bytecode trong `target/classes`
- frontend TypeScript scan dùng `src/main/webapp/angular/tsconfig.json`

---

## 3. Cần Có Gì Trước Khi Chạy

Bạn nên có đủ các thứ sau:

### Bắt buộc

- SonarQube server URL
- Sonar token có quyền analyze project
- `sonar-scanner` đã cài và chạy được trong terminal
- Maven chạy được

### Nên có

- `node_modules` đã được cài nếu environment của bạn chưa có
- branch/workspace đang ở đúng source snapshot bạn muốn scan

### Tối thiểu nên kiểm tra

```powershell
sonar-scanner --version
mvn -version
node -v
npm -v
```

---

## 4. Thứ Tự Chạy Chuẩn

Trong repo này, thứ tự an toàn là:

1. vào đúng thư mục repo
2. build Java bytecode
3. đảm bảo frontend dependency có đủ nếu cần
4. chạy `sonar-scanner`

---

## 5. Lệnh Chạy Chuẩn

### Bước 1. Vào repo

```powershell
Set-Location C:\Users\nk_nhat.BRYCENVN\Documents\kikancen
```

### Bước 2. Build Java bytecode

Theo [sonar-project.properties](C:/Users/nk_nhat.BRYCENVN/Documents/kikancen/sonar-project.properties), bước này là bắt buộc vì `sonar.java.binaries=target/classes`.

```powershell
mvn -q -DskipTests compile
```

### Bước 3. Cài frontend dependency nếu máy chưa có

Chỉ cần khi máy của bạn chưa có `node_modules` hoặc Angular config đang thiếu dependency.

```powershell
npm install
```

### Bước 4. Chạy scan

Không lưu `sonar.host.url` và `sonar.token` vào source control. Truyền qua command line:

```powershell
sonar-scanner `
  -Dsonar.host.url=http://localhost:9000 `
  -Dsonar.token=YOUR_TOKEN
```

Nếu server của bạn không phải local:

```powershell
sonar-scanner `
  -Dsonar.host.url=http://your-sonarqube-server:9000 `
  -Dsonar.token=YOUR_TOKEN
```

---

## 6. Lệnh Gộp Thường Dùng

Nếu chỉ muốn scan nhanh một lần:

```powershell
Set-Location C:\Users\nk_nhat.BRYCENVN\Documents\kikancen
mvn -q -DskipTests compile
sonar-scanner -Dsonar.host.url=http://localhost:9000 -Dsonar.token=YOUR_TOKEN
```

Nếu vừa clone repo mới về và chưa có dependency:

```powershell
Set-Location C:\Users\nk_nhat.BRYCENVN\Documents\kikancen
npm install
mvn -q -DskipTests compile
sonar-scanner -Dsonar.host.url=http://localhost:9000 -Dsonar.token=YOUR_TOKEN
```

---

## 7. Kết Quả Mong Đợi Sau Khi Chạy

Một scan thành công thường sẽ cho bạn:

- log phân tích source
- log upload result lên SonarQube server
- project dashboard hoặc analysis URL trên SonarQube

Sau khi scan xong, bạn nên:

1. mở SonarQube dashboard
2. lọc issue theo scope bạn quan tâm
3. export hoặc copy findings
4. nếu muốn xử lý theo framework mới, dùng `sonar_manual.md`

---

## 8. Khi Nào Phải Chạy Lại Scan

Nên chạy lại khi:

- vừa đổi code đáng kể
- vừa đổi branch
- vừa fix một batch issue và muốn refresh findings
- nghi report cũ không còn match current code

Không nên dùng report quá cũ để triage/fix, vì:

- line number có thể đã lệch
- issue có thể đã stale
- current code có thể khác snapshot lúc scan

---

## 9. Lỗi Hay Gặp

### Lỗi 1. Quên compile Java trước

Triệu chứng:

- Sonar báo thiếu Java binaries
- backend analysis yếu hoặc fail

Cách xử lý:

```powershell
mvn -q -DskipTests compile
```

### Lỗi 2. Chưa có `sonar-scanner`

Triệu chứng:

- terminal báo không tìm thấy command

Cách xử lý:

- cài SonarScanner CLI
- thêm vào `PATH`
- chạy lại `sonar-scanner --version`

### Lỗi 3. Sai `sonar.host.url`

Triệu chứng:

- không connect được tới server

Cách xử lý:

- kiểm tra URL, port, VPN, firewall

### Lỗi 4. Sai token hoặc token hết quyền

Triệu chứng:

- authenticate fail
- upload fail

Cách xử lý:

- tạo token mới
- dùng token có quyền analyze project

### Lỗi 5. Frontend dependency thiếu

Triệu chứng:

- TypeScript analysis lỗi do config hoặc dependency

Cách xử lý:

```powershell
npm install
```

### Lỗi 6. Dùng report cũ để fix luôn

Sai vì:

- scan chỉ sinh findings
- chưa xác nhận issue còn đúng trên current code

Đúng là:

- scan xong thì triage

---

## 10. Scan Xong Thì Làm Gì Tiếp

Nếu bạn chỉ cần scan:

- dừng ở đây là đủ

Nếu bạn muốn xử lý issue:

- không fix ngay từ dashboard Sonar
- tạo hoặc dùng workflow trong `sonar_manual.md`

Flow tiếp theo:

1. chạy scan
2. lấy findings
3. chạy `sonar-triage` hoặc `sonar-triage-and-fix`
4. tạo `docs/sonar/<date>-<scope>-triage.md`
5. nếu cần remediation đợt sau thì dùng `sonar-fix-from-triage`

---

## 11. Prompt Mẫu Nếu Bạn Chỉ Muốn AI Hướng Dẫn Scan

```md
Tôi chỉ muốn chạy SonarQube scan cho repo này.
Không triage, không fix.
Hãy hướng dẫn đúng theo `sonar-project.properties`,
nêu rõ prerequisite,
và đưa ra lệnh PowerShell cụ thể để chạy scan.
```

---

## 12. Câu Nhớ Nhanh

Nếu chỉ muốn chạy Sonar:

> compile Java trước, rồi chạy sonar-scanner với host URL và token; scan xong chưa được phép fix mù.

