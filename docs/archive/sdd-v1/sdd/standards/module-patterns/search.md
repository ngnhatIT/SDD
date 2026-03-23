# Search Module Patterns

## When To Use

Use this file when changing a search screen, search endpoint, count endpoint, or related DTO family.

## How To Use

Match the surrounding search/count split and keep row and count behavior aligned.

## Required Output

- search and count impact documented in `02-design.md`
- verification that list and count behavior stay consistent

## Gate

Do not collapse count logic into the list path unless the touched module family already does so.

## Rules

- search features often split list and count behavior into separate processes and endpoints
- when the module family already uses `SearchCnt` then `Search`, preserve that two-step flow instead of collapsing it into one request
- backend search families often centralize SQL assembly in a shared `SearchAll...Process` base that both list and count actions reuse
- when the backend search family already validates request inputs in `beforeProcessing(...)`, keep required, date, length, and master-code guards there instead of shifting them into ad-hoc screen-only checks
- result row DTOs usually live in the base screen package
- frontend table screens often depend on both row data and count data
- frontend search screens commonly validate current inputs, snapshot search conditions into DTO or local state, then call the count endpoint before loading the list
- when sibling screens already use `SearchConditionManagementService`, load required init data first and then hydrate or save search conditions through that service
- when focus-out validation already populated field-level errors, block the search action until those messages are cleared through the approved validation path
- when a screen depends on init data such as dropdowns or store lists, load that init data before hydrating saved search conditions
- legacy search screens in this repository often keep search conditions and search results in separate `card wms-card` blocks
- result headers in those screens often place the record count on the left and `wms-page` on the right
- zero-result count paths usually clear table and pager state and route through the standard no-data info message flow
- when zero-result paths also maintain result header flags or body caches, clear those flags and caches with the table and pager state instead of leaving stale result UI visible
