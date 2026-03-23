---
id: "2026-03-16-repository-rule-sweep"
title: "Repository-wide rule sweep acceptance criteria"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01` | `AGENTS.md` tells implementers to check sibling flows, cross-layer validation parity, constant catalogs, explicit contract gaps, and manual regression evidence when automated tests are absent. | Updated root operating contract |
| `AC-02` | `REQ-02` | Backend standards explicitly require parity review across sibling process flows when shared-table filter or row-selection behavior changes. | Updated backend standard |
| `AC-03` | `REQ-03` | Frontend standards explicitly block new silent `.catch(...)` handling in user-visible transport flows and require documented parity when frontend mirrors backend validation. | Updated frontend standard |
| `AC-04` | `REQ-04` | Validation guidance explicitly states that duplicated frontend and backend validation must be reviewed together with backend as final authority. | Updated validation standard |
| `AC-05` | `REQ-05` | Review checklist and review rules explicitly check sibling-flow parity, silent catches, validation parity, and contract-gap handling. | Updated review checklist and guidance |
| `AC-06` | `REQ-06` | QA and review guidance explicitly require manual regression evidence when automated tests are absent in the touched area. | Updated QA checklist and review guidance |
