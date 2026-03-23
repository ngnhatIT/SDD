---
id: "2026-03-17-sdd-framework-rationalization"
title: "SDD framework rationalization design"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Design

## Overview

- Approach: audit the current documentation framework first, then apply only high-confidence clarifications in the same branch while capturing larger merge or drop moves in a grounded migration plan.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`

## Current State

- `AGENTS.md` is the root operating contract, but it also duplicates detailed standards and workflow rules that already exist in `docs/sdd/`.
- `docs/sdd/` contains canonical context, governance, process, standards, templates, prompts, and additive SDD2+ layers, but some folders overlap in role and some historical files are stale.
- `agent/` still exists as a bridge and contains complete alternative entrypoints, pipelines, rules, prompts, and standards that can conflict with canonical docs.
- Previous framework upgrade work explicitly kept SDD2+ additive, which means destructive cleanup now needs to be justified and staged carefully.

## Target State

- The framework clearly separates canonical execution path, supporting examples or history, and legacy bridge content.
- AI agents can tell what to read first by task type and when to stop on uncertainty or authority conflicts.
- Historical migration docs no longer read like active instructions.
- Legacy `agent/` entrypoints no longer present themselves as parallel source-of-truth documents.
- Follow-up merge or drop work has a grounded file-level plan and an explicit human-review boundary.

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Audit scope includes `AGENTS.md`, `docs/sdd/`, `docs/specs/README.md`, and the legacy `agent/` bridge tree; feature packages and generated spec-packs are consulted as evidence but not treated as framework inventory scope. | `REQ-01` |
| `DES-02` | The audit report will use one explicit evaluation grid per file: role clarity, canonical authority, operational value, overlap, decision support, enforceability, AI usability, and maintenance cost. | `REQ-01`, `REQ-02` |
| `DES-03` | Direct edits in this branch stay limited to authority clarification, stale-history tightening, target-structure clarification, and legacy-bridge warnings; broad file merges or removals remain planned unless operational safety is obvious. | `REQ-03`, `REQ-04` |
| `DES-04` | The migration plan will separate immediate safe changes from follow-up merges or drops that still need human confirmation because of compatibility or workflow risk. | `REQ-03`, `REQ-04` |
| `DES-05` | The cleanup will preserve current executable tooling and approval flow; no change in this branch will redefine `docs/specs/` as anything other than the governing approval source for non-trivial work. | `REQ-02`, `REQ-03` |

## Impacted Areas

- Backend: `n/a`
- Frontend: `n/a`
- Database: `n/a`
- Integrations: repository documentation entrypoints and AI usage flow
- Operations: humans and AI agents reading repository guidance

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: mirror the existing `docs/sdd/` markdown structure, explicit gates, numbered spec conventions, and cautious additive-compatibility approach already used by prior framework features.
- New tables/source families/screen structure in scope: `no`; this change updates framework documentation only.

## Non-Changes

- No runtime product behavior change
- No change to `scripts/sdd/` behavior
- No change to product API, DTO, or database contracts
- No repo-wide deletion of the `agent/` bridge without explicit follow-up confirmation
