# Known Inconsistencies

## When To Use

Use this file when the touched area already contains conflicting legacy patterns.

## How To Use

Treat these inconsistencies as constraints. Follow the dominant local pattern unless the feature package explicitly addresses the inconsistency.

## Required Output

- ambiguity or inconsistency called out in the feature package when it materially affects implementation or review

## Gate

Do not silently normalize unrelated legacy inconsistencies during an unrelated feature.

## Known Cases

- naming and package casing are not fully consistent across the repository
- Angular routing contains duplicate path entries in at least one place
- validation helpers exist in overlapping Java and TypeScript forms
- generated output trees and bundled libs are part of the current repo shape
- older guidance sometimes over-enforced affected-row checks on normal `executeUpdate()` calls
- JAX-RS root path style is not fully consistent; both `@Path("kikancen")` and `@Path("/kikancen")` exist, so preserve the touched local family style unless normalization is explicitly in scope
- incremental SQL parameter indexing is not fully consistent; both `int index = ConstantValue.INDEX/INDEX_1` and `AtomicInteger` styles exist. Preserve untouched legacy files during unrelated work, but treat `AtomicInteger` as the preferred style for new or touched mutable counter flows because active search, delete, and API batch families already use it
- backend DTO style is not fully consistent; bean-style getters and setters are common, and some helper DTOs or response holders use different shapes, so mirror the touched family instead of inventing a global DTO style
- `TMT050` name lookup style is not fully consistent; both `VMT050_ALL` and direct `TMT050_NAME` joins exist in live modules, so preserve the touched family style unless the governing feature package explicitly normalizes that family
- audit timestamp SQL is not fully consistent; both `SYSDATE(6)` and `NOW()` exist in live code, so preserve the touched family and record anchor evidence before changing timestamp-function style
- backend error handling mixes shared exception routing and direct `printStackTrace()` calls in older helpers; do not treat stack-trace printing as a valid pattern to spread into new code
- shared frontend transport intentionally uses jQuery `$.ajax`; do not treat that as permission to add new transport paths during unrelated work
- frontend transport handling mixes guarded response paths and empty `.catch(...)` blocks; keep unrelated work scoped, but do not use empty catches as a precedent for new user-visible flows
- frontend focus-out handling is not fully consistent; both `BaseComponent.fnFocusOutCommon(...)` and direct screen-local `fnGetName(...)` wrappers exist, so treat the base-common path as preferred current and the wrapper style as tolerated legacy bridge only
- frontend table setup is not fully consistent; both config-driven `fnGetColumnTableConfig()` plus `generateColumns(...)` and manual column-object assembly exist, so preserve untouched legacy screens but treat the config-driven path as preferred current where sibling anchors already support it
- frontend validation routing is not fully consistent; newer screens commonly use `validateFields(...)` with inline `.inputError`, while older screens may still raise broader popups, so do not let popup-heavy legacy code justify new field-validation regressions
- saved search-condition handling is not fully universal; `SearchConditionManagementService` appears in many but not all screen families, so reuse it where the family already owns it and document grounded exceptions where it does not
- frontend form layout is not fully consistent; newer screens use multi-breakpoint Bootstrap grids and wrap-aware groups, while older screens still rely on more desktop-heavy `col-md-*` splits, so treat the responsive multi-breakpoint layout as preferred current where sibling anchors already support it
- comment language and comment density vary by family; untouched mixed-language comments are tolerated legacy, but new or rewritten comments in touched scope must be English and minimal
- stray `console.log(...)` calls, unused legacy imports such as `import { event } from 'jquery'`, and commented-out placeholder blocks exist in some screens or shared inputs; do not copy those defects into new code and remove them from touched scope when safe
- screen and action naming has live case or spelling drift such as `init` versus `Init`, `Webservice` versus `WebService`, and `serach` versus `search`; preserve existing identifiers in place but do not use those defects as anchors for new artifacts
- shared frontend registries such as `common/SubWindow.ts` intentionally import screen components; that exception does not justify component imports inside general-purpose services
