---
id: "2026-03-13-sdd-governance-hardening"
title: "SDD governance hardening for source-base anchors and style parity acceptance criteria"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "docs/sdd/"
  - "docs/specs/README.md"
  - "scripts/sdd/"
test_refs:
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Requirement Links | Acceptance statement | Evidence expected |
| --- | --- | --- | --- |
| `AC-01` | `REQ-01` | Repository standards, governance rules, and gates explicitly require source-base anchors, style parity, scope parity, and contract parity where applicable. | Updated rule and checklist files contain the new enforcement language |
| `AC-02` | `REQ-02`, `REQ-03` | Design templates and specs guidance require a fixed-label anchor block that scripts can validate semantically. | Updated templates and `docs/specs/README.md` contain the fixed labels and `n/a` guidance |
| `AC-03` | `REQ-03` | Spec-pack generation and validation scripts surface and check source-base anchors, scope guardrails, traceability, and conditional manifest behavior. | Generated pack contains the new sections and validator passes the sample feature |
| `AC-04` | `REQ-04` | The customer export sample feature and generated spec-pack remain valid under the hardened scripts, and the repository bootstrap design is updated to the new anchor contract. | Sample design docs contain the anchor block and required verify commands pass |
