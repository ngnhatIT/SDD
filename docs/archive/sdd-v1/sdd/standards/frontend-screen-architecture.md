# Frontend Screen Architecture

## When To Use

Use this file during frontend design and screen implementation.

## How To Use

Match the existing component, route, and shared-service structure of the touched screen family.

## Required Output

- changed components, services, routes, and shared state recorded in `02-design.md`
- user-facing behavior documented in `05-behavior.md`

## Gate

Do not introduce a new frontend structure or state pattern without updating the design and, if needed, an ADR.

## Repeated Frontend Shape

- one large Angular module declares most components
- one large routing module maps screen codes directly to components
- screen components commonly extend `BaseComponent`
- shared UI pieces live under `components/common`
- screen code typically identifies itself with `DisplayScreenID` and sends `accessInfo` from `LoginInfoService`
- search and tabular screens commonly reuse `<app-table>`, `<wms-page>`, `formItemNm[...]`, and shared modal helpers such as `SubWindow`

## Structural Pattern Classification

- preferred current pattern: a screen stays under `components/<screen-code>/`, extends `BaseComponent`, reuses shared transport and modal flows, and adds screen-owned `.dto.ts` or `services/<screen-code>/` only when sibling anchors already use that split
- tolerated legacy pattern: older screens may keep more logic inline in the component or may miss one of the shared helper paths while untouched
- required migration pattern: touched screens whose sibling anchors already rely on `BaseComponent`, `SearchConditionManagementService`, `generateColumns(...)`, `fnGetColumnTableConfig()`, or `SubWindow` for the same concern

## Dependency Direction

- feature components may depend on shared services, constants, and modal or routing registries
- services under `src/main/webapp/angular/src/app/services` should stay component-agnostic
- shared files may import feature components only when they are acting as explicit registries or coordinators, such as routing modules or `common/SubWindow.ts`
- transport stays on `services/common/webservice.service.ts`, which currently wraps jQuery `$.ajax`; do not bypass it with `HttpClient`, `fetch`, or component-local `$.ajax`

## Repeated Behavior Pattern

- a screen identifies itself with `DisplayScreenID`
- requests usually include access info based on the display screen id
- transport goes through shared web service wrappers
- shared singleton services hold cross-screen state
- when backend validation drives field-level UI messages, keep response keys and `fatalError.controlID` values aligned with the component's existing error-binding logic
- large stateful screen components are normal in this repo; do not introduce ad-hoc store, hook, view-model, or facade layers for one screen unless the approved design makes that structural change explicit
- newer screen layouts already use breakpoint-aware Bootstrap grids and wrap-aware control groups for smaller windows; touched frontend forms should reuse that responsive structure when sibling anchors support it
