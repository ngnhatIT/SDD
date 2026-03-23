# Template Strategy

`spec_pack.md` remains the canonical governed artifact. Use a companion function spec only when one delivery surface needs implementation-facing detail that the generic pack should not absorb.

## Companion Spec Location

- store companion function specs under `docs/spec-packs/<feature-id>/function-specs/`
- name files `<function-id>.screen-module.md`, `<function-id>.api-service.md`, `<function-id>.batch-job.md`, or `<function-id>.report-import-export.md`
- link companion specs from `spec_pack.md` and keep their traceability section current
- do not create `function-specs/` when the pack itself is already clear enough

## Template Map

| Template | Use for | Avoid when |
| --- | --- | --- |
| `screen-module-spec.template.md` | UI screens, linked UI modules, field-heavy workflows, button-state or permission-heavy behavior | API-first, batch-first, or file-first work where UI is incidental |
| `api-service-spec.template.md` | request or response contracts, service endpoints, auth or dependency-heavy backend behavior | screen flow, report mapping, or scheduled job orchestration |
| `batch-job-spec.template.md` | scheduled, manual-run, event-driven, or recovery-sensitive background jobs | synchronous request or response work or file-first user actions |
| `report-import-export-spec.template.md` | reports, CSV or Excel flows, imports, exports, file mappings, and generated download behavior | generic APIs with no file or mapping surface |
| `traceability-section.template.md` | reusable traceability block for any companion spec or appendix | task closeout artifacts that already use `verification.md`, `review.md`, or `audit.md` |
| `adr.template.md` | repository-level ADRs under `docs/decisions/` | feature-local one-off decisions that belong in `<feature-id>/decisions.md` |
| `decisions.template.md` | feature-local decisions inside one governed task folder | cross-module or reusable decisions that must become ADRs |

## Usage Rules

- start with `spec_pack.md`; add a companion function spec only when the pack is too generic for reviewers to defend the implementation
- use one dominant function-type template per surface instead of stretching one universal template across all work
- if the same change has a screen and an API surface, keep the pack as the summary and add only the companion specs that materially reduce ambiguity
- when a design choice is cross-module, reusable, security-impacting, performance-impacting, or changes ownership boundaries, create or update an ADR under `docs/decisions/`
- keep traceability inside the companion spec itself unless a larger matrix is genuinely needed
