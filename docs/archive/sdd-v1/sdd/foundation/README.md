# SDD2+ Foundation

Use `foundation/` only after the core `AGENTS.md -> context -> governance` load is complete.

This file is the additive SDD2+ entrypoint. It explains how the repository extends the base SDD2 model without changing approval authority.

## Core Rule

SDD2+ extends the current SDD2 lifecycle. It does not fork it.

The base model remains intact:

- governed work still starts from `docs/specs/<feature-id>/`
- `docs/sdd/context/` and `docs/sdd/governance.md` remain the core loading contract
- `docs/spec-packs/` remains supportive, never authoritative
- process gates still run through process, governance, and checklists

## What SDD2+ Adds

SDD2+ adds operational support for faster human and AI execution:

- AI-oriented spec-pack guidance and execution brief templates
- feature-level `13-risk-log.md` and `14-decision-notes.md`
- prompt starters for common delivery tasks
- explicit AI operations guidance for evidence, handoff, and scope control
- evidence-first documentation so implementation and review facts are easy to find

Use SDD2+ when the team wants faster onboarding or smoother AI execution without changing the underlying approval model.

## Lifecycle Mapping

| Existing SDD2 stage | SDD2+ addition | Compatibility rule |
| --- | --- | --- |
| Intake | risk framing and execution-artifact choice | does not replace the feature package |
| Requirements and design | evidence-first writing, decision notes | numbered spec files stay authoritative |
| Task planning | prompt library and execution brief preparation | tasks, AC, and TC still gate coding |
| Implementation | implementation report plus risk updates | code must trace back to the same `REQ -> DES -> TASK -> AC -> TC` chain |
| Review | risk disposition and evidence summary | `12-review-report.md` remains the review verdict artifact |
| Release | quality gate level and release risk check | rollout and changelog rules still apply |

## Artifact Mapping

| Existing artifact | SDD2+ companion | Rule |
| --- | --- | --- |
| `docs/specs/<feature-id>/` | `13-risk-log.md`, `14-decision-notes.md` | additive only |
| `spec-pack.manifest.yaml` | AI-oriented pack guidance | manifest remains optional unless the feature owns a spec-pack |
| `docs/spec-packs/<feature-id>.pack.md` | execution brief template and pack enrichment | generated pack stays non-authoritative |
| `scripts/sdd/` | `tools/sdd/` command index | scripts remain the executable entrypoint |

## Evidence-First Documentation

Write the facts needed for implementation and review where readers expect them instead of leaving them implied.

### Spec Writing

- State scope in `README.md` with explicit in-scope and out-of-scope bullets.
- Record source-base anchors in `02-design.md` before coding.
- Put durable local design reasoning in `14-decision-notes.md`.
- Put operational, release, or regression risk in `13-risk-log.md`.
- Map every acceptance statement to at least one test case.

### Report Writing

- `11-implementation-report.md` should show what changed, what evidence was produced, and what remains open.
- `12-review-report.md` should show findings, verdict, residual risks, and whether testing is automated or manual.
- When automation is absent, record the manual regression path rather than implying coverage.

### Evidence Priority

1. Governing feature package
2. Machine-readable contracts when owned
3. Implementation report and review report
4. Generated spec-pack and execution brief

If evidence exists only in chat, memory, or a local scratch file, the repository is still missing the evidence.

## AI Execution Artifacts

SDD2+ keeps spec-packs and execution briefs as compact execution artifacts for humans and AI agents.

### Spec-Pack Purpose

Use a spec-pack when one task would otherwise require repeated cross-file crawling across context, standards, specs, and contracts.

An AI-optimized spec-pack should surface:

- governing package location
- source-base anchors
- related code references
- locked contracts
- scope guardrails and prohibited scope
- key design decisions
- implementation constraints
- open questions when they still affect safe execution
- risk and decision companion artifacts when present

### Execution Brief Purpose

Use an execution brief when a single task profile needs a deterministic reading list and done criteria.

An execution brief should make these questions obvious:

- what is the governing feature package
- what request inputs were resolved for this task
- what is mandatory to read now
- what is optional but useful
- what task scope is approved
- what constraints and locked contracts apply
- what validation must happen before the task is done

### Non-Negotiable Rule

Spec-packs and execution briefs accelerate execution. They do not approve changes.

## Backward Compatibility Rules

- Do not rename or delete existing SDD2 files just to adopt SDD2+.
- Do not make older feature packages invalid just because they do not include SDD2+ companion files.
- When a new feature uses SDD2+, keep the base numbered artifacts complete before adding companion files.
- When a generated pack or brief contains more detail than an older pack, the older pack format remains acceptable until that feature is rebuilt.
