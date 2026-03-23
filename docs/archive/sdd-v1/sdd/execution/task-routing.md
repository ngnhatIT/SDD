# Task Routing

Use this file to choose the governed execution path, primary contract, and next required reads.

## Routing Order

1. classify the change with governance
2. resolve the formal `Task Profile` when present
3. resolve the practical mode
4. choose the primary execution contract
5. load the current agent profile
6. load the governing feature package or spec-authoring workflow

## Formal Task Profiles

| Task Profile | Use When | Primary Contract | Primary Output |
| --- | --- | --- | --- |
| `implement-new` | approved governed implementation should start | `contracts/implement-feature.md` | repository change plus implementation evidence |
| `fix-from-pack` | a governed fix should use a generated spec-pack | `contracts/implement-feature.md` | targeted fix plus refreshed evidence |
| `fix-from-bug` | a bug source exists and no spec-pack drives the fix | `contracts/create-spec.md` then `contracts/implement-feature.md` when non-trivial | fix plus required governed artifacts |
| `review-from-pack` | review should use both feature package and spec-pack | `contracts/review-feature.md` | findings-first review plus review evidence |
| `review-from-rules` | review is rules-first and spec-pack is optional | `contracts/review-feature.md` | findings-first review plus governed review evidence when required |
| `sonar-triage` | SonarQube findings should be validated and classified without fixing code | `contracts/sonar-triage.md` | triage artifact with current-code validation, classifications, and decision statuses |
| `sonar-triage-and-fix` | SonarQube findings should be triaged and only clearly safe items fixed in the same pass | `contracts/sonar-triage.md` | safe fixes plus updated triage artifact |
| `sonar-fix-from-triage` | approved remediation should be applied from an existing triage artifact | `contracts/sonar-fix-from-triage.md` | approved fixes plus updated triage artifact and evidence |

## Practical Modes

| Mode | Use When | Primary Contract Or Path | Primary Output |
| --- | --- | --- | --- |
| `docs-only` | docs, governance, prompts, templates, or framework updates only | direct docs path or `contracts/create-spec.md` when governed authoring is needed | updated docs and required evidence |
| `review-only` | only review should happen in this pass | `contracts/review-feature.md` | review findings |
| `audit-only` | inspect and report without fixing | `contracts/review-feature.md` | audit findings |
| `tiny-fix` | obviously bounded low-risk `no-spec` correction | direct bounded path | minimal safe diff plus the smallest relevant proof |
| `hotfix` | outage, security, legal, or regulatory emergency | emergency governance plus the matching implementation or review contract | compact safe change, rollback evidence, and backfill note when normal proof or docs are deferred |
| `recovery` | next step is unclear or work resumes after interruption | `contracts/recover-context.md` | grounded next-step note |

## Risk-Proportional Use

- Start with the lightest path that still fits the actual risk and available evidence.
- `tiny-fix` and bounded `docs-only` work should feel lightweight, but they still need explicit classification and the smallest relevant proof.
- When scope, blast radius, contract impact, or ambiguity grows, escalate to reduced-path or full-path governed handling instead of stretching a lightweight label.
- `hotfix` is for real urgency only. If the emergency path defers normal spec or proof work, record the required backfill in the same change and close it after stabilization.

## Spec Authoring Route

Use `contracts/create-spec.md` plus `docs/sdd/spec-authoring/README.md` when:

- a new governed feature package must be created
- an existing feature package must be updated before code or review can proceed
- raw inputs must be normalized into approved numbered artifacts

## Finding-Driven Fix Route

Use `contracts/fix-from-review.md` when grounded review, QA, bug, or production findings already exist and the work should close those findings without reopening design scope.

## Execution-Aid Routes

| Need | Primary Contract | Primary Output |
| --- | --- | --- |
| generate or refresh a feature-wide spec-pack | `contracts/generate-spec-pack.md` | `docs/spec-packs/<feature-id>.pack.md` |
| generate or refresh a task-scoped execution brief | `contracts/generate-execution-brief.md` | `docs/spec-packs/<feature-id>.<task-profile>.brief.md` |

## Agent Profile Selection

Use this order:

1. explicit `Agent Profile` header
2. current client or tool profile
3. `auto`

Load the selected profile from `docs/sdd/execution-profiles/`.

## Required Next Reads

After routing, load all of these:

1. the selected execution contract under `docs/sdd/execution/contracts/`
2. the selected agent profile under `docs/sdd/execution-profiles/`
3. the governing feature package or `docs/sdd/spec-authoring/README.md`
4. only the standards, checklists, reports, and support files needed for the selected task

## Stop Rules

Stop and escalate when:

- no governing feature package exists for governed work
- the package shape is incomplete for the claimed scope
- approval, schema, contract, or externally visible behavior would be guessed
- a lighter practical mode no longer matches the real evidence
- SonarQube findings cannot be validated against the current code or approved triage artifact
