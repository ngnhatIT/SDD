# Spec-Pack Template

Use this canonical template when generating or reviewing a feature-wide spec-pack under `docs/spec-packs/`.

The pack is an execution aid only. The governing feature package remains the approval source of truth.

Generated packs should use this section order exactly.

## Snapshot

- Feature: `docs/specs/<feature-id>/`
- Output Pack: `docs/spec-packs/<feature-id>.pack.md`
- Source Package Status: `<draft | approved | in review>`
- Manifest: `<path or n/a>`
- Note: `execution aid only; governing feature package remains authoritative`

## Input Traceability

- list every source file used to build the pack
- group by canonical source, helper-only source, and generated source
- if a required source is missing, record it here and keep the gap explicit in later sections

## Source Of Truth Files

- list the governing numbered artifacts first
- list owned `contracts/` when present
- list `13-risk-log.md` and `14-decision-notes.md` when present
- list approved ADRs only when they affect execution

## Required Reads

- list the canonical context and governance files the downstream operator must load
- include `docs/sdd/governance/03-context-binding.md` and `docs/sdd/context/schema_database.yaml` when the feature owns DB-related scope
- do not list generated aids here as substitutes for canonical docs

## Related Code References

- list source-base anchor files for each touched layer
- add sibling module references that must be inspected before write
- do not claim a reusable pattern without file references

## Locked Contracts And Schema

- list owned machine-readable contracts when they exist
- otherwise name the prose contract files that remain locked
- for DB-related scope, list the schema-bound tables, columns, and mapping constraints taken from `schema_database.yaml`
- state that external shapes stay locked unless an approved artifact authorizes the change

## Scope Guardrails

- In Scope: `<approved scope list>`
- Out Of Scope: `<explicit exclusions>`
- Non-Changes: `<locked non-change boundaries>`
- Compatibility Notes: `<backward-compatibility or additive-only notes>`

## Requirements Snapshot

- preserve requirement intent
- do not compress away business rules, validation rules, or parity requirements

## Design Snapshot

- preserve design decisions, source-base anchors, and execution-critical constraints
- preserve any approved `preferred current`, `tolerated legacy`, or `required migration` classifications

## Data And Contract Notes

- summarize data-model and interface shape rules only from approved sources
- keep unknown or missing ownership explicit

## Behavior And Edge Cases

- preserve user-visible behavior, edge-case routing, failure handling, and non-changes
- do not infer silent defaults from missing detail

## Task / Acceptance / Test Snapshot

- summarize the implementation tasks that matter for execution
- summarize the acceptance criteria that must be proven
- summarize the test cases or manual verification path without claiming coverage that does not exist

## Execution Constraints

- require read-before-write
- require reuse-before-create
- require conflict reporting instead of silent guessing
- require ask-before-break before contract, schema, or externally visible behavior changes without explicit approval
- preserve explicit `unknown (...)`, blocker, and non-change notes

## Assumptions

- list only assumptions explicitly supported by source material
- if an item is not supported, move it to `Unknowns And Blockers`

## Unknowns And Blockers

- list unresolved questions, missing artifacts, conflicts, and schema or contract gaps
- do not convert blockers into inferred answers

## Open Questions

- list only unresolved questions that still affect safe downstream execution
