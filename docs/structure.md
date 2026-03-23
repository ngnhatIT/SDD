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
- use a stable unique name; prefer `YYYY-MM-DD-short-slug`
- use an external feature ID such as `SPMT00141` when that is the real governing identifier
- do not rename a folder after it already holds active evidence unless the move is explicitly recorded

## Task-Type Files

| Task Type | Required Files | Optional Files Or Notes |
| --- | --- | --- |
| `spec` alias | `spec_pack.md`, `verification.md` | use repo task type `docs` when no separate spec header is in use; `reinforcement.md` is required when the work is non-trivial |
| `code` alias | `spec_pack.md`, `verification.md` | matches change-making work; `reinforcement.md` is required when the work is non-trivial |
| `implement`, `fix`, `docs`, `hotfix` | `spec_pack.md`, `verification.md` | `reinforcement.md` is required when the work is non-trivial |
| `review` | `review.md` | keep the review in the governed task folder; `reinforcement.md` is required when the review is non-trivial |
| `audit` | `audit.md` | no code changes; `reinforcement.md` is required when the audit is non-trivial |

## Validation Floor

- run `python scripts/validate-task.py docs/spec-packs/<feature-id> <task-type> [--non-trivial]`
- the validator supports repo task types plus the simple aliases `spec` and `code`
- the validator checks the minimum artifact set only; governance can still require more evidence or more reads
