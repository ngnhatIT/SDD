---
id: "fixture-valid-full-path"
title: "Full path validator fixture test cases"
owner: "SDD Test Suite"
status: "ready-for-implementation"
last_updated: "2026-03-13"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs: []
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Integration | Submit one valid fixture export request. | The endpoint returns `200 OK` and a CSV stream. |
| `TC-02` | `AC-02` | Script | Build the fixture spec-pack and validate the fixture package. | Contracts and generated spec-pack stay aligned with the source package. |
