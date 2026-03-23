---
id: "2026-03-17-sdd4-mode-driven-efficiency"
title: "SDD4 mode-driven efficiency test cases"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-17"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs: []
test_refs: []
---

# Test Cases

| ID | Acceptance Link | Test Type | Procedure | Expected Result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Manual review | Inspect `docs/sdd/governance/minimal-sufficient-context-policy.md`, `docs/sdd/context/ai-loading-order.md`, `docs/sdd/context/task-profiles.md`, `docs/sdd/prompts/daily-operator-guide.md`, and `docs/sdd/prompts/quick-guide.md`. Confirm the policy owns minimal-context rules and the other docs point to it instead of restating a second full rule set. | A single canonical policy defines minimal sufficient context and supporting docs only reference or apply it. |
| `TC-02` | `AC-02` | Manual review | Inspect `docs/sdd/governance/definition-of-done.md` and any aligned checklist update. Confirm each required mode names grounding, outputs, evidence, validation depth, escalation triggers, and not-required items. | Mode-based completion expectations are explicit and governance-owned. |
| `TC-03` | `AC-03` | Manual review | Inspect `docs/sdd/context/task-mode-matrix.md` and `docs/sdd/prompts/daily-operator-guide.md`. Confirm docs-only, audit-only, tiny-fix, review-only, low-risk cleanup, hotfix, and recovery or resume guidance define allowed use, minimum artifacts, evidence or reports, and escalation boundaries. | Lightweight paths are operationally clear and still safety-bounded. |
| `TC-04` | `AC-04` | Manual review | Inspect `docs/sdd/ai-ops/framework-health-metrics.md` and `docs/sdd/ai-ops/README.md`. Confirm each metric defines meaning, value, lightweight recording guidance, and problematic trend signals. | Metrics guidance is practical, maintainable, and helper-only. |
| `TC-05` | `AC-05` | Manual review | Inspect `docs/README.md`, `docs/sdd/README.md`, `docs/sdd/governance/README.md`, `docs/sdd/context/ai-loading-order.md`, `docs/sdd/context/task-profiles.md`, `docs/sdd/prompts/README.md`, and `docs/sdd/prompts/quick-guide.md`. Confirm they make the new material discoverable without recreating a second workflow hub. | Navigation improves while authority remains in the existing canonical layers. |
