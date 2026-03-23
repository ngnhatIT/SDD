---
id: "2026-03-13-sdd-governance-hardening"
title: "SDD governance hardening for source-base anchors and style parity rollout"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "docs/sdd/"
  - "scripts/sdd/"
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Deployment Order

1. Update governance, checklist, and template documents under `docs/sdd/`.
2. Update feature authoring guidance in `docs/specs/README.md`.
3. Update `scripts/sdd/build_spec_pack.sh` and `scripts/sdd/validate_specs.sh`.
4. Retrofit sample specs and regenerate the example spec-pack.
5. Publish the new ADR and governing feature package for reviewer use.

## Smoke Checks

- Confirm the updated templates show the fixed-label anchor block.
- Confirm the generated example spec-pack includes `Source Base Anchors`, `Scope Guardrails`, `Traceability Snapshot`, and `Implementation Constraints`.
- Confirm the validator passes the example feature package under Git `sh.exe`.

## Rollback

1. Revert the documentation and script changes in one branch rollback.
2. Restore the previous generated example spec-pack if the new build output is rejected.
3. Re-run the prior validation flow on the example package to confirm the rollback state.

## Release Risks

- Existing feature packages without retrofit may fail validation if maintainers opt into validating them immediately.
- Future authors may still bypass the contract if they do not run the updated validator or stage gates.

## Monitoring

- Reviewer feedback on anchor-block clarity
- Validation failures caused by missing anchor labels
- Drift between template wording and validator expectations
