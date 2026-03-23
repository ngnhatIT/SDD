# Spec Pack: 2026-03-23-sdd-function-type-governance - Function-Type Templates And ADR/Traceability Upgrade

- Status: approved
- Owner: repository maintainers
- Last Updated: 2026-03-23

## 1. Context

- active SDD v2 already has a lean, implementation-oriented spec-pack flow and strong screen or module documentation patterns in governed artifacts
- the active template surface is still too generic for work types that behave differently, especially API or service, batch or job, and report or import or export scope
- ADR coverage exists at repository level, but there is no explicit active policy that tells operators when ADR is required versus unnecessary
- traceability is stronger at the task-artifact level than at the function-spec level, which makes requirement-to-spec-to-code review less consistent than it should be
- this upgrade must preserve current screen or module strengths and avoid a broad framework rewrite

## 2. Scope

### In Scope

- assess the active SDD assets and classify them as reuse as-is, improve, create new, or defer
- introduce function-type-specific templates for screen or module, API or service, batch or job, and report or import or export work
- define a lightweight but strict ADR policy, including status handling and repository conventions
- define a lightweight traceability policy and a reusable traceability section standard for active templates
- update only the active docs needed to route teams toward the new templates, ADR rules, and traceability model
- preserve existing working screen or module spec patterns unless the review finds a concrete gap

### Out Of Scope

- redesigning the lean v2 operating model around a large new governance framework
- replacing implementation-oriented spec packs with theoretical architecture documentation
- forcing ADR creation for trivial field, label, or screen-only behavior that has no wider design impact
- introducing enterprise-weight trace matrices that small work items will not maintain

## 3. Functional Requirements

### FR-01 Current Strengths Are Preserved

- the review must identify active screen or module patterns that already work and keep them unless a concrete delivery gap is proven
- no new active template may flatten or replace useful screen or module detail just for stylistic consistency

### FR-02 Function Templates Are Separated By Work Type

- the active template surface must provide dedicated templates for screen or module, API or service, batch or job, and report or import or export work
- each template must state purpose, correct usage, incorrect usage, required sections, optional sections, review focus, risks if omitted, traceability minimums, and ADR linking
- templates must stay concise and must not all be the same size

### FR-03 ADR Policy Is Explicit

- active docs must define when ADR is required, optional, and unnecessary
- the ADR policy must include a minimum template, naming convention, storage location, status model, and rules for linking from specs
- ADR policy must fit meaningful design decisions only, such as architecture trade-offs, integration strategy, security, performance, data ownership, cross-module choices, or reusable patterns

### FR-04 Traceability Is Lightweight But Enforceable

- active docs must define the minimum trace chain from requirement source to spec, ADR when applicable, implementation location, verification evidence, and release note when available
- templates must distinguish mandatory trace links from optional ones
- the traceability model must stay usable for small day-to-day work without a separate heavy matrix

### FR-05 Repository Changes Are Concrete

- this upgrade must result in file-level repository changes, not chat-only recommendations
- the touched files must include the new templates, ADR guidance, and traceability guidance needed to operate the new model

### FR-06 Active Docs Stay Lean

- updates must stay inside the active v2 surface and must not reopen archived v1 structure as current authority
- any new rule must directly support function-type-specific templating or ADR and traceability governance

## 4. Technical Shape

### Source Anchors

- authority root: `AGENTS.md`
- active framework docs: `docs/execution/`, `docs/governance/`, `docs/structure.md`, `docs/spec-packs/README.md`, `docs/README.md`
- active templates: `docs/templates/`
- active repository decisions: `docs/decisions/`
- representative governed packs under `docs/spec-packs/`

### Planned Shape

- assess representative active docs and packs to capture what already works for screen or module detail
- create new template files under `docs/templates/` for the four function types
- add an ADR template and policy guidance under active docs
- add a traceability section standard and route templates to it
- update only the docs that need to point teams to the new surfaces

## 5. Decisions And Constraints

- preserve the spec-pack-first execution model; function-specific templates complement it rather than replace it
- prefer targeted additions and short routing updates over a new top-level governance layer
- do not make API, batch, or report templates as verbose as screen or module templates if the work type does not need the same depth
- keep ADR rules strict on triggers but light on ceremony
- keep traceability in the spec artifact itself unless a broader release record already exists elsewhere

## 6. Execution Slices

| Slice | Goal | Main files or modules | Verification target |
| --- | --- | --- | --- |
| S1 | ground the upgrade in a governed task home | `docs/spec-packs/2026-03-23-sdd-function-type-governance/` | AC-01 |
| S2 | assess active assets and preserve strong patterns | `docs/templates/`, `docs/spec-packs/`, `docs/decisions/` | AC-01, AC-02 |
| S3 | add function-type templates and ADR or traceability artifacts | `docs/templates/`, `docs/decisions/` | AC-02, AC-03, AC-04 |
| S4 | align routing and usage guidance | `docs/README.md`, `docs/spec-packs/README.md`, `docs/governance/`, `docs/execution/` | AC-03, AC-04, AC-05 |

## 7. Acceptance Criteria

### AC-01 Assessment Is Evidence-Driven

- active SDD assets are reviewed from repository evidence
- findings are classified as reuse as-is, improve, create new, or defer
- strong current screen or module patterns are named explicitly

### AC-02 Function Templates Are Practical

- dedicated template files exist for screen or module, API or service, batch or job, and report or import or export work
- each template includes purpose, use when, do not use when, mandatory sections, optional sections, review focus, omission risks, minimal traceability fields, and ADR links
- templates are concise and shaped to their work type rather than mirrored blindly

### AC-03 ADR Governance Is Usable

- active docs define ADR trigger and non-trigger conditions
- an ADR template exists with status tracking and naming or storage rules
- specs know how to reference ADRs when a design decision exists

### AC-04 Traceability Is Clear Without Heavyweight Overhead

- active docs define a minimum trace chain and mandatory versus optional links
- templates contain a traceability section standard or equivalent required fields
- small work items can satisfy the rule inside the main spec without a separate matrix

### AC-05 Repository Guidance Is Updated

- the active docs surface points teams to the correct templates, ADR policy, and traceability rules
- no active change reopens archived v1 authority or replaces current working screen or module structure without a grounded reason

### AC-06 Verification Records The Upgrade

- this task folder contains `spec_pack.md`, `reinforcement.md`, and `verification.md`
- `verification.md` maps completed repository changes back to these acceptance criteria

## 8. Required Context

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/execution/task-contracts.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/governance/minimal-quality.md`
- `docs/structure.md`
- `docs/checklists/spec-pack-quality.md`
- `docs/checklists/reinforcement-gate.md`
- `docs/templates/`
- `docs/decisions/`
- representative active feature packs under `docs/spec-packs/`

## 9. Open Issues / Stop Points

- stop if the active docs or representative packs show that one of the proposed new templates would replace a working screen or module pattern rather than support it
- stop if a meaningful ADR rule cannot be expressed without conflicting with `ADR-0006` or `ADR-0007`
- stop if the only way to express traceability is to introduce a separate heavy matrix for every work item
- stop if active docs disagree on where function-level templates or ADRs should live
