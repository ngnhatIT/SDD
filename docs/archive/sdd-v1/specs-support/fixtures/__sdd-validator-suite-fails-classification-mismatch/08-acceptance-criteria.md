---
id: "fixture-valid-full-path"
title: "Full path validator fixture acceptance criteria"
owner: "SDD Test Suite"
status: "ready-for-implementation"
last_updated: "2026-03-13"
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
| `AC-01` | `REQ-01` | The fixture export endpoint returns a CSV stream for an authorized request. | Response sample |
| `AC-02` | `REQ-02` | The fixture keeps contracts and generated spec-pack aligned with the source package. | Validator and build output |
