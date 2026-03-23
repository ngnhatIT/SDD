# Spec Packs

Each active governed work item lives under `docs/spec-packs/<feature-id>/`.

Use `../structure.md` for the layout, naming, and task-type file contract.

## Rules

- `spec_pack.md` is the canonical feature artifact.
- `spec_pack.md` stays canonical even when the task uses companion function specs.
- `reinforcement.md` is mandatory for non-trivial work.
- `verification.md` is required before final closeout for `implement`, `fix`, `docs`, and `hotfix`.
- `review.md` is required before final closeout for `review`.
- `audit.md` is required before final closeout for `audit`.
- `decisions.md` is optional unless the feature has local design choices worth preserving.
- use `function-specs/` only when the pack needs implementation-facing detail for a dominant screen or module, API or service, batch or job, or report or import or export surface.
- use `../templates/README.md` to choose the correct companion template instead of stretching one universal spec shape.
- cross-module, reusable, security, performance, ownership, or integration decisions belong in `../decisions/`; keep one-off local rationale in `<feature-id>/decisions.md`.
- if a governed task does not already have a feature-pack home for its required artifact, create or identify one before closing the work.
- run `python scripts/validate-task.py docs/spec-packs/<feature-id> <task-type> [--non-trivial] [--strict]` before closeout to check the minimum artifact quality bar.

- use `../governance/minimal-quality.md` when checking whether an artifact is too weak to close out.

## Legacy

The previous flat spec-pack outputs were archived under `../archive/sdd-v1/spec-packs-flat/`.
