---
id: "2026-03-23-sdd-route1-operational-alignment"
title: "SDD Route 1 operational alignment design"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-23"
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

Keep the authority stack unchanged, place the stable fixed-prefix model in existing canonical context and governance files, place task-specific variable context in the existing header and execution-brief surfaces, adapt Codex and Copilot profiles to use hypothesis-first minimal verification, and strengthen existing recovery, prompt, checklist, and report artifacts so the Route 1 operating pattern is discoverable without adding any new top-level framework.

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: `docs-only framework change; preserve the current split where context and governance own stable operating rules, execution profiles own agent behavior, prompts remain thin adapters, checklists own stage gates, and ai-ops stays helper-only`
- Shared helper or constant reuse note: `reuse the existing task header, execution brief, recovery, prompt, checklist, and report artifacts instead of adding parallel control files`
- Touched-scope cleanup note: `no unrelated framework cleanup; only insert Route 1 rules where the current layer already owns that concern`
- Backend validation/helper reuse note: `n/a`
- Frontend base-common reuse note: `n/a`
- Frontend structure reuse note: `n/a`
- Touched-scope modernization note: `replace implicit compact-context behavior with explicit Route 1 wording inside current canonical files`
- Mixed-pattern classification note: `current fixed-prefix behavior is partial and implicit; promote explicit stable-prefix guidance without changing authority order`
- Frontend-backend validation parity note: `n/a`
- Field-level vs popup error-routing note: `n/a`
- Frontend responsive layout note: `n/a`
- Paired-field alignment note: `n/a`
- Search or CSV lifecycle note: `n/a`
- Comment language note: `English-only new comments, none needed for docs`
- New tables/source families/screen structure in scope: `no`

## Framework Anchors Inspected

- `AGENTS.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/governance.md`
- `docs/sdd/governance/01-ai-agent-policy.md`
- `docs/sdd/governance/minimal-sufficient-context-policy.md`
- `docs/sdd/governance/12-uncertainty-escalation-policy.md`
- `docs/sdd/execution/task-input-header.md`
- `docs/sdd/execution/contracts/recover-context.md`
- `docs/sdd/execution-profiles/codex.md`
- `docs/sdd/execution-profiles/copilot.md`
- `docs/sdd/prompts/README.md`
- `docs/sdd/checklists/02-requirements-review.md`
- `docs/sdd/checklists/03-design-review.md`
- `docs/sdd/checklists/06-code-review-against-spec.md`
- `docs/sdd/templates/execution-brief-template.md`
- `docs/sdd/templates/feature-package/11-implementation-report.md`
- `docs/sdd/templates/feature-package/12-review-report.md`
- `docs/sdd/ai-ops/09-recovery-mode.md`
- `docs/sdd/ai-ops/agent-clients-and-handoff.md`

## Raw Input Normalization

### Facts

- The repository already has canonical layers for context, governance, execution, profiles, prompts, checklists, templates, and AI-ops helpers.
- Minimal reading, recovery, and evidence-oriented reporting already exist, but the Route 1 operating model is only implicit.
- The request explicitly forbids any parallel AI-governance surface such as `CLAUDE.md` or `.claude/`.
- The request explicitly names the operating principles that must be preserved, including fixed-prefix behavior, minimal reading, permission-based exploration, hypothesis-first verification, log discipline, long-session restart, and better Codex or Copilot repeatability.

### Open Questions

- The full text of `Document 32` is not available in the repository; only the approved principle list in the request is available.

### Non-Changes

- No change to the current authority order.
- No new runtime application behavior.
- No new CI, CD, or API cache rules.
- No new top-level framework root or client-specific control surface.

### Approval Gaps

- none; the user request provides the approved principles, constraints, and required placement rules for this framework update

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | `Define the stable fixed-prefix model in docs/sdd/context/ai-loading-order.md and docs/sdd/governance/01-ai-agent-policy.md, and define the variable task packet in docs/sdd/execution/task-input-header.md plus docs/sdd/templates/execution-brief-template.md.` | `REQ-01` |
| `DES-02` | `Put the detailed minimal-reading and permission-based exploration rules in docs/sdd/governance/minimal-sufficient-context-policy.md, with a lighter compliance echo in docs/sdd/process/99-ai-checklist.md.` | `REQ-02` |
| `DES-03` | `Place the hypothesis-first short-path investigation rule in the Codex and Copilot execution profiles because it is agent operating behavior, not repository governance.` | `REQ-03` |
| `DES-04` | `Place log excerpt and restart or handoff rules in the existing recover-context contract, recovery-mode guide, handoff guide, and implementation or review report templates so both live execution and recorded evidence stay compact.` | `REQ-04` |
| `DES-05` | `Strengthen the existing prompt, checklist, and report surfaces with short support text for requirement clarification, design review, traceability review, and document refactoring instead of adding a new prompt framework.` | `REQ-05` |

## Canonical Placement

| Concern | Canonical Home | Why |
| --- | --- | --- |
| stable fixed prefix | `docs/sdd/context/ai-loading-order.md`, `docs/sdd/governance/01-ai-agent-policy.md` | stable instructions belong in context and governance |
| variable task context | `docs/sdd/execution/task-input-header.md`, `docs/sdd/templates/execution-brief-template.md` | these are the current task-packet surfaces |
| permission-based exploration | `docs/sdd/governance/minimal-sufficient-context-policy.md` | it is a repo-wide context-loading rule |
| hypothesis-first verification | `docs/sdd/execution-profiles/codex.md`, `docs/sdd/execution-profiles/copilot.md` | it is client operating behavior |
| log excerpt discipline | `docs/sdd/governance/01-ai-agent-policy.md`, report templates | it affects live execution and persisted evidence |
| restart and handoff summary | `docs/sdd/execution/contracts/recover-context.md`, `docs/sdd/ai-ops/09-recovery-mode.md`, `docs/sdd/ai-ops/agent-clients-and-handoff.md` | these already own recovery and handoff behavior |
| requirement, design, review, and refactoring support prompts | `docs/sdd/prompts/` plus review checklists | these already own execution aids and review gates |

## Implementation Plan

1. Create a reduced-path docs-only feature package for this change.
2. Update canonical context and governance docs to define the fixed-prefix model, variable packet boundary, minimal reading, exploration notes, and log discipline.
3. Update Codex and Copilot profiles plus task-packet templates so Route 1 behavior is explicit at execution time.
4. Update recovery and handoff artifacts so long sessions can be restarted from a short packet.
5. Update prompt, checklist, and reporting artifacts so requirement analysis, design review, traceability review, and document refactoring are supported without new framework roots.
6. Self-review for duplication, authority drift, and unnecessary complexity, then record implementation and review evidence.

## Risks And Mitigations

| Risk | Mitigation |
| --- | --- |
| Route 1 rules get scattered across too many files. | Keep each rule only in its owning layer and use short cross-layer echoes only where execution needs them. |
| Fixed-prefix wording becomes a second authority chain. | Anchor it explicitly to existing context, governance, execution contracts, and profiles rather than inventing new roots. |
| The missing full text of `Document 32` leads to invented details. | Implement only the explicitly approved principles and constraints from the request. |
| Prompt support becomes another heavy workflow manual. | Keep prompt changes short, task-shaped, and subordinate to contracts and checklists. |
