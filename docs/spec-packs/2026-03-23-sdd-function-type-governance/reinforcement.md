# Reinforcement: 2026-03-23-sdd-function-type-governance

- Status: complete
- Last Updated: 2026-03-23

## 1. Grounded Sources

- user request in this task thread
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
- active files under `docs/templates/`
- active repository decisions under `docs/decisions/`
- representative active governed packs under `docs/spec-packs/`

## 2. Consistency Checks

- the task is `docs` work, but it is non-trivial because it changes framework rules, templates, and traceability guidance
- the current active framework already protects task-level artifacts, so the new work must extend that model rather than replace it
- the user explicitly requires preserving working screen or module patterns, which means the assessment must inspect repository evidence before any structural replacement is proposed
- targeted archive comparison is justified because the active surface does not yet contain function-type-specific templates, and the user explicitly asked to preserve existing screen or module strengths

## 3. Ambiguities

- the repository may already contain strong screen or module documentation patterns inside governed packs rather than inside `docs/templates/`, so representative pack sampling is required before drafting final template rules
- it is not yet clear whether ADR policy belongs only in `docs/decisions/README.md` or also needs routing references from `docs/README.md` or `docs/spec-packs/README.md`
- traceability might be best captured by one shared section standard, but the exact location must follow what current active docs already use successfully

## 4. Risks

- creating one generic template plus variants in name only would fail the user goal and add maintenance cost without delivery value
- over-expanding ADR requirements would make design records ceremonial and likely unused
- adding traceability fields with no clear reviewer use would create bureaucracy and drift
- changing current screen or module structure too aggressively could discard working repository patterns that the user explicitly wants preserved

## 5. Stop Conditions

- stop if no active evidence can be found for the current screen or module pattern, because then preservation claims would be guessed rather than grounded
- stop if the proposed ADR policy conflicts with active decision records or creates a second authority path
- stop if traceability rules cannot be expressed as lightweight fields inside the active templates and docs

## 6. Confidence

- medium
- the priority areas are clear, but the final shape still depends on what the active templates and representative governed packs actually show
