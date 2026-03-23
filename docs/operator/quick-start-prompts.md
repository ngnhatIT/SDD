# Quick Start Prompts

- start with the task header
- before closeout, run `python scripts/validate-task.py docs/spec-packs/<feature-id> <task-type> [--non-trivial]`

## Implement From Spec Pack

```text
Task Type: implement
Feature Pack: docs/spec-packs/<feature-id>/
Standards: auto

Read the active docs in repo order. Implement only what `spec_pack.md` approves. Use `reinforcement.md` for non-trivial work. Update `verification.md`. Stop on contract or schema ambiguity.
```

## Review From Codebase

```text
Task Type: review
Feature Pack: docs/spec-packs/<feature-id>/
Standards: auto

Review the current diff or named files against `spec_pack.md` and active standards. Record findings first in `review.md`, then assumptions or uncertainties and residual risks. Do not change code.
```

## Audit Task

```text
Task Type: audit
Feature Pack: docs/spec-packs/<feature-id>/ | n/a
Standards: auto

Inspect the named scope against active rules and code. Do not modify code. Write a grounded `audit.md` with compliance status, evidence, and follow-up risks only.
```

## Generate Spec Pack

```text
Task Type: docs
Feature Pack: docs/spec-packs/<feature-id>/
Standards: auto

Create or revise `spec_pack.md` from the request and current repo. Keep it lean, enforceable, and explicit about scope, acceptance, and stop points. Update `verification.md`. Add `reinforcement.md` when the work is non-trivial or changes framework rules.
```
