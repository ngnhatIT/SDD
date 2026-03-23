---
id: "2026-03-17-sdd4-framework-self-validation"
title: "SDD4 framework self-validation and self-audit requirements"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "README.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "README.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Requirements

## Problem

- The current SDD validator already checks base feature-package presence, identifier formatting, traceability coverage, placeholder anchors, contract prose references, README artifact drift, and generated spec-pack drift.
- The framework still lacks deterministic checks for implementation and review report completeness, several canonical reference and packaging problems, and bridge or legacy ambiguity signals that can weaken SDD4 maintainability.
- Operators also lack one canonical framework self-audit document that explains what must still be inspected manually beyond the validator.

## Scope

### In Scope

- improve deterministic validator coverage only where canonical governance, templates, or documented conventions already define the rule
- improve diagnostic output for validator failures and warnings
- add one helper framework self-audit document for recurring framework maintenance
- update test fixtures and usage docs minimally to cover new grounded checks

### Out Of Scope

- new validator checks based on inference or undocumented best guesses
- runtime application behavior changes
- a new framework authority layer parallel to `AGENTS.md`, `docs/sdd/`, or `docs/specs/`
- automated replacement of human review for semantic conflicts or nuanced judgment calls

## Requirements

### REQ-01

- Statement: The validator must audit and report current grounded coverage gaps against the existing canonical framework shape, not just the older package-minimum checks.
- Rationale: Maintainers need to know what is already enforced, what is still missing, and which gaps are safe for deterministic enforcement.
- Source: `docs/sdd/governance/02-minimum-completeness-before-coding.md`, `docs/sdd/context/spec-structure-schema.md`, `scripts/sdd/README.md`

### REQ-02

- Statement: The validator must enforce implementation-report and review-report completeness only for sections that are required by canonical templates or governance rules when those reports exist or are required by README artifact status.
- Rationale: SDD4 relies on auditable implementation and review evidence, but the checks must stay grounded and low-noise.
- Source: `docs/sdd/governance/03-implementation-traceability-rules.md`, `docs/sdd/governance/04-review-rules.md`, `docs/sdd/governance/definition-of-done.md`, `docs/sdd/templates/feature-package/11-implementation-report.md`, `docs/sdd/templates/feature-package/12-review-report.md`

### REQ-03

- Statement: The validator must detect grounded reference and packaging drift across README navigation, spec-pack manifest targets, generated spec-packs, contract ownership cues, and task-profile or package-shape declarations where canonical docs already define those relationships.
- Rationale: Structural drift is expensive and should be detected early when the rule is deterministic.
- Source: `docs/specs/README.md`, `docs/sdd/templates/spec-pack-template.md`, `docs/sdd/governance/09-documentation-update-policy.md`, `docs/sdd/context/task-profiles.md`, `docs/sdd/governance/01-when-a-spec-is-required.md`

### REQ-04

- Statement: The framework must define a recurring self-audit process that covers structural drift, authority drift, duplication drift, prompt-to-governance drift, report-template drift, bridge ambiguity, and validator blind spots.
- Rationale: Some framework-health questions cannot be enforced safely by shell validation alone and still need a canonical manual audit path.
- Source: `docs/sdd/ai-ops/framework-health-metrics.md`, `docs/sdd/governance/09-ai-agent-policy.md`, `docs/sdd/governance/12-uncertainty-escalation-policy.md`

### REQ-05

- Statement: Validator output and operator docs must explain severity, rule source, purpose, and next action clearly enough that maintainers can act without reverse-engineering the shell script.
- Rationale: Actionable output reduces noise and keeps the validator useful as the framework evolves.
- Source: `docs/sdd/governance/README.md`, `scripts/sdd/README.md`, `docs/sdd/README.md`

## Constraints

- Preserve `docs/sdd/` and `docs/specs/` as canonical authority surfaces.
- Do not enforce any validator rule until it is already grounded in canonical governance, templates, or documented conventions.
- Prefer deterministic text and path checks over heuristic semantic inference.
- Keep the validator maintainable as a shell script and avoid building a new framework around it.
- Report uncertainty explicitly when a useful signal cannot be validated safely.

## Non-Goals

- no CI or pipeline integration
- no new manifest schema keys unless separately approved
- no runtime code scanning outside SDD framework artifacts and their documented references
- no automatic correction or rewrite of drifting artifacts
