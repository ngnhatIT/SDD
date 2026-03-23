---
id: "2026-03-19-sdd-sonarqube-triage-workflow"
title: "SDD SonarQube triage workflow rollout"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-19"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Release Scope

- Environment or audience: `repository documentation users, reviewers, and AI agents`
- Dependencies: `none beyond the updated canonical docs in this branch`

## Deployment Steps

1. Merge the updated SDD framework docs and new `docs/sonar/` guidance.
2. Use the new task profiles and contracts for the next SonarQube-driven task.
3. Create the first `docs/sonar/<date>-<scope>-triage.md` artifact when Sonar triage is requested.

## Rollback Steps

1. Revert the framework-doc changes from this feature package if the workflow needs redesign.
2. Remove or archive any experimental `docs/sonar/` triage artifact created only for this framework rollout if it is not yet approved for operational use.

## Release Checks

- Confirm the canonical routing surfaces and governance files all list the new Sonar task profiles consistently.
- Confirm `docs/sonar/README.md` and the Sonar triage template are present.
- Confirm checklist, report, and done surfaces reference the triage artifact expectations.

## Post-Release Watch

- Watch for any workflow gap where Sonar-driven remediation still starts from raw scanner output instead of a validated current-code triage pass.
