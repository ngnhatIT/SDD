# Spec Pack: 2026-03-23-task-artifact-traceability - Task Artifact Traceability

- Status: approved
- Owner: repository maintainers
- Last Updated: 2026-03-23

## 1. Context

- Active SDD v2 intentionally reduced the feature artifact surface to `spec_pack.md`, `reinforcement.md`, and `verification.md`.
- That lean shape left a gap for `review` and `audit` tasks because their current contract allows findings-only output in chat without a durable Markdown artifact in the repository.
- The repository now wants every governed task type to leave a Markdown trace in the active feature folder without restoring the heavier SDD v1 artifact stack.

## 2. Scope

### In Scope

- define task-to-artifact mapping for all active task types
- require durable Markdown output for `review` and `audit`
- preserve `verification.md` as the main closeout record for change-making tasks
- update active routing, governance, read-path, and template docs to reflect the new trace model
- add active templates for any newly required artifacts

### Out Of Scope

- restoring numbered SDD v1 feature-package artifacts
- storing raw shell transcripts, per-command logs, or chat copies in the repository
- changing application runtime behavior

## 3. Functional Requirements

### FR-01 Every Task Type Has A Markdown Trace

- each active task type must map to at least one required Markdown artifact in active docs
- the required artifact path must be predictable from the task type
- if a governed task does not already have a feature-pack home, active docs must require creating or identifying one before closeout

### FR-02 Change-Making Tasks Keep Verification

- `implement`, `fix`, `docs`, and `hotfix` continue to use `verification.md` as the required closeout record
- active docs must not imply that those tasks can close without updating `verification.md`

### FR-03 Review Tasks Create Review Artifact

- `review` must create or update `docs/spec-packs/<feature-id>/review.md`
- `review.md` must capture findings first, then assumptions or uncertainties and residual risks

### FR-04 Audit Tasks Create Audit Artifact

- `audit` must create or update `docs/spec-packs/<feature-id>/audit.md`
- `audit.md` must capture a grounded inspected report without implying implementation

### FR-05 Read Path And Templates Stay Usable

- active read-order, routing, and done-definition docs must point to the correct task artifact for resume or closeout
- templates must exist for any newly required active artifact

### FR-06 Lean V2 Shape Is Preserved

- the change must add only the minimum artifact surface needed for durable task traceability
- active docs must not reintroduce the archived SDD v1 numbered artifact workflow

## 4. Technical Shape

### Source Anchors

- entrypoints: `AGENTS.md`, `docs/README.md`, `docs/spec-packs/README.md`
- execution rules: `docs/execution/ai-loading-order.md`, `docs/execution/task-routing.md`, `docs/execution/task-contracts.md`
- governance rules: `docs/governance/core-rules.md`, `docs/governance/minimal-context.md`, `docs/governance/done-definition.md`
- templates: `docs/templates/`
- decisions: `docs/decisions/`

### Planned Shape

- add `docs/templates/review.template.md`
- add `docs/templates/audit.template.md`
- update active docs so `review.md` and `audit.md` are named as conditional feature-pack artifacts
- keep `verification.md` as the required artifact for change-making tasks rather than replacing it with a generic worklog

## 5. Decisions And Constraints

- interpret "everything should leave a markdown trace" as "every governed task type leaves a task-level Markdown artifact", not "every intermediate step or command is logged"
- keep `verification.md` as the canonical change closeout record for tasks that modify code or docs
- use `review.md` and `audit.md` only when those task types are the main governed output
- when a review or audit task starts without an existing governed feature folder, create a compact feature-pack home before closeout instead of inventing a new top-level docs surface
- avoid duplicating the same evidence across multiple active files unless the task genuinely needs separate review or audit output

## 6. Execution Slices

| Slice | Goal | Main files or modules | Verification target |
| --- | --- | --- | --- |
| S1 | define the traceability rule | `AGENTS.md`, `docs/README.md`, `docs/spec-packs/README.md`, `docs/governance/`, `docs/execution/` | AC-01, AC-02, AC-03 |
| S2 | provide active artifact templates | `docs/templates/` | AC-04 |
| S3 | align repository-level decisions and closeout | `docs/decisions/`, this feature pack | AC-05, AC-06 |

## 7. Acceptance Criteria

### AC-01 Task Routing Names A Markdown Artifact For Every Task Type

- `docs/execution/task-routing.md` and `docs/execution/task-contracts.md` map each active task type to a Markdown output file
- `review` and `audit` no longer end with chat-only outputs in active docs

### AC-02 Governance And Read Path Recognize Task-Specific Artifacts

- active governance and AI loading docs name the correct artifact for resume, review, and closeout flows
- no active governance rule still implies that `verification.md` is the only required artifact for every task type

### AC-03 Feature-Pack Layout Documents Conditional Trace Files

- `docs/spec-packs/README.md` and `docs/README.md` explain when `review.md` and `audit.md` are used
- the documented layout remains lean and does not restore archived numbered artifacts

### AC-04 Templates Exist For Newly Required Artifacts

- active templates exist for `review.md` and `audit.md`
- the templates reflect the task contracts rather than archived v1 structure

### AC-05 Repository-Level Decision Record Is Aligned

- an active decision record explains why task-level Markdown traceability was added without restoring v1 artifact sprawl
- active docs and the decision record do not conflict

### AC-06 Verification Covers The Framework Change

- this feature folder has `spec_pack.md`, `reinforcement.md`, `verification.md`, and `decisions.md`
- `verification.md` maps evidence back to these acceptance criteria

## 8. Required Context

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/execution/task-contracts.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/governance/done-definition.md`
- `docs/checklists/spec-pack-quality.md`
- `docs/checklists/reinforcement-gate.md`
- `docs/checklists/verification-closeout.md`
- `docs/archive/sdd-v1/sdd/templates/feature-package/12-review-report.md` only for legacy comparison

## 9. Open Issues / Stop Points

- stop if any active rule still leaves a governed task type without a durable Markdown artifact
- stop if the change accidentally restores archived numbered review artifacts or parallel authority paths
- stop if active docs and decision records disagree on whether `verification.md` remains required for change-making tasks
