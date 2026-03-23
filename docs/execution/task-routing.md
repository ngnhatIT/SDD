# Task Routing

Use this file when the task type is unclear or no header is provided.

## Optional Header

```md
Task Type: implement | fix | review | docs | audit | hotfix
Feature Pack: docs/spec-packs/<feature-id>/ | n/a
Standards: auto | docs/standards/<file>[, docs/standards/<file>...]
```

## Task Types

| Task Type | Use When | Required Main Inputs | Required Main Output |
| --- | --- | --- | --- |
| `implement` | approved new work should be built | `spec_pack.md`, relevant standards, `reinforcement.md` if non-trivial | repo change plus updated `verification.md` |
| `fix` | scoped repair or follow-up should be applied | `spec_pack.md` or grounded bug scope, relevant standards, `reinforcement.md` if non-trivial | targeted fix plus updated `verification.md` |
| `review` | findings are required before changes or approval | `spec_pack.md`, relevant standards, current diff or code, `reinforcement.md` if non-trivial | findings-first `review.md` |
| `docs` | docs or framework changes only, including governed `spec_pack.md` authoring | relevant docs, relevant pack when governed, `reinforcement.md` if non-trivial or if the docs change execution rules | updated docs plus updated `verification.md` |
| `audit` | inspect and report without changing code | relevant pack or scoped target, code, standards, and `reinforcement.md` if non-trivial | grounded `audit.md` only |
| `hotfix` | urgent, narrow remediation is required | compact `spec_pack.md`, `reinforcement.md`, relevant standards | smallest safe fix plus updated `verification.md` and follow-up note |

## Routing Rules

- If the task changes behavior, contracts, or framework rules, treat it as non-trivial unless proven otherwise.
- If non-trivial work has no feature pack, stop and create one before implementation.
- If the task's required Markdown artifact does not already have a governed feature-pack home, stop and create or identify one before closeout.
- If the task begins as `audit` or `review` but now needs changes, reroute to `fix` or `implement`.
- If the task is urgent but risky, `hotfix` still requires a feature pack, reinforcement, and verification.
- If the task creates, renames, or validates a task folder, use `docs/structure.md`.

## Validation

- run `python scripts/validate-task.py <task-folder> <task-type> [--non-trivial]` before closeout to check the minimum artifact set
- the validator is intentionally minimal and does not replace `spec_pack.md`, `reinforcement.md`, standards, or stop rules

## Next Reads

1. the relevant feature pack
2. `docs/governance/core-rules.md`
3. `docs/governance/minimal-context.md`
4. `docs/execution/task-contracts.md`
5. `docs/structure.md` when the task home is being created or validated
6. only the standards needed for the touched scope
