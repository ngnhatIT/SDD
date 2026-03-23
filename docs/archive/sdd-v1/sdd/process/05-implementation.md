# Implementation

## When To Use

Use this stage after the feature package passes the pre-implementation gate.

For non-trivial implementation or fix work, run it as a two-pass stage. This is required when multiple layers, contracts, schema, or unfamiliar module families are involved.

## How To Use

1. Run pass 1 before non-trivial work starts:
   - load the governing feature package, standards, and source-base anchors
   - inspect sibling flows, tests, contracts, and local family conventions
   - inspect shared utilities, constants, message catalogs, base or common flows, validation ownership, touched-file cleanup needs, responsive layout anchors, and comment-language expectations for the touched concerns
   - classify mixed repository evidence as preferred current, tolerated legacy, or required migration for the touched concerns
   - record the exact change plan, preserved local patterns, required touched-scope modernization, blockers, and ask-before-break surfaces
   - stop and escalate if evidence is still insufficient
2. Implement the planned `TASK-` items in pass 2:
   - implement only the grounded scope from pass 1
   - update specs, contracts, and reports together when owned behavior changes
   - return to pass 1 if new evidence invalidates the plan
3. Update the feature package when behavior, contracts, rollout steps, or failure handling change.
4. Keep task status current in `07-tasks.md`.
5. Add `11-implementation-report.md` as implementation evidence accumulates.
6. Add an ADR before review starts if implementation introduces a new cross-cutting choice.
7. Escalate uncertainty instead of guessing when evidence becomes insufficient.

## Required Output

- code changes
- updated feature package
- `11-implementation-report.md`
- pass 1 grounding evidence for non-trivial work

For non-trivial work, pass 1 evidence must identify:

- approved artifacts used
- touched layers and source-base anchors
- code references and sibling flows inspected
- owned contracts or schema artifacts inspected
- local family conventions to preserve
- touched-scope cleanup requirements, including unused imports, redundant code, and comment rewrites when applicable
- repository-derived shared helpers, constants, message paths, base-common flows, table helpers, and validation-parity rules that apply to the touched scope
- responsive layout and paired-field alignment expectations for touched frontend forms or search conditions
- preferred-current versus tolerated-legacy classification for mixed patterns in the touched scope
- field-level versus popup error-routing expectations for touched frontend validation or fatal-error flows
- locked contracts or ask-before-break surfaces
- planned tasks and expected artifact updates
- blockers, unresolved uncertainty, and current confidence level

## Gate

Advance only when:

- completed tasks are marked done
- remaining work is marked deferred or blocked
- implementation evidence exists for the implemented scope
- `docs/sdd/checklists/05-implementation-completion.md` passes

For non-trivial work, pass 2 must not begin until pass 1 grounding is complete.

## Pass 2 Rules

- do not widen scope silently
- do not touch locked surfaces without explicit approval
- do not replace the touched family with invented abstractions
- do not leave touched files with unused imports, redundant dead code, or commented-out placeholder blocks that should have been removed inside the grounded scope
- do not skip required shared helper, constant, message, focus-out, table-helper, or validation-parity reuse just because the local file still contains an older pattern
- do not leave backend validation or focus-out flows on a weaker local duplicate when the touched family already supports `beforeProcessing(...)`, shared error-DTO routing, `MasterCodeCheckProcess`, or the shared master-name lookup path
- do not leave touched frontend validation on popup-only handling when sibling anchors already use `validateFields(...)`, inline `.inputError`, or `Ultility.fnSetErrorMsg(...)` for the same concern
- do not ship touched frontend layout work without checking smaller-window behavior and paired range-field alignment where that concern is in scope
- do not add new or rewritten non-English comments; keep comments minimal and only for non-obvious logic
- do not bypass the existing search init, saved-condition, count, list, pager, or zero-result lifecycle when the touched family already owns that pattern
- run `docs/sdd/process/05-self-review.md` before claiming completion
