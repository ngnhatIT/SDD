# Execution Brief Template

Use this canonical template when one task needs a compact deterministic execution packet.

Generated briefs should use this section order exactly.

Brief substitution is allowed only under `docs/sdd/governance/minimal-sufficient-context-policy.md`. A brief may replace repeated loading of supporting docs for one task, but it never replaces `AGENTS.md`, governance, the governing feature package, or locked contract sources.

## Snapshot

- Feature: `docs/specs/<feature-id>/`
- Task Profile: `implement-new | fix-from-pack | fix-from-bug | review-from-pack | review-from-rules | sonar-triage | sonar-triage-and-fix | sonar-fix-from-triage`
- Governing Package: `always the source of truth`
- Brief Status: `<draft | refreshed>`
- Fixed Prefix Already Loaded: `<AGENTS/context/governance/contract/profile set>`

## Routing Decision

- Governance Classification: `<no-spec | reduced-path | full-path | emergency>`
- Practical Mode: `<mode>`
- Primary Prompt Or Path: `<path>`
- Primary Deliverable: `<artifact>`

## Required Inputs

- Feature: `<path or n/a>`
- Task Profile: `<value>`
- Spec Pack: `<path or n/a>`
- Backend Spec: `<path or alias or n/a>`
- Bug Source: `<path or n/a>`
- Sonar Source: `<path or n/a>`
- Triage Artifact: `<path or n/a>`
- Review Scope: `<spec | rules | spec+rules | n/a>`
- Current Request Summary: `<one short task summary>`
- Target Files Or Doc Surfaces: `<paths or n/a>`
- Focused Error, Log, Or Diff Excerpt: `<root-cause excerpt or n/a>`
- Open Blockers Or Unknowns: `<list or none>`

## Source Of Truth Files

- list the governing numbered artifacts first
- add `13-risk-log.md` and `14-decision-notes.md` when present
- add owned `contracts/` when present

## Mandatory Reads

- list canonical context and governance files
- list governing feature artifacts required for this task
- include `docs/sdd/governance/03-context-binding.md` and `docs/sdd/context/schema_database.yaml` when the task is DB-related

## DB Schema Binding

- `n/a` when the task is not DB-related
- otherwise list touched tables, columns, mapping constraints, and any schema blocker from `schema_database.yaml`

## Optional Consult

- generated spec-pack
- implementation report
- review report
- helper-only backend notes

## Related Code References

- list source-base anchors for each touched layer
- add sibling modules or shared utilities that must be inspected before write or verdict

## Locked Contracts

- list `contracts/` when owned
- otherwise name `04-api-contract.md`, `03-data-model.md`, or other locked prose contract sources

## Locked Decisions

- list relevant `DES-` decisions, ADRs, and source-base anchors

## Task Scope

- list explicit in-scope items only

## Constraints

- list prohibited scope items
- require read-before-write
- require reuse-before-create
- require conflict reporting instead of silent guessing
- require ask-before-break before contract, schema, or externally visible behavior changes without explicit approval
- require uncertainty escalation when evidence is insufficient
- preserve explicit `unknown (...)` and blocker notes
- keep issue, log, or failing-output context to the shortest root-cause excerpt that still supports the task
- broader exploration beyond the named packet requires a short `why / scope / expected result` note
- when debugging or investigating, record three likely hypotheses and verify the shortest path first

## Expected Outputs

- list implementation, review, fix, or docs outputs tied back to the governing package

## Done Criteria

- validation commands or manual verification path
- required `TC-` or review evidence
- self-review and done-check evidence when applicable
- required report or artifact updates for the selected task profile
- confidence report for the claimed completed scope

## Open Questions

- list only blockers or unresolved ambiguity that still affect safe execution
