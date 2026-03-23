# Spec Packs

Each active governed work item lives under:

```text
docs/spec-packs/<feature-id>/
  spec_pack.md
  reinforcement.md
  verification.md
  review.md      # required for Task Type: review
  audit.md       # required for Task Type: audit
  decisions.md  # optional
```

## Rules

- `spec_pack.md` is the canonical feature artifact.
- `reinforcement.md` is mandatory for non-trivial work.
- `verification.md` is required before final closeout for `implement`, `fix`, `docs`, and `hotfix`.
- `review.md` is required before final closeout for `review`.
- `audit.md` is required before final closeout for `audit`.
- `decisions.md` is optional unless the feature has local design choices worth preserving.
- if a governed task does not already have a feature-pack home for its required artifact, create or identify one before closing the work.

## Legacy

The previous flat spec-pack outputs were archived under `../archive/sdd-v1/spec-packs-flat/`.
