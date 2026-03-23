# Lean SDD v2.5

Use the repo through the active lean SDD surface. `AGENTS.md` remains the root execution contract.

## Quick Start

1. read `AGENTS.md`
2. use `docs/README.md` for the active framework surface
3. keep governed work under `docs/spec-packs/<feature-id>/`
4. run `python scripts/validate-task.py docs/spec-packs/<feature-id> <task-type> [--non-trivial] [--strict]` before closeout

## Main Paths

- `AGENTS.md`
- `docs/README.md`
- `docs/structure.md`
- `docs/operator/quick-start-prompts.md`

## Optional Local Automation

- install an optional pre-commit validator hook with `scripts/install-validate-task-hook.sh <task-folder> <task-type> [--non-trivial] [--strict]`

## Legacy

Archived v1 material lives under `docs/archive/sdd-v1/` and `scripts/archive/sdd-v1/`.
