# Specs Support

`docs/specs-support/` holds non-canonical spec-shaped artifacts that still need stable repository paths.

## What Belongs Here

- governed examples under `examples/`
- validator and tooling fixtures under `fixtures/`

## What Does Not Belong Here

- approval-source feature packages
- active governed implementation, fix, or review packages
- archived review-only evidence

Those belong in:

- `docs/specs/` for governed approval-source packages
- `docs/archive/reviews/` for archived review-only evidence

## Operating Rule

Support packages may be used for:

- format reference
- generator or validator coverage
- prompt or tooling examples

They are never the approval source for unrelated product work.
