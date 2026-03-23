# Done Definition

A governed task is done only when all of these are true:

- the governed scope matches `spec_pack.md` or the grounded task target
- required standards and stop rules were respected
- the task-specific Markdown artifact is updated: `verification.md` for `implement`, `fix`, `docs`, and `hotfix`; `review.md` for `review`; `audit.md` for `audit`
- `review.md` and `audit.md`, when present, reference the originating `spec_pack.md`
- `reinforcement.md` exists for non-trivial work
- `python scripts/validate-task.py <task-folder> <task-type> [--non-trivial] [--strict]` passes when the task has a governed folder
- unresolved risks, assumptions, or follow-ups are recorded in the right artifact instead of chat only
