---
id: "2026-03-17-sdd4-operating-model-optimization"
title: "SDD4 operating-model optimization design"
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

## Design Summary

Keep the authority stack unchanged, move duplicated operational detail out of `AGENTS.md` into existing canonical docs by pointer, add one practical routing matrix plus one short daily guide, and tighten report templates so implementation and review evidence become more structured and auditable.

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: `docs-only framework change; preserve existing canonical authority split between AGENTS.md, docs/sdd/, and docs/specs/ while keeping prompt and template guidance concise and evidence-oriented`
- New tables/source families/screen structure in scope: `no`

## Framework Anchors Inspected

- `AGENTS.md`
- `docs/README.md`
- `docs/sdd/README.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/context/task-profiles.md`
- `docs/sdd/governance.md`
- `docs/sdd/governance/09-ai-agent-policy.md`
- `docs/sdd/governance/12-uncertainty-escalation-policy.md`
- `docs/sdd/governance/definition-of-done.md`
- `docs/sdd/prompts/quick-guide.md`
- `docs/sdd/prompts/README.md`
- `docs/sdd/templates/README.md`
- `docs/sdd/templates/feature-package/11-implementation-report.md`
- `docs/sdd/templates/feature-package/12-review-report.md`

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | `AGENTS.md` will be reduced to the root operating contract and will point to canonical governance, task routing, standards, templates, and escalation docs instead of restating detailed standards. | `REQ-01` |
| `DES-02` | Add `docs/sdd/context/task-mode-matrix.md` as the practical daily routing matrix aligned to task profiles and governance, then link it from the context and prompt entrypoints. | `REQ-02` |
| `DES-03` | Strengthen `11-implementation-report.md` and `12-review-report.md` with explicit sections for basis, scope, evidence, assumptions, conflicts, unsupported assumptions, contract drift, traceability, tests, verdict, and follow-up actions. | `REQ-03` |
| `DES-04` | Update active canonical docs so any bridge wording clearly states bridge-only or historical status and does not imply a live competing `agent/` authority surface in this repo state. | `REQ-04` |

## Implementation Plan

1. Create and maintain a reduced-path feature package for this docs-only framework change.
2. Refactor `AGENTS.md` to keep only the root contract and deeper-doc pointers.
3. Add the task-mode matrix and daily operator guide, then update only the necessary navigation points.
4. Tighten report templates and keep alias templates as thin compatibility pointers.
5. Update active bridge references where they misstate the current repo reality.
6. Record implementation evidence and manual verification paths in `11-implementation-report.md`.

## Local Shape Constraints To Preserve

- Keep `AGENTS.md` as the first entrypoint, not a README replacement.
- Keep task-profile precedence unchanged.
- Keep prompts as execution aids only, not approval artifacts.
- Keep templates and guides short enough for daily operator use.
- Keep bridge handling subordinate to canonical docs and avoid creating another workflow hub.

## Risks And Mitigations

| Risk | Mitigation |
| --- | --- |
| `AGENTS.md` becomes too thin and loses critical safety constraints. | Keep hard-stop and escalation behavior in `AGENTS.md` and point directly to canonical policy files for details. |
| New routing docs conflict with existing task-profile guidance. | Reuse the same mode names and authority order, and treat the matrix as a practical view over existing governance. |
| Bridge cleanup overreaches into historical archives. | Limit edits to active canonical docs and avoid destructive archive changes. |
