# SonarQube Working Artifacts

Use this folder for canonical SonarQube triage artifacts created by the SDD workflow.

## Canonical Artifact

- `docs/sonar/<date>-<scope>-triage.md`

Use `docs/sdd/templates/sonar-triage-report.md` as the required structure.

## When To Create Or Update

- create the artifact when `Task Profile: sonar-triage` or `Task Profile: sonar-triage-and-fix` starts
- update the same artifact when `Task Profile: sonar-fix-from-triage` applies approved remediation later
- update the artifact whenever issue classification, decision status, fixed-item status, or follow-up notes change

## Required Contents

- request scope, source, reviewer, and date
- summary counts by classification
- per-issue fields for finding details, current-code validation, classification, decision status, reason, proposed action, and risks
- `Fixed in this pass`
- `Not fixed in this pass`
- `User decision items`
- `Next actions`

## Governance Notes

- SonarQube findings are advisory inputs only.
- The triage artifact is the canonical SonarQube working artifact, but it is not a replacement for a governing feature package when non-trivial remediation still requires normal SDD approval.
- `sonar-fix-from-triage` may change code only for issues explicitly approved for the current pass and must update the artifact in the same pass.
