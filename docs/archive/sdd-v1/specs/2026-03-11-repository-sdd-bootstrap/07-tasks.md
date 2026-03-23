# Tasks

## Delivery Plan

| Task | Description | Requirement Links | Design Links | Owner | Status |
| --- | --- | --- | --- | --- | --- |
| TASK-01 | Create the tracked docs entrypoints and SDD architecture docs | REQ-01 | DES-01 | Codex | done |
| TASK-02 | Create process docs, checklists, and templates | REQ-02, REQ-03 | DES-02, DES-03 | Codex | done |
| TASK-03 | Add governance, ADR bootstrap, changelog support, and PR template | REQ-01, REQ-03 | DES-03 | Codex | done |
| TASK-04 | Write migration notes and a live example spec package for the bootstrap itself | REQ-04 | DES-04 | Codex | done |

Status values:

- `todo`
- `in-progress`
- `blocked`
- `done`
- `deferred`

## Implementation Tasks

### TASK-01

- Objective: Establish tracked repo entrypoints and folder structure.
- Steps:
  - replace the minimal root README
  - create `docs/README.md`
  - create `docs/sdd/README.md`
  - create `docs/sdd/target-architecture.md`
- Dependencies: none
- Done when: contributors can find the delivery system from the repo root

### TASK-02

- Objective: Make the SDD flow usable immediately.
- Steps:
  - add process docs
  - add checklists
  - add templates
  - add repo-specific standards
- Dependencies: TASK-01
- Done when: a team can start a new change folder without inventing structure

### TASK-03

- Objective: Add governance and review hooks.
- Steps:
  - add governance rules
  - add ADR bootstrap
  - add changelog
  - add PR template
- Dependencies: TASK-01
- Done when: review expectations and documentation rules are explicit

### TASK-04

- Objective: Preserve traceability for the bootstrap work itself.
- Steps:
  - create migration notes
  - create a real spec folder for the bootstrap change
  - link the changelog and ADR to the bootstrap artifacts
- Dependencies: TASK-01, TASK-02, TASK-03
- Done when: the new system contains a working example and migration guidance

## Verification Tasks

### TASK-90

- Objective: Review the documentation set for consistency.
- Evidence expected: matching folder names, cross-links, stage order, and terminology

## Release Tasks

### TASK-99

- Objective: Mark the bootstrap complete and communicate the adoption path.
- Notes: done through changelog, ADR, README, and migration notes
