# Spec Packs

`docs/spec-packs/` stores generated execution aids only.

## Sources

Generated packs and briefs may be derived from:

- governed feature packages under `docs/specs/`
- support examples or fixtures under `docs/specs-support/`

## Rule

Generated artifacts in this folder never replace the governing source package.

When a governed change exists, `docs/specs/<feature-id>/` wins on every conflict.
