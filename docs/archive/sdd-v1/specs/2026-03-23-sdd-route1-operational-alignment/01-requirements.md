---
id: "2026-03-23-sdd-route1-operational-alignment"
title: "SDD Route 1 operational alignment requirements"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-23"
related_specs:
  - "README.md"
  - "02-design.md"
  - "07-tasks.md"
dependencies: []
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Requirements

## Objective

Align the existing SDD framework to a Route 1-friendly operating approach that keeps a stable fixed prefix, sharply separates fixed versus variable context, reduces unnecessary reading and log noise, improves restart and handoff behavior, and strengthens Codex or Copilot repeatability without adding any parallel governance surface.

## In Scope

- fixed versus variable context guidance embedded in existing SDD layers
- minimal-reading and permission-based exploration rules
- hypothesis-first investigation guidance for Codex and Copilot
- root-cause excerpt discipline for logs and error context
- short restart or handoff summary guidance
- prompt, checklist, and report support for requirement clarification, design review, traceability review, and document refactoring

## Out Of Scope

- new top-level AI control files
- runtime code, database, API, DTO, or build behavior changes
- CI or CD automation and API cache behavior
- replacing the current SDD authority hierarchy

## Requirements

| ID | Requirement | Rationale |
| --- | --- | --- |
| `REQ-01` | `The framework MUST define the stable fixed context versus variable task context split inside the existing SDD layers, and MUST keep the stable operating prefix anchored in canonical context, governance, execution contracts, and execution profiles rather than in ad-hoc task packets.` | Route 1 behavior depends on a reusable fixed prefix and a small task packet. |
| `REQ-02` | `The framework MUST make minimal reading explicit: read only what is needed, state why a file is being opened when widening context, prefer narrow reads over broad reads, and require permission-based exploration notes for broader repo inspection.` | Lower token use and lower drift require controlled exploration. |
| `REQ-03` | `The Codex and Copilot execution profiles MUST define a hypothesis-first investigation pattern: list three likely hypotheses when debugging or investigating, verify the shortest path first, and read additional files only as needed to confirm or reject the current hypothesis.` | Repeatable debugging needs a deterministic short-path loop. |
| `REQ-04` | `The framework MUST define log discipline and long-session recovery discipline: use root-cause excerpts instead of full logs by default, strip repeated warnings or noise, and provide a short restart or handoff summary pattern that captures current objective, changed artifacts, blockers, and next grounded step.` | Context recovery and bug triage should stay compact and reusable. |
| `REQ-05` | `The prompt, checklist, and reporting layers MUST give short immediately usable support for requirement clarification, design review, traceability review, and document refactoring inside the existing SDD structure.` | The new operating model should strengthen routine SDD analysis and review work, not just implementation. |

## Constraints

- Keep `AGENTS.md`, `docs/sdd/context/`, `docs/sdd/governance.md`, `docs/sdd/execution/`, `docs/sdd/execution-profiles/`, `docs/sdd/prompts/`, `docs/sdd/checklists/`, and `docs/sdd/templates/` as the active structure.
- Do not create `CLAUDE.md`, `.claude/`, or any parallel AI-governance hierarchy.
- Do not duplicate full policy text across many files; put rules in the canonical layer and lighter echoes in profiles, prompts, or templates only when needed.
- Prefer minimal-diff edits and short operational wording.

## Non-Goals

- no generic AI framework detached from this repository
- no new task-profile tokens or authority layers
- no forced heavy blocking rules that prevent normal work when a smaller ask-first path is sufficient
