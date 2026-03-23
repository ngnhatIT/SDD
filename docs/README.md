# Documentation Home

Start here for the active SDD v2 framework.

## Main Paths

- Canonical feature instructions: `spec-packs/<feature-id>/spec_pack.md`
- Anti-hallucination gate: `spec-packs/<feature-id>/reinforcement.md`
- Change closeout record: `spec-packs/<feature-id>/verification.md`
- Review trace: `spec-packs/<feature-id>/review.md`
- Audit trace: `spec-packs/<feature-id>/audit.md`
- Task routing: `execution/task-routing.md`
- Default AI read path: `execution/ai-loading-order.md`
- Cross-cutting rules: `governance/`
- Implementation standards: `standards/`
- Cross-cutting decisions: `decisions/`

## Default Read Path

1. `../AGENTS.md`
2. `spec-packs/<feature-id>/spec_pack.md` when the task is feature-scoped
3. `execution/ai-loading-order.md`
4. `execution/task-routing.md` when task type is unclear or no header is given
5. `governance/core-rules.md`
6. `governance/minimal-context.md`
7. `spec-packs/<feature-id>/reinforcement.md` for non-trivial work
8. only the standards needed for the task
9. the task-specific trace artifact under `spec-packs/<feature-id>/`, such as `verification.md`, `review.md`, or `audit.md`, when resuming, reviewing, or closing

## Legacy

`archive/sdd-v1/README.md` explains where the previous `docs/sdd/`, `docs/specs/`, flat `docs/spec-packs/`, manuals, and helper scripts were moved.
