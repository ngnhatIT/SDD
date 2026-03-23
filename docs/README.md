# Documentation Home

Start here for the active lean SDD v2.5 framework.

## Main Paths

- Canonical feature instructions: `spec-packs/<feature-id>/spec_pack.md`
- Anti-hallucination gate: `spec-packs/<feature-id>/reinforcement.md`
- Change closeout record: `spec-packs/<feature-id>/verification.md`
- Review trace: `spec-packs/<feature-id>/review.md`
- Audit trace: `spec-packs/<feature-id>/audit.md`
- Function-spec templates: `templates/README.md`
- Traceability policy: `governance/traceability-policy.md`
- ADR policy and active ADRs: `decisions/README.md`
- Task routing: `execution/task-routing.md`
- Default AI read path: `execution/ai-loading-order.md`
- Task folder contract: `structure.md`
- Operator prompts: `operator/quick-start-prompts.md`
- Local validator: `../scripts/validate-task.py`
- Lightweight gap checker: `../scripts/check-gap.py`
- Cross-cutting rules: `governance/`
- Implementation standards: `standards/`
- Cross-cutting decisions: `decisions/`

## Quick Start

1. read `../AGENTS.md`
2. identify or create the governed task home under `spec-packs/<feature-id>/`
3. route the task through `execution/task-routing.md`
4. if the pack needs function-level detail, choose the matching companion template from `templates/README.md`; if the change introduces a meaningful cross-cutting decision, check `decisions/README.md`
5. run `python scripts/validate-task.py docs/spec-packs/<feature-id> <task-type> [--non-trivial] [--strict]` before closeout

## Default Read Path

1. `../AGENTS.md`
2. `spec-packs/<feature-id>/spec_pack.md` when the task is feature-scoped
3. `execution/ai-loading-order.md`
4. `execution/task-routing.md` when task type is unclear or no header is given
5. `governance/core-rules.md`
6. `governance/minimal-context.md`
7. `spec-packs/<feature-id>/reinforcement.md` for non-trivial work
8. `structure.md` when creating, validating, or closing a task folder
9. only the standards needed for the task
10. the task-specific trace artifact under `spec-packs/<feature-id>/`, such as `verification.md`, `review.md`, or `audit.md`, when resuming, reviewing, or closing

## Optional Local Automation

- install an optional pre-commit validator hook with `../scripts/install-validate-task-hook.sh docs/spec-packs/<feature-id> <task-type> [--non-trivial] [--strict]`

## Legacy

`archive/sdd-v1/README.md` explains where the previous `docs/sdd/`, `docs/specs/`, flat `docs/spec-packs/`, manuals, and helper scripts were moved.
