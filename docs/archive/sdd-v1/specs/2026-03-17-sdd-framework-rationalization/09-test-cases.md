---
id: "2026-03-17-sdd-framework-rationalization"
title: "SDD framework rationalization test cases"
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
| `TC-01` | `AC-01` | Manual review | Open the audit report and verify that every file under `AGENTS.md`, `docs/sdd/`, `docs/specs/README.md`, and `agent/` has one row in a file-level audit table. | No in-scope framework file is missing, and each row has a role, canonical status, ratings, decision, and action. |
| `TC-02` | `AC-02` | Manual review | Inspect the audit report sections for conflicts, canonical artifacts after cleanup, prompt simplification, AI smooth-operation checklist, and target structure. | The report clearly identifies authority order, redundant areas, and the lean target structure without inventing unsupported rules. |
| `TC-03` | `AC-03` | Manual review | Open the migration plan and verify that it includes current summary, structural problems, target structure, old-to-new mapping, keep/merge/drop/rewrite sets, and safe migration order. | The plan separates immediate safe changes from follow-up moves and preserves operational continuity. |
| `TC-04` | `AC-04` | Manual review + command | Inspect the edited framework files and run `git diff -- docs/sdd agent docs/specs/2026-03-17-sdd-framework-rationalization` to confirm only documentation guidance changes were applied and risky deletions were not silently bundled. | Edited files improve authority clarity or legacy warnings, and remaining destructive cleanup is explicitly deferred or marked for confirmation. |
