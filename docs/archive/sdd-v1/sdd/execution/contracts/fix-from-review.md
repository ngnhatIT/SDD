# Execution Contract: Fix From Review

## Use When

Close grounded findings from a review report or equivalent approved finding source such as QA validation, bug notes, or production-incident follow-up that has been triaged into governed work.

## Required Inputs

- governing feature package
- review report or approved findings

## Required Reads

- governing feature package
- current `12-review-report.md` or approved finding source
- current implementation evidence
- relevant standards
- `docs/sdd/governance/09-documentation-update-policy.md`
- `docs/sdd/checklists/touched-scope-enforcement.md`

Add schema binding reads when DB-related scope exists.

## Optional Support

- generated spec-pack
- bug source or defect note when referenced by the finding

## Forbidden Assumptions

- treating review notes as approval to redesign scope
- declaring a finding closed without rereading the affected code and evidence

## Expected Outputs

- targeted repository fixes
- updated `11-implementation-report.md`
- updated `12-review-report.md` or equivalent finding artifact
- updated governing artifacts when the finding changes intended behavior, acceptance proof, or residual-risk understanding

## Stop Conditions

- the finding conflicts with the governing feature package
- closing the finding would alter a locked contract or visible behavior without approval
- the review report is too vague to ground a safe fix
