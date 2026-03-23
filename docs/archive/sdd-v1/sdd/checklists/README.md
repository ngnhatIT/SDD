# SDD Checklists

## When To Use

Use these files at stage boundaries.

## How To Use

1. Open the checklist that matches the current stage.
2. Check an item only when the evidence is visible in the feature package, code, PR, or test result.
3. Mark a condition `n/a` only when the governing spec says the artifact does not apply.

## Required Output

- a pass or fail result for the stage
- a list of missing artifacts or unresolved items when the stage fails

## Gate

The stage does not advance until all applicable items are checked.

## Checklist Order

1. `01-feature-intake.md`
2. `02-requirements-review.md`
3. `03-design-review.md`
4. `spec-authoring-checklist.md`
5. `04-pre-implementation-gate.md`
6. `touched-scope-enforcement.md`
7. `05-implementation-completion.md`
8. `self-review-checklist.md`
9. `06-code-review-against-spec.md`
10. `07-qa-validation.md`
11. `08-release-readiness.md`
12. `done-checklist.md`
13. `09-post-release-review.md`
