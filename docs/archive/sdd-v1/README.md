# SDD v1 Archive

This folder contains the documentation and tooling surface that was active before the lean SDD v2 refactor on 2026-03-23.

## Archived Surfaces

- `sdd/`: the old multi-layer framework
- `specs/`: old numbered feature-package authority
- `spec-packs-flat/`: old flat spec-pack outputs
- `specs-support/`: old examples and validator fixtures
- `decisions/`: ADRs tied to the previous framework model
- `sonar/`: old Sonar workflow docs
- `manuals/`: old onboarding and Sonar manuals

## Replacement Paths

- Feature authority now lives in `docs/spec-packs/<feature-id>/spec_pack.md`
- Non-trivial grounding now lives in `docs/spec-packs/<feature-id>/reinforcement.md`
- Completion evidence now lives in `docs/spec-packs/<feature-id>/verification.md`
- Active governance now lives in `docs/governance/`
- Active execution rules now live in `docs/execution/`
- Active standards now live in `docs/standards/`

Archived content is not authoritative unless active docs explicitly require legacy comparison.
