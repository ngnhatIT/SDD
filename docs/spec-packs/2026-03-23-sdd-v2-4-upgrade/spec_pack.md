# Spec Pack: 2026-03-23-sdd-v2-4-upgrade - Lean SDD v2.4 Operational Hardening

- Status: implemented
- Owner: repository maintainers
- Last Updated: 2026-03-23

## 1. Context

- the active SDD v2 line is lean, but several key controls still depend on documentation discipline only
- root `README.md` is referenced as an active entrypoint in the repo history and active packs, but the file is missing
- reinforcement classification is directionally correct but still slow to apply in borderline cases
- review and audit artifacts exist, but their templates are still too thin for consistent operator use
- the repo lacks a short operator prompt layer and an explicit structure contract

## 2. Scope

### In Scope

- add a minimal task-artifact validator under `scripts/`
- fix the active entrypoint story, including the root `README.md` decision
- tighten active governance, execution, and checklist docs where they overlap with validator or structure rules
- add lean operator prompts, structure contract, and failure-mode guidance
- strengthen review and audit templates without expanding the framework surface

### Out Of Scope

- restoring the archived SDD v1 validator suite or numbered package model
- adding CI, bots, or mandatory automation beyond a local validator command
- redesigning the framework away from the current lean `spec_pack.md` / `reinforcement.md` / task-artifact model

## 3. Functional Requirements

### FR-01 Minimal Enforcement

- the repo must ship a simple validator that checks required task artifacts from a task folder path and task type
- validator failures must be explicit and exit non-zero

### FR-02 Real Entrypoints Only

- every active doc must point only to entrypoints that exist
- if root `README.md` is kept, it must be short and route to `AGENTS.md` and the active docs surface

### FR-03 Fast Reinforcement Decisions

- active governance must include a compact decision table for reinforcement-required vs reinforcement-not-required cases

### FR-04 Operational Review And Audit Artifacts

- review template must require scope reviewed, files inspected, and assumptions or uncertainties
- audit template must state that no code was modified and record compliance status as `pass`, `fail`, or `partial`

### FR-05 Operator Prompt Surface

- operators must have short prompt stubs for implementation, review, audit, and spec-pack authoring

### FR-06 Frozen Structure Contract

- the expected `docs/spec-packs/<feature-id>/` layout must be explicit
- required vs optional task artifacts must be stated in one place and aligned with the validator surface

### FR-07 Failure-Mode Guidance

- common workflow failures must have compact symptom, detection, and corrective-action guidance

### FR-08 Tighter AI Loading Guidance

- `docs/execution/ai-loading-order.md` must define `minimal`, `extended`, and `full`
- task type and complexity must map cleanly to those load levels without expanding the read path unnecessarily

### FR-09 Lean Preservation

- the upgrade must stay inside the existing active folders and tone
- new docs must reduce ambiguity without recreating the archived v1 process weight

## 4. Technical Shape

### Source Anchors

- authority root: `AGENTS.md`
- docs entrypoint: `docs/README.md`
- task routing and contracts: `docs/execution/`
- governance: `docs/governance/`
- artifact contract: `docs/spec-packs/README.md`
- templates: `docs/templates/`
- scripts: `scripts/`
- archived validator reference only: `scripts/archive/sdd-v1/`

### Planned Shape

- create `README.md`
- create `scripts/validate-task.py`
- create `docs/structure.md`
- create `docs/operator/quick-start-prompts.md`
- create `docs/governance/failure-modes.md`
- update only the active governance, execution, checklist, template, and entrypoint docs needed to keep the contract consistent

## 5. Decisions And Constraints

- preserve repo-native task types in active routing; use aliases only where they reduce operator friction without changing workflow authority
- keep the validator intentionally small; it is an artifact-presence gate, not a replacement for the full governance rules
- do not introduce CI or background automation as part of this upgrade
- root `README.md` may exist only as a short router; `AGENTS.md` remains the root execution contract
- use archived v1 validation scripts for comparison only; do not restore their heavier rule surface

## 6. Execution Slices

| Slice | Goal | Main files or modules | Verification target |
| --- | --- | --- | --- |
| S1 | govern the 2.4 upgrade itself | `docs/spec-packs/2026-03-23-sdd-v2-4-upgrade/` | AC-09 |
| S2 | add minimal enforcement and structure clarity | `scripts/`, `docs/structure.md`, `docs/spec-packs/README.md`, `docs/checklists/` | AC-01, AC-06 |
| S3 | tighten entrypoints and operator guidance | `README.md`, `docs/README.md`, `docs/operator/`, `docs/execution/` | AC-02, AC-05, AC-08 |
| S4 | tighten governance and templates | `docs/governance/`, `docs/templates/`, `AGENTS.md` | AC-03, AC-04, AC-07, AC-09 |

## 7. Acceptance Criteria

### AC-01 Validator Exists And Works

- `scripts/validate-task.py` exists
- it accepts task folder path and task type
- it fails with clear messages for missing required files and exits non-zero

### AC-02 Entrypoints Are Real And Consistent

- root `README.md` exists and is short
- active docs no longer imply a missing root entrypoint

### AC-03 Reinforcement Decision Is Fast

- `docs/governance/core-rules.md` includes a compact reinforcement decision table with required and not-required examples

### AC-04 Review And Audit Templates Are More Operational

- review template includes scope reviewed, files inspected, and assumptions or uncertainties
- audit template includes explicit `no code modified` and compliance status

### AC-05 Operators Have Ready Prompts

- `docs/operator/quick-start-prompts.md` exists
- it includes short prompts for implement, review, audit, and spec-pack authoring

### AC-06 Structure Contract Is Explicit

- `docs/structure.md` exists
- it defines the task folder layout, one-task-one-folder expectation, and required vs optional artifacts

### AC-07 Failure Modes Are Documented

- `docs/governance/failure-modes.md` exists
- each listed failure mode has symptom, detection, and corrective action

### AC-08 AI Loading Guidance Uses Load Levels

- `docs/execution/ai-loading-order.md` defines `minimal`, `extended`, and `full`
- task types and complexity map to those levels with token efficiency called out explicitly

### AC-09 Active Docs Stay Lean And Aligned

- `AGENTS.md`, `docs/README.md`, `docs/execution/`, `docs/governance/`, `docs/templates/`, `docs/operator/`, `docs/structure.md`, and `docs/spec-packs/README.md` do not conflict on artifact or entrypoint rules

## 8. Required Context

- `AGENTS.md`
- this feature pack
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/execution/task-contracts.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/spec-packs/README.md`
- `docs/templates/review.template.md`
- `docs/templates/audit.template.md`
- archived validator docs only when a comparison is needed

## 9. Open Issues / Stop Points

- stop if the validator contract and the documented structure contract diverge
- stop if root `README.md` starts duplicating `docs/README.md` as a second policy hub
- stop if any active edit reopens archived paths as current authority
- stop if the upgrade requires CI or a heavier rule engine to satisfy the requested goals
