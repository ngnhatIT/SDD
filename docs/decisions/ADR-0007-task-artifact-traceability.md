# ADR-0007 Task Artifact Traceability

- Status: accepted
- Date: 2026-03-23
- Owners: repository maintainers

## Context

Lean SDD v2 made `verification.md` the active closeout record and removed the larger SDD v1 artifact stack.

That simplification worked for change-making tasks, but it left `review` and `audit` with active contracts that could end in chat-only output. The repository now wants every governed task type to leave a durable Markdown trace in the repo without restoring the archived numbered workflow.

## Decision

The repository refines the v2 model with these rules:

1. `verification.md` remains the required closeout and validation record for `implement`, `fix`, `docs`, and `hotfix`.
2. `review` must create or update `docs/spec-packs/<feature-id>/review.md`.
3. `audit` must create or update `docs/spec-packs/<feature-id>/audit.md`.
4. If a governed task does not already have a feature-pack home for its required artifact, create or identify one before closeout instead of inventing a new top-level docs surface.
5. This decision refines ADR-0006 item 3; it does not restore the archived SDD v1 numbered artifact stack.

## Consequences

- every active task type now has a durable Markdown artifact
- `review` and `audit` can no longer close only in chat
- `verification.md` stays focused on change-making closeout instead of becoming a generic transcript or worklog
- the active docs surface remains under the existing `spec-packs/`, `governance/`, `execution/`, `standards/`, `templates/`, `checklists/`, and `decisions/` folders
