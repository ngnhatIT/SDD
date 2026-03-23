# Migration Notes

## When To Use

Use this file only when tracing how the repository moved from earlier local-only guidance into the current tracked SDD system.

## Important Scope Note

This file is historical.

Do not use it as the active workflow source for implementation, review, or prompt routing. Use:

- `AGENTS.md`
- `docs/sdd/README.md`
- `docs/sdd/context/`
- `docs/sdd/governance.md`
- `docs/specs/README.md`

## Historical Caveat

Some older migration language refers to `agent/agent/`.

Those path names describe an earlier migration view, not the current live bridge tree. The repository still contains `agent/` as a legacy bridge, and canonical docs already say that `agent/` is not the primary source of truth.

## Goal Of The Original Migration

Move the repository from ad hoc delivery and local-only guidance to a tracked, repo-native Spec-Driven Development system.

## Stable Outcome That Still Matters

- `docs/sdd/` is the canonical repository framework for process, governance, standards, templates, prompts, and AI support guidance.
- `docs/specs/` is the human-authored approval source for non-trivial work.
- `docs/decisions/` holds cross-cutting decisions.
- `AGENTS.md` is the root operating contract for agents.

## What Was Preserved

Useful legacy ideas were normalized into tracked canonical docs:

- delivery flow -> `docs/sdd/process/`
- review and readiness gates -> `docs/sdd/checklists/`
- repo-specific rules -> `docs/sdd/standards/` and `docs/sdd/governance/`
- feature-package guidance -> `docs/specs/README.md` and `docs/sdd/templates/feature-package/`
- conflict-handling helpers -> canonical templates and standards

## What This File Is Not

- not the current loading order
- not the current bridge policy
- not the current target structure
- not approval to treat legacy `agent/` docs as canonical
