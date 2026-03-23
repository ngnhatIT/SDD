# Tasks

## Delivery Plan

1. Establish the governing package and redesign target.
2. Build canonical execution contracts and agent profiles.
3. Rewire prompts, checklists, and entrypoints around the new operating stack.
4. Separate live approval packages from support packages and archived history.
5. Record evidence and verify the new path and tooling behavior.

| Task ID | Description | Requirement Links | Design Links | Verification Links | Status | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| `TASK-01` | Create the governing feature package for the multi-agent SDD operating-system upgrade and document the required target state. | `REQ-01` | `DES-01` | `TC-01` | `done` | This package is the approval source for the redesign. |
| `TASK-02` | Build the new execution layer with canonical routing and minimum execution contracts. | `REQ-02` | `DES-02`, `DES-03` | `TC-02` | `done` | Added `docs/sdd/execution/` with routing, header, and task contracts. |
| `TASK-03` | Add explicit Codex, Claude, and GitHub Copilot execution profiles and rewire prompt usage around them. | `REQ-03`, `REQ-04` | `DES-04`, `DES-07` | `TC-03` | `done` | Added `docs/sdd/execution-profiles/` and rewrote prompt files into thin adapters. |
| `TASK-04` | Upgrade spec authoring into a governed workflow with raw-input normalization and authoring review gates. | `REQ-05` | `DES-05` | `TC-04` | `done` | Added `docs/sdd/spec-authoring/`, authoring checklist, and updated `docs/specs/README.md`. |
| `TASK-05` | Convert repeated fragile rules into reusable enforcement checklists and reduce duplication across process, checklists, and prompts. | `REQ-06` | `DES-06` | `TC-05` | `done` | Added shared enforcement checklist and rewrote stage checklists around it. |
| `TASK-06` | Update canonical entrypoints, move support or historical material out of the approval tree, and keep compatibility bridges thin. | `REQ-07`, `REQ-08` | `DES-02`, `DES-07`, `DES-08` | `TC-06`, `TC-07` | `done` | Rewired entrypoints, created `docs/specs-support/`, moved history to `docs/archive/`, and updated helper scripts for the new roots. |
| `TASK-07` | Produce the upgrade report, record implementation evidence, and verify the cleaned path and tooling behavior. | `REQ-07`, `REQ-08` | `DES-08` | `TC-06`, `TC-07` | `done` | Added the upgrade report, refreshed generated aids, and recorded verification evidence. |
