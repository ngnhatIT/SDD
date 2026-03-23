---
id: "2026-03-17-sdd4-operating-model-optimization"
title: "SDD4 operating-model optimization requirements"
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

Optimize daily SDD4 execution guidance so humans and AI agents can route common work faster without weakening governance, traceability, or anti-hallucination controls.

## Requirements

| ID | Requirement | Rationale |
| --- | --- | --- |
| `REQ-01` | `AGENTS.md` MUST remain the root operating contract but should keep only the loading order, authority model, task-profile routing entry, core operating rules, hard-stop behavior, and pointers to deeper canonical docs.` | Reduce cognitive overload without weakening the root contract. |
| `REQ-02` | `The canonical context layer MUST gain an explicit task-mode matrix and the prompt layer MUST gain a short daily operator guide that route common execution paths without changing governance authority or task-profile precedence.` | Daily execution needs a faster path than scanning multiple files every time. |
| `REQ-03` | `Canonical implementation and review report templates MUST require stronger evidence, conflict, assumption, and verdict structure so AI-assisted work leaves auditable records.` | Reporting must better enforce anti-hallucination and traceability controls. |
| `REQ-04` | `Active canonical docs MUST reduce ambiguity around legacy bridge material and MUST NOT imply a live competing authority surface when the bridge is absent or non-canonical.` | Operators should not be misrouted to stale or non-existent bridge content. |

## Constraints

- Keep `docs/sdd/` as the canonical governance, process, standards, and templates library.
- Keep `docs/specs/` as the canonical human authoring and approval location for governed changes.
- Do not create a new authority layer, duplicate rule sets, or weaken source-of-truth order.
- Resolve conflicts in the most canonical location instead of adding parallel instructions.
- Prefer minimal-diff edits and short operator-facing guidance.

## Non-Goals

- no runtime product code changes
- no change to current task-profile precedence
- no speculative new workflow types beyond practical daily routing support
- no destructive bridge cleanup beyond minimal safe clarification in active docs
