# Execution Contract: Create Or Update Spec

## Use When

Create or update a governed feature package from a request, ticket, bug, spreadsheet, design note, bilingual note, or existing package change.

## Required Inputs

- at least one raw source or approved request
- approved Sonar triage artifact when later remediation is being authored from prior triage
- target feature id or folder when updating
- affected surface or explicit unknown

## Required Reads

- `docs/sdd/spec-authoring/README.md`
- `docs/sdd/spec-authoring/raw-input-normalization.md`
- `docs/specs/README.md`
- `docs/sdd/checklists/spec-authoring-checklist.md`
- `docs/sdd/governance.md`
- `docs/sdd/governance/01-when-a-spec-is-required.md`
- `docs/sdd/governance/minimal-sufficient-context-policy.md`

Add schema binding reads when DB-related scope exists.

## Optional Support

- existing governing feature package
- approved ADRs
- examples or fixtures only when they clarify format rather than authority

## Forbidden Assumptions

- inventing hidden business rules, contracts, schema, or validation
- treating raw notes as approved behavior without normalization
- copying example-feature content as if it were approval
- treating a triage artifact as a direct replacement for normal approval when the resulting remediation is non-trivial

## Expected Outputs

- updated numbered feature-package files under `docs/specs/<feature-id>/`
- updated owned contracts only when the feature owns interface shape
- explicit open questions, non-changes, and blockers

## Stop Conditions

- raw inputs do not support reduced-path vs full-path classification
- affected surfaces cannot be identified
- source materials conflict and approval is unclear
- DB-related scope exists and schema binding is missing or conflicting
