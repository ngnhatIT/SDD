---
id: "2026-03-13-task-profile-routing"
title: "Task-profile routing for agent markdown loading test cases"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs:
  - "docs/sdd/context/task-profiles.md"
  - "docs/sdd/templates/task-profile-examples.md"
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01`, `AC-02` | Manual review | Inspect `AGENTS.md`, `docs/sdd/context/ai-loading-order.md`, `docs/sdd/context/task-profiles.md`, `docs/sdd/governance.md`, `docs/sdd/governance/01-when-a-spec-is-required.md`, and `docs/sdd/governance/04-review-rules.md`. | The task profiles, prompt header, precedence, and governance boundaries are stated consistently. |
| `TC-02` | `AC-01`, `AC-02`, `AC-04` | Script | Run `validate_specs.sh` against the new feature package. | The feature package passes validation without requiring a spec-pack manifest. |
| `TC-03` | `AC-03` | Manual review | Inspect `docs/sdd/templates/task-profile-examples.md` and the `spec_back.md` policy in the routing docs. | All five request types are represented, and `spec_back.md` is documented as helper-only rather than approval source. |
