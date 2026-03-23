# Traceability Section Template

Use this section inside any companion function spec or implementation-facing appendix.

## Required Links

- source requirement, ticket, or governing request
- originating `spec_pack.md`
- function or surface identifier
- implementation refs
- validation or evidence refs

## Optional Links

- ADR refs when a meaningful design decision exists
- release or change note
- machine-readable contract or migration refs

## Template

| Field | Required | Value | Notes |
| --- | --- | --- | --- |
| Source requirement or ticket | yes | | |
| Originating pack | yes | `docs/spec-packs/<feature-id>/spec_pack.md` | |
| Function or surface id | yes | | |
| Related ADRs | conditional | `none` | list ADR ids when applicable |
| Implementation refs | yes | | code path, contract file, or migration ref |
| Validation or evidence refs | yes | | `verification.md`, `review.md`, `audit.md`, or test refs |
| Release or change note | no | | optional |

## Example

| Field | Required | Value | Notes |
| --- | --- | --- | --- |
| Source requirement or ticket | yes | `CRM-1842` | export current filtered result set |
| Originating pack | yes | `docs/spec-packs/2026-03-23-example-customer-export/spec_pack.md` | |
| Function or surface id | yes | `customer-search-export` | |
| Related ADRs | conditional | `docs/decisions/ADR-0008-function-type-specs-and-traceability.md` | export traceability rule only when applicable |
| Implementation refs | yes | `src/main/java/.../CustomerSearchCsvExportProcess.java`, `src/main/webapp/angular/.../customer-search.component.ts` | |
| Validation or evidence refs | yes | `verification.md`, `TC-01`, `TC-04` | |
| Release or change note | no | `2026.04 release notes` | optional |
