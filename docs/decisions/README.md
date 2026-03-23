# Cross-Cutting Decisions

Use this folder for repository-level decisions that outlive a single feature pack. Keep feature-local one-off rationale in `docs/spec-packs/<feature-id>/decisions.md`.

## ADR Is Required When

- the decision changes a reusable pattern that future modules should follow
- the decision changes integration strategy, protocol use, or ownership boundaries
- the decision changes security, privacy, auth, performance, or availability trade-offs
- the decision changes compatibility or versioning rules beyond one isolated function
- the decision spans multiple modules or feature packs and reviewers need one durable rationale

## ADR Is Optional When

- the decision is still scoped to one governed pack but is likely to be revisited or cited by review later
- the change introduces a temporary migration or fallback strategy that lasts beyond one small edit
- a reviewer asks for durable rationale because the trade-off is real but not yet repo-wide

## ADR Is Unnecessary When

- the change is a field label, field order, or local validation detail with no wider pattern impact
- the change is a small refactor, naming cleanup, or local mapper fix with no design trade-off
- the decision is purely feature-local and does not need to outlive the governed task folder

## Template And Status Model

- use `docs/templates/adr.template.md`
- allowed statuses are `proposed`, `accepted`, `superseded`, and `deprecated`
- only `accepted` ADRs are active authority
- `superseded` ADRs stay for history and must point to the replacing ADR
- `deprecated` ADRs remain informative but should not guide new design work

## Naming And Storage

- store ADRs as `docs/decisions/ADR-XXXX-short-kebab-title.md`
- keep the numeric id zero-padded and increasing
- do not store feature-local rationale here when `docs/spec-packs/<feature-id>/decisions.md` is enough

## Spec Linking Rules

- `spec_pack.md` names related ADRs when they govern the scoped work
- companion function specs record ADR refs in their traceability section when a decision affects that surface
- `verification.md`, `review.md`, and `audit.md` cite ADRs only when the implementation or finding actually depends on them

## Active ADRs

- `ADR-0006-lean-sdd-v2-model.md`
- `ADR-0007-task-artifact-traceability.md`
- `ADR-0008-function-type-specs-and-traceability.md`

## Legacy

Earlier ADRs tied to the archived SDD v1 model live under `../archive/sdd-v1/decisions/`.
