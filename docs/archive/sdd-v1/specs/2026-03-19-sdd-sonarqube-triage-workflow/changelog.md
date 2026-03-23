---
id: "2026-03-19-sdd-sonarqube-triage-workflow-changelog"
title: "SDD SonarQube triage workflow changelog"
owner: "Codex"
status: "ready-for-review"
last_updated: "2026-03-19"
related_specs:
  - "README.md"
dependencies: []
implementation_refs: []
test_refs: []
---

# Feature Changelog

- Added a governed two-phase SonarQube triage and approved-remediation workflow to the SDD framework.
- Added canonical routing, governance, template, checklist, and artifact support for `docs/sonar/<date>-<scope>-triage.md`.
- Added guidance so approved Sonar triage artifacts can feed later governed remediation without allowing blind fixes from raw scanner output.
