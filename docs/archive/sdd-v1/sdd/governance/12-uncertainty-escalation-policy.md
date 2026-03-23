# Uncertainty Escalation Policy

## When To Use

Use this rule when evidence is incomplete, conflicting, stale, or too weak to support a safe implementation, review, or completion claim.

## How To Use

1. Detect the uncertainty trigger.
2. Stop any scope-expanding or potentially breaking edit on the affected area.
3. Gather missing evidence from approved artifacts, existing code, tests, or contracts.
4. If the gap remains, record the blocker and escalate instead of guessing.
5. Apply ask-before-break rules for contract, schema, or externally visible behavior changes.

## Required Output

- explicit uncertainty note with evidence refs
- blocker, escalation, or ask-before-break decision
- confidence level with a short basis

## Gate

No agent may guess through insufficient evidence for locked contracts, schema, externally visible behavior, or completion status.

## Trigger Conditions

Escalate when any of these apply:

- a required artifact is missing, ambiguous, or stale
- spec, code, tests, schema, or standards conflict
- the touched family's local pattern cannot be identified from inspected anchors
- a durable-data change was proposed or reviewed without checking the touched entries in `docs/sdd/context/schema_database.yaml`
- the touched family is mixed and fewer than two sibling anchors were inspected, so the claimed local convention cannot be defended
- affected consumers of a contract or schema change are unknown
- completion cannot be proven from `AC-`, `TC-`, review, and required artifact evidence
- a proposed change may break contract, schema, or externally visible behavior and approval is not explicit

## Severity Of Uncertainty

- `low`: minor evidence gap; continue evidence gathering only, no risky edits
- `medium`: important gap or inconsistency; narrow scope and record the issue before continuing
- `high`: safe implementation or review is blocked; stop work on the affected area and escalate
- `critical`: possible breaking contract, schema, security, or externally visible behavior change without explicit approval; ask before break and do not proceed on that surface

## Ask-Before-Break Policy

If a proposed change may alter any of these and no approved artifact explicitly authorizes it, the agent must ask or raise a blocker before editing:

- HTTP routes, request or response shape, DTO fields, or response keys
- file format, export shape, import shape, or durable data semantics
- database schema, table shape, or migration behavior
- externally visible validation, auth, tenant, or user-facing behavior

Rules:

- silence is not approval
- inferred compatibility is not approval
- review must fail unapproved breaking changes even if the code compiles

## Confidence Reporting

Use `high`, `medium`, or `low` only with evidence:

- `high`: approved artifacts, code evidence, and verification all align
- `medium`: artifacts and code mostly align, but there are limited or manual-only gaps
- `low`: key evidence is missing, conflicting, or unverified

Confidence rules:

- confidence does not override a blocker
- low confidence cannot be used to close a task
- medium confidence requires explicit residual-risk or gap notes

## Recording Rules

- record unresolved uncertainty in `11-implementation-report.md`, `12-review-report.md`, or both, depending on stage
- record ask-before-break blockers in the governing feature package when they affect approved scope or contract ownership
- record completion uncertainty in the done checklist instead of claiming the task is complete
