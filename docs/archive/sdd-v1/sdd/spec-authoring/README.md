# Spec Authoring

Use this layer when governed work must be created or updated from raw design inputs.

## Minimum Required Input

At least one of these must exist:

- ticket or feature request
- bug description
- spreadsheet or xlsx
- design note
- bilingual business note
- approved human request in tracked text
- approved Sonar triage artifact

The input set must also provide:

- intended outcome or defect statement
- affected surface or explicit unknown
- enough evidence to classify `reduced-path` vs `full-path`, or an explicit blocker

## Workflow

1. collect raw inputs
2. normalize raw inputs into facts, open questions, non-changes, and approval gaps
3. classify the change path
4. create or update `docs/specs/<feature-id>/`
5. fill required numbered files before implementation or governed review starts
6. run `docs/sdd/checklists/spec-authoring-checklist.md`
7. only then hand off to implementation, review, or pack generation

## Mandatory Outputs

- `README.md`
- `01-requirements.md`
- `02-design.md`
- `07-tasks.md`
- `08-acceptance-criteria.md`
- `09-test-cases.md`
- `10-rollout.md`
- `changelog.md`

Add conditional files only when the change really needs them.

## Review Rules

- do not promote unnormalized raw notes directly into approved behavior
- do not treat a Sonar triage artifact as a replacement for a governing feature package when the resulting remediation is still non-trivial
- record open questions instead of burying them in prose
- keep traceability visible from `REQ -> DES -> TASK -> AC -> TC`
- run schema binding before authoring DB-related requirements or design

## Stop Rules

- input quality is too weak to classify the change safely
- the affected surface cannot be identified
- approval is missing for a contract, schema, or visible behavior change
