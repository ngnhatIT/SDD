---
id: "2026-03-13-sdd-governance-hardening-changelog"
title: "SDD governance hardening changelog"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "README.md"
dependencies: []
implementation_refs:
  - "docs/sdd/"
  - "scripts/sdd/"
test_refs:
  - "09-test-cases.md"
---

# Feature Changelog

## 2026-03-13

### Changed

- Hardened repository standards, governance rules, and stage gates around source-base anchors, style parity, scope parity, and contract parity.
- Added a fixed-label source-base anchor block requirement to design templates and specs guidance.
- Expanded spec-pack generation and validation to surface anchors, scope guardrails, and traceability while keeping manifest checks conditional.
- Added semantic validation for feature artifact inventory, stable `REQ/DES/TASK/AC/TC` identifiers, `TASK -> AC -> TC` coverage, and machine-readable contract references.
- Added an automated validator regression suite with reduced-path and full-path fixtures, including spec-pack drift and placeholder-anchor coverage.

### Notes

- This change affects repository delivery workflow only; no runtime application behavior changed.
