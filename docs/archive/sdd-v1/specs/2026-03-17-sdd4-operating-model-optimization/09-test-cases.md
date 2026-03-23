---
id: "2026-03-17-sdd4-operating-model-optimization"
title: "SDD4 operating-model optimization test cases"
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
| `TC-01` | `AC-01` | Manual review | Open `AGENTS.md` and verify it keeps the loading order, authority model, task-profile routing entry, core operating rules, hard-stop behavior, and deeper-doc pointers, while detailed standards and checklists are no longer duplicated there. | `AGENTS.md` is shorter, still authoritative, and safety-critical rules are preserved by concise direct references. |
| `TC-02` | `AC-02` | Manual review | Open `docs/sdd/context/task-mode-matrix.md` and `docs/sdd/prompts/daily-operator-guide.md`, then verify `docs/README.md`, `docs/sdd/README.md`, `docs/sdd/context/ai-loading-order.md`, `docs/sdd/context/task-profiles.md`, and prompt guidance link or reference them where needed. | Common execution paths are routable from canonical entrypoints without introducing conflicting authority. |
| `TC-03` | `AC-03` | Manual review | Inspect `docs/sdd/templates/feature-package/11-implementation-report.md` and `12-review-report.md` and confirm the required schema explicitly covers scope, basis, inspected areas, changes, validation, assumptions, conflicts, residual risks, follow-ups, hallucination checks, contract drift, traceability, test evidence, and verdict. | Both report templates are more structured and evidence-oriented, and alias templates still point to the canonical versions. |
| `TC-04` | `AC-04` | Manual review | Inspect active canonical docs touched by this change and confirm legacy bridge wording does not imply `agent/` is a live canonical authority in the current repo state. | Bridge ambiguity is reduced without deleting or inventing historical content. |
