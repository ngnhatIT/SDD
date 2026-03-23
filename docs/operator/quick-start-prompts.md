# Quick Start Prompts

- always start with the task header
- always declare `Mode`, `Target`, and `Output`
- before closeout, run `python scripts/validate-task.py docs/spec-packs/<feature-id> <task-type> [--non-trivial] [--strict]`
- use `python scripts/check-gap.py docs/spec-packs/<feature-id>` when the task needs a lightweight spec-to-code gap check

## Implement From Spec Pack

```text
Task Type: implement
Feature Pack: docs/spec-packs/<feature-id>/
Standards: auto

Mode: implement
Target: docs/spec-packs/<feature-id>/
Output: verification.md

Read the active docs in repo order. Implement only what `spec_pack.md` approves. Use `reinforcement.md` for non-trivial work. Update `verification.md` with acceptance coverage, verification steps, and residual risks. Stop on contract or schema ambiguity.
```

## Review From Codebase

```text
Task Type: review
Feature Pack: docs/spec-packs/<feature-id>/
Standards: auto

Mode: review
Target: docs/spec-packs/<feature-id>/
Output: review.md only

Review the current diff or named files against the originating `spec_pack.md` and active standards. Record scope reviewed, files inspected, findings, assumptions or uncertainties, and residual risks in `review.md`. Do not change code. Do not write `verification.md` as the main output.
```

## Audit Task

```text
Task Type: audit
Feature Pack: docs/spec-packs/<feature-id>/
Standards: auto

Mode: audit
Target: docs/spec-packs/<feature-id>/
Output: audit.md only

Inspect the named scope against the originating `spec_pack.md`, active rules, and inspected code. Do not modify code. Write a grounded `audit.md` with compliance status, explicit `Code Modified: no`, evidence, and follow-up risks only.
```

## Governed Docs Or Framework Change

```text
Task Type: docs
Feature Pack: docs/spec-packs/<feature-id>/
Standards: auto

Mode: docs
Target: docs/spec-packs/<feature-id>/
Output: verification.md

Create or revise `spec_pack.md` only when the governed docs task requires it. Keep the framework lean, enforceable, and explicit about scope, acceptance, lifecycle, and stop points. Update `verification.md`. Add `reinforcement.md` when the work is non-trivial or changes framework rules.
```
