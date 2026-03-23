# Implementation Traceability Rules

## When To Use

Use this rule during implementation, review, and PR preparation.

## How To Use

Link code, PR text, and implementation notes back to the governing feature package.

## Required Output

- PR text that names the governing feature package
- a visible `REQ -> DES -> TASK -> AC -> TC` chain in the feature package
- task, requirement, design, acceptance, or test IDs tied to the implementation
- implementation notes that identify delivered tasks

## Gate

If a reviewer cannot map a code change back to the feature package, traceability is incomplete.

## Required Traceability

- the feature package must make the minimum `REQ -> DES -> TASK -> AC -> TC` chain visible before code refs are attached
- code changes must map to `REQ-`, `DES-`, `TASK-`, `AC-`, or `TC-` items
- the feature `README.md` must contain the traceability summary or links to it
- `11-implementation-report.md` must list approved artifacts used, code references inspected, interfaces reused, new code introduced, delivered tasks, tests updated, conflicts detected, and implementation refs
- `11-implementation-report.md` must also record the anchor-family conventions that were preserved for DTO shape, transport path, import boundaries, comment style, and other local constraints when those factors affected the change
- `11-implementation-report.md` must record pass 1 grounding for non-trivial work, self-review status, uncertainty notes, and confidence for the claimed completed scope
- when SonarQube or static-analysis findings drive the change, `11-implementation-report.md` must cite the finding source, triage artifact path, affected issue IDs, and decision-status updates
- each new externally visible change must name the approving spec or contract artifact instead of relying on prompt wording or AI inference
- if implementation relies on an existing pattern, the implementation notes must cite the inspected anchor or sibling files
- when SQL or HTML style parity matters, implementation notes should identify the anchor files used for the comparison

## PR Minimum

Every non-trivial PR must state:

- governing feature folder
- affected spec files
- completed `TASK-` IDs
- affected `AC-` and `TC-` IDs
- triage artifact path and issue IDs when SonarQube or static-analysis findings drove the change
- related ADRs when applicable

## Code Comment Rule

Use spec IDs in code comments only when the logic is non-obvious or high-risk.
