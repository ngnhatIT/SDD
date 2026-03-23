# Task Planning

## When To Use

Use this stage after design is approved and before coding starts.

## How To Use

1. Write `07-tasks.md`.
2. Split work into delivery slices, not file lists.
3. Link each `TASK-` item to the governing requirements and design sections.
4. Separate implementation work, verification work, and release work.
5. If the feature owns `spec-pack.manifest.yaml`, include build and validate work for `docs/spec-packs/` in the task plan.
6. For non-trivial work, record pass 1 grounding and change-plan expectations before pass 2 implementation starts.
7. Include any required touched-scope modernization work that follows repository-promoted shared patterns, such as unused-import cleanup, redundant-code removal, helper or constant reuse, message normalization, base-common reuse, table-helper migration, frontend structure reuse, responsive verification, paired-field alignment checks, comment cleanup, or frontend-backend validation parity checks.
8. Mark any ask-before-break approval point or uncertainty blocker explicitly in the task order.
9. Include explicit verification work for field-level versus popup error routing, backend validation-path reuse, search or saved-condition lifecycle parity, responsive small-window behavior, and paired-field alignment when those concerns are in scope.

## Required Output

- `07-tasks.md`
- task sequencing and dependency notes
- pass 1 grounding and change-plan notes for non-trivial work
- explicit blockers for any unresolved work
- build and validation steps for contracts or spec-pack artifacts when the feature owns them

## Gate

Advance only when:

- reviewers can tell when each task is done
- verification work is visible in the plan
- repository-derived reuse, touched-scope cleanup, responsive-layout, and parity checks are visible in the task plan when those concerns are in scope
- mixed-pattern classification and any required migration work are visible in the task plan when the touched scope includes competing live patterns
- dependencies and blocked work are explicit
- `docs/sdd/checklists/04-pre-implementation-gate.md` passes
