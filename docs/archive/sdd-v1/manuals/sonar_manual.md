# SonarQube Manual

Tai lieu nay mo ta quy trinh ro rang de xu ly SonarQube theo SDD ma van uu tien 2 muc tieu:

1. sua dung issue that su con ton tai
2. khong lam hu logic code

Workflow van hanh giu nguyen 4 phase:

1. `triage`
2. `fix safe`
3. `approve`
4. `fix approved`

Khac biet quan trong la:

- khong fix dua tren Sonar output alone
- moi issue deu phai doi chieu voi current code
- chi fix khi co du bang chung rang fix do giu nguyen behavior
- item nao con mo ho, risky, hoac co kha nang doi business logic thi khong auto-fix

## 1. Nguyen Tac Bat Buoc

Phai nho 6 dieu nay:

1. SonarQube chi la input tham khao.
2. Sonar bao dung line chua chac issue van con dung tren current code.
3. `Classification` khong phai `Decision status`.
4. Chi issue `confirmed-fixable` moi duoc xem xet auto-fix.
5. Truoc khi fix phai danh gia logic xung quanh, caller, output, exception, va side effect.
6. Neu con nghi ngo fix co the doi behavior, dung lai va dua vao triage artifact.

## 2. Khi Nao Duoc Goi La Safe Fix

Mot fix chi duoc coi la safe khi tat ca dieu kien sau deu dung:

- issue van con ton tai tren current code
- root cause da duoc hieu ro
- diff nho, cuc bo, va khong mo rong scope
- khong doi input/output contract
- khong doi business rule
- khong doi query, transaction, auth, permission, tenant behavior, validation meaning, hoac error semantics
- co cach verify sau khi sua

Neu thieu bat ky dieu kien nao o tren, khong auto-fix.

## 3. Nhung Loai Fix Khong Duoc Tu Y Auto-Fix

Khong auto-fix neu issue dong vao:

- `if/else` anh huong business path
- return value, response field, DTO shape, API key, schema, file shape
- null handling co the doi ket qua nghiep vu
- exception type, catch logic, retry logic, rollback logic
- SQL, JPQL, criteria, filter, sort, paging
- time, date, timezone, rounding, money, quantity
- auth, role, permission, tenant, session
- loop, batch, concurrency, locking
- regex, validation rule, sanitization rule co the doi behavior
- ma nguon ma ban chua tim du caller / sibling flow

Nhung item nay phai vao artifact va cho `approve`.

## 4. Phase 1: Triage

Muc tieu:

- xac dinh issue co con dung khong
- xac dinh issue co safe-fix duoc khong
- ghi day du ket qua vao triage artifact

Task profile:

- `sonar-triage`

Header mau:

```md
Task Profile: sonar-triage
Feature: n/a
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Sonar Source: sonar_issue.md
Triage Artifact: docs/sonar/2026-03-19-kikancen-triage.md
Review Scope: n/a
Agent Profile: codex
```

AI phai lam tung issue theo thu tu nay:

1. mo file va dong code ma Sonar nhac den
2. doc them method xung quanh, class xung quanh, caller chinh, va test lien quan neu co
3. kiem tra issue con dung hay da stale
4. neu issue con dung, danh gia fix co giu nguyen behavior hay khong
5. gan `Classification`
6. ghi `Decision status`
7. ghi `Reason`, `Proposed action`, `Risk / notes`

Prompt mau:

```md
Hay doc sonar_issue.md, doi chieu current code, doc logic xung quanh cho tung issue, phan loai tung item, va tao triage artifact. Khong sua code trong buoc nay.
```

Ket qua mong doi:

- moi issue deu co ket luan ro
- item an toan duoc nhan dien
- item risky / mo ho / stale duoc ghi vao artifact

## 5. Phase 2: Fix Safe

Muc tieu:

- sua ngay nhung item that su ro rang va giu nguyen logic
- van ghi artifact day du cho tat ca item

Task profile:

- `sonar-triage-and-fix`

Header mau:

```md
Task Profile: sonar-triage-and-fix
Feature: n/a
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Sonar Source: sonar_issue.md
Triage Artifact: docs/sonar/2026-03-19-kikancen-triage.md
Review Scope: n/a
Agent Profile: codex
```

Prompt mau:

```md
Hay doc sonar_issue.md, doi chieu current code, chi fix nhung item confirmed-fixable va behavior-preserving, khong sua item risky hay ambiguous, va cap nhat triage artifact day du.
```

Truoc khi AI duoc fix mot item, AI phai tu tra loi duoc 5 cau hoi:

1. issue nay co con dung tren current code khong?
2. root cause co ro khong?
3. fix nay co doi logic nghiep vu khong?
4. fix nay co doi contract, output, query, exception, validation, hoac side effect khong?
5. co cach verify nhanh rang behavior van dung khong?

Chi khi ca 5 cau tra loi deu an toan moi duoc fix.

Sau khi fix moi item safe, AI phai:

- review lai diff
- kiem tra method va sibling flow bi anh huong
- chay compile / test / lint / check phu hop neu co
- neu phat hien fix co nguy co doi behavior, khong giu fix do trong safe pass

## 6. Phase 3: Approve

Muc tieu:

- quyet dinh item nao duoc sua tiep
- item nao de sau
- item nao la stale / false positive / risky

Buoc nay do reviewer, lead, hoac team thuc hien tren triage artifact.

Decision status nen dung:

- `approved-fix`
- `approved-later`
- `false-positive`
- `stale`
- `needs-business-confirmation`
- `needs-technical-confirmation`
- `risky-no-auto-fix`
- `done`

Rule:

- chi item co `approved-fix` moi duoc vao phase 4
- item `approved-later`, `false-positive`, `stale`, `needs-business-confirmation`, `needs-technical-confirmation`, `risky-no-auto-fix` thi khong sua trong dot hien tai

## 7. Phase 4: Fix Approved

Muc tieu:

- sua cac item da duoc team approve ro rang
- van khong duoc lam hu logic code

Task profile:

- `sonar-fix-from-triage`

Header mau:

```md
Task Profile: sonar-fix-from-triage
Feature: docs/specs/<feature-id>/ | n/a
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Sonar Source: n/a
Triage Artifact: docs/sonar/2026-03-19-kikancen-triage.md
Review Scope: n/a
Agent Profile: codex
```

Prompt mau:

```md
Hay doc triage artifact, chi fix cac item co Decision status: approved-fix, revalidate current code truoc khi sua, va cap nhat artifact thanh done neu hoan tat.
```

Du da approve, AI van phai:

1. mo lai current code
2. xac nhan issue van con dung
3. doc logic xung quanh
4. xac nhan fix hien tai khong vuot scope approval
5. verify sau khi sua

Neu current code da thay doi va issue khong con giong nhu trong artifact, khong duoc fix mu. Phai cap nhat lai artifact.

## 8. Classification Dung Chuan

Chi dung 6 gia tri nay:

- `confirmed-fixable`
- `confirmed-but-risky`
- `not-reproducible`
- `likely-false-positive`
- `needs-human-decision`
- `deferred`

Y nghia nhanh:

- `confirmed-fixable`: issue con dung va co fix giu nguyen behavior
- `confirmed-but-risky`: issue con dung nhung fix co nguy co doi logic
- `not-reproducible`: issue khong con tai current code
- `likely-false-positive`: Sonar canh bao nhung khong hop ly ve mat ky thuat
- `needs-human-decision`: can quyet dinh nghiep vu / kien truc
- `deferred`: biet issue nhung chua xu ly dot nay

## 9. Decision Status Dung Chuan

`Classification` tra loi cau hoi: issue nay la gi.

`Decision status` tra loi cau hoi: team se xu ly issue nay the nao.

Khong tron 2 truong nay.

## 10. Triage Artifact Canonical

Duong dan canonical:

```md
docs/sonar/<date>-<scope>-triage.md
```

Artifact phai co:

- `Summary`
- `Issue Details`
- `Fixed in this pass`
- `Not fixed in this pass`
- `User decision items`
- `Next actions`

Moi issue phai co:

- `Issue ID`
- `Rule`
- `Severity`
- `File`
- `Line`
- `Sonar message`
- `Current code status`
- `Classification`
- `Decision status`
- `Reason`
- `Proposed action`
- `Risk / notes`

## 11. Checklist Truoc Khi Giup AI Fix

Truoc khi giao AI lam `fix safe` hoac `fix approved`, ban nen co:

- file findings hoac triage artifact ro rang
- dung task profile
- scope code ro rang
- neu fix co kha nang non-trivial thi co governing feature package

Khong nen giao AI theo kieu:

```md
Sonar bao nhieu day, sua het giup toi.
```

Nen giao theo kieu:

```md
Hay triage tung issue tren current code. Chi fix item behavior-preserving, khong doi business logic, con lai ghi vao triage artifact.
```

## 12. Nho Nhanh

Day la quy trinh toi thieu nhung an toan:

1. `triage`
2. `fix safe`
3. `approve`
4. `fix approved`

Neu muc tieu la sua dung va khong lam hu logic code, diem khac biet nam o day:

- moi issue deu phai doc current code that su
- moi fix deu phai qua safe gate
- item risky khong duoc sua trong safe pass
- item approved van phai revalidate truoc khi sua
