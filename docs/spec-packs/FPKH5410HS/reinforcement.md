# Reinforcement: FPKH5410HS

- Status: constrained hybrid implementation
- Last Updated: 2026-03-24
- Originating Pack: `docs/spec-packs/FPKH5410HS/spec_pack.md`

## 1. Grounded Sources

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-contracts.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/structure.md`
- `docs/standards/api-rules.md`
- `docs/standards/db-rules.md`
- `docs/standards/testing-rules.md`
- `docs/standards/schema_database.yaml`
- `docs/spec-packs/FPKH5410HS/spec_pack.md`
- `docs/archive/sdd-v1/decisions/ADR-0002-source-base-anchor-and-style-parity-enforcement.md`
- `docs/archive/sdd-v1/sdd/standards/frontend-screen-architecture.md`
- `docs/archive/sdd-v1/sdd/standards/frontend-change-rules.md`
- `docs/archive/sdd-v1/sdd/standards/repository-context.md`
- code patterns inspected:
  - `src/main/java/jp/co/brycen/kikancen/common/focusout/`
  - `src/main/java/jp/co/brycen/kikancen/common/initdropdown/`
  - `src/main/java/jp/co/brycen/kikancen/spmt10101*/`
  - `src/main/java/jp/co/brycen/kikancen/spmt01201init/`
  - `src/main/java/jp/co/brycen/kikancen/spvw00151*/`
  - `src/main/java/jp/co/brycen/kikancen/tmt050allkbnsearch/`
  - `src/main/webapp/angular/src/app/components/spmt10101/`
  - `src/main/webapp/angular/src/app/components/spvw00151/`
  - `src/main/webapp/angular/src/app/components/common/base/base.component.ts`
  - `src/main/webapp/angular/src/app/components/spbs00061/`

## 2. Consistency Checks

- the pack names all target services for this feature as `(de xuat)` rather than as established repo contracts
- the pack points to `document_init/FPKH5410HS/spkh5410hs.md`, but that source file is not present in the current repository
- repository search found no existing `spkh5410hs` implementation surface under `src/main/java` or `src/main/webapp/angular` before this task
- schema authority search found no `tmt104`, `tmt105`, `tmt106`, `tmt107`, `tmt108`, or `tmt140` entries in `docs/standards/schema_database.yaml`
- the pack itself still marks unresolved blockers for DB mapping, target ownership, delete scope, and validation completeness in OI-01, OI-02, OI-03, OI-04, and OI-09
- exact legacy screen source was not found in `docs/archive/sdd-v1/`, so archive docs only grounded style parity, not screen-specific API or DB behavior
- schema authority search still found no `tmt104`, `tmt105`, `tmt106`, `tmt107`, `tmt108`, `tmt140`, or `tmt100_customer` entries in `docs/standards/schema_database.yaml`
- user explicitly directed a function-first continuation; implementation therefore expanded only into grounded read-only/backend-helper slices and did not cross into save/update/delete persistence
- the requested validator now runs, but strict validation still fails on the non-canonical governed folder name `FPKH5410HS`

## 3. Rules And Constraints

- do not invent API request fields, response fields, DTO keys, or error keys while the pack still labels the APIs as proposed only
- do not invent tables, columns, soft-delete scope, or audit behavior; `docs/standards/schema_database.yaml` remains the schema authority
- do not infer missing behavior from the absent `document_init/FPKH5410HS/spkh5410hs.md`
- align the screen to the existing Angular family shape when that can be done without inventing API or DB contracts
- only add backend slices already grounded by repo family patterns:
  - screen-specific init wrapper that delegates to `InitDropDownSearchProcess`
  - frontend usage of existing common `FocusOutGetName` for `TMT026_PRODUCT`
- keep save, update, delete, detail display, dialog search, and customer lookup out of scope until the pack and schema authority ground them

## 4. Allowed Work Slice

- normalize governed artifacts inside `docs/spec-packs/FPKH5410HS/`
- record blocker evidence, verification attempts, and residual risks in task artifacts
- add an Angular-only scaffold for `SPKH5410HS`:
  - screen id registration
  - route registration
  - module declaration
  - component/template aligned to the existing screen family with `BaseComponent` and `DisplayScreenID`
  - `formItemNm` fallback labels when TMT340-driven labels are not yet grounded for the new screen
  - local-only dialog scaffolding, sample rows, enable/disable behavior, and copy/clear/confirm/delete triggers
- add a read-only backend init wrapper `Spkh5410hsInit` using the existing `webservice -> process -> dto` family and `InitDropDownSearchProcess`
- wire product-code additions in `SPKH5410HS` to existing common `FocusOutGetName` / `TMT026_PRODUCT` master lookup
- reuse existing Angular screen layout patterns where possible without adding new backend contracts
- do not add SQL, schema changes, or persisted save/search/delete/detail flows

## 5. Stop Conditions

- stop if the next step requires a concrete mapping for OI-01, OI-02, OI-03, OI-04, or OI-09
- stop if a save, update, or delete flow would require tables or columns not present in `docs/standards/schema_database.yaml`
- stop if a new API surface would be created beyond the grounded init-wrapper family or existing common helper services
- stop if implementation would depend on the missing `document_init/FPKH5410HS/spkh5410hs.md` source file
