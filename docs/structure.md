# Structure Contract

## Canonical Task Home

All governed work lives under one folder:

```text
docs/spec-packs/<feature-id>/
  spec_pack.md
  reinforcement.md
  verification.md
  review.md
  audit.md
  decisions.md
```

## Naming

- use one governed work item per folder
- create a new folder for new work; do not reuse an existing folder for unrelated scope
- use the canonical active folder pattern `YYYY-MM-DD-short-slug`
- keep any external feature ID inside `spec_pack.md` or `decisions.md`; it is not an alternative folder naming contract
- do not rename a folder after it already holds active evidence unless the move is explicitly recorded

## Canonical Task Types

The active framework uses one canonical task type set only:

- `implement`
- `fix`
- `review`
- `docs`
- `audit`
- `hotfix`

Do not use alias task types such as `spec` or `code` in active governed work.

## Task-Type Files

| Task Type | Required Files | Optional Files Or Notes |
| --- | --- | --- |
| `implement`, `fix`, `docs`, `hotfix` | `spec_pack.md`, `verification.md` | `reinforcement.md` is required when the work is non-trivial |
| `review` | `spec_pack.md`, `review.md` | `review.md` must reference the originating `spec_pack.md`; `reinforcement.md` is required when the review is non-trivial |
| `audit` | `spec_pack.md`, `audit.md` | `audit.md` must reference the originating `spec_pack.md`; no code changes; `reinforcement.md` is required when the audit is non-trivial |

## Task Lifecycle Rules

- one folder equals one primary governed task lifecycle rooted in `spec_pack.md`
- allowed evidence evolution inside that folder is:

```text
spec_pack.md -> change work -> review.md -> audit.md
```

- `verification.md` records change-making closeout for `implement`, `fix`, `docs`, and `hotfix`
- `review.md` is downstream review evidence for the same governed task and must name the originating `spec_pack.md`
- `audit.md` is downstream audit evidence for the same governed task and must name the originating `spec_pack.md`
- do not mix unrelated specs, reviews, or audits in the same folder
- if the work changes to a different primary scope, create a new governed folder instead of overloading the existing one

## Validation Floor

- run `python scripts/validate-task.py docs/spec-packs/<feature-id> <task-type> [--non-trivial] [--strict]`
- the validator accepts only canonical task types
- the validator checks required file presence, minimal content quality, canonical naming, and review or audit spec traceability


## Optional Local Hook

- install an optional pre-commit validator hook with `scripts/install-validate-task-hook.sh <task-folder> <task-type> [--non-trivial] [--strict]`
- the hook is local-only and does not change the repo workflow contract
