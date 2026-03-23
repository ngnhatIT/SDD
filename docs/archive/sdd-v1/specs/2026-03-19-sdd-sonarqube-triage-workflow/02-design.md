---
id: "2026-03-19-sdd-sonarqube-triage-workflow"
title: "SDD SonarQube triage workflow design"
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

# Design

## Overview

Extend the existing SDD framework in place by adding one dedicated SonarQube triage policy, two dedicated execution contracts, one canonical triage-report template, one canonical `docs/sonar/` artifact definition, and targeted updates to routing, governance, implementation, review, and completion artifacts.

## Current State

- SDD already supports governed fixes, review-driven fixes, and spec authoring, but it does not have a dedicated workflow for validating SonarQube findings against the current codebase before remediation.
- Current routing and task-profile vocabulary does not distinguish between triage-only work, safe-fix triage passes, and later approved remediation from a triage artifact.
- Current checklists and report templates do not explicitly require non-fixed static-analysis findings to be classified and recorded for follow-up.

## Target State

- SonarQube work has explicit phase A and phase B routes with canonical task profiles and contracts.
- Sonar findings are validated against current code before any remediation decision.
- Non-fixed findings are recorded in a standard artifact under `docs/sonar/`.
- Later approved remediation can consume that artifact without treating raw Sonar output as approval authority.
- Review, completion, and Codex execution guidance all enforce the validation-before-remediation rule.

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: extend existing canonical SDD markdown surfaces in place, create new standalone files only for net-new canonical concepts (`SonarQube triage policy`, `Sonar contracts`, `Sonar triage template`, `docs/sonar/` artifact definition), and keep the additive framework structure already used by recent SDD upgrades.
- New tables/source families/screen structure in scope: `no`

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Add `docs/sdd/governance/11-static-analysis-triage-policy.md` as the canonical SonarQube triage policy, then hook it into governance, anti-hallucination, review, traceability, documentation-update, and done rules instead of scattering Sonar-specific rules across unrelated files only. | `REQ-01`, `REQ-04`, `REQ-05` |
| `DES-02` | Add `sonar-triage`, `sonar-triage-and-fix`, and `sonar-fix-from-triage` as formal task profiles, extend the canonical request header with `Sonar Source` and `Triage Artifact`, and route the work through dedicated execution contracts. | `REQ-02`, `REQ-05` |
| `DES-03` | Define `docs/sonar/<date>-<scope>-triage.md` as the canonical Sonar working artifact and `docs/sdd/templates/sonar-triage-report.md` as the exact structure; keep issue classification separate from decision status. | `REQ-01`, `REQ-03` |
| `DES-04` | Extend implementation-report, review-report, checklist, and done surfaces so Sonar-driven work must prove current-code validation, safe-fix boundaries, non-fixed finding recording, and traceable approval status for later remediation. | `REQ-03`, `REQ-04` |
| `DES-05` | Treat an approved Sonar triage artifact as a valid raw-input source for later remediation authoring, but do not let it replace a governing feature package when the resulting remediation is non-trivial or behavior-sensitive. | `REQ-05` |

## Impacted Areas

- Backend: `n/a`
- Frontend: `n/a`
- Database: `n/a`
- Integrations: `n/a`
- Operations: SDD operator workflow, review workflow, and AI execution workflow for Sonar-driven work

## Non-Changes

- No SonarQube API integration or import automation
- No runtime code remediation in this framework change
- No product contract, schema, or workflow change
