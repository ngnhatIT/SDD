---
brief_version: 1
feature: "example-feature"
task_profile: "implement-new"
governance_classification: "full-path"
feature_status: "ready-for-implementation"
review_scope: "n/a"
spec_pack: "docs/spec-packs/example-feature.pack.md"
backend_spec: "n/a"
bug_source: "n/a"
generator: "scripts/sdd/build_execution_brief.sh"
---

# Execution Brief

## Snapshot

- Feature: `example-feature`
- Title: `SPPM00061 expired-file filter with search and export parity`
- Task profile: `implement-new`
- Governance classification: `full-path`
- Feature status: `ready-for-implementation`
- Governing package: `docs/specs-support/examples/example-feature/`
- Conflict rule: the governing feature package wins over generated execution aids

## Required Inputs

- Feature: `docs/specs-support/examples/example-feature/`
- Task Profile: `implement-new`
- Spec Pack: `docs/spec-packs/example-feature.pack.md`
- Backend Spec: `n/a`
- Bug Source: `n/a`
- Review Scope: `n/a`

## Source Of Truth Files

- `docs/specs-support/examples/example-feature/README.md`
- `docs/specs-support/examples/example-feature/01-requirements.md`
- `docs/specs-support/examples/example-feature/02-design.md`
- `docs/specs-support/examples/example-feature/07-tasks.md`
- `docs/specs-support/examples/example-feature/08-acceptance-criteria.md`
- `docs/specs-support/examples/example-feature/09-test-cases.md`
- `docs/specs-support/examples/example-feature/10-rollout.md`
- `docs/specs-support/examples/example-feature/changelog.md`
- `docs/specs-support/examples/example-feature/03-data-model.md`
- `docs/specs-support/examples/example-feature/04-api-contract.md`
- `docs/specs-support/examples/example-feature/05-behavior.md`
- `docs/specs-support/examples/example-feature/06-edge-cases.md`
- `docs/specs-support/examples/example-feature/13-risk-log.md`
- `docs/specs-support/examples/example-feature/14-decision-notes.md`

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
- `docs/sdd/standards/module-patterns/search.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/module-patterns/csv.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/security-validation-and-logging.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/backend-change-rules.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/frontend-change-rules.md` - selected repository standard for the touched layer or workflow
- `docs/specs-support/examples/example-feature/README.md` - feature summary, traceability, and artifact status
- `docs/specs-support/examples/example-feature/01-requirements.md` - requirements and scope constraints
- `docs/specs-support/examples/example-feature/02-design.md` - design intent, anchors, and locked decisions
- `docs/specs-support/examples/example-feature/07-tasks.md` - implementation task breakdown
- `docs/specs-support/examples/example-feature/08-acceptance-criteria.md` - acceptance conditions
- `docs/specs-support/examples/example-feature/09-test-cases.md` - verification targets
- `docs/specs-support/examples/example-feature/03-data-model.md` - feature-owned conditional artifact
- `docs/specs-support/examples/example-feature/04-api-contract.md` - feature-owned conditional artifact
- `docs/specs-support/examples/example-feature/05-behavior.md` - feature-owned conditional artifact
- `docs/specs-support/examples/example-feature/06-edge-cases.md` - feature-owned conditional artifact
- `docs/specs-support/examples/example-feature/13-risk-log.md` - feature-owned SDD2+ companion artifact
- `docs/specs-support/examples/example-feature/14-decision-notes.md` - feature-owned SDD2+ companion artifact
- `docs/specs-support/examples/example-feature/contracts/` - machine-readable contract source

## Optional Consult

- `docs/spec-packs/example-feature.pack.md` - generated execution aid; feature package still wins on conflicts

## Locked Decisions

- `DES-01` Add `expiredOnly` to the existing search workflow instead of creating a new expired-file endpoint.
- `DES-02` Apply the same expired-only predicate to count, list, and CSV export sibling flows.
- `DES-03` Treat omitted `expiredOnly` as `false` for backward compatibility with existing callers and saved conditions.
- `DES-04` Keep the example feature documentation, contracts, and generated spec-pack aligned as one governed set.
- Source-base anchors are locked to the files named below:
- Backend process anchor files: `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchAllRecProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061CSVExportProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061SearchWebService.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061SearchRecCntWebService.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061CSVExportWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchAllRecProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.ts`
- Frontend .html anchor files: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.html`
- Dominant module/style note: Reuse the current search-family split for count, list, and export; preserve `StringBuilder` SQL assembly style; reuse the existing screen component and shared CSV export flow instead of creating a new export-specific path.
- New tables/source families/screen structure in scope: `no`

## Prohibited Scope

- new tables or durable audit records
- changes to attachment delete or download flows
- asynchronous export or background jobs
- permission model changes
- No new table or audit row
- No change to attachment delete, save, or download flows
- No asynchronous export path

## Constraints

- Read before write: inspect the named anchors, sibling flows, existing tests, and owned contracts before editing.
- Reuse before create: extend the current module family before introducing new routes, DTOs, classes, modules, or tables.
- Conflict reporting: record spec, code, test, schema, and standard conflicts instead of silently guessing through them.
- Locked contracts remain unchanged unless the governing feature package explicitly authorizes the change.
- Unknown source detail must stay `unknown (...)` or blocked; do not infer hidden requirements from the prompt.

## Touched Layers And Components

- Backend process: `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchAllRecProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061CSVExportProcess.java`
- Backend webservice: `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061SearchWebService.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061SearchRecCntWebService.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/webservice/Sppm00061CSVExportWebService.java`
- SQL: `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchRecCntProcess.java`; `src/main/java/jp/co/brycen/kikancen/sppm00061search/process/Sppm00061SearchAllRecProcess.java`
- Frontend .ts: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.ts`
- Frontend .html: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.html`
- Contracts: `docs/specs-support/examples/example-feature/contracts/`

## Locked Contracts

- `docs/specs-support/examples/example-feature/contracts/`
- `docs/specs-support/examples/example-feature/03-data-model.md` remains the locked durable-data source when schema ownership is prose-only.

## Task Scope

- add an `expiredOnly` filter to the `SPPM00061` search screen
- apply the same filter to search count, search list, and CSV export paths
- preserve saved-condition restore behavior for the new filter
- document the request-contract change and screen behavior

## Done Criteria

- `sh scripts/sdd/validate_specs.sh example-feature`
- `sh scripts/sdd/build_spec_pack.sh example-feature`
- Satisfy verification evidence for: `TC-01, TC-02, TC-03, TC-04`
- Apply `docs/sdd/checklists/04-pre-implementation-gate.md` before implementation starts
- Update `11-implementation-report.md` with approved artifacts used, inspected code refs, reuse decisions, conflicts, and tests.
- Apply `docs/sdd/governance/definition-of-done.md` before marking the feature done
- Apply `docs/sdd/governance/06-release-readiness-rules.md` when the change is marked release-ready or merged for shipment

## Expected Outputs

- Deliver implementation and verification aligned to the governing `REQ -> DES -> TASK -> AC -> TC` chain.
- Keep `04-api-contract.md` and `contracts/` aligned if interface or durable data shape changes.
- Rebuild the generated spec-pack if the feature keeps `spec-pack.manifest.yaml`.
- Update `10-rollout.md` and `changelog.md` when behavior or release guidance changes.
- Record delivered implementation in `11-implementation-report.md` once implementation starts.
- Keep `13-risk-log.md` aligned with current mitigations, open risks, and release blockers.
- Keep `14-decision-notes.md` aligned with local feature decisions and ADR links.

## Assumptions And Current Limits

- This brief is generated from canonical markdown and fixed task-profile mappings; it is an execution aid, not an approval artifact.
- Classification is inferred from owned feature files: `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, and `06-edge-cases.md` imply `full-path`; otherwise the generator emits `reduced-path`.
- The generator does not infer intent from free-form prompts. Request-scoped inputs such as `--bug-source`, `--backend-spec`, `--review-scope`, and `--spec-pack` must be provided explicitly when needed.
- Missing scope, decision, or helper inputs are emitted as `unknown (...)` rather than guessed.

## Open Questions

- None.
