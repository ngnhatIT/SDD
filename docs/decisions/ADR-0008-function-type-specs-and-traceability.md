# ADR-0008 Function-Type Specs And Spec-Level Traceability

- Status: accepted
- Date: 2026-03-23
- Owners: repository maintainers
- Related Specs: `docs/spec-packs/2026-03-23-sdd-function-type-governance/spec_pack.md`
- Related Function Specs: `none`
- Supersedes: `none`
- Superseded By: `none`

## Context

Lean SDD v2 keeps `spec_pack.md` as the canonical governed artifact and already requires durable task-level evidence through `verification.md`, `review.md`, and `audit.md`.

That model stays directionally correct, but the active template surface is still too generic when the dominant work is a screen, API, batch job, or report, import, or export flow. The repository also has implicit ADR practice and task-level traceability, but no explicit active rule for when ADR is required and how function-level traceability should be recorded.

## Decision

1. `spec_pack.md` remains the canonical governed artifact; function-specific templates do not replace it.
2. When a pack needs implementation-facing detail that the generic pack should not absorb, add companion specs under `docs/spec-packs/<feature-id>/function-specs/`.
3. The active template surface provides dedicated companion templates for `screen-module`, `api-service`, `batch-job`, and `report-import-export` work.
4. Companion specs use a shared minimum traceability section so reviewers can follow source request, pack, ADR when applicable, implementation refs, and evidence.
5. Repository-level ADRs are required only for meaningful cross-module, reusable, security, performance, ownership, or integration decisions. Feature-local one-off rationale stays in the governed task folder.

## Consequences

- screen or module patterns can stay detailed without forcing the same shape onto API, batch, or file-first work
- API, batch, and report or import or export specs now have a dedicated home in the active surface instead of stretching the generic pack
- ADR use becomes stricter and more intentional rather than ceremonial
- traceability becomes clearer at the function level without restoring the archived v1 artifact stack or a mandatory matrix for every task
