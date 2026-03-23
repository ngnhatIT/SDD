# Execution Contract: Generate Spec Pack

## Use When

Generate or refresh a feature-wide execution pack without replacing the governing feature package.

## Required Inputs

- governing feature package
- output pack path

## Required Reads

- `docs/specs/README.md`
- governing feature package
- owned `contracts/` when present
- `docs/sdd/templates/spec-pack-template.md`
- `docs/sdd/governance/01-ai-agent-policy.md`
- `docs/sdd/governance/02-anti-hallucination.md`

Add schema binding reads when DB-related scope exists.

## Optional Support

- existing generated pack
- `spec-pack.manifest.yaml` when owned
- current implementation or review reports

## Forbidden Assumptions

- compressing away blockers, unknowns, or compatibility notes
- treating the pack as approval authority

## Expected Outputs

- refreshed `docs/spec-packs/<feature-id>.pack.md`

## Stop Conditions

- governing package is incomplete
- required source files conflict
- the pack would need invented constraints or schema facts
