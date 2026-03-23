---
id: "<feature-id>"
title: "<feature title> implementation report"
owner: "<team or person>"
status: "not-started"
last_updated: "YYYY-MM-DD"
related_specs:
  - "07-tasks.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
dependencies:
  - "07-tasks.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Implementation Report

Canonical numbered template for `11-implementation-report.md`.

Create this file when implementation starts.

## Implementation Scope

- Task profile: `<implement-new | fix-from-pack | fix-from-bug | sonar-triage-and-fix | sonar-fix-from-triage | docs-only | hotfix | n/a>`
- Change path: `<no-spec | reduced-path | full-path | emergency compact>`
- Scope: `<implemented scope>`
- Out of scope held: `<none or list>`
- Touched layers: `<docs | backend | frontend | SQL | contracts | mixed>`
- Source-base anchors loaded: `<paths or n/a>`

## Governing Artifacts Used

- `<artifact or none>`

## Supporting Evidence Used

- `<standard, checklist, spec-pack, execution brief, ADR, or none>`

## Focused Issue Or Log Excerpts

Use root-cause excerpts only. Do not paste full logs unless the longer output is required to explain the implemented change or blocker.

| Source | Excerpt | Why Relevant | Noise Removed |
| --- | --- | --- | --- |
| `<log, diff, error, or n/a>` | `<excerpt or n/a>` | `<reason>` | `<yes/no/n/a>` |

## Static-Analysis Or Sonar Inputs

| Source | Artifact | Issues Or Scope | Result | Notes |
| --- | --- | --- | --- | --- |
| `<Sonar source, triage artifact, or n/a>` | `<path or n/a>` | `<issue IDs or scope>` | `<used or n/a>` | `<notes>` |

## Code Areas Inspected

| Area | Why Inspected | Evidence |
| --- | --- | --- |
| `<path, module, or doc>` | `<reason>` | `<file, symbol, or note>` |

## Changes Made

| Change | Files | Traceability | Notes |
| --- | --- | --- | --- |
| `<what changed>` | `<files>` | `<TASK/AC/TC refs>` | `<notes>` |

## Contract Or Interface Impact

| Surface | Compatibility Class | Affected Consumers | Result | Evidence |
| --- | --- | --- | --- | --- |
| `<API, DTO, file, schema, or n/a>` | `<additive | behavior-tightening | breaking | internal-only | n/a>` | `<consumers or n/a>` | `<changed | unchanged>` | `<artifact>` |

## Delivered Scope Status

| Task | Status | Files | Notes |
| --- | --- | --- | --- |
| `TASK-01` | `<done or partial>` | `<files>` | `<notes>` |

## Acceptance And Test Traceability

| Acceptance | Test Case | Result | Evidence |
| --- | --- | --- | --- |
| `AC-01` | `TC-01` | `<pass or fail or partial>` | `<evidence>` |

## Validations And Tests Run

| Type | Procedure Or Command | Result | Evidence |
| --- | --- | --- | --- |
| `<manual or automated>` | `<what was run>` | `<pass or fail or partial>` | `<evidence>` |

## Repository-Derived Standards Check

| Check | Result | Evidence |
| --- | --- | --- |
| `SQL formatting aligned` | `<pass or fail or n/a>` | `<evidence>` |
| `Unused imports removed` | `<pass or fail or n/a>` | `<evidence>` |
| `Formatting aligned` | `<pass or fail or n/a>` | `<evidence>` |
| `Redundant code removed` | `<pass or fail or n/a>` | `<evidence>` |
| `Mixed-pattern classification recorded` | `<pass or fail or n/a>` | `<evidence>` |
| `Sonar findings validated against current code` | `<pass or fail or n/a>` | `<evidence>` |
| `Non-fixed Sonar items classified and recorded` | `<pass or fail or n/a>` | `<evidence>` |
| `Only approved triage items changed` | `<pass or fail or n/a>` | `<evidence>` |
| `Backend validation path reused` | `<pass or fail or n/a>` | `<evidence>` |
| `Null or empty helper reused` | `<pass or fail or n/a>` | `<evidence>` |
| `Empty-string constant reused` | `<pass or fail or n/a>` | `<evidence>` |
| `Magic strings reduced` | `<pass or fail or n/a>` | `<evidence>` |
| `Messages normalized` | `<pass or fail or n/a>` | `<evidence>` |
| `Frontend structure aligned` | `<pass or fail or n/a>` | `<evidence>` |
| `Frontend base-common reuse checked` | `<pass or fail or n/a>` | `<evidence>` |
| `Field-level vs popup routing checked` | `<pass or fail or n/a>` | `<evidence>` |
| `Responsive layout checked` | `<pass or fail or n/a>` | `<evidence>` |
| `Paired-field alignment checked` | `<pass or fail or n/a>` | `<evidence>` |
| `Shared table-helper reuse checked` | `<pass or fail or n/a>` | `<evidence>` |
| `Search lifecycle parity checked` | `<pass or fail or n/a>` | `<evidence>` |
| `Frontend-backend validation parity checked` | `<pass or fail or n/a>` | `<evidence>` |
| `Comments English-only and minimal` | `<pass or fail or n/a>` | `<evidence>` |

## Assumptions

- `<assumption or none>`

## Conflicts Found

- `<conflict or none>`

## Residual Risks

- `<risk or none>`

## Follow-Up Items

- `<follow-up or none>`

## Self-Review Summary

- Result: `<completed or blocked>`
- Blocking self-findings: `<none or list>`
- Remaining blocker: `<none or list>`

## Completion Self-Check

- Required artifacts updated: `<yes or no>`
- Done-check status: `<pass or fail or partial>`
- Blocking issues remain: `<yes or no>`

## Confidence Summary

- Confidence: `<high or medium or low>`
- Basis: `<why>`
