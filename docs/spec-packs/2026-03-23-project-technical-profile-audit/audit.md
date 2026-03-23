# Audit: 2026-03-23-project-technical-profile-audit

- Status: complete
- Last Updated: 2026-03-23

## 1. Scope And Basis

- target scope: repository-level technical profile across Java backend, Angular frontend, deployment wiring, tests, and tooling
- active rules or standards applied: `AGENTS.md`, `docs/execution/ai-loading-order.md`, `docs/execution/task-routing.md`, `docs/governance/core-rules.md`, `docs/governance/minimal-context.md`
- inspected evidence: `pom.xml`, `build.xml`, `src/main/webapp/WEB-INF/web.xml`, `src/main/java/jp/co/brycen/common/config/ApplicationConfig.java`, `src/main/java/jp/co/brycen/common/webservice/AbstractAPIWebService.java`, representative backend feature packages, Angular entrypoint/module/router/shared services, representative Angular screens, frontend test config, backend test sources, and checked-in `target` output

## 2. Grounded Report

- deployable shape: a single repository and single deployable WAR-based business system with both Java backend and Angular SPA frontend, not a package-based monorepo
- backend runtime: Jersey 2.x servlet-based API stack hosted in the WAR, with `web.xml` mapping `/webapi/*` and `ApplicationConfig` registering shared filters and exception handling
- backend module structure: screen or use-case oriented packages under `jp.co.brycen.kikancen`, commonly split into `dto`, `process`, and `webservice` subpackages rather than a modern controller-service-repository package layout
- backend data access: custom `DBAccessor` and `DBPoolManager` infrastructure on top of HikariCP, with handwritten SQL inside process classes; no ORM or repository abstraction evidence was found
- frontend runtime: Angular 13 browser SPA under `src/main/webapp/angular`, bootstrapped via `platformBrowserDynamic().bootstrapModule(WmsModule)`
- rendering: client-side rendering only; no Angular Universal, SSR, hydration, or prerender evidence was found
- routing: Angular Router with `useHash: true`, one very large eager route table, wildcard-to-login fallback, and no route-guard or lazy-loading evidence
- state: custom singleton services and `Subject`-based event channels are the primary shared-state mechanism; `@ngrx/store` is installed but no active runtime usage was confirmed
- server state: frontend API traffic goes through a custom jQuery `$.ajax` wrapper (`WebService`) with global wait-overlay and common error routing, not Angular `HttpClient`
- forms: template-driven binding and custom validation in shared base classes and shared input components are primary; `ReactiveFormsModule` is imported but not proven as the main pattern
- UI layer: Bootstrap and ng-bootstrap plus a large internal shared component layer are primary; ag-grid and FullCalendar are active secondary widgets in specific screens
- testing: Java has a small focused JUnit 4 plus JerseyTest surface for API import modules; Angular Jasmine/Karma config exists but the configured `src/test.ts` bootstrap file is missing, so the frontend test entry is currently broken
- observability: backend uses log4j2 console and rolling-file logging; frontend relies on modal notifications, wait overlays, and some `console.*` or `alert` usage, with no app analytics SDK confirmed
- business signal: the system is a warehouse or retail operations management application with login, company and store context, product and master maintenance, ordering, purchase and returns, payment workflows, inventory, CSV import or export, and WEB-EDI related flows

## 3. Follow-Up Or Residual Risks

- confirm final packaging and deployment behavior around Angular `baseHref` `/kikancen/home.html` versus servlet 404 fallback to `/index.html`
- confirm whether Angular Material, `ng-select`, and multiselect packages are active in unsampled screens or are mostly dormant imports
- verify whether frontend test bootstrap breakage is accidental or whether Angular tests are effectively abandoned
- shared base classes, singleton services, request wrappers, and reusable table or input components remain the highest blast-radius review zones

## 4. Confidence

- high
- bootstrap files, deployment config, shared services, representative backend modules, representative Angular screens, and checked-in build output all align on one hybrid WAR monolith with a legacy-heavy custom application stack
