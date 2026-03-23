---
id: "2026-03-13-execution-brief-generator"
title: "Execution-brief generator for task-specific SDD loading requirements"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "README.md"
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "README.md"
implementation_refs:
  - "scripts/sdd/build_execution_brief.sh"
  - "docs/spec-packs/"
test_refs:
  - "09-test-cases.md"
---

# Requirements

## Problem Statement

The repository now has strong routing, governance, and feature-package documentation, but starting one governed task still requires manual synthesis across multiple markdown layers. A first execution-brief generator is needed to compile a concise task-specific snapshot without changing the current approval model.

## Scope

### In Scope

- Generate one deterministic execution brief for a selected governed feature package and task profile.
- Include task profile, classification, governing files, mandatory reads, optional consults, locked decisions, task scope, constraints, touched layers, required validations, and expected outputs.
- Accept explicit request-scoped helper inputs for spec-pack, backend helper, bug source, and review scope.
- Generate a sample brief for an existing feature package.
- Document command usage, assumptions, and limits.

### Out Of Scope

- Replacing `docs/specs/<feature-id>/` as the approval source of truth
- Parsing free-form prompts to infer task profile automatically
- Introducing CI freshness enforcement for generated briefs
- Adding new runtime behavior or contract artifacts

## Requirements

### REQ-01

- Statement: The repository must provide a scriptable way to generate a concise execution brief for one governed feature package and one explicit task profile.
- Rationale: Startup context should be compiled deterministically instead of rebuilt manually on every task.
- Source: execution-brief generator request

### REQ-02

- Statement: The generated brief must expose the current task profile, governance classification, source-of-truth files, mandatory reads, optional consults, task scope, constraints, touched layers, required validations, and expected outputs.
- Rationale: The brief only helps if it reduces startup ambiguity without hiding the canonical sources.
- Source: execution-brief generator request

### REQ-03

- Statement: The generator must keep canonical markdown authoritative and mark missing request-scoped or narrative information explicitly as unknown instead of guessing.
- Rationale: A concise brief is useful only if it does not create false certainty or a second approval surface.
- Source: `AGENTS.md` operating rules

### REQ-04

- Statement: Repository docs must explain how to run the generator, and the repository must include at least one generated sample brief for review.
- Rationale: A tooling change is not reviewable if users cannot see the command contract and output shape in-repo.
- Source: execution-brief generator request

## Constraints

- Keep `docs/specs/<feature-id>/` as the governing approval source.
- Keep generated briefs under `docs/spec-packs/` as execution aids only.
- Use deterministic ordering and stable section names.
- Keep request-scoped inputs explicit; do not infer them from free-form prompt text.

## Assumptions

- A shell script aligned with existing `scripts/sdd/*.sh` tooling is the least disruptive implementation choice.
- Classification can be inferred from owned numbered feature files for the first version.

## Open Questions

- None.
