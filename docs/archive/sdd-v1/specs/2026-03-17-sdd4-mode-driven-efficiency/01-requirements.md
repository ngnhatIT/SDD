---
id: "2026-03-17-sdd4-mode-driven-efficiency"
title: "SDD4 mode-driven efficiency requirements"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "README.md"
  - "02-design.md"
  - "07-tasks.md"
dependencies: []
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Requirements

## Objective

Add the next SDD4 optimization layer so daily execution becomes more mode-driven, more token-efficient, and easier to operate without weakening governance, traceability, or anti-hallucination rigor.

## Requirements

| ID | Requirement | Rationale |
| --- | --- | --- |
| `REQ-01` | `The framework MUST define a canonical minimal-sufficient-context policy that loads only the minimum necessary canonical context for the active task profile and mode, while preserving anti-hallucination and source-of-truth rules.` | Reduce token waste without letting reduced context become guessed execution. |
| `REQ-02` | `Definition of Done MUST be explicit by mode and MUST state required grounding, outputs, evidence, validation depth, escalation triggers, and what is not required for that mode.` | Operators need a clear completion bar that matches the actual execution path. |
| `REQ-03` | `Lightweight execution paths MUST be explicit for docs-only, audit-only, tiny-fix, review-only, low-risk cleanup, hotfix, and recovery or resume work, including when each path is allowed, the minimum artifacts required, the mandatory evidence or report, and the escalation boundary.` | Practical lightweight paths should be faster without becoming loose or ambiguous. |
| `REQ-04` | `The framework MUST define a lightweight set of maintainable framework-health signals that can be recorded from existing work artifacts without requiring a new analytics system.` | Repository maintainers need operational signals when routing, governance, or grounding quality starts to drift. |
| `REQ-05` | `Canonical navigation and operator guides MUST make the new policy, DoD, lightweight paths, and metrics easy to find while keeping authority centered in docs already designated as canonical.` | Discoverability should improve without creating parallel process authority. |

## Constraints

- `docs/sdd/` remains the canonical governance, process, standards, checklist, template, prompt, and AI-ops library.
- `docs/specs/` remains the canonical human-authored approval source for governed work.
- Do not weaken contract, traceability, testing, escalation, or ask-before-break rules.
- Do not turn lightweight paths into permission to skip grounding, required evidence, or explicit blockers.
- Put policy in governance, operator routing in context and prompts, and reusable output structures in templates.
- Prefer minimal, high-leverage edits over broad framework rewrites.

## Non-Goals

- no runtime product behavior change
- no new formal task-profile header tokens
- no new mandatory metrics ledger, dashboard, or automation
- no duplication of complete rules across governance, prompts, and templates
