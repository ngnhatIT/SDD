# Execution Contract: Implement Feature Or Governed Fix

## Use When

Implement approved governed behavior or a governed fix.

## Required Inputs

- governing feature package
- optional spec-pack

## Required Reads

- governing feature package
- `07-tasks.md`, `08-acceptance-criteria.md`, `09-test-cases.md`
- owned `contracts/` when present
- relevant standards for touched layers
- `docs/sdd/checklists/touched-scope-enforcement.md`
- `docs/sdd/process/05-self-review.md`

Add schema binding reads when DB-related scope exists.

## Optional Support

- generated spec-pack
- current implementation report
- backend helper notes

## Forbidden Assumptions

- implementing from prompt wording instead of the governing package
- widening into redesign without approved scope
- preserving weaker local duplicates when the touched scope already supports the promoted shared path

## Expected Outputs

- repository changes
- updated governed artifacts when behavior or evidence changed
- updated `11-implementation-report.md`

## Stop Conditions

- feature package is incomplete for the claimed scope
- anchors or shared patterns cannot be grounded
- approval is missing for a visible contract or behavior change
