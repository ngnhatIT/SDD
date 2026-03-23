# Execution Contract: Generate Execution Brief

## Use When

One task needs a compact deterministic reading packet for a known task profile.

## Required Inputs

- governing feature package
- selected task profile

## Required Reads

- `docs/sdd/execution/task-routing.md`
- governing feature package
- owned `contracts/` when present
- selected execution contract
- `docs/sdd/templates/execution-brief-template.md`

Add schema binding reads when DB-related scope exists.

## Optional Support

- generated spec-pack
- backend helper notes
- implementation or review reports

## Forbidden Assumptions

- using the brief as a second approval artifact
- omitting blockers, unknowns, or locked decisions to make the brief shorter

## Expected Outputs

- refreshed `docs/spec-packs/<feature-id>.<task-profile>.brief.md`

## Stop Conditions

- required inputs for the selected task profile are missing
- the governing package is incomplete
- the brief would need invented constraints or reads
