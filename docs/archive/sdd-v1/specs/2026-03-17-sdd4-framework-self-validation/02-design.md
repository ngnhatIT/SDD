---
id: "2026-03-17-sdd4-framework-self-validation"
title: "SDD4 framework self-validation and self-audit design"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: extend the existing shell validator with small deterministic checks tied directly to canonical governance and templates, add structured finding output, keep fixture expansion minimal, and add one helper self-audit document for blind spots and recurring framework maintenance.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`, `REQ-05`

## Current State

- `scripts/sdd/validate_specs.sh` validates required base files, anchor placeholders, several traceability chains, contract prose references, README artifact inventory drift, manifest references, generated pack shape, and spec-pack drift.
- `scripts/sdd/test_validate_specs.sh` covers the existing rules with pass and fail fixtures, but it does not cover report completeness, operator-facing diagnostics, bridge ambiguity, or some canonical reference-resolution problems.
- Canonical templates and governance now define stronger implementation and review report structure, but the validator does not consume that structure yet.
- Framework drift signals are partly documented in helper docs such as `framework-health-metrics.md`, but no dedicated self-audit playbook exists for the framework itself.

## Target State

- Validator coverage includes grounded report completeness and selected framework-shape checks that are deterministic and low-noise.
- Validator output reports each issue with a severity class, failure level, rationale, canonical source, and next action.
- Fixture coverage proves the new checks with a minimal number of additional fail cases.
- One framework self-audit guide exists for recurring manual inspection of drift signals and validator blind spots.

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | `Start with an audit of current validation capabilities and use that audit to separate grounded checks, grounded gaps, and non-mechanical blind spots.` | `REQ-01` |
| `DES-02` | `Add report-completeness checks only when a report file exists or when README artifact status says the report should exist, and validate section presence against canonical templates plus governance-required markers rather than exact template lockstep.` | `REQ-02`, `REQ-05` |
| `DES-03` | `Add deterministic structure and reference checks for README canonical pointers, manifest-to-artifact resolution, conditional contract ownership cues, package-shape or task-profile mismatches, spec-pack drift, and bridge ambiguity where the source docs already define the relationship.` | `REQ-03`, `REQ-05` |
| `DES-04` | `Refactor validator output into structured issue records with severity, level, rule source, why, and next action so operators can understand failures without reading the script.` | `REQ-01`, `REQ-05` |
| `DES-05` | `Add docs/sdd/ai-ops/framework-self-audit.md as a helper-only self-audit playbook that covers authority drift, duplication drift, prompt drift, bridge ambiguity, and validator blind spots that remain manual.` | `REQ-04`, `REQ-05` |

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: `docs-only and shell-tooling framework change; preserve the existing authority chain, shell-script conventions, template hierarchy, and helper-only status of ai-ops materials`
- New tables/source families/screen structure in scope: `no`

## Impacted Areas

- Backend: `scripts/sdd/validate_specs.sh` and `scripts/sdd/test_validate_specs.sh`
- Frontend: `n/a`
- Database: `n/a`
- Integrations: `docs/spec-packs/`, `docs/specs/`, and canonical framework docs used by the validator
- Operations: framework maintainers and operators reading validator output or running self-audits

## Framework Artifacts To Inspect And Preserve

- `scripts/sdd/validate_specs.sh`
- `scripts/sdd/test_validate_specs.sh`
- `scripts/sdd/README.md`
- `docs/sdd/governance/02-minimum-completeness-before-coding.md`
- `docs/sdd/governance/03-implementation-traceability-rules.md`
- `docs/sdd/governance/04-review-rules.md`
- `docs/sdd/governance/09-documentation-update-policy.md`
- `docs/sdd/governance/definition-of-done.md`
- `docs/sdd/templates/feature-package/11-implementation-report.md`
- `docs/sdd/templates/feature-package/12-review-report.md`
- `docs/specs/README.md`
- `docs/sdd/README.md`
- `docs/sdd/ai-ops/README.md`
- `docs/sdd/ai-ops/framework-health-metrics.md`

## Validation Boundaries

- Mechanically safe:
  - required section and marker presence
  - file existence and reference resolution
  - canonical path and artifact-inventory consistency
  - spec-pack drift and duplicate-bridge-path detection when explicit text or paths exist
- Not mechanically safe by default:
  - whether narrative content is substantively correct
  - whether a design choice truly warrants an ADR when the trigger is judgment-heavy
  - whether a bridge reference is historical context or harmful duplication without explicit wording
  - whether acceptance or review evidence is actually sufficient beyond presence and explicit recorded results

## Non-Changes

- No runtime product behavior change
- No new canonical authority layer
- No replacement of human review or manual framework audit
- No CI enforcement or machine-readable validator output in this change
