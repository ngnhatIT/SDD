# Execution Contract: Review Feature

## Use When

Run a governed review, rules-first review, or audit-style inspection.

## Required Inputs

- review target
- governing feature package when the work is governed
- optional spec-pack

## Required Reads

- governing feature package when governed
- current implementation evidence when present
- relevant standards and checklists
- `docs/sdd/checklists/touched-scope-enforcement.md`
- `docs/sdd/governance/04-review-rules.md`

Add schema binding reads when DB-related scope exists.

## Optional Support

- generated spec-pack
- current `12-review-report.md`
- implementation report

## Forbidden Assumptions

- fixing code during the review step
- treating the spec-pack as authoritative
- issuing a verdict that cannot be defended from observed evidence

## Expected Outputs

- findings-first review
- updated `12-review-report.md` when governed

## Stop Conditions

- governing evidence is missing for governed work
- code, spec, or schema conflict cannot be resolved from approved artifacts
- the review basis is too weak for a defensible verdict
