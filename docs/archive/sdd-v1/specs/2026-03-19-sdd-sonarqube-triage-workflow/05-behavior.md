---
id: "2026-03-19-sdd-sonarqube-triage-workflow"
title: "SDD SonarQube triage workflow behavior"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Behavior

## Entry Points

- Screen, API, or process: `task-profile header`, `docs/sonar/<date>-<scope>-triage.md`, `docs/specs/` authoring path for later remediation
- Actors: `AI agent`, `reviewer`, `human approver`

## Main Flows

| Flow | Trigger | Expected Behavior | Notes |
| --- | --- | --- | --- |
| `Phase A triage only` | `Task Profile: sonar-triage` with a SonarQube finding source | Inspect each finding against current code, classify it, avoid code changes, and create or update the canonical triage artifact. | Use when the goal is classification and follow-up planning only. |
| `Phase A triage and safe fix` | `Task Profile: sonar-triage-and-fix` with a SonarQube finding source | Inspect each finding against current code, fix only findings that are still valid and clearly safe, and record every non-fixed finding in the triage artifact. | Governance classification still applies before any non-trivial code change. |
| `Phase B approved remediation` | `Task Profile: sonar-fix-from-triage` with an approved triage artifact | Read the triage artifact, revalidate the approved items against current code, fix only items explicitly approved for this pass, and update decision status in the same artifact. | Items marked `false-positive`, `stale`, `needs-business-confirmation`, `needs-technical-confirmation`, `risky-no-auto-fix`, `approved-later`, or `done` are not touched in the current remediation pass. |

## Validation And Messages

| Case | Trigger | Expected Feedback | Owner | Shared Message Or Helper Path |
| --- | --- | --- | --- | --- |
| `Finding no longer matches current code` | file, line, or message does not reproduce in the current workspace | classify the issue as `not-reproducible` or `likely-false-positive`, set a non-fix decision status, and record the reason in the triage artifact | `AI agent or reviewer` | `docs/sonar/<date>-<scope>-triage.md` |
| `Finding is valid but risky or ambiguous` | remediation could change intended behavior or needs business or technical approval | do not auto-fix; classify as `confirmed-but-risky` or `needs-human-decision` and route it to user-decision items | `AI agent or reviewer` | `docs/sonar/<date>-<scope>-triage.md` |
| `Finding is valid and safe` | remediation is confirmed and behavior-preserving | fix only in `sonar-triage-and-fix` or `sonar-fix-from-triage` when the task profile and approval status allow it | `AI agent` | `docs/sdd/governance/11-static-analysis-triage-policy.md` |
| `Comments are added or changed` | remediation introduces or rewrites comments in code or docs | comments remain English-only and minimal | `AI agent or reviewer` | `docs/sdd/governance/10-code-standards.md` |

## State And Guard Rules

- Classification and decision status are separate fields and must not be collapsed into one value.
- `sonar-fix-from-triage` may act only on issues whose decision status is explicitly `approved-fix` for the current pass.
- The triage artifact is updated in the same pass whenever a fixed issue becomes `done` or a non-fixed issue remains open.
- SonarQube scanner output alone is never proof that a finding still applies.
