# Review

## When To Use

Use this stage after implementation and verification evidence exist.

This stage has two parts:

1. self-review, which must complete before any completion claim or formal review starts
2. formal review, which produces the repository review verdict

## How To Use

1. Run self-review first:
   - run `docs/sdd/process/05-self-review.md`
   - fix or explicitly escalate blocking issues before moving on
   - update `11-implementation-report.md` with the self-review result, unresolved uncertainty, and confidence
2. Run formal review after self-review passes:
   - review the change against the feature package in order
   - record findings and verdict in `12-review-report.md`
   - confirm the implemented code, test evidence, and rollout notes still match the approved spec
   - record follow-up work or release blockers explicitly
3. Classify findings by severity: `critical`, `high`, `medium`, or `low`.

## Required Output

- completed self-review checklist
- self-review summary in `11-implementation-report.md`
- `12-review-report.md`
- review evidence
- verdict and blocking findings
- severity-rated findings
- explicit follow-up or release recommendation

## Gate

Advance only when:

- review confirms the implementation matches the approved spec
- test evidence covers the implemented acceptance criteria
- self-review completed before the formal review started
- blocking findings are resolved or explicitly deferred by rule
- `docs/sdd/checklists/06-code-review-against-spec.md` passes

Formal review or completion claims must not start until self-review is complete and all `critical` or `high` self-findings are resolved or escalated.

## Severity Guide

- `critical`: unapproved breaking contract or schema change, security risk, data-loss risk, or false completion claim
- `high`: acceptance gap, required artifact missing, contract drift, invented surface, or unresolved blocker
- `medium`: meaningful regression risk, parity gap, incomplete evidence, or manual follow-up still needed
- `low`: non-blocking clarity or cleanup issue with no release impact

## Minimum Self-Review Scope

- hallucination and grounding checks
- scope and contract drift
- local code-shape drift
- acceptance and test evidence coverage
- required artifact completion
- unresolved uncertainty and confidence status
- repository-derived shared helper, constant, message, focus-out, table-helper, SQL-formatting, and validation-parity checks for the touched scope
- touched-scope import cleanup, formatting alignment, redundant-code removal, and comment-language checks
- touched frontend structure reuse and responsive small-window checks, including paired range-field alignment where applicable
- backend validation-path reuse and field-level versus popup error-routing checks for the touched scope
- search init, saved-condition, count, list, pager, and zero-result lifecycle checks for touched search families
- preferred-current versus tolerated-legacy classification checks where repository evidence is mixed
