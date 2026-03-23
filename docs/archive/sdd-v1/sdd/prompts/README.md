# Prompt Library

These prompts are reusable execution adapters for governed work in this repository.

They do not replace `AGENTS.md`, canonical context, governance, or the governing feature package.

## How To Use

1. Load canonical docs first.
2. Route through `docs/sdd/execution/task-routing.md`.
3. Load the selected execution contract under `docs/sdd/execution/contracts/`.
4. Load the selected agent profile under `docs/sdd/execution-profiles/`.
5. Use a prompt only after the route, contract, and profile are already clear.
6. Treat prompts as execution aids only. If a prompt conflicts with approved artifacts, governance, or inspected evidence, the prompt loses.

## Prompt Selection

- `MASTER_ROUTINE.md`, `daily-operator-guide.md`, and `quick-guide.md` are routing helpers only.
- task-family operating rules live in `docs/sdd/execution/contracts/`.
- agent-specific adaptation lives in `docs/sdd/execution-profiles/`.

## Prompt Set

### Orchestration

| Prompt | Primary Use | Canonical Backing Source |
| --- | --- | --- |
| `MASTER_ROUTINE.md` | one-prompt routing entrypoint | `docs/sdd/execution/task-routing.md` |
| `daily-operator-guide.md` | shortest route selector | `docs/sdd/execution/task-routing.md` |
| `quick-guide.md` | choose the right prompt after the route is known | `docs/sdd/execution/task-routing.md` |

### Primary Prompts

| Prompt | Primary Use | Canonical Contract | Canonical Template |
| --- | --- | --- | --- |
| `create-spec.md` | create or update a governed feature package | `docs/sdd/execution/contracts/create-spec.md` | `docs/sdd/templates/feature-package/` |
| `implement-feature.md` | implement from the governing feature package | `docs/sdd/execution/contracts/implement-feature.md` | `docs/sdd/templates/feature-package/11-implementation-report.md` |
| `review-feature.md` | review against spec or rules | `docs/sdd/execution/contracts/review-feature.md` | `docs/sdd/templates/feature-package/12-review-report.md` |
| `fix-from-review-report.md` | fix findings already recorded in review | `docs/sdd/execution/contracts/fix-from-review.md` | `docs/sdd/templates/feature-package/11-implementation-report.md` and `docs/sdd/templates/feature-package/12-review-report.md` |
| `generate-spec-pack.md` | build or refresh a feature-wide spec-pack | `docs/sdd/execution/contracts/generate-spec-pack.md` | `docs/sdd/templates/spec-pack-template.md` |
| `generate-execution-brief.md` | build a task-scoped execution brief | `docs/sdd/execution/contracts/generate-execution-brief.md` | `docs/sdd/templates/execution-brief-template.md` |

### Support Uses

| Prompt | Short Support Use | Backing Source |
| --- | --- | --- |
| `create-spec.md` | requirement clarification or governed document refactoring when the work still belongs to spec authoring | `docs/sdd/spec-authoring/README.md` |
| `review-feature.md` | design review, traceability review, or SDD review when the route is already known | `docs/sdd/execution/contracts/review-feature.md` |

### Utility Prompts

| Prompt | Primary Use | Canonical Backing Source |
| --- | --- | --- |
| `core/recover-context.md` | regain grounded task context before continuing | `docs/sdd/execution/contracts/recover-context.md` |
| `core/self-review.md` | run mandatory self-review before completion | `docs/sdd/process/05-self-review.md`, `docs/sdd/checklists/self-review-checklist.md` |
| `core/pre-merge-audit.md` | audit merge readiness, blockers, and confidence | `docs/sdd/governance/definition-of-done.md`, `docs/sdd/checklists/done-checklist.md` |

## Compatibility Notes

- `create-spec.md` covers both create and update flows.
- `create-spec.md` may also be used for requirement clarification and governed document refactoring as long as it still follows the spec-authoring path.
- `review-feature.md` covers both `review-from-pack` and `review-from-rules`.
- `review-feature.md` may also be used for design review and traceability review when the target is already grounded.
- retained top-level prompt filenames are compatibility-friendly adapters; the contracts remain the operational source.
- top-level compatibility aliases such as `recover-context.md`, `self-review.md`, and `execution-brief.md` must point back to their canonical prompt or template instead of carrying a second workflow body.
