# Audit: 2026-03-23-repository-security-audit

- Status: completed
- Last Updated: 2026-03-23

## 1. Scope And Basis

- Governing inputs loaded: `AGENTS.md`, `docs/execution/ai-loading-order.md`, `docs/execution/task-routing.md`, `docs/execution/task-contracts.md`, `docs/governance/core-rules.md`, `docs/governance/minimal-context.md`, `docs/standards/api-rules.md`, `docs/standards/db-rules.md`, `docs/standards/testing-rules.md`, `docs/standards/schema_database.yaml`.
- Repository shape inspected: Java WAR backend + Angular frontend + checked-in resources + build scripts + manifests + existing local outputs.
- Codebase size observed during audit: 4,254 Java files, 751 `*WebService.java`, 1,003 `*Process.java`, 8 test files under `src/test/java`.
- Existing outputs consumed:
  - `.scannerwork/report-task.txt`
  - `static-analysis-report.md`
  - no SARIF, no CodeQL, no Semgrep, no Trivy, no Syft, no Grype, no Gitleaks, no osv-scanner artifacts were present
- Security-important files inspected directly:
  - `src/main/webapp/WEB-INF/web.xml`
  - `src/main/java/jp/co/brycen/common/config/ApplicationConfig.java`
  - `src/main/java/jp/co/brycen/common/process/AbstractProcess.java`
  - `src/main/java/jp/co/brycen/common/utility/IdTokenUtility.java`
  - `src/main/java/jp/co/brycen/common/utility/AES128AndBase64.java`
  - `src/main/java/jp/co/brycen/common/database/DBPoolManager.java`
  - `src/main/java/jp/co/brycen/common/database/DBStatement.java`
  - `src/main/java/jp/co/brycen/common/webservice/AbstractAPIWebService.java`
  - `src/main/resources/config.properties`
  - `src/main/resources/db.properties`
  - `src/main/resources/log4j2.xml`
  - `src/main/resources/mode.properties`
  - `src/main/webapp/META-INF/context.xml`
  - `core-system-396904-7ed053021321.json`
  - `src/main/resources/json/core-system-396904-7ed053021321.json`
  - `pom.xml`
  - `build.xml`
  - `package.json`
  - `package-lock.json`
  - `src/main/webapp/angular/package.json`
  - `src/main/webapp/angular/package-lock.json`
- Validation commands actually run:
  - `mvn -q test`
  - `mvn dependency:list "-DincludeScope=runtime" "-DoutputFile=artifacts/security/maven-dependency-list.txt" "-DappendOutput=false"`
  - `mvn dependency:tree "-DoutputType=text" "-DoutputFile=artifacts/security/maven-dependency-tree.txt"`
  - `mvn org.cyclonedx:cyclonedx-maven-plugin:2.9.1:makeAggregateBom -DoutputFormat=json ...`
  - `npm audit --json`
  - `npm audit --omit=dev --json`
  - `npm ls --omit=dev --depth=0 --json`
  - `npm sbom --sbom-format cyclonedx --omit=dev`
  - `npm sbom --sbom-format spdx --omit=dev`
  - targeted `git log`, `git grep`, `Select-String`, and file inspection commands
- Key tool limits recorded during execution:
  - dedicated scanners such as `syft`, `grype`, `trivy`, `gitleaks`, `semgrep`, and `osv-scanner` were not installed
  - OWASP Dependency-Check could not produce a report in this workspace: default Maven runtime was Java 8 and the newer plugin failed to load there; a second run under JDK 25 timed out without emitting a report
  - npm SBOM generation failed because the installed Angular dependency tree is incomplete for `ag-grid-angular` and `ag-grid-community`
- Existing `static-analysis-report.md` was treated as a low-trust input only. It contained at least one stale claim, namely that `src/test/java` did not exist. Any overlapping issue was re-validated from repository evidence before inclusion.

## 2. Grounded Report

### 1. エグゼクティブサマリー

- 全体リスク判定: `critical`
- Severity 別件数: `critical 2`, `high 4`, `medium 3`, `low 1`
- カテゴリ別件数: `SAST 7`, `Secrets 1`, `IaC/CI-CD 1`, `SCA 1`, `SBOM 0`
- Top 5 issue:
  - `KIKA-SEC-001` リポジトリ内に有効形態の秘密情報が現物コミットされ、履歴にも残っている
  - `KIKA-SEC-002` ユーザーパスワードが平文保存・平文比較・平文更新されている
  - `KIKA-SEC-003` 保存済みパスワードや外部連携資格情報が API でクライアントへ返却されている
  - `KIKA-SEC-004` 認証前 API がユーザー存在、権限属性、組織属性を返している
  - `KIKA-SEC-005` SQL パラメータ、API key、宛先情報がログへ平文近い形で流れる
- CI を fail すべきか: `FAIL`
  - 理由: validated の `critical` が存在し、露出 secret が存在し、匿名 auth 境界の高信頼 issue と runtime dependency の validated high が存在する

### 2. カバレッジマトリクス

| 領域 | status | evidence source | blockers | blind spots |
| --- | --- | --- | --- | --- |
| SAST | partial | 主要 auth/login/change-password/download/logging/crypto/batch 実装、`mvn-test.log`、751 webservice と 1,003 process を前提に高リスク経路を重点確認 | Semgrep/CodeQL 不在、巨大コードベース、動的 runtime 文脈なし | 全 4,254 Java ファイルの行単位精査、全業務ロジック、全ファイル処理・テンプレート系 |
| Secrets | partial | `config.properties`, `db.properties`, 2 件の GCP JSON, `context.xml`, targeted `git log` | gitleaks/trufflehog 不在、バイナリ/JAR 内 secrets 未走査 | 全 git 履歴のパターン全走査、外部 CI 変数、artifact/registry secrets |
| IaC / CI-CD | partial | `git ls-files` により active tracked build/deploy 面を確認、`build.xml` 精査 | tracked IaC/CI 定義自体がほぼ存在しない | 外部 CI システム、クラウド IAM、実デプロイ基盤、registry policy |
| SCA | partial | `pom.xml`, Maven dependency list/tree, npm audit full/prod, npm ls prod, Angular lockfile | Java CVE scanner 実レポート未取得、vendored JAR、node_modules 不整合 | Java transitive CVE の完全性、native binary、未インストール npm transitive 全件 |
| SBOM | partial | `artifacts/security/sbom.cyclonedx.json`, npm SBOM failure logs, manifests/lockfiles | SPDX generator が repo-wide に揃わず、npm SBOM が `ESBOMPROBLEMS` で失敗 | Angular/runtime npm components の完全 BOM、vendored JAR provenance、repo-wide SPDX JSON |

### 3. 脅威モデル要約

- アーキテクチャ概要:
  - `src/main/webapp/WEB-INF/web.xml` の Jersey servlet が `/webapi/*` を公開
  - `ApplicationConfig` が CORS, JSON validation を登録
  - Java backend は MySQL/HikariCP, SendGrid, Google Cloud Storage, SSH 経由の外部 batch 実行と接続
  - Angular frontend は `src/main/webapp/angular` に同居
- 攻撃面:
  - 751 個の `*WebService` endpoint
  - login/change-password/check-code 系の pre-auth endpoint
  - token 付き download endpoint 群
  - admin/detail/search API
  - config/resource files と checked-in credential material
  - checked-in build script と vendored JAR
- Trust boundary:
  - browser -> `/webapi/*`
  - anonymous caller -> login/check-code/change-password flows
  - app -> MySQL
  - app -> Google Cloud Storage using checked-in service account key
  - app -> SendGrid using checked-in API key
  - app -> remote host via SSH private key and `StrictHostKeyChecking=no`
  - build script -> workstation-local Eclipse/QALab classpath
- Crown jewels:
  - ユーザーパスワード
  - GCP service account private key
  - SendGrid API key
  - DB connection credentials
  - session token
  - 管理者権限属性、組織属性、partner 情報
  - customer/admin detail data and mail recipients
- 重要な仮定:
  - `context.xml` の datasource credential は active use 未確認だが checked-in exposure として扱う
  - tracked repo 上に Docker/Kubernetes/Terraform/GitHub Actions/GitLab CI 定義は存在しない
  - tenant/organization boundary は `cmpnycd`, `storecd`, `USRCD`, `systemadminauth`, `headquarterupdateauth` の組み合わせで表現されているが、全 query の tenant review は未完

### 4. Findings 一覧表

| ID | category | title | severity | confidence | status | files | short rationale |
| --- | --- | --- | --- | --- | --- | --- | --- |
| KIKA-SEC-001 | Secrets | Checked-in secrets and credentials in current tree and history | critical | high | validated | `config.properties`, `db.properties`, both GCP key JSON files, `context.xml` | 実 credential material が現物で存在し、少なくとも一部はコードから利用される |
| KIKA-SEC-002 | SAST | Plaintext password storage, comparison, and update across login flows | critical | high | validated | login/update process classes | DB の `PASSWORD`/`BFRPASSWORD` を平文のまま扱っている |
| KIKA-SEC-003 | SAST | Stored passwords and external credentials are returned to authenticated clients | high | high | validated | detail/search process classes and Angular admin components | 保存済み secret が response DTO と Angular state へ流れている |
| KIKA-SEC-004 | SAST | Pre-auth endpoints enumerate users and leak privilege and org metadata | high | high | validated | `AbstractProcess`, `ConstantValue`, `Spcm00101CheckCode*`, `Spcm00101CheckChangePass*` | 認証前 endpoint が権限属性や氏名を返している |
| KIKA-SEC-005 | SAST | SQL params and API keys are logged to persistent logs | high | high | validated | `DBStatement`, `AbstractAPIWebService`, `log4j2.xml`, `MailService` | current/new password, API key, recipient list が log sink に入る |
| KIKA-SEC-006 | SAST | Custom static AES key and IV make secret and token protection reversible | medium | high | strongly-supported | `AES128AndBase64`, `DBPoolManager`, `IdTokenUtility` | 固定 key/IV の可逆暗号で DB credential と session token を扱う |
| KIKA-SEC-007 | SAST | Session token is sent in URL query parameters for downloads | medium | high | validated | Angular download builders and 12 Java download webservices | browser history, referrer, reverse proxy log, access log へ token が残りうる |
| KIKA-SEC-008 | SAST | SSH batch execution disables host key verification and has no timeout | medium | high | validated | 19 process classes | MITM と stuck process の両リスクがある |
| KIKA-SEC-009 | SCA | Frontend runtime dependencies have validated high-severity vulnerabilities | high | high | validated | Angular manifest/lockfile and npm audit outputs | production dependency 4 件が direct high、dev chain は 40 件 total |
| KIKA-SEC-010 | IaC / CI-CD | Tracked build path is not reproducible and depends on workstation-local absolute paths | low | high | informational-hygiene | `build.xml`, vendored `WEB-INF/lib` jars | build provenance と artifact integrity control が弱い |

### 5. 詳細 Findings

#### KIKA-SEC-001

- category: `Secrets`
- title: `Checked-in secrets and credentials in current tree and history`
- severity / confidence / status: `critical / high / validated`
- 影響ファイルと行番号:
  - `src/main/resources/config.properties:4,6,7,8,10,11`
  - `src/main/resources/db.properties:1,2,3,4`
  - `core-system-396904-7ed053021321.json:4,5,6`
  - `src/main/resources/json/core-system-396904-7ed053021321.json:4,5,6`
  - `src/main/webapp/META-INF/context.xml:38,39`
  - secret use path examples:
    - `src/main/java/jp/co/brycen/common/ConstantValue.java:802,837`
    - `src/main/java/jp/co/brycen/kikancen/common/process/MailService.java:62,63`
    - `src/main/java/jp/co/brycen/kikancen/common/cloudfiledownload/process/CloudFileDownloadProcess.java:57,58`
- vulnerability class: `hardcoded credential`, `secret material exposure`
- root cause:
  - runtime secrets were committed directly into source-controlled resources instead of being injected from a secret store or runtime-only config
  - the same GCP service account key was duplicated in two tracked locations
- exploitability explanation:
  - anyone with repository read access can retrieve the GCP private key, SendGrid key, DB connection material, and at least one Tomcat datasource credential
  - because the GCP key path and SendGrid properties are referenced by live code, these are not dead examples
  - targeted `git log` shows these files have historical commits, so exposure is not limited to the current checkout
- evidence:
  - masked inspection showed `sendGridApiKey=SG.k***NPBA`, `fromMail=anac***m.mm`, SSH host and key path in `config.properties`
  - masked inspection showed `url`, `user`, `pass`, and `key` in `db.properties`
  - both JSON key files contain `private_key_id`, `private_key`, and `client_email`
  - targeted history contains commits such as `8f2a0de4 db.properties追加`, `400191aa add config mail`, `b0474382 init new source`
- 実施した validation と結果:
  - file inspection: success
  - `git log --oneline --all -- <secret files>`: success, history confirmed
  - active use confirmation: success for GCP and SendGrid paths through code references
  - live credential validity: not tested
- 最小修正:
  - revoke and rotate all exposed credentials before any code change rollout
  - remove secret values from tracked files and inject them from environment, JNDI, or a platform secret store
- 長期修正:
  - split service identities by function
  - move all runtime secrets to a managed secret store
  - enforce pre-commit and CI secret scanning
  - purge repository history with an approved incident process after rotation
- 変更すべきファイル:
  - `src/main/resources/config.properties`
  - `src/main/resources/db.properties`
  - `src/main/webapp/META-INF/context.xml`
  - `core-system-396904-7ed053021321.json`
  - `src/main/resources/json/core-system-396904-7ed053021321.json`
  - consuming code under `common/process`, `common/cloudfiledownload`, `ConstantValue`
- patch sketch:

```diff
- sendGridApiKey=SG....
- fromMail=anac.testingmail@...
+ sendGridApiKey=${SENDGRID_API_KEY}
+ fromMail=${SENDGRID_FROM_MAIL}

- protected String serviceAccountKeyFile = "json/core-system-396904-7ed053021321.json";
+ protected String serviceAccountKeyFile = System.getenv("GCS_SERVICE_ACCOUNT_JSON_PATH");
```

- 回帰テスト:
  - CI secret scan must fail on `private_key`, `client_email`, `sendGridApiKey=SG.`, datasource `password="..."`, or JDBC credential patterns under tracked files
- rollout 上の注意点:
  - rotate first, deploy second, purge history third
  - keep a rollback-safe secret cutover plan because mail and GCS integrations are runtime-critical
- defer した場合の残存リスク:
  - immediate third-party service abuse, data access, and incident response burden remain

#### KIKA-SEC-002

- category: `SAST`
- title: `Plaintext password storage, comparison, and update across login flows`
- severity / confidence / status: `critical / high / validated`
- 影響ファイルと行番号:
  - `src/main/java/jp/co/brycen/kikancen/spcm00101login/process/Spcm00101LoginProcess.java:139,162,201`
  - `src/main/java/jp/co/brycen/kikancen/spcm00401acLogin/process/Spcm00401acLoginProcess.java:133,156,195`
  - `src/main/java/jp/co/brycen/kikancen/spcm00301update/process/Spcm00301UpdateProcess.java:73,178,202,204,221,223`
  - `src/main/java/jp/co/brycen/kikancen/spcm00501acupdate/process/Spcm00501AcUpdateProcess.java:70,175,199,201,218,220`
- vulnerability class: `insecure credential storage`
- root cause:
  - authentication and password change logic are built around `PASSWORD` and `BFRPASSWORD` columns as raw secrets, not one-way password hashes
- exploitability explanation:
  - any DB exposure yields immediate credential compromise
  - any logging or API exposure of these fields yields direct account takeover
  - password reuse across systems amplifies blast radius beyond this application
- evidence:
  - login flow fetches `TMT002_USER.PASSWORD` and compares it with `password.equals(...)`
  - password change flow validates `AND PASSWORD = ?` and updates `PASSWORD = ?`, `BFRPASSWORD = ?`
- 実施した validation と結果:
  - source inspection: success
  - compile/test sanity: `mvn -q test` succeeded, so inspected code is build-valid in this workspace
  - runtime DB check: not performed
- 最小修正:
  - stop reading raw password columns for login checks
  - migrate to one-way hashed columns and verify with a password hashing service such as Argon2id or bcrypt
- 長期修正:
  - schema migration under `docs/standards/schema_database.yaml` authority
  - forced password reset for all users after migration
  - remove any legacy `BFRPASSWORD` plaintext retention
- 変更すべきファイル:
  - login and password update processes listed above
  - DTOs and constants that carry raw password fields
  - schema authority and corresponding DB migration artifacts
- patch sketch:

```diff
- this.setPasswordDb(rs.getString(Spcm00101Constant.PASSWORD));
- return !password.equals(this.getPasswordDb());
+ this.setPasswordHash(rs.getString("PASSWORD_HASH"));
+ return !passwordHasher.verify(password, this.getPasswordHash());

- strSql.append("AND PASSWORD = ? ");
- strSql.append("PASSWORD = ? ");
- strSql.append(",BFRPASSWORD = ? ");
+ // fetch by user id, verify hash in application code, then store only new hash
+ strSql.append("PASSWORD_HASH = ? ");
+ strSql.append(",PREV_PASSWORD_HASH = ? ");
```

- 回帰テスト:
  - login succeeds with correct password and fails with incorrect password against hashed storage
  - password change no longer issues SQL containing raw current or new password values
  - no API response contains stored password material
- rollout 上の注意点:
  - requires staged data migration and mandatory password reset window
  - old and new auth paths should not coexist without clear cutover logic
- defer した場合の残存リスク:
  - one DB leak or log leak remains a full credential compromise event

#### KIKA-SEC-003

- category: `SAST`
- title: `Stored passwords and external credentials are returned to authenticated clients`
- severity / confidence / status: `high / high / validated`
- 影響ファイルと行番号:
  - `src/main/java/jp/co/brycen/kikancen/spmt00101getdetail/process/Spmt00101GetDetailProcess.java:65`
  - `src/main/java/jp/co/brycen/kikancen/spmt00101search/process/Spmt00101SearchAllRecProcess.java:223`
  - `src/main/java/jp/co/brycen/kikancen/spmt00241getdetail/process/Spmt00241GetUserRowProcess.java:137,138`
  - `src/main/java/jp/co/brycen/kikancen/spmt01401ac/process/Spmt01401acCommonProcess.java:101,237`
  - `src/main/webapp/angular/src/app/components/spmt00101/spmt00101.component.ts:965`
  - `src/main/webapp/angular/src/app/components/spmt00241/spmt00241.user.component.ts:303,315`
  - `src/main/webapp/angular/src/app/components/spmt01401ac/spmt01401ac.component.ts:424,755`
  - `src/main/webapp/angular/src/app/components/sppr00101ac/sppr00101ac.component.ts:1173,1639`
- vulnerability class: `sensitive data exposure`
- root cause:
  - backend detail/search processes serialize stored password fields into response DTOs
  - frontend components hydrate password inputs directly from those response fields
- exploitability explanation:
  - any authenticated operator with access to these screens can retrieve stored user or external integration secrets
  - browser devtools, support screenshots, XSS, and client logs all become additional exfiltration points
- evidence:
  - backend code sets `pass`, `password`, `bfrPassword`, and WebEDI password fields from DB result sets
  - Angular components assign `response.pass`, `data.password`, and `detail.password` into component state
- 実施した validation と結果:
  - source inspection: success
  - auth boundary: endpoints are authenticated by default, but sensitive value exposure still occurs post-auth
- 最小修正:
  - stop returning any stored secret field in response DTOs
  - reset password forms to empty write-only inputs
- 長期修正:
  - remove password-bearing fields from DTO contracts entirely
  - replace any “show current password” behavior with reset or reissue workflows
- 変更すべきファイル:
  - backend processes listed above
  - corresponding response DTOs
  - Angular components that bind returned password fields
- patch sketch:

```diff
- res.setPass(rs.getString(Spmt00101Constant.PASSWORD));
- userData.setPassword(getStringOrDefault(rs, Spmt00241Constant.PASSWORD, ""));
- this.registPass = response.pass;
- this.passwordInput = data.password;
+ // stored passwords are write-only; never return them
+ this.registPass = Const.EMPTY_STRING;
+ this.passwordInput = Const.EMPTY_STRING;
```

- 回帰テスト:
  - JSON responses for these detail/search APIs must not contain `pass`, `password`, `bfrPassword`, or equivalent secret fields
  - Angular component tests should assert password inputs remain blank on detail load
- rollout 上の注意点:
  - coordinate with UI owners because existing screens may assume the returned fields
  - if these fields support external WebEDI credentials, move to a reset-and-confirm flow
- defer した場合の残存リスク:
  - authenticated data harvest of user and integration credentials remains possible

#### KIKA-SEC-004

- category: `SAST`
- title: `Pre-auth endpoints enumerate users and leak privilege and org metadata`
- severity / confidence / status: `high / high / validated`
- 影響ファイルと行番号:
  - `src/main/java/jp/co/brycen/common/ConstantValue.java:114,115,117`
  - `src/main/java/jp/co/brycen/common/process/AbstractProcess.java:587,588,592,593,601`
  - `src/main/java/jp/co/brycen/kikancen/spcm00101checkcode/webservice/Spcm00101CheckCodeWebService.java:20,23,24`
  - `src/main/java/jp/co/brycen/kikancen/spcm00101checkcode/process/Spcm00101CheckCodeProcess.java:76,77,78,79,80,81,95,96,97,98,100,101,106,107`
  - `src/main/java/jp/co/brycen/kikancen/spcm00101checkchangepass/webservice/Spcm00101CheckChangePassWebService.java:16,19,20`
  - `src/main/java/jp/co/brycen/kikancen/spcm00101checkchangepass/process/Spcm00101CheckChangePassProcess.java:54`
- vulnerability class: `authentication flaw`, `user enumeration`, `authorization metadata disclosure`
- root cause:
  - a hardcoded bypass list in `AbstractProcess.checkAuth` exempts 14 login-related process IDs from auth enforcement
  - two public endpoints return more than the minimum data needed for a safe pre-auth flow
- exploitability explanation:
  - an anonymous caller can test user codes and obtain user display name, main company/store, language, usability, admin flags, and partner metadata
  - this materially lowers the cost of credential stuffing, phishing, and privilege-targeted attacks
- evidence:
  - `getProcessId()` defaults to simple class name, and `Spcm00101CheckCodeProcess` / `Spcm00101CheckChangePassProcess` are explicitly in the bypass list
  - the public webservices are `POST /webapi/kikancen/Spcm00101CheckCode` and `POST /webapi/kikancen/Spcm00101CheckChangePass`
  - response population includes `setSystemAdminAuth`, `setHeadQuarterUpdateAuth`, `setPartnerCd`, `setPartnerNm`, and `USRNM`
- 実施した validation と結果:
  - source inspection: success
  - test execution: no dedicated auth tests for these endpoints were present in the existing suite
- 最小修正:
  - remove these endpoints from the auth bypass list unless a pre-auth business requirement is explicitly approved
  - if they must remain public, return only a generic success/failure signal without identity or privilege detail
- 長期修正:
  - redesign password-change initiation around proof of possession, one-time reset token, or out-of-band verification
  - add rate limiting and abuse monitoring on all pre-auth endpoints
- 変更すべきファイル:
  - `src/main/java/jp/co/brycen/common/ConstantValue.java`
  - `src/main/java/jp/co/brycen/common/process/AbstractProcess.java`
  - both `Spcm00101CheckCode*` and `Spcm00101CheckChangePass*` implementations
- patch sketch:

```diff
- || request.accessInfo.PRCSID.equals(ConstantValue.LOGIN_PROCESS_NM5)
- || request.accessInfo.PRCSID.equals(ConstantValue.LOGIN_PROCESS_NM6)
+ // pre-auth identity lookups removed

- resSpcm00101CheckCode.setSystemAdminAuth(systemadminauth);
- resSpcm00101CheckCode.setHeadQuarterUpdateAuth(headquarterupdateauth);
- resSpcm00101CheckChangePass.USRNM = rs.getString(...);
+ // return only generic reset eligibility state after stronger verification
```

- 回帰テスト:
  - anonymous request to these endpoints should not reveal whether a user exists, their name, or their auth flags
  - rate-limit tests or abuse counters should fire on repeated invalid requests
- rollout 上の注意点:
  - coordinate with the login UX because current flow appears to rely on these calls
  - generic errors will change some screen behavior and must be communicated
- defer した場合の残存リスク:
  - targeted phishing and password attack preparation remains easy and low-noise

#### KIKA-SEC-005

- category: `SAST`
- title: `SQL params and API keys are logged to persistent logs`
- severity / confidence / status: `high / high / validated`
- 影響ファイルと行番号:
  - `src/main/java/jp/co/brycen/common/database/DBStatement.java:60,98,122,194`
  - `src/main/java/jp/co/brycen/common/webservice/AbstractAPIWebService.java:104,132`
  - `src/main/resources/log4j2.xml:10,11,12,25,26,27`
  - `src/main/java/jp/co/brycen/kikancen/common/process/MailService.java:320,321,322`
  - `artifacts/security/mvn-test.log:16,17`
- vulnerability class: `unsafe logging`
- root cause:
  - shared DB and API logging code appends raw parameter values and API keys before sending them to info-level log sinks
- exploitability explanation:
  - any operator, log shipper, incident dump, or support bundle with log access may recover current password, new password, API key, or recipient information
  - this compounds the plaintext password design and query-string token design
- evidence:
  - `DBStatement.setString()` appends raw values to `params`, and `executeQuery` / `executeUpdate` log SQL plus params
  - `AbstractAPIWebService` logs `request.getApikey()`
  - `log4j2.xml` routes info logs to `/console/brycen.log`
  - `mvn-test.log` captured `WebService...(dummy-key/127.0.0.1/...)`, proving the log path executes in tests
- 実施した validation と結果:
  - source inspection: success
  - `mvn -q test` under `cmd` with log capture: success, log artifact created
- 最小修正:
  - centrally mask or suppress sensitive fields before logging
  - never log API keys, passwords, tokens, or full recipient lists
- 長期修正:
  - introduce structured logging with field allowlists and a common redaction utility
  - add automated log-content tests for sensitive patterns
- 変更すべきファイル:
  - `DBStatement.java`
  - `AbstractAPIWebService.java`
  - `MailService.java`
  - logging helper classes if present
- patch sketch:

```diff
- params.append("[" + parameterIndex + "-" + x + "]");
+ params.append("[" + parameterIndex + "-" + redact(parameterIndex, x) + "]");

- logSend(LogLevel.INFOMATION, "WebService開始：(" + request.getApikey() + "/" + ...);
+ logSend(LogLevel.INFOMATION, "WebService開始：(" + maskApiKey(request.getApikey()) + "/" + ...);
```

- 回帰テスト:
  - grep captured test logs for forbidden patterns such as `dummy-key`, `token=`, `PASSWORD = ?` bound values, or full email lists
- rollout 上の注意点:
  - security masking should be deployed before or alongside password migration to cut ongoing leakage
- defer した場合の残存リスク:
  - every new login, password change, or API request can continue seeding log stores with recoverable secrets

#### KIKA-SEC-006

- category: `SAST`
- title: `Custom static AES key and IV make secret and token protection reversible`
- severity / confidence / status: `medium / high / strongly-supported`
- 影響ファイルと行番号:
  - `src/main/java/jp/co/brycen/common/utility/AES128AndBase64.java:37,40,43,116,117,121,154,155,157`
  - `src/main/java/jp/co/brycen/common/database/DBPoolManager.java:92,316,332`
  - `src/main/java/jp/co/brycen/common/utility/IdTokenUtility.java:80,147`
- vulnerability class: `cryptographic misuse`
- root cause:
  - application-defined AES-CBC uses a hardcoded static key and IV embedded in source
  - the same helper protects both DB credential material and session token contents
- exploitability explanation:
  - anyone with source or decompiled bytecode can reproduce encryption and decryption behavior
  - session token secrecy depends on the same primitive, so exposure of token ciphertext yields full token plaintext to any code-aware attacker
- evidence:
  - `STATIC_IV_STRING` and `STATIC_KEY_STRING` are literal constants
  - `DBPoolManager` decrypts database password material with this helper
  - `IdTokenUtility.generate()` encrypts the session token with the same helper and `check()` decrypts it
- 実施した validation と結果:
  - source inspection: success
  - live decryption of repository secrets: intentionally not performed
- 最小修正:
  - remove this helper from secret protection use cases
  - move DB credentials to runtime secret injection
  - replace encrypted custom session token with a signed random token or opaque server-generated session id
- 長期修正:
  - if application cryptography is still required, use standard libraries with per-message randomness and managed keys
  - separate key domains for storage encryption and session handling
- 変更すべきファイル:
  - `AES128AndBase64.java`
  - `DBPoolManager.java`
  - `IdTokenUtility.java`
- patch sketch:

```diff
- private static final String STATIC_IV_STRING = "...";
- private static final String STATIC_KEY_STRING = "...";
- strIdToken = AES128AndBase64.encrypt(strIdToken);
+ strIdToken = sessionTokenService.issueOpaqueToken(dto);
+ // DB credentials supplied by runtime secret provider, not app-level reversible crypto
```

- 回帰テスト:
  - token issuance should produce non-deterministic opaque values
  - no application code path should be able to decrypt DB credentials from tracked config
- rollout 上の注意点:
  - changing token format invalidates existing sessions and requires coordinated logout handling
- defer した場合の残存リスク:
  - any future secret accidentally committed in encrypted form remains practically recoverable

#### KIKA-SEC-007

- category: `SAST`
- title: `Session token is sent in URL query parameters for downloads`
- severity / confidence / status: `medium / high / validated`
- 影響ファイルと行番号:
  - `src/main/webapp/angular/src/app/components/common/base/base.component.ts:1215`
  - `src/main/webapp/angular/src/app/services/common/webservice.service.ts:200,201,202,203`
  - 代表 backend endpoints:
    - `src/main/java/jp/co/brycen/kikancen/common/csvexport/webservice/CsvDownloadWebService.java:30`
    - `src/main/java/jp/co/brycen/kikancen/common/exceldownload/webservice/ExcelDownloadWebService.java:31`
    - `src/main/java/jp/co/brycen/kikancen/spcm00101downloadmanual/webservice/Spcm00101DownloadManualWebService.java:28`
  - measured occurrence count: 12 Java download webservices with `@QueryParam("token")`
- vulnerability class: `credential exposure via URL`
- root cause:
  - frontend builds file-download URLs by concatenating `token`, `usrcd`, and auth flags into a query string
  - backend download APIs accept the session token from query parameters
- exploitability explanation:
  - the full authenticated URL can be written to browser history, reverse proxy access logs, server logs, referrer headers, clipboard shares, and screenshots
  - a leaked valid URL contains both `usrcd` and `token`, which is enough for replay during the token lifetime
- evidence:
  - `generateFileDownloadParam()` appends `&token=...`
  - `window.open()` sends the resulting URL
  - download webservices read `@QueryParam("token")`
- 実施した validation と結果:
  - source inspection: success
  - occurrence count query: success, 12 endpoints matched
- 最小修正:
  - stop sending tokens in URLs
  - move download auth to `Authorization` header or one-time short-lived download ticket in POST body
- 長期修正:
  - centralize file download through a tokenless signed URL or server-side blob streaming endpoint with header-based auth only
- 変更すべきファイル:
  - Angular download param builder and `window.open` flow
  - all download webservices currently using `@QueryParam("token")`
- patch sketch:

```diff
- param += "&token=" + this.loginInfo.token;
- window.open(baseUrl + param, "_blank");
+ this.downloadService.openWithAuthorization(webServiceNm, requestBody, this.loginInfo.token);

- @QueryParam("token") String token
+ @HeaderParam("Authorization") String authorization
```

- 回帰テスト:
  - generated download URLs must not contain `token=`
  - backend should reject query-string token auth once header flow is introduced
- rollout 上の注意点:
  - browser download UX may need to switch from raw `window.open` to authenticated fetch + blob flow
- defer した場合の残存リスク:
  - log and browser leak channels continue to expose active sessions

#### KIKA-SEC-008

- category: `SAST`
- title: `SSH batch execution disables host key verification and has no timeout`
- severity / confidence / status: `medium / high / validated`
- 影響ファイルと行番号:
  - representative files:
    - `src/main/java/jp/co/brycen/kikancen/sppr00121/process/UpdateStockChangeProcess.java:113,168`
    - `src/main/java/jp/co/brycen/kikancen/sppr00121/process/GetTaxRateBatchProcess.java:73,120`
    - `src/main/java/jp/co/brycen/kikancen/sppm00031update/process/Sppm00091BatchProcess.java:135,161`
  - measured occurrence count: 19 classes using `StrictHostKeyChecking=no`
- vulnerability class: `unsafe command execution hardening`
- root cause:
  - remote SSH invocations were implemented repeatedly with permissive options and blocking waits
- exploitability explanation:
  - `StrictHostKeyChecking=no` allows silent host key replacement and weakens trust in the remote endpoint
  - `waitFor()` without timeout creates a stuck-process and resource exhaustion path if the remote side hangs
- evidence:
  - `git grep` found 19 occurrences of `StrictHostKeyChecking=no`
  - representative files call `process.waitFor()` directly
- 実施した validation と結果:
  - source inspection: success
  - full runtime execution against remote host: not performed
- 最小修正:
  - set `StrictHostKeyChecking=yes`
  - configure `ConnectTimeout` and bounded `waitFor(timeout, unit)`
- 長期修正:
  - centralize SSH execution behind a hardened wrapper with host key pinning, timeout, retry, stderr capture, and metrics
- 変更すべきファイル:
  - the 19 matched process classes
  - any shared helper used to build remote batch commands
- patch sketch:

```diff
- new ProcessBuilder("ssh", "-o", "StrictHostKeyChecking=no", "-i", key, host, "-p", port, remoteCommand);
- return process.waitFor();
+ new ProcessBuilder("ssh", "-o", "StrictHostKeyChecking=yes", "-o", "ConnectTimeout=10", "-i", key, host, "-p", port, remoteCommand);
+ return process.waitFor(60, java.util.concurrent.TimeUnit.SECONDS) ? process.exitValue() : TIMEOUT_EXIT;
```

- 回帰テスト:
  - unit tests on command builder args and timeout branch
  - failure-path tests for host-key mismatch and timeout handling
- rollout 上の注意点:
  - host key verification requires known_hosts provisioning before deployment
- defer した場合の残存リスク:
  - remote batch trust remains weak and hung remote calls can degrade service reliability

#### KIKA-SEC-009

- category: `SCA`
- title: `Frontend runtime dependencies have validated high-severity vulnerabilities`
- severity / confidence / status: `high / high / validated`
- 影響ファイルと行番号:
  - `src/main/webapp/angular/package.json:13,14,15,33,34`
  - `src/main/webapp/angular/package-lock.json:2489,2497`
  - `artifacts/security/npm-audit-prod.json`
  - `artifacts/security/npm-audit-full.json`
  - `artifacts/security/npm-ls-prod.json`
- vulnerability class: `vulnerable dependency`
- root cause:
  - Angular 13-era runtime packages and `ag-grid-community` remain on vulnerable ranges
  - the installed dependency tree is incomplete, which also blocks clean SBOM generation
- exploitability explanation:
  - `npm audit --omit=dev` reported 4 direct runtime high-severity findings:
    - `@angular/common`: XSRF token leakage via protocol-relative URLs
    - `@angular/compiler`: stored XSS / unsanitized SVG script attribute issues
    - `@angular/core`: XSS in SVG/i18n paths
    - `ag-grid-community`: prototype pollution
  - full tree audit reported 40 total findings including a critical `webpack` issue in the build chain
- evidence:
  - production audit counts: `high 4`, `total 4`
  - full audit counts: `critical 1`, `high 23`, `moderate 10`, `low 6`, `total 40`
  - `npm ls --omit=dev --depth=0` reported missing `ag-grid-angular@^30.2.1` and `ag-grid-community@^30.2.1`
- 実施した validation と結果:
  - `npm audit --omit=dev --json`: success, report saved
  - `npm audit --json`: success, report saved
  - `npm ls --omit=dev --depth=0 --json`: success with `ELSPROBLEMS`, proving tree drift
- 最小修正:
  - upgrade direct vulnerable runtime packages to a non-vulnerable supported branch
  - repair the Angular install tree so manifest, lockfile, and node_modules agree
- 長期修正:
  - keep frontend dependencies on a supported Angular release line
  - gate CI on `npm audit` and lockfile integrity
  - remove dual root/frontend manifest drift
- 変更すべきファイル:
  - `src/main/webapp/angular/package.json`
  - `src/main/webapp/angular/package-lock.json`
  - possibly root `package.json` and `package-lock.json` if they remain in use
- patch sketch:

```diff
- "@angular/common": "~13.2.0",
- "@angular/compiler": "~13.2.0",
- "@angular/core": "~13.2.0",
- "ag-grid-community": "^30.2.1",
+ "@angular/common": "21.2.5",
+ "@angular/compiler": "21.2.5",
+ "@angular/core": "21.2.5",
+ "ag-grid-community": "35.1.0",
```

- 回帰テスト:
  - `npm ci`
  - `npm audit --omit=dev`
  - application smoke tests for grid, Angular sanitization-sensitive views, and download/auth flows
- rollout 上の注意点:
  - audit-recommended fixes are semver-major and likely require framework migration testing
- defer した場合の残存リスク:
  - known frontend XSS and prototype-pollution exposure remain in supported user paths

#### KIKA-SEC-010

- category: `IaC / CI-CD`
- title: `Tracked build path is not reproducible and depends on workstation-local absolute paths`
- severity / confidence / status: `low / high / informational-hygiene`
- 影響ファイルと行番号:
  - `build.xml:18,41,127,156,180,205,367`
  - `pom.xml:176,177,185,186,194,195`
  - `src/main/webapp/WEB-INF/lib/commons-io-2.4.jar`
  - `src/main/webapp/WEB-INF/lib/jasperreports-6.0.0.jar`
  - `src/main/webapp/WEB-INF/lib/jasperreports-6.11.0.jar`
  - `src/main/webapp/WEB-INF/lib/mysql-connector-java-8.0.28.jar`
- vulnerability class: `supply-chain trust / provenance weakness`
- root cause:
  - tracked Ant build definitions depend on developer workstation paths and local Eclipse/QALab plugins
  - multiple runtime jars are vendored under `WEB-INF/lib` and referenced via `systemPath`
- exploitability explanation:
  - reproducibility and artifact integrity are weak because a clean checkout alone is insufficient to prove the build input set
  - compromised local tool paths or untracked workstation jars could alter outputs without repository diff
- evidence:
  - `git ls-files` found no tracked GitHub Actions, GitLab CI, Docker, Kubernetes, or Terraform files; `build.xml` is the only tracked build/deploy-like script
  - `build.xml` hardcodes `C:/java_projects/...` and `C:\Users\BCMM040\eclipse\...`
  - `pom.xml` uses `systemPath` for vendored jars
- 実施した validation と結果:
  - tracked-file discovery: success
  - build script inspection: success
- 最小修正:
  - stop relying on workstation-specific Ant classpaths for any production build path
  - use Maven-resolved dependencies only, with build executed from a clean environment
- 長期修正:
  - introduce a checked-in, pinned CI pipeline and containerized build image
  - generate provenance and keep all dependency sources in versioned manifests
- 変更すべきファイル:
  - `build.xml`
  - `pom.xml`
  - vendored jars under `WEB-INF/lib`
- patch sketch:

```diff
- <pathelement location="C:\Users\BCMM040\eclipse\..."/>
- <pathelement location="C:/java_projects/kikan_system/src/main/webapp/WEB-INF/lib/..."/>
+ <!-- build from Maven-resolved dependencies in a clean CI image only -->
```

- 回帰テスト:
  - clean-room build from a fresh checkout with no undeclared local paths
  - compare generated SBOM against expected dependency set
- rollout 上の注意点:
  - removing `build.xml` dependencies may break legacy local workflows and should be coordinated
- defer した場合の残存リスク:
  - provenance blind spot and untracked build input risk remain

### 6. 依存関係 / SBOM セクション

- 検出 ecosystem:
  - Maven / Java
  - npm / Angular
- manifest / lockfile 一覧:
  - `pom.xml`
  - `package.json`
  - `package-lock.json`
  - `src/main/webapp/angular/package.json`
  - `src/main/webapp/angular/package-lock.json`
- risky dependency:
  - frontend runtime direct:
    - `@angular/common` installed `13.2.7`, audit range `<19.2.16`, severity `high`
    - `@angular/compiler` installed `13.2.7`, audit range `<=18.2.14`, severity `high`
    - `@angular/core` installed `13.2.7`, audit range `<=18.2.14`, severity `high`
    - `ag-grid-community` declared `^30.2.1`, audit vulnerable range `<31.3.4`, severity `high`
  - frontend build chain:
    - `webpack` critical in full audit, build-time impact
- dependency hygiene issue:
  - Angular install drift:
    - `npm ls --omit=dev --depth=0` reported missing `ag-grid-angular` and `ag-grid-community`
    - npm SBOM generation failed because of this drift
  - dual npm manifests:
    - root `package.json` differs from `src/main/webapp/angular/package.json`
    - root `package-lock.json` is effectively empty and should not be mistaken for the live frontend lockfile
  - Java dependency hygiene:
    - `pom.xml` includes old core libraries such as Jersey `2.16`, Jackson `2.9.7`, JSch `0.1.54`, OkHttp `4.4.0`, PDFBox `2.0.21`, SendGrid `4.6.3`, MSAL4J `1.7.1`
    - `pom.xml` also references `systemPath` jars, which weakens CVE and provenance coverage
    - no validated Java CVE list is claimed because a working Java vulnerability scanner report was not produced
- SBOM artifact の保存先:
  - CycloneDX JSON: `artifacts/security/sbom.cyclonedx.json`
  - CycloneDX generator also left `artifacts/security/sbom.json`
  - SPDX JSON: not generated for the full repo in this workspace
- SBOM completeness:
  - covered ecosystem:
    - Maven only, 211 components
  - version source:
    - Maven component versions came from Maven resolution, not guesswork
    - Angular versions came from `package-lock.json`, `package.json`, and `npm ls`, but no final npm SBOM artifact was generated
  - license data:
    - Maven CycloneDX BOM includes licenses for 211/211 components
  - hash / provenance:
    - Maven CycloneDX BOM includes hashes for 211/211 components
    - provenance attestation or signed build metadata was not generated
  - why full SBOM generation was incomplete:
    - no repo-wide SPDX generator was available in the workspace
    - npm SBOM failed with `ESBOMPROBLEMS` because the installed Angular tree is missing `ag-grid-angular` and `ag-grid-community`

### 7. Secrets response セクション

| secret type | redacted identifier | exposure location | likely impact | immediate response actions |
| --- | --- | --- | --- | --- |
| GCP service account private key | `private_key_id=***`, `client_email=***` | `core-system-396904-7ed053021321.json`, `src/main/resources/json/core-system-396904-7ed053021321.json` | object storage access, signing abuse, incident response burden | revoke key, issue new service account credential, review access logs, remove both files |
| SendGrid API key | `SG.k***NPBA` | `src/main/resources/config.properties:10` | outbound mail abuse, phishing, reputation damage | rotate key, review SendGrid activity, move to secret manager |
| Mail sender identity | `anac***m.mm` | `src/main/resources/config.properties:11` | assists abuse and phishing context | confirm intended sender, treat as supporting secret context |
| DB connection secret material | `user=***`, `pass=mEKf***9w==`, `key=_Bkj***wg==` | `src/main/resources/db.properties:1-4` | DB access if combined with app crypto helper, wider credential recovery | rotate DB password, replace app-level reversible storage, review DB access logs |
| SSH host/private-key path | `key=~/.k***-dev`, `host=bcm-***54.4` | `src/main/resources/config.properties:4,6,7,8` | aids remote batch access targeting | rotate key if shared, move host/key details to runtime config |
| Tomcat datasource credential | `username="SY***"`, `password="MA***"` | `src/main/webapp/META-INF/context.xml:38,39` | app DB compromise if active | verify whether active, rotate if real, remove from tracked file |

### 8. CI/CD gate 推奨

- Recommendation: `FAIL`
- Gate rationale:
  - validated `critical` findings exist: `KIKA-SEC-001`, `KIKA-SEC-002`
  - exposed secret material exists in tracked files and history
  - validated `high` findings exist on auth boundary, logging, and runtime dependencies
- Priority next actions:
  - `P0`: rotate and revoke exposed secrets, remove them from runtime and source control
  - `P0`: stop returning stored password material and block plaintext password handling migration work
  - `P0`: close or minimize pre-auth enumeration endpoints
  - `P1`: redact shared logging sinks and remove token-in-URL flow
  - `P1`: upgrade Angular runtime dependencies and repair install tree
  - `P2`: replace legacy build path and finish repo-wide SBOM/SPDX once dependency tree is healthy

### 9. Appendix

- 実行した command:
  - `mvn -q test`
  - `cmd /c "mvn -q test > artifacts\security\mvn-test.log 2>&1"`
  - `mvn dependency:list "-DincludeScope=runtime" "-DoutputFile=artifacts/security/maven-dependency-list.txt" "-DappendOutput=false"`
  - `mvn dependency:tree "-DoutputType=text" "-DoutputFile=artifacts/security/maven-dependency-tree.txt"`
  - `mvn org.cyclonedx:cyclonedx-maven-plugin:2.9.1:makeAggregateBom -DoutputFormat=json ...`
  - `npm audit --json`
  - `npm audit --omit=dev --json`
  - `npm ls --omit=dev --depth=0 --json`
  - `cmd /c "npm sbom --sbom-format cyclonedx --omit=dev > ....\artifacts\security\npm-sbom-cyclonedx.log 2>&1"`
  - `cmd /c "npm sbom --sbom-format spdx --omit=dev > ....\artifacts\security\npm-sbom-spdx.log 2>&1"`
  - `git log --oneline --all -- <secret files>`
  - multiple targeted `git grep` and `Select-String` inspections
- 作成した artifact:
  - `artifacts/security/maven-dependency-list.txt`
  - `artifacts/security/maven-dependency-tree.txt`
  - `artifacts/security/mvn-test.log`
  - `artifacts/security/npm-audit-full.json`
  - `artifacts/security/npm-audit-prod.json`
  - `artifacts/security/npm-ls-prod.json`
  - `artifacts/security/npm-sbom-cyclonedx.log`
  - `artifacts/security/npm-sbom-spdx.log`
  - `artifacts/security/sbom.cyclonedx.json`
  - `artifacts/security/sbom.json`
- 利用できなかった tool / check:
  - `syft`, `grype`, `trivy`, `gitleaks`, `semgrep`, `osv-scanner` were not installed
  - OWASP Dependency-Check did not yield a report in this workspace
  - repo-wide SPDX JSON generation was not available with the current toolset and dependency state
- この環境外で追加すべき follow-up:
  - full secret rotation, incident scope review, and history purge approval
  - repo-wide Java SCA under a supported vulnerability scanning pipeline
  - external CI/CD configuration review, IAM review, and registry provenance validation
  - dynamic authz and tenant-boundary testing against a deployed environment

## 3. Follow-Up Or Residual Risks

- No claim is made that the full repository is free of SQL injection, SSRF, file upload, or tenant-isolation flaws. This audit prioritized high-signal auth, credential, logging, download, crypto, dependency, and build-trust surfaces.
- No live secret validity, cloud IAM scope, database content, or runtime deployment mode was verified.
- Active IaC and CI definitions may exist outside the repository. Their absence from tracked files reduces IaC/CI finding density but increases blind spots.
- Java dependency vulnerability completeness remains limited until a working CVE scanner report is produced for the Maven graph and vendored jars.

## 4. Confidence

- Overall confidence: `medium-high`
- Reasoning:
  - the top findings are grounded in direct source evidence, not inference
  - secrets, plaintext password handling, response leakage, auth bypass, and logging leakage are high-confidence and reproducible from the checked-in code
  - completeness is reduced by repository size, missing scanners, missing active IaC definitions, and the inability to complete a repo-wide Java CVE scan or full npm SBOM
