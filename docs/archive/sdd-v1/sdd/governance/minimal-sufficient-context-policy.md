# Minimal Sufficient Context Policy

## When To Use

Use this policy when choosing how much canonical context to load for implementation, fixing, review, docs work, hotfixes, audits, spec authoring, or recovery.

## How To Use

1. Classify the change path first.
2. Route the task through `docs/sdd/execution/task-routing.md`.
3. Pick the active task profile or practical mode.
4. Load the baseline reads for that path.
5. Deepen only when scope, risk, or uncertainty requires it.
6. Escalate instead of guessing when reduced context is no longer defensible.

## Required Output

- the smallest sufficient canonical read set for the current task
- explicit note of any deepening trigger or blocker when the baseline is not enough

## Gate

Minimal context is valid only when it still preserves source-of-truth priority, anti-hallucination rigor, and a defensible completion claim.

## Core Rule

- Load only the minimum canonical context needed for the active task profile, mode, and risk level.
- Prefer targeted section reads and named files over full-file or full-folder reading when the narrower read is sufficient.
- Before widening beyond the current baseline, state why the extra read is needed and what uncertainty it is meant to resolve.
- Do not bulk-load all standards, process files, prompts, or templates by default.
- Reduced context does not change governance classification, approval requirements, or contract lock rules.
- If the next safe step cannot be defended from the current evidence set, the context is no longer sufficient and must be deepened or escalated.

## Required Baseline Reads By Path

### tiny-fix

- `AGENTS.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/governance/01-when-a-spec-is-required.md`
- touched file or immediate local context

### docs-only

- `AGENTS.md`
- `docs/README.md`
- `docs/sdd/README.md`
- `docs/sdd/execution/task-routing.md`
- `docs/sdd/governance.md`
- this policy
- touched canonical docs

### spec authoring

- `AGENTS.md`
- `docs/sdd/context/constitution.md`
- `docs/sdd/context/note.md`
- `docs/sdd/context/architecture-context.md`
- `docs/sdd/context/product-context.md`
- `docs/sdd/context/tech-context.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/execution/task-routing.md`
- `docs/sdd/execution/contracts/create-spec.md`
- `docs/sdd/spec-authoring/README.md`
- `docs/sdd/spec-authoring/raw-input-normalization.md`
- `docs/sdd/checklists/spec-authoring-checklist.md`
- `docs/specs/README.md`

### review-only or audit-only

- `AGENTS.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/execution/task-routing.md`
- `docs/sdd/execution/contracts/review-feature.md`
- `docs/sdd/governance.md`
- this policy
- governing feature package when the work is governed
- current implementation evidence when present

### sonar-triage

- `AGENTS.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/execution/task-routing.md`
- `docs/sdd/execution/contracts/sonar-triage.md`
- `docs/sdd/governance.md`
- `docs/sdd/governance/11-static-analysis-triage-policy.md`
- this policy
- Sonar finding source
- current code anchors for the findings being triaged
- `docs/sdd/templates/sonar-triage-report.md` or the current triage artifact when one already exists

### sonar-triage-and-fix

- all `sonar-triage` reads
- selected agent profile when relevant
- `docs/sdd/checklists/touched-scope-enforcement.md` when code changes are made
- `docs/specs/README.md` and the governing feature package when standard governance classifies the remediation as reduced-path or full-path

### sonar-fix-from-triage

- `AGENTS.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/execution/task-routing.md`
- `docs/sdd/execution/contracts/sonar-fix-from-triage.md`
- `docs/sdd/governance.md`
- `docs/sdd/governance/11-static-analysis-triage-policy.md`
- this policy
- approved triage artifact
- current code anchors for the approved findings
- selected agent profile when relevant
- `docs/specs/README.md` and the governing feature package when standard governance classifies the remediation as reduced-path or full-path

### reduced-path fix or implementation

- `AGENTS.md`
- `docs/sdd/context/constitution.md`
- `docs/sdd/context/note.md`
- `docs/sdd/context/architecture-context.md`
- `docs/sdd/context/product-context.md`
- `docs/sdd/context/tech-context.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/execution/task-routing.md`
- selected execution contract
- selected agent profile when relevant
- `docs/sdd/governance.md`
- this policy
- `docs/specs/README.md`
- governing feature package
- `07-tasks.md`, `08-acceptance-criteria.md`, `09-test-cases.md`

### full-path governed implementation

- all reduced-path reads
- all owned feature artifacts under the governing package
- feature-owned `contracts/`
- all relevant standards for the touched layers

### hotfix

- `AGENTS.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/execution/task-routing.md`
- selected execution contract
- `docs/sdd/governance/07-emergency-change-handling.md`
- `docs/sdd/governance/12-uncertainty-escalation-policy.md`
- this policy
- incident summary or emergency request
- current or new compact feature package

### recovery or resume

- `AGENTS.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/execution/task-routing.md`
- `docs/sdd/execution/contracts/recover-context.md`
- `docs/sdd/governance.md`
- this policy
- current feature package or changed-file evidence when one exists

## Deepening Triggers

Deepen the read set immediately when any of these are true:

- the change touches a contract, schema, file shape, auth rule, tenant rule, or externally visible behavior
- the local family pattern or source-base anchors are not obvious from the baseline evidence
- the task spreads beyond one local workflow, one bounded docs surface, or one review target
- the execution brief or generated spec-pack compresses away an unknown, blocker, or conflict
- self-review, formal review, release readiness, or a completion claim is starting
- current evidence is manual-only and the risk of misclassification remains meaningful

When deepening:

- record a short exploration note with:
  - `why`: the blocker or uncertainty being resolved
  - `scope`: the exact files, folders, or artifact family to inspect next
  - `expected result`: what confirmation, rejection, or missing fact the deeper read should produce
- load only the specific standard, process file, checklist, contract, or companion artifact that resolves the uncertainty
- stop broadening once the expected result is reached or the named scope is exhausted
- do not jump from a tiny baseline to bulk-loading every folder
- record the reason for the deeper read in the implementation or review evidence when the task is governed

## Execution Brief Substitution Rule

An execution brief may substitute for reopening many supporting docs only when all of these are true:

- one concrete task is active
- the governing feature package is current and already loaded
- the brief is current for that task profile
- no source conflict, blocker, or ask-before-break trigger is open
- the brief preserves the locked contracts, guardrails, deepening triggers, and open questions from its sources

An execution brief must not substitute for:

- `AGENTS.md`
- `docs/sdd/governance.md`
- this policy
- the governing feature package itself
- owned `contracts/` or locked prose contract sources when the task touches interface shape
- any source that must be reopened to resolve a conflict, uncertainty, or possible breaking change

## Anti-Hallucination Guardrails For Reduced Context

- Source priority stays unchanged under reduced context.
- Do not infer hidden behavior because fewer docs were loaded.
- Cite the exact artifact, code reference, or report that grounds each change or review claim.
- Reduced context does not permit skipping sibling-flow inspection when parity risk is present.
- If a compact source says `unknown (...)`, keep it unknown until the governing source resolves it.
- Missing artifacts, stale briefs, and conflicting rules are blockers, not invitations to improvise.
- Completion claims require the same honesty about uncertainty and confidence as full-context work.
