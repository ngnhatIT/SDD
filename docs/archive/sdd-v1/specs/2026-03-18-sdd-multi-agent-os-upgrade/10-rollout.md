# Rollout

## Rollout Type

- `docs-only framework update`

## Deployment Steps

1. Update the governing feature package and complete the redesign in `docs/sdd/`, `docs/specs/README.md`, and related entrypoints.
2. Move non-canonical support packages and historical cleanup records to their new support or archive roots.
3. Run a manual consistency pass across authority order, links, routing, prompt-to-contract mapping, checklist references, and generated artifact paths.
4. Rebuild or refresh any generated packs, briefs, or graphs that still point at moved support packages.
5. Record the upgrade report and implementation evidence.
6. Hand the framework change to review before relying on the new operating model for later repository work.

## Release Checks

- Confirm `docs/specs/` only contains governed approval-source packages.
- Confirm `docs/specs-support/` contains the non-canonical examples and fixtures still needed for tooling or format reference.
- Confirm `docs/archive/` contains the relocated historical migration, cleanup, and review-only material.
- Confirm `scripts/sdd/build_spec_pack.sh`, `scripts/sdd/build_execution_brief.sh`, `scripts/sdd/build_spec_graph.sh`, and `scripts/sdd/validate_specs.sh` resolve both canonical and support package roots.

## Rollback

1. Revert the documentation changes in the same branch if the new routing or authority path is inconsistent.
2. Restore the prior canonical entrypoints if a broken link or missing bridge blocks normal work.
3. Move support packages or historical files back only if path cleanup itself proves incompatible with repository tooling.

## Operational Notes

- No runtime deployment is required.
- No database, API, or product rollback steps are required.
- Historical artifacts remain in the repository under `docs/archive/`, but they must not be on the active execution path after this change.
