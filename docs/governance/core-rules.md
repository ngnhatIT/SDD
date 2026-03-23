# Core Rules

## Source Priority

1. `AGENTS.md`
2. `docs/execution/ai-loading-order.md`
3. active files under `docs/governance/`
4. `docs/execution/task-routing.md` and `docs/execution/task-contracts.md`
5. `docs/structure.md`
6. `docs/spec-packs/<feature-id>/spec_pack.md`
7. `docs/spec-packs/<feature-id>/reinforcement.md`
8. relevant files under `docs/standards/`
9. the task-specific trace artifact under `docs/spec-packs/<feature-id>/`, such as `verification.md`, `review.md`, or `audit.md`
10. `docs/decisions/`
11. `docs/archive/sdd-v1/` only for legacy comparison

## Non-Negotiable Rules

- `spec_pack.md` is the canonical feature artifact.
- `reinforcement.md` is mandatory for non-trivial work.
- a task-specific Markdown artifact is required before final closeout: `verification.md` for `implement`, `fix`, `docs`, and `hotfix`; `review.md` for `review`; `audit.md` for `audit`
- `docs/structure.md` is the task-folder naming and artifact-placement contract.
- Do not guess missing behavior, schema facts, contract details, error semantics, or rollout rules.
- Preserve approved contracts unless `spec_pack.md` explicitly changes them.
- Keep traceability from requirement or design intent to recorded task evidence and any required acceptance coverage.
- Update machine-readable contracts in the same change when the feature pack changes API, DTO, file, or DB shape.
- Keep the lightest process that still controls real risk.

## Non-Trivial Work

Treat the work as non-trivial when any of these are true:

- code changes are required
- API, DTO, file, or DB shape may change
- behavior, auth, tenant, company, or validation rules may change
- the change touches multiple files or module families
- the request is ambiguous enough that the next step could be guessed
- the task changes framework rules, templates, routing, or standards

## Reinforcement Decision Table

| Case | Reinforcement |
| --- | --- |
| complex logic or multi-branch behavior | required |
| DB or schema change | required |
| API, DTO, file-shape, auth, validation, or contract change | required |
| framework rule, routing, or standards change | required |
| minor text or wording fix with no rule change | not required |
| small refactor or rename with no behavior change | not required |
| if unsure whether behavior changes | required |

## Validation Floor

- run `python scripts/validate-task.py <task-folder> <task-type> [--non-trivial]` before closeout when the task has a governed folder
- the validator checks minimum artifact presence only; it does not waive any other stop rule

## Stop Rules

- Stop if the feature pack is missing or materially incomplete.
- Stop if reinforcement is missing for non-trivial work.
- Stop if the next change would break an approved contract without explicit approval.
- Stop if `docs/standards/schema_database.yaml` conflicts with code or docs.
- Stop if active docs conflict and the conflict is not resolved by priority.
- Stop if the task folder layout conflicts with `docs/structure.md`.
- Stop if the local module pattern or ownership cannot be identified from code and active docs.
- Stop if confidence is too low to defend the next change.

## Required Records

- use `spec_pack.md` for approved intent, scope, constraints, and acceptance
- use `reinforcement.md` for grounded sources, ambiguity handling, and stop conditions
- use `verification.md` for what changed, what was tested, and what remains open for `implement`, `fix`, `docs`, and `hotfix`
- use `review.md` for findings-first review evidence, assumptions or uncertainties, and residual risks
- use `audit.md` for grounded audit reports, compliance status, and follow-up notes
