# Prompt: Review Governed Change

Use this prompt only after routing is already known.

## Canonical Backing Sources

- `docs/sdd/execution/contracts/review-feature.md`
- `docs/sdd/execution-profiles/<current-agent>.md`

## Primary Output

- findings-first review plus governed review evidence when required

## Short Support Uses

- design review against `01-requirements.md` and `02-design.md`
- traceability review against `REQ -> DES -> TASK -> AC -> TC`
- SDD review when the target is an existing framework or docs change and the governing basis is already known

## Keep The Variable Packet Small

- review target
- governing artifacts
- focused evidence or log excerpt when one matters
- explicit review scope

Do not fix code in the review step.
