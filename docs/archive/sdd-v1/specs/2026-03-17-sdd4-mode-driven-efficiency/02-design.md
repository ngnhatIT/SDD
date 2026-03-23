---
id: "2026-03-17-sdd4-mode-driven-efficiency"
title: "SDD4 mode-driven efficiency design"
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

Keep authority split unchanged, add one new governance policy for minimal sufficient context, keep completion rules in the existing definition-of-done document, sharpen lightweight-path routing in the task-mode matrix, add one practical framework-health-metrics helper under `ai-ops/`, and connect these with small navigation updates rather than new parallel guides.

## Source Base Anchors

- Backend process anchor files: `n/a`
- Backend webservice anchor files: `n/a`
- SQL anchor files: `n/a`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: `docs-only framework change; preserve the current authority split where governance holds rules, context holds routing, prompts remain operator aids, and ai-ops remains helper-only`
- New tables/source families/screen structure in scope: `no`

## Framework Anchors Inspected

- `AGENTS.md`
- `docs/README.md`
- `docs/sdd/README.md`
- `docs/sdd/context/ai-loading-order.md`
- `docs/sdd/context/task-profiles.md`
- `docs/sdd/context/task-mode-matrix.md`
- `docs/sdd/governance.md`
- `docs/sdd/governance/01-when-a-spec-is-required.md`
- `docs/sdd/governance/07-emergency-change-handling.md`
- `docs/sdd/governance/09-ai-agent-policy.md`
- `docs/sdd/governance/09-documentation-update-policy.md`
- `docs/sdd/governance/12-quality-gate-levels.md`
- `docs/sdd/governance/12-uncertainty-escalation-policy.md`
- `docs/sdd/governance/definition-of-done.md`
- `docs/sdd/process/05-implementation.md`
- `docs/sdd/process/06-tests-and-verification.md`
- `docs/sdd/process/07-review.md`
- `docs/sdd/process/08-release.md`
- `docs/sdd/prompts/README.md`
- `docs/sdd/prompts/daily-operator-guide.md`
- `docs/sdd/prompts/quick-guide.md`
- `docs/sdd/templates/README.md`
- `docs/sdd/templates/execution-brief-template.md`
- `docs/sdd/checklists/done-checklist.md`
- `docs/sdd/ai-ops/README.md`
- `docs/sdd/ai-ops/09-recovery-mode.md`
- `docs/decisions/ADR-0003-task-profile-routing.md`
- `docs/decisions/ADR-0004-sdd2-plus-agent-ready-extension.md`

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | `Create docs/sdd/governance/minimal-sufficient-context-policy.md as the canonical context-loading rule so minimal context discipline lives in governance, not in prompts or templates.` | `REQ-01` |
| `DES-02` | `Keep the core completion standard in docs/sdd/governance/definition-of-done.md and extend it with a mode matrix; use task-mode routing docs only for path selection and escalation boundaries.` | `REQ-02`, `REQ-03` |
| `DES-03` | `Sharpen lightweight path behavior in docs/sdd/context/task-mode-matrix.md and operator guides, including a practical review-only mode and a low-risk cleanup rule that maps back to existing governance instead of creating a new approval layer.` | `REQ-03`, `REQ-05` |
| `DES-04` | `Add docs/sdd/ai-ops/framework-health-metrics.md as a helper-only operational signals document that points to existing reports and findings as the recording source.` | `REQ-04` |
| `DES-05` | `Use only short cross-references in docs/README.md, docs/sdd/README.md, governance indexes, task profiles, loading order, and prompt guides so discoverability improves without duplicating the new rules.` | `REQ-05` |

## Canonical Placement

| Concern | Canonical Home | Why |
| --- | --- | --- |
| minimal sufficient context rules | `docs/sdd/governance/minimal-sufficient-context-policy.md` | Context loading discipline is policy, not prompt advice |
| completion requirements by mode | `docs/sdd/governance/definition-of-done.md` | Done standards belong with governance and release gates |
| lightweight path routing and escalation boundaries | `docs/sdd/context/task-mode-matrix.md` | This file already owns practical mode selection |
| framework operational signals | `docs/sdd/ai-ops/framework-health-metrics.md` | Metrics are helper-only operating signals, not approval policy |
| operator discoverability | `docs/sdd/prompts/*.md`, `docs/sdd/README.md`, `docs/README.md`, `docs/sdd/governance/README.md` | These are existing navigation entrypoints |

## Implementation Plan

1. Create the reduced-path feature package for this docs-only framework change.
2. Add the minimal-sufficient-context policy and wire governance or context references to it.
3. Extend `definition-of-done.md` with a mode-based completion matrix and align the done checklist intro.
4. Expand lightweight-path guidance in `task-mode-matrix.md` and refresh operator guides with minimal new wording.
5. Add the framework-health-metrics document and wire discovery links from `ai-ops/` and top-level docs indexes.
6. Record implementation evidence and manual validation in `11-implementation-report.md`.

## Local Shape Constraints To Preserve

- Keep `AGENTS.md` and the existing context stack as the loading entrypoint.
- Keep task-profile precedence unchanged.
- Do not let prompts or execution briefs become approval sources.
- Do not duplicate full governance rules into routing docs.
- Keep lightweight paths strict about escalation, artifact minimums, and explicit blockers.

## Risks And Mitigations

| Risk | Mitigation |
| --- | --- |
| The new minimal-context policy duplicates loading-order or task-profile rules. | Keep the new policy focused on loading discipline and deepening rules, then cross-link instead of restating full routing. |
| Mode-specific DoD drifts from task-mode routing. | Keep completion requirements in `definition-of-done.md` and let `task-mode-matrix.md` reference that file for final completion. |
| Lightweight paths are interpreted as permission to skip evidence. | State explicit required artifacts, mandatory evidence, and escalation triggers for each lightweight path. |
| Metrics become a heavy reporting burden. | Define only a short set of signals and record them from existing reports and review findings instead of a new ledger. |
