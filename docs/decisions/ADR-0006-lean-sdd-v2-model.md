# ADR-0006 Lean SDD v2 Model

- Status: accepted
- Date: 2026-03-23
- Owners: repository maintainers
- Refined By: `ADR-0007-task-artifact-traceability.md`, `ADR-0008-function-type-specs-and-traceability.md`

## Context

The repository's previous SDD framework used multiple authority layers: `AGENTS.md`, `docs/sdd/`, numbered feature packages under `docs/specs/`, generated flat spec packs, extensive checklists, and helper prompts.

That model preserved rigor, but it also increased token usage, duplicated routing and governance language, and created a dual-authority problem once an external tool became the real `spec_pack` generator.

## Decision

The repository adopts a lean SDD v2 model with these rules:

1. `docs/spec-packs/<feature-id>/spec_pack.md` is the canonical feature artifact.
2. `docs/spec-packs/<feature-id>/reinforcement.md` is mandatory for non-trivial work.
3. `docs/spec-packs/<feature-id>/verification.md` is the completion and validation record for change-making tasks.
4. Active governance is reduced to `core-rules.md`, `uncertainty-escalation.md`, `minimal-context.md`, and `done-definition.md`.
5. Active execution guidance is reduced to `task-routing.md`, `task-contracts.md`, and `ai-loading-order.md`.
6. Previous SDD v1 docs, specs, flat spec packs, manuals, and helper scripts are archived, not left active.

## Consequences

- `docs/specs/` and `docs/sdd/` are no longer active authority paths.
- Feature work starts from the feature's spec pack, not from numbered requirements and design files.
- Anti-hallucination discipline is preserved as a separate reinforcement stage instead of being merged into the spec pack.
- Legacy materials remain available for historical comparison under archive paths.
