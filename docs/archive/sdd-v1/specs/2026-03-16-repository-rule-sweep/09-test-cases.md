---
id: "2026-03-16-repository-rule-sweep"
title: "Repository-wide rule sweep test cases"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Test case | Evidence |
| --- | --- | --- | --- |
| `TC-01` | `AC-01` | Inspect `AGENTS.md` and confirm the new bullets cover sibling-flow parity, cross-layer validation parity, constant scanning, contract-gap recording, and manual regression evidence. | Text diff against `AGENTS.md` |
| `TC-02` | `AC-02` | Inspect `docs/sdd/standards/backend-change-rules.md` and confirm it requires sibling-flow parity checks for shared-table filter or row-selection changes. | Text diff against backend standard |
| `TC-03` | `AC-03` | Inspect `docs/sdd/standards/frontend-change-rules.md` and confirm it blocks new silent transport catches and requires documented frontend or backend validation parity. | Text diff against frontend standard |
| `TC-04` | `AC-04` | Inspect `docs/sdd/standards/security-validation-and-logging.md` and confirm it states how duplicated frontend and backend validation must be reviewed. | Text diff against validation standard |
| `TC-05` | `AC-05` | Inspect `docs/sdd/checklists/06-code-review-against-spec.md` and `docs/sdd/governance/04-review-rules.md` and confirm the new review checks are present. | Text diff against review guidance |
| `TC-06` | `AC-06` | Inspect `docs/sdd/checklists/07-qa-validation.md` and `docs/sdd/governance/04-review-rules.md` and confirm manual-regression requirements are present for areas without automated tests. | Text diff against QA and review guidance |
