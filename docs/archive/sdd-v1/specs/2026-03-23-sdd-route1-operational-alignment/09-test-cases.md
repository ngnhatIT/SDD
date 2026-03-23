---
id: "2026-03-23-sdd-route1-operational-alignment"
title: "SDD Route 1 operational alignment test cases"
owner: "Codex"
status: "ready-for-implementation"
last_updated: "2026-03-23"
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
| `TC-01` | `AC-01` | Manual review | Inspect `docs/sdd/context/ai-loading-order.md`, `docs/sdd/governance/01-ai-agent-policy.md`, `docs/sdd/execution/task-input-header.md`, and `docs/sdd/templates/execution-brief-template.md`. | Stable fixed context versus variable task context is explicit and placed in the correct existing layers. |
| `TC-02` | `AC-02` | Manual review | Inspect `docs/sdd/governance/minimal-sufficient-context-policy.md` and `docs/sdd/process/99-ai-checklist.md`. | Broader exploration requires a short why/scope/expected-result note, and narrow reading remains the default. |
| `TC-03` | `AC-03` | Manual review | Inspect `docs/sdd/execution-profiles/codex.md` and `docs/sdd/execution-profiles/copilot.md`. | Both profiles define three hypotheses first, shortest-path verification first, and hypothesis-tied minimal reading. |
| `TC-04` | `AC-04` | Manual review | Inspect `docs/sdd/execution/contracts/recover-context.md`, `docs/sdd/ai-ops/09-recovery-mode.md`, `docs/sdd/ai-ops/agent-clients-and-handoff.md`, `docs/sdd/templates/feature-package/11-implementation-report.md`, and `docs/sdd/templates/feature-package/12-review-report.md`. | Restart packets are short and logs are reduced to root-cause excerpts by default. |
| `TC-05` | `AC-05` | Manual review | Inspect updated prompt and checklist files. | Requirement clarification, design review, traceability review, and document refactoring support is short, discoverable, and still subordinate to contracts and governance. |
| `TC-06` | `AC-06` | Manual review | Inspect the final changed-file set and implementation or review evidence. | Only existing SDD folders are used, no parallel control surface was added, and implementation plus review evidence exists. |
