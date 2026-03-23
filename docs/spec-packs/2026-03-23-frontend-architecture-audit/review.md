# Review: 2026-03-23-frontend-architecture-audit

- Status: complete
- Last Updated: 2026-03-23
- Originating Spec: `docs/spec-packs/2026-03-23-frontend-architecture-audit/spec_pack.md`

## 1. Scope Reviewed

- feature pack or scoped target: `docs/spec-packs/2026-03-23-frontend-architecture-audit/spec_pack.md`
- diff, file set, or code path reviewed: active Angular frontend under `src/main/webapp/angular`; no frontend diff was present in the inspected local git delta, so the review was grounded on current code paths and directly impacted shared modules
- standards or rules applied: `AGENTS.md`, `docs/execution/ai-loading-order.md`, `docs/execution/task-routing.md`, `docs/governance/core-rules.md`, `docs/governance/minimal-context.md`, `docs/execution/task-contracts.md`, `docs/standards/testing-rules.md`

## 2. Files Inspected

- `src/main/webapp/angular/src/app/shared/components/header/header.component.html`
- `src/main/webapp/angular/src/app/shared/components/header/header.component.ts`
- `src/main/webapp/angular/src/app/components/spcm00021/spcm00021.component.ts`
- `src/main/webapp/angular/src/app/components/csvimport/csvimport.component.ts`
- `src/main/webapp/angular/angular.json`
- `src/main/webapp/angular/src/app/**/*.spec.ts` sample sweep

## 3. Findings

- [Blocker] Common CSV import screen validates and displays reflect date but drops it from the final import request. `spcm00021.component.ts` restores and validates `Const.REFLECT_DATE`, and the route map reuses this screen for `SPMT00331` and `SPMT00341`, but `uploadFunc()` sends `optionData` without `REFLECTDATE`. The shared `csvimport.component.ts` path includes that field both in modal handoff and final request, so the common-screen path diverges from the established import contract and can import data under the wrong effective date.
- [Major] Logout leaves `LoginInfoService` state intact while route-level login enforcement is disabled. `header.component.ts` clears store services and navigates to `/Login`, but never calls `loginInfo.clear()`. `BaseComponent.ngOnInit()` has the login check commented out, and `fnSetFormItemNm()` still repopulates header/app state from `LoginInfoService` on screen init. With `useHash` routing and no guard, back/forward or deep-link re-entry can rebuild post-login UI from stale singleton state until some later request fails.
- [Major] Mobile header renders company info twice and never renders store info. In `header.component.html`, the third mobile subheader block repeats `titlecmpnynm` and `cmpnynm` instead of using `titlestorenm` and `storenm`, while the desktop header uses the correct store binding. This creates a persistent mobile-only UI mismatch in the shared shell.
- [Major] Jasmine/Karma test execution is currently broken and source coverage is effectively absent. `angular.json` points the test target to `src/test.ts`, but the file is missing and `npm test -- --watch=false --browsers=ChromeHeadless` fails with `ENOENT` on that path. Under `src/app`, only `services/common/sidebar.service.spec.ts` exists and it covers service creation only, leaving shared routing, logout state, CSV import flow, and shell rendering without executable regression coverage.

## 4. Assumptions Or Uncertainties

- Confirm whether `SPMT00331` and `SPMT00341` imports are contractually required to submit `REFLECTDATE` on the same API field used by the shared CSV import screen. Current UI and shared implementation strongly suggest yes, but the backend request contract should be confirmed before changing it.
- Confirm whether post-logout back-button access is expected to be blocked at router-entry time or only after the next API error. Current shared-base behavior suggests the intended router gate may have been disabled rather than deliberately removed.
- Confirm whether mobile header store display is required for every screen or may be hidden on some routes via `hideStoreInfo`. The duplicated company block is still incorrect for routes where store info should be shown.

## 5. Residual Risks

- No frontend diff was available to scope this as a change-only review, so there may be additional impacted screens that share the same singleton-state or CSV-wrapper assumptions.
- Portal (`SPCM00401`) still appears to rely on `console.log(response)` after `fatalError` on announcement/calendar loads, which is a weaker operational signal than the modal/inline error patterns used elsewhere.

## 6. Confidence

- high
- the findings are grounded in shared shell templates, router wiring, singleton services, the common CSV import flow, and an executed failing test command
