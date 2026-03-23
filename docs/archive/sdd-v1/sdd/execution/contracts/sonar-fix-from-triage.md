# Execution Contract: Sonar Fix From Triage

## Use When

Apply approved remediation from an existing SonarQube triage artifact.

## Required Inputs

- `Task Profile: sonar-fix-from-triage`
- approved triage artifact (`Triage Artifact`)
- current code scope or touched files

## Required Reads

- `docs/sdd/execution/task-routing.md`
- `docs/sdd/governance.md`
- `docs/sdd/governance/11-static-analysis-triage-policy.md`
- `docs/sdd/governance/minimal-sufficient-context-policy.md`
- approved triage artifact
- current code anchors for the approved findings
- selected agent profile when relevant

Load `docs/specs/README.md`, the governing feature package, and the normal implementation contract when the remediation is non-trivial under standard governance.

## Optional Support

- current implementation report
- current review report
- generated spec-pack or execution brief

## Forbidden Assumptions

- fixing issues whose decision status is not explicitly `approved-fix`
- trusting the triage artifact without revalidating the current code
- treating `approved-later` as approval for the current pass
- closing a finding in the artifact without updating remediation notes

## Expected Outputs

- fixes for currently valid issues with `Decision status: approved-fix`
- updated triage artifact with remediation notes and `done` status where completed
- updated implementation evidence when code changes were made

## Stop Conditions

- the triage artifact is missing, stale, or does not contain explicit approval for the current pass
- current code no longer matches the approved finding
- the requested remediation would alter a locked contract or visible behavior without approval
- the work becomes non-trivial but no governing feature package exists yet
