# Decisions: 2026-03-23-task-artifact-traceability

## D-01 Task-Level Traceability, Not Transcript Logging

- context: the user wants every governed action path to leave a Markdown trace in the repository
- options considered: extend only review, add a generic worklog for all tasks, or require task-specific artifacts where gaps exist
- chosen decision: require task-specific artifacts so every active task type has a durable Markdown output while keeping `verification.md` for change-making work
- impact: `review` and `audit` gain dedicated artifacts, but `implement`, `fix`, `docs`, and `hotfix` continue to close through `verification.md`
- references: this `spec_pack.md`, `docs/execution/task-routing.md`, `docs/execution/task-contracts.md`

## D-02 Lean V2 Surface Is Preserved

- context: archived SDD v1 used a larger artifact stack, including dedicated review reports
- options considered: restore numbered artifacts or add only the smallest missing active artifacts
- chosen decision: add `review.md` and `audit.md` as conditional active files instead of restoring the archived v1 package model
- impact: active docs gain durable traceability without reopening archived numbered workflow structure
- references: `docs/archive/sdd-v1/sdd/templates/feature-package/12-review-report.md`, `docs/decisions/ADR-0006-lean-sdd-v2-model.md`
