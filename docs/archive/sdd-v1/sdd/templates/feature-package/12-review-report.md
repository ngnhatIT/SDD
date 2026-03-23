---
id: "<feature-id>"
title: "<feature title> review report"
owner: "<reviewer>"
status: "not-started"
last_updated: "YYYY-MM-DD"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "11-implementation-report.md"
dependencies:
  - "11-implementation-report.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Review Report

Canonical numbered template for `12-review-report.md`.

Create this file when formal review starts.

## Review Basis

- Task profile: `<review-from-pack or review-from-rules>`
- Review scope: `<spec | rules | spec+rules>`
- Review target: `<PR, files, package, or branch>`
- Governing artifacts: `<feature path or governance rule>`
- Supporting inputs: `<artifacts used>`
- Triage artifact: `<path or n/a>`
- Standards or checklists used: `<files>`
- Automation note: `<[NO-AUTOMATED-TESTS] or n/a>`

## Static-Analysis Finding Validation

| Source | Current Code Status | Triage Artifact | Result | Follow-Up |
| --- | --- | --- | --- | --- |
| `<Sonar source or n/a>` | `<validated or n/a>` | `<path or n/a>` | `<pass or fail or n/a>` | `<note>` |

## Focused Issue Or Log Excerpts

Use root-cause excerpts only. Do not paste full logs unless the longer output is required to defend the review finding or blocker.

| Source | Excerpt | Why Relevant | Noise Removed |
| --- | --- | --- | --- |
| `<log, diff, error, or n/a>` | `<excerpt or n/a>` | `<reason>` | `<yes/no/n/a>` |

## Findings By Severity

| Severity | ID | Summary | Spec Or Rule Link | Evidence | Required Fix |
| --- | --- | --- | --- | --- | --- |
| `<critical or high or medium or low>` | `<F-01>` | `<finding>` | `<path or ID>` | `<evidence>` | `<fix or follow-up>` |

If there are no findings, state `No blocking findings.` and still complete the checks below.

## Hallucination And Unsupported-Assumption Check

- Unsupported assumptions:
  - `<assumption or none>`
- Confirmed hallucination findings:
  - `<finding or none>`
- Unsupported claims disproved by evidence:
  - `<note or none>`

## Contract Drift Check

| Surface | Expected | Observed | Result | Follow-Up |
| --- | --- | --- | --- | --- |
| `<API, DTO, file, schema, or n/a>` | `<expected>` | `<observed>` | `<pass or fail or n/a>` | `<note>` |

## Traceability Check

| Trace Target | Evidence | Result | Notes |
| --- | --- | --- | --- |
| `REQ -> DES -> TASK -> AC -> TC` | `<evidence>` | `<pass or fail or partial>` | `<note>` |
| `implementation -> review artifacts` | `<evidence>` | `<pass or fail or partial>` | `<note>` |

## Test Evidence Check

| Area | Evidence Reviewed | Result | Gap Or Follow-Up |
| --- | --- | --- | --- |
| `<tests or manual path>` | `<evidence>` | `<pass or fail or partial>` | `<note>` |

## Repository-Derived Standards Check

| Check | Result | Evidence | Follow-Up |
| --- | --- | --- | --- |
| `SQL formatting aligned` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Unused imports removed` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Formatting aligned` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Redundant code removed` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Mixed-pattern classification recorded` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Sonar findings validated against current code` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Non-fixed Sonar items classified and recorded` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Only approved triage items changed` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Backend validation path reused` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Null or empty helper reused` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Empty-string constant reused` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Magic strings reduced` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Messages normalized` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Frontend structure aligned` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Frontend base-common reuse checked` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Field-level vs popup routing checked` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Responsive layout checked` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Paired-field alignment checked` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Shared table-helper reuse checked` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Search lifecycle parity checked` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Frontend-backend validation parity checked` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |
| `Comments English-only and minimal` | `<pass or fail or n/a>` | `<evidence>` | `<note>` |

## Observed Facts

- `<fact 1>`

## Residual Risks

- `<risk 1>`

## Verdict

- Status: `<pass | pass with notes | fail>`
- Merge or release recommendation: `<recommendation>`
- Required fixes: `<list or none>`
- Follow-ups: `<list or none>`
- Confidence: `<high | medium | low>`
- Basis: `<why>`
