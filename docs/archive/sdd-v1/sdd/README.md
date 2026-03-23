# SDD Playbook

## What This Is

`docs/sdd/` is the canonical repository framework for fast, safe, governed delivery.

Use it together with:

- `../AGENTS.md` as the root agent contract
- `goal-and-success-metrics.md` as the canonical statement of delivery intent, success criteria, operating principles, and feedback expectations
- `../specs/README.md` as the feature-package standard
- `../specs-support/README.md` for support-only examples and fixtures
- `../spec-packs/` only as generated execution aids
- `../archive/` only when tracing history or archived outputs

## Active Versus Archived Surface

### Canonical Active

- `AGENTS.md`
- `context/`
- `governance.md` and `governance/`
- `execution/`
- `execution-profiles/`
- `spec-authoring/`
- `checklists/`
- `standards/`
- `templates/`
- `docs/specs/README.md`
- governing feature packages under `docs/specs/<feature-id>/`

### Supporting Active But Non-Authoritative

- `prompts/`
- `process/`
- `ai-ops/`
- `foundation/`
- `reports/`
- `docs/spec-packs/`
- `docs/specs-support/`
- historical or compatibility bridge files that explicitly point back to the canonical path

### Archived Or Bridge Only

- `../archive/sdd/`
- `../archive/spec-results/`
- `../archive/reviews/`
- retained legacy bridge roots such as `agent/` when present

Do not start normal work from archived or bridge material.

## Main Directories

| Directory or file | Primary role |
| --- | --- |
| `goal-and-success-metrics.md` | canonical SDD goal, measurable success signals, operating principles, and feedback-loop intent |
| `context/` | canonical loading order and stable repo context |
| `governance.md` and `governance/` | policy and gate decisions |
| `execution/` | task routing and minimum execution contracts |
| `execution-profiles/` | operating profiles for Codex, Claude, and GitHub Copilot |
| `spec-authoring/` | governed spec-authoring workflow from raw inputs |
| `checklists/` | stage gates and done checks |
| `standards/` | implementation and review rules by layer or module family |
| `templates/` | canonical output structures |
| `prompts/` | thin intent adapters and prompt-selection helpers |
| `process/` | stage guidance after routing is already known |
| `ai-ops/` | recovery, handoff, and framework-health helpers only |
| `foundation/` | additive explanatory material, not the main execution path |
| `reports/` | framework audit or upgrade reports; never authority |
| `../specs-support/` | support-only examples and validator fixtures |
| `../archive/` | archived framework history, historical generated results, and review-only evidence |

## Normal Read Path

1. `../AGENTS.md`
2. `context/constitution.md`
3. `context/note.md`
4. `context/architecture-context.md`
5. `context/product-context.md`
6. `context/tech-context.md`
7. `context/ai-loading-order.md`
8. `execution/task-routing.md`
9. `governance.md`
10. `goal-and-success-metrics.md` when framework intent, delivery tradeoffs, or success signals matter
11. `governance/minimal-sufficient-context-policy.md` when choosing the smallest compliant read set
12. the selected profile under `execution-profiles/`
13. the selected task contract under `execution/contracts/`
14. `spec-authoring/README.md` for spec creation or `../specs/README.md` for governed work
15. the governing feature package under `docs/specs/<feature-id>/`
16. only then the relevant standards, checklists, stage docs, prompts, or generated aids

## Read First By Task Type

| Task type | Start here | Then load |
| --- | --- | --- |
| understand SDD delivery intent or success signals | `goal-and-success-metrics.md` | `governance.md`, `execution/task-routing.md`, and the matching standards or feature package |
| implement or fix governed work | `AGENTS.md` -> `context/` -> `governance.md` -> `execution/task-routing.md` | selected execution contract, selected agent profile, `docs/specs/README.md`, governing feature package, relevant standards and checklists |
| review governed work | `AGENTS.md` -> `context/` -> `governance.md` -> `execution/task-routing.md` | review contract, selected agent profile, governing feature package, relevant standards and review checklist |
| create or update a feature package | `AGENTS.md` -> `context/` -> `governance.md` -> `execution/task-routing.md` | `spec-authoring/README.md`, create-spec contract, `docs/specs/README.md`, authoring checklist |
| choose the daily operator path | `AGENTS.md` -> `execution/task-routing.md` | selected contract, selected agent profile, then the matching governance and feature docs |
| choose the smallest compliant read set | `AGENTS.md` -> `governance/minimal-sufficient-context-policy.md` | `execution/task-routing.md`, then the matching feature or review evidence |
| recover lost AI context | normal canonical path first | `execution/contracts/recover-context.md`, then `ai-ops/09-recovery-mode.md` only if needed |
| inspect execution aids | canonical path first | `prompts/`, `docs/spec-packs/`, `foundation/`, and `reports/` only as support |
| trace historical framework decisions | canonical path first | `reports/`, `../archive/sdd/history/`, `../archive/spec-results/`, `../archive/reviews/` |

## Where Authority Lives

| Need | Canonical location |
| --- | --- |
| root operating contract | `../AGENTS.md` |
| repository policy and gates | `governance.md` and `governance/` |
| task routing and execution contracts | `execution/` |
| agent-specific operating behavior | `execution-profiles/` |
| governed spec authoring | `spec-authoring/` |
| AI governance | `governance/01-ai-agent-policy.md`, `governance/02-anti-hallucination.md`, `governance/03-context-binding.md` |
| feature-package approval source | `../specs/README.md` and `../specs/<feature-id>/` |
| implementation and review rules | `standards/` |
| workflow stages after routing is known | `process/` |
| AI self-check before final output | `process/05-self-review.md`, `process/99-ai-checklist.md` |
| gate checklists | `checklists/` |
| output structures | `templates/feature-package/`, `templates/feature-package-plus/`, `templates/execution-brief-template.md`, `templates/spec-pack-template.md` |
| execution aids | `prompts/`, `ai-ops/`, `foundation/`, `../spec-packs/`, `reports/` |
| archived framework history | `../archive/sdd/` |
| archived generated results and review-only evidence | `../archive/spec-results/`, `../archive/reviews/` |

## Prompt And Template Notes

- `execution/task-routing.md` is the canonical route selector.
- `prompts/MASTER_ROUTINE.md`, `prompts/daily-operator-guide.md`, and `prompts/quick-guide.md` are thin routing helpers only.
- task steps live in `execution/contracts/`, not in prompt prose.
- agent adaptation lives in `execution-profiles/`, not inside duplicated prompt bodies.
- `governance/minimal-sufficient-context-policy.md` is the canonical rule for keeping context loading small without weakening grounding.
- `ai-ops/framework-self-audit.md` is the helper-only recurring audit guide for framework drift and validator blind spots.
- the retained prompt set is intentionally thin. Start from `prompts/README.md`; do not recreate workflow-manual prompts.
- `templates/feature-package/` and `templates/feature-package-plus/` are the only canonical feature-package scaffolds.
- `templates/feature/` now exists mainly as compatibility aliases plus two specialized add-ons: `conflict-review.md` and `linked-screen-scope.md`.
- `templates/execution-brief-template.md` is the canonical execution-brief template.
- `ai-ops/framework-health-metrics.md` defines helper-only framework drift and health signals.

## History And Compatibility

- Historical rationalization reports and migration ledgers are not part of the main read path.
- Compatibility bridge files may remain for old links, but they must point back to the canonical execution or governance source.
- Review-only evidence that is not a governing feature package belongs under `../archive/reviews/`, not on the active approval path.
- Example packages and validator fixtures belong under `../specs-support/`, not under `../specs/`.

## Compatibility Rules

- Existing SDD2 artifacts stay valid. SDD2+ adds companion guidance; it does not replace current governance or feature-package approval.
- `13-risk-log.md` and `14-decision-notes.md` remain additive feature artifacts.
- Generated spec-packs and execution briefs stay secondary to the governing package in `docs/specs/`.
- Retained bridge roots such as `agent/` stay helper-only when present and must point back to `AGENTS.md`, `docs/sdd/README.md`, and `docs/specs/README.md`.
- `context/task-profiles.md`, `context/task-mode-matrix.md`, and similar older routing surfaces are compatibility bridges only when retained.

## Gate

Do not advance a change until the governing feature package or spec-authoring package, matching governance rule, selected execution contract, and relevant checklist all agree.
