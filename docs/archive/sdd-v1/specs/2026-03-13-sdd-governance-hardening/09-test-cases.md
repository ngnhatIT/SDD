---
id: "2026-03-13-sdd-governance-hardening"
title: "SDD governance hardening for source-base anchors and style parity test cases"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "08-acceptance-criteria.md"
dependencies:
  - "08-acceptance-criteria.md"
implementation_refs:
  - "scripts/sdd/build_spec_pack.sh"
  - "scripts/sdd/validate_specs.sh"
test_refs: []
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01`, `AC-02` | Manual review | Inspect updated standards, governance files, checklists, templates, and `docs/specs/README.md`. | Anchor, style, scope, and contract parity rules are aligned and the fixed-label anchor block is documented consistently. |
| `TC-02` | `AC-02`, `AC-03` | Script | Run syntax checks for both shell scripts, then run the updated validator on feature packages with and without manifests as needed. | Shell syntax checks pass and semantic validation behavior matches the hardened contract. |
| `TC-03` | `AC-03`, `AC-04` | Script | Build and validate the `2026-03-11-example-customer-export` spec-pack with explicit Git `sh.exe`. | Build succeeds, generated pack contains the new marker sections, and validation passes. |

## Test Data Notes

- Use `C:\Program Files\Git\bin\sh.exe` because bare `sh` is not on `PATH` in this workstation.
