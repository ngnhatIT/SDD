# Audit: 2026-03-23-frontend-architecture-audit

- Status: complete
- Last Updated: 2026-03-23
- Originating Spec: `docs/spec-packs/2026-03-23-frontend-architecture-audit/spec_pack.md`
- Code Modified: no

## 1. Scope And Basis

- target scope: active frontend under `src/main/webapp/angular`
- active rules or standards applied: `AGENTS.md`, `docs/execution/ai-loading-order.md`, `docs/execution/task-routing.md`, `docs/governance/core-rules.md`, `docs/governance/minimal-context.md`
- inspected evidence: Angular entrypoint and build config, root module and router, shared services, representative screens (`SPCM00101`, `SPCM00401`, `SPOR00201AC`), UI templates, test config, and logging patterns

## 2. Grounded Report

- framework: Angular 13 browser application bootstrapped from `src/main.ts` into `WmsModule`
- routing: Angular Router with hash-based navigation and many screen-ID routes defined in `wms-routing.module.ts`
- rendering: client-side rendering only; no SSR or Angular Universal evidence found
- state management: custom singleton services with `Subject`-based event buses (`AppService`, `SidebarService`, `SearchConditionService`) and small in-memory stores (`DataService`)
- server-state and API access: custom `WebService` wrapper built on jQuery `$.ajax`; some newer code wraps it into `Observable`, but no Angular `HttpClient`, NgRx data layer, or query library evidence was found
- forms: template-driven forms with `[(ngModel)]` plus custom validation and modal notification logic in `BaseComponent`
- UI system: Bootstrap and ng-bootstrap plus internal shared components are primary; FullCalendar, ag-grid, Perfect Scrollbar, and a few other libraries appear in specific screens
- tests: Jasmine and Karma are configured, but source test coverage is extremely sparse and the configured `src/test.ts` bootstrap file is missing
- analytics and logging: no runtime analytics SDK evidence found; logging is mostly `console.*` plus user-facing modal/error helpers
- business context: authenticated warehouse/business-management SPA with login, portal, authorized sidebar navigation, and screens spanning products, ordering, purchase/returns, inventory, payment, CSV workflows, and access-log inquiry

## 3. Compliance Status

- `partial`
- architecture findings are grounded, but test coverage and some contract confirmations remain incomplete

## 4. Follow-Up Or Residual Risks

- verify whether Angular Material, `ng-select`, and multiselect imports are dormant legacy or used through screens not sampled in depth
- confirm whether the missing `src/test.ts` is an accidental break or the test command is effectively abandoned
- shared base components and request wrappers remain high-impact review zones because many screens depend on them

## 5. Confidence

- high
- the entrypoint, module, routing, templates, and service layer all align on one active Angular SPA with custom shared infrastructure
