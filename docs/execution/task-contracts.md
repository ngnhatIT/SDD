# Task Contracts

## Implement

- input: `spec_pack.md`, relevant standards, `reinforcement.md` for non-trivial work
- output: code or docs changes, updated `verification.md`, explicit acceptance coverage
- stop if the pack does not authorize the visible change

## Fix

- input: grounded defect or review finding, relevant feature pack when behavior is governed, relevant standards
- output: scoped repair, updated `verification.md`, explicit note of what was not changed
- stop if the fix would widen scope beyond the grounded problem

## Review

- input: feature pack, diff or code target, relevant standards
- output: updated `review.md` with findings first, then open questions or residual risks
- stop if intent cannot be grounded from the active pack or code

## Docs

- input: affected active docs and any framework pack that governs the change
- output: coherent doc updates plus updated `verification.md`
- stop if the docs would create a second authority path

## Audit

- input: target scope, active rules, inspected evidence, and a governed feature-pack home before closeout
- output: updated `audit.md` with grounded report only
- stop if the user has implicitly asked for implementation and the task is blocked on a missing pack

## Hotfix

- input: compact feature pack, reinforcement, relevant standards, incident or urgent request
- output: narrow safe remediation, updated `verification.md`, and explicit follow-up if anything was deferred
- stop if urgency is being used to bypass contract clarity

## Artifact Rule

- the main task output must be recorded in the matching Markdown artifact, not only in chat
- use `verification.md` for `implement`, `fix`, `docs`, and `hotfix`
- use `review.md` for `review`
- use `audit.md` for `audit`

## Checklist Use

- use `docs/checklists/spec-pack-quality.md` when authoring or materially updating `spec_pack.md`
- use `docs/checklists/reinforcement-gate.md` when writing or refreshing `reinforcement.md` for non-trivial work before implementation or review relies on it
- use `docs/checklists/verification-closeout.md` when updating `verification.md` before final closeout
