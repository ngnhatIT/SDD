# Traceability Policy

Use the lightest traceability that still lets a reviewer move from request to design to implementation and evidence without guesswork.

## Required Trace Chain

1. source request, requirement, or ticket
2. `docs/spec-packs/<feature-id>/spec_pack.md`
3. companion function spec when the pack needs function-level detail
4. ADR when a meaningful design decision exists
5. implementation refs
6. validation evidence in `verification.md`, `review.md`, `audit.md`, or named tests

Release or change notes are optional and should be linked only when they already exist.

## Minimal Fields

| Field | Required | Where It Lives |
| --- | --- | --- |
| source requirement or ticket | yes | `spec_pack.md` and companion function spec when used |
| originating pack path | yes | companion function spec, review, and audit artifacts |
| function or surface id | yes for companion specs | companion function spec |
| related ADRs | conditional | `spec_pack.md`, companion function spec, or ADR header |
| implementation refs | yes | companion function spec and task evidence |
| validation or evidence refs | yes | companion function spec and task evidence |
| release or change note | no | companion function spec or `verification.md` |

## Mandatory Vs Optional Links

- mandatory: request or requirement -> pack -> implementation refs -> evidence
- mandatory when applicable: pack -> companion function spec; companion function spec -> ADR
- optional: release note, rollout note, machine-readable contract, migration note

## Where To Record Traceability

- `spec_pack.md`: scope, acceptance, related companion specs, and related ADRs when applicable
- `function-specs/*.md`: function-level traceability using `docs/templates/traceability-section.template.md`
- `docs/decisions/ADR-*.md`: decision rationale and links back to governed specs
- `verification.md`, `review.md`, `audit.md`: evidence, commands run, findings, and residual risks

## Lightweight Usage Rule

- for small work, keep traceability in `spec_pack.md` and the task evidence only; do not create a companion spec or ADR unless they solve a real reviewer gap
- create a companion function spec only when the pack becomes too generic for the dominant screen, API, batch, or file surface
- create a separate mapping table only when a reviewer cannot follow the implementation from normal refs
- current local validation remains a task-artifact floor; companion spec and ADR quality still depend on review discipline

## Example Mapping

| Source | Spec | ADR | Implementation | Evidence | Release |
| --- | --- | --- | --- | --- | --- |
| `CRM-1842` | `docs/spec-packs/2026-03-23-example-customer-export/spec_pack.md` | `none` | `...CustomerSearchCsvExportProcess.java`, `...customer-search.component.ts` | `verification.md`, `TC-01`, `TC-04` | `2026.04 release notes` |
