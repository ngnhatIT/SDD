# Execution Contract: Sonar Triage

## Use When

Run SonarQube or equivalent static-analysis triage against the current codebase, either as triage-only (`sonar-triage`) or triage plus safe remediation (`sonar-triage-and-fix`).

## Required Inputs

- `Task Profile: sonar-triage` or `Task Profile: sonar-triage-and-fix`
- Sonar finding source (`Sonar Source`)
- current code scope or touched files
- optional existing triage artifact

## Required Reads

- `docs/sdd/execution/task-routing.md`
- `docs/sdd/governance.md`
- `docs/sdd/governance/11-static-analysis-triage-policy.md`
- `docs/sdd/governance/minimal-sufficient-context-policy.md`
- selected agent profile when relevant
- `docs/sdd/templates/sonar-triage-report.md`
- existing triage artifact when one already exists
- current code anchors for each finding being triaged

Load `docs/specs/README.md`, the governing feature package, and the normal implementation contract only when the work becomes a non-trivial code change under standard governance.

## Optional Support

- generated spec-pack or execution brief
- current implementation report or review report
- pasted issue list, markdown, or export attachment

## Forbidden Assumptions

- treating the scanner output as proof that a finding still applies
- fixing every reported issue just because it appears in SonarQube
- inferring safety from the rule title alone
- skipping the triage artifact because only some findings were fixed

## Expected Outputs

- current-code validation result per finding
- classification and decision status per finding
- `docs/sonar/<date>-<scope>-triage.md`
- optional safe fixes for `confirmed-fixable` findings when the active task profile and governance path allow them
- updated implementation evidence when code changes were made

## Stop Conditions

- the finding cannot be reproduced or safely classified from current code
- the fix would change intended behavior, contract shape, schema semantics, or another governed surface without approval
- the work stops being obviously tiny but no governing feature package exists yet
- the triage artifact cannot be created or updated
