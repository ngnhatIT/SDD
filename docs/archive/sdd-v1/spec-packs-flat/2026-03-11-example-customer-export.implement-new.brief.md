---
brief_version: 1
feature: "2026-03-11-example-customer-export"
task_profile: "implement-new"
governance_classification: "full-path"
feature_status: "done"
review_scope: "n/a"
spec_pack: "docs/spec-packs/2026-03-11-example-customer-export.pack.md"
backend_spec: "n/a"
bug_source: "n/a"
generator: "scripts/sdd/build_execution_brief.sh"
---

# Execution Brief

## Snapshot

- Feature: `2026-03-11-example-customer-export`
- Title: `Example customer search CSV export with audit logging`
- Task profile: `implement-new`
- Governance classification: `full-path`
- Feature status: `done`
- Governing package: `docs/specs-support/examples/2026-03-11-example-customer-export/`
- Conflict rule: the governing feature package wins over generated execution aids

## Required Inputs

- Feature: `docs/specs-support/examples/2026-03-11-example-customer-export/`
- Task Profile: `implement-new`
- Spec Pack: `docs/spec-packs/2026-03-11-example-customer-export.pack.md`
- Backend Spec: `n/a`
- Bug Source: `n/a`
- Review Scope: `n/a`

## Source Of Truth Files

- `docs/specs-support/examples/2026-03-11-example-customer-export/README.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/01-requirements.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/02-design.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/07-tasks.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/08-acceptance-criteria.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/09-test-cases.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/10-rollout.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/changelog.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/03-data-model.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/04-api-contract.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/05-behavior.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/06-edge-cases.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/11-implementation-report.md`
- `docs/specs-support/examples/2026-03-11-example-customer-export/12-review-report.md`

## Mandatory Reads

- `AGENTS.md` - root execution contract
- `docs/sdd/context/constitution.md` - non-negotiable SDD rules
- `docs/sdd/context/note.md` - repository-specific pitfalls and cautions
- `docs/sdd/context/architecture-context.md` - repository shape and module families
- `docs/sdd/context/product-context.md` - business-domain and system-change context
- `docs/sdd/context/tech-context.md` - stack and implementation constraints
- `docs/sdd/context/ai-loading-order.md` - canonical loading order
- `docs/sdd/context/task-profiles.md` - task-profile routing matrix
- `docs/sdd/governance.md` - change classification and gate rules
- `docs/specs/README.md` - feature-package rules and required files
- `docs/sdd/standards/repository-context.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/backend-process-architecture.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/frontend-screen-architecture.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/database-change-rules.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/module-patterns/csv.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/backend-change-rules.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/frontend-change-rules.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/security-validation-and-logging.md` - selected repository standard for the touched layer or workflow
- `docs/specs-support/examples/2026-03-11-example-customer-export/README.md` - feature summary, traceability, and artifact status
- `docs/specs-support/examples/2026-03-11-example-customer-export/01-requirements.md` - requirements and scope constraints
- `docs/specs-support/examples/2026-03-11-example-customer-export/02-design.md` - design intent, anchors, and locked decisions
- `docs/specs-support/examples/2026-03-11-example-customer-export/07-tasks.md` - implementation task breakdown
- `docs/specs-support/examples/2026-03-11-example-customer-export/08-acceptance-criteria.md` - acceptance conditions
- `docs/specs-support/examples/2026-03-11-example-customer-export/09-test-cases.md` - verification targets
- `docs/specs-support/examples/2026-03-11-example-customer-export/03-data-model.md` - feature-owned conditional artifact
- `docs/specs-support/examples/2026-03-11-example-customer-export/04-api-contract.md` - feature-owned conditional artifact
- `docs/specs-support/examples/2026-03-11-example-customer-export/05-behavior.md` - feature-owned conditional artifact
- `docs/specs-support/examples/2026-03-11-example-customer-export/06-edge-cases.md` - feature-owned conditional artifact
- `docs/specs-support/examples/2026-03-11-example-customer-export/contracts/` - machine-readable contract source

## Optional Consult

- `docs/spec-packs/2026-03-11-example-customer-export.pack.md` - generated execution aid; feature package still wins on conflicts
- `docs/specs-support/examples/2026-03-11-example-customer-export/11-implementation-report.md` - implementation evidence when delivered behavior matters
- `docs/specs-support/examples/2026-03-11-example-customer-export/12-review-report.md` - existing review verdict and findings

## Locked Decisions

- `DES-01` Add a dedicated export action to the existing customer search screen instead of creating a separate export screen.
- `DES-02` Reuse the existing customer search criteria builder so on-screen search and export use the same filter, sort, and visibility logic.
- `DES-03` Run a count query before file generation and block requests above `10,000` rows.
- `DES-04` Keep export synchronous for this feature because the limit is bounded and the output is generated from a single request.
- `DES-05` Persist an audit row for both `SUCCESS` and `FAILED` outcomes in a dedicated audit table.
- `DES-06` Use the shared CSV module family for file creation and define one explicit export column order for the screen.
- Source-base anchors are locked to the files named below:
- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/tmt220funcget/process/Tmt220FuncGetProcess.java`; `src/main/java/jp/co/brycen/kikancen/tsm030search/process/Tsm030SearchProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/spcm00011searchStore/webservice/Spcm00011SearchStoreWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/tmt220funcget/process/Tmt220FuncGetProcess.java`; `src/main/java/jp/co/brycen/kikancen/tsm030search/process/Tsm030SearchProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/spcm00021/spcm00021.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/spcm00021/spcm00021.component.html`
- Dominant module/style note: Reuse the current JAX-RS webservice plus process split, `StringBuilder` SQL assembly style, and Angular screen-family layout patterns from the chosen anchor files instead of inventing a new export-specific structure.
- New tables/source families/screen structure in scope: `yes` for one additive audit table; `no` for new backend source families and `no` for new screen structure.

## Prohibited Scope

- Async export jobs
- Scheduled exports
- Email delivery of exported files
- Changes to customer master data
- Search result pagination behavior does not change.
- Customer master data is not updated.
- No asynchronous job or notification flow is introduced.

## Constraints

- Read before write: inspect the named anchors, sibling flows, existing tests, and owned contracts before editing.
- Reuse before create: extend the current module family before introducing new routes, DTOs, classes, modules, or tables.
- Conflict reporting: record spec, code, test, schema, and standard conflicts instead of silently guessing through them.
- Locked contracts remain unchanged unless the governing feature package explicitly authorizes the change.
- Unknown source detail must stay `unknown (...)` or blocked; do not infer hidden requirements from the prompt.

## Touched Layers And Components

- Backend process: `src/main/java/jp/co/brycen/kikancen/tmt220funcget/process/Tmt220FuncGetProcess.java`; `src/main/java/jp/co/brycen/kikancen/tsm030search/process/Tsm030SearchProcess.java`
- Backend webservice: `src/main/java/jp/co/brycen/kikancen/spcm00011searchStore/webservice/Spcm00011SearchStoreWebService.java`
- SQL: `src/main/java/jp/co/brycen/kikancen/tmt220funcget/process/Tmt220FuncGetProcess.java`; `src/main/java/jp/co/brycen/kikancen/tsm030search/process/Tsm030SearchProcess.java`
- Frontend .ts: `src/main/webapp/angular/src/app/components/spcm00021/spcm00021.component.ts`
- Frontend .html: `src/main/webapp/angular/src/app/components/spcm00021/spcm00021.component.html`
- Contracts: `docs/specs-support/examples/2026-03-11-example-customer-export/contracts/`

## Locked Contracts

- `docs/specs-support/examples/2026-03-11-example-customer-export/contracts/`
- `docs/specs-support/examples/2026-03-11-example-customer-export/03-data-model.md` remains the locked durable-data source when schema ownership is prose-only.

## Task Scope

- Add a CSV export action to the customer search screen.
- Reuse the active screen filters and sort order for export.
- Enforce the same authorization and company isolation rules as on-screen search.
- Block exports above the configured row limit.
- Write an audit row for successful and failed export attempts.

## Done Criteria

- `sh scripts/sdd/validate_specs.sh 2026-03-11-example-customer-export`
- `sh scripts/sdd/build_spec_pack.sh 2026-03-11-example-customer-export`
- Satisfy verification evidence for: `TC-01, TC-02, TC-03, TC-04, TC-05, TC-06, TC-07`
- Apply `docs/sdd/checklists/04-pre-implementation-gate.md` before implementation starts
- Update `11-implementation-report.md` with approved artifacts used, inspected code refs, reuse decisions, conflicts, and tests.
- Update `12-review-report.md` with observed facts, grounded risks, unsupported assumptions, and confirmed hallucination findings.
- Apply `docs/sdd/governance/definition-of-done.md` before marking the feature done
- Apply `docs/sdd/governance/06-release-readiness-rules.md` when the change is marked release-ready or merged for shipment

## Expected Outputs

- Deliver implementation and verification aligned to the governing `REQ -> DES -> TASK -> AC -> TC` chain.
- Keep `04-api-contract.md` and `contracts/` aligned if interface or durable data shape changes.
- Rebuild the generated spec-pack if the feature keeps `spec-pack.manifest.yaml`.
- Update `10-rollout.md` and `changelog.md` when behavior or release guidance changes.
- Record delivered implementation in `11-implementation-report.md` once implementation starts.
- Record review findings and verdict in `12-review-report.md` when formal review starts.

## Assumptions And Current Limits

- This brief is generated from canonical markdown and fixed task-profile mappings; it is an execution aid, not an approval artifact.
- Classification is inferred from owned feature files: `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, and `06-edge-cases.md` imply `full-path`; otherwise the generator emits `reduced-path`.
- The generator does not infer intent from free-form prompts. Request-scoped inputs such as `--bug-source`, `--backend-spec`, `--review-scope`, and `--spec-pack` must be provided explicitly when needed.
- Missing scope, decision, or helper inputs are emitted as `unknown (...)` rather than guessed.

## Open Questions

- None. This package is intentionally complete as a reference example.
