---
brief_version: 1
feature: "2026-03-13-spec-graph-extractor"
task_profile: "implement-new"
governance_classification: "reduced-path"
feature_status: "ready-for-review"
review_scope: "n/a"
spec_pack: "n/a"
backend_spec: "n/a"
bug_source: "n/a"
generator: "scripts/sdd/build_execution_brief.sh"
---

# Execution Brief

## Snapshot

- Feature: `2026-03-13-spec-graph-extractor`
- Title: `First-pass spec graph extractor for feature packages`
- Task profile: `implement-new`
- Governance classification: `reduced-path`
- Feature status: `ready-for-review`
- Governing package: `docs/specs/2026-03-13-spec-graph-extractor/`
- Conflict rule: the governing feature package wins over generated execution aids

## Required Inputs

- Feature: `docs/specs/2026-03-13-spec-graph-extractor/`
- Task Profile: `implement-new`
- Spec Pack: `n/a`
- Backend Spec: `n/a`
- Bug Source: `n/a`
- Review Scope: `n/a`

## Source Of Truth Files

- `docs/specs/2026-03-13-spec-graph-extractor/README.md`
- `docs/specs/2026-03-13-spec-graph-extractor/01-requirements.md`
- `docs/specs/2026-03-13-spec-graph-extractor/02-design.md`
- `docs/specs/2026-03-13-spec-graph-extractor/07-tasks.md`
- `docs/specs/2026-03-13-spec-graph-extractor/08-acceptance-criteria.md`
- `docs/specs/2026-03-13-spec-graph-extractor/09-test-cases.md`
- `docs/specs/2026-03-13-spec-graph-extractor/10-rollout.md`
- `docs/specs/2026-03-13-spec-graph-extractor/changelog.md`
- `docs/specs/2026-03-13-spec-graph-extractor/11-implementation-report.md`

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
- `docs/sdd/standards/backend-change-rules.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/frontend-screen-architecture.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/frontend-change-rules.md` - selected repository standard for the touched layer or workflow
- `docs/sdd/standards/database-change-rules.md` - selected repository standard for the touched layer or workflow
- `docs/specs/2026-03-13-spec-graph-extractor/README.md` - feature summary, traceability, and artifact status
- `docs/specs/2026-03-13-spec-graph-extractor/01-requirements.md` - requirements and scope constraints
- `docs/specs/2026-03-13-spec-graph-extractor/02-design.md` - design intent, anchors, and locked decisions
- `docs/specs/2026-03-13-spec-graph-extractor/07-tasks.md` - implementation task breakdown
- `docs/specs/2026-03-13-spec-graph-extractor/08-acceptance-criteria.md` - acceptance conditions
- `docs/specs/2026-03-13-spec-graph-extractor/09-test-cases.md` - verification targets

## Optional Consult

- `docs/specs/2026-03-13-spec-graph-extractor/11-implementation-report.md` - implementation evidence when delivered behavior matters

## Locked Decisions

- `DES-01` Emit `spec.graph.yaml` beside the feature package as a companion artifact instead of replacing numbered markdown files.
- `DES-02` Implement the extractor in shell with repo-local markdown parsing rules rather than introducing a new language runtime or parser framework.
- `DES-03` Extract only explicit relations from current tables and headings, and record anything else under warnings or manual authoring notes.
- `DES-04` Support both table-style and heading-style `REQ` and `DES` sections in the first extractor.
- `DES-05` Generate example graphs for `2026-03-11-example-customer-export` and `2026-03-13-task-profile-routing`.
- Source-base anchors are locked to the files named below:
- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Mirror the deterministic shell-and-markdown parsing style already used by the existing SDD scripts and keep the graph explicitly non-authoritative.
- New tables/source families/screen structure in scope: `no`; this feature changes docs and tooling only.

## Prohibited Scope

- Replacing the numbered markdown feature package as the approval source of truth
- Adding a repo-wide graph validator or CI gate
- Backfilling every existing feature package in one change
- Inferring relations that are not stated explicitly in current markdown
- Changing runtime backend, frontend, or SQL behavior
- No runtime module behavior changes
- No new validator gate or CI integration
- No automatic inference of narrative-only relationships
- No rewrite of the current feature-package authoring model

## Constraints

- Read before write: inspect the named anchors, sibling flows, existing tests, and owned contracts before editing.
- Reuse before create: extend the current module family before introducing new routes, DTOs, classes, modules, or tables.
- Conflict reporting: record spec, code, test, schema, and standard conflicts instead of silently guessing through them.
- Locked contracts remain unchanged unless the governing feature package explicitly authorizes the change.
- Unknown source detail must stay `unknown (...)` or blocked; do not infer hidden requirements from the prompt.

## Touched Layers And Components

- Backend process: `n/a`
- Backend webservice: `n/a`
- SQL: `n/a`
- Frontend .ts: `n/a`
- Frontend .html: `n/a`
- Contracts: `n/a`

## Locked Contracts

- `n/a`

## Task Scope

- Add a shell extractor that generates `spec.graph.yaml` for one selected feature package.
- Extract feature metadata, scope, anchors, open questions, `REQ`, `DES`, `TASK`, `AC`, and `TC` nodes, explicit contract references, and explicit trace links.
- Generate sample graphs for an existing full-path feature and an existing reduced-path feature.
- Document current limits and which graph fields still require human authoring.

## Done Criteria

- `sh scripts/sdd/validate_specs.sh 2026-03-13-spec-graph-extractor`
- Satisfy verification evidence for: `TC-01, TC-02, TC-03, TC-04`
- Apply `docs/sdd/checklists/04-pre-implementation-gate.md` before implementation starts
- Update `11-implementation-report.md` with approved artifacts used, inspected code refs, reuse decisions, conflicts, and tests.
- Apply `docs/sdd/governance/definition-of-done.md` before marking the feature done
- Apply `docs/sdd/governance/06-release-readiness-rules.md` when the change is marked release-ready or merged for shipment

## Expected Outputs

- Deliver implementation and verification aligned to the governing `REQ -> DES -> TASK -> AC -> TC` chain.
- Update `10-rollout.md` and `changelog.md` when behavior or release guidance changes.
- Record delivered implementation in `11-implementation-report.md` once implementation starts.

## Assumptions And Current Limits

- This brief is generated from canonical markdown and fixed task-profile mappings; it is an execution aid, not an approval artifact.
- Classification is inferred from owned feature files: `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, and `06-edge-cases.md` imply `full-path`; otherwise the generator emits `reduced-path`.
- The generator does not infer intent from free-form prompts. Request-scoped inputs such as `--bug-source`, `--backend-spec`, `--review-scope`, and `--spec-pack` must be provided explicitly when needed.
- Missing scope, decision, or helper inputs are emitted as `unknown (...)` rather than guessed.

## Open Questions

- None.
