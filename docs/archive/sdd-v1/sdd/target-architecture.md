# Target SDD Architecture

## When To Use

Use this file when deciding where new framework material belongs or when checking whether the current framework shape is still coherent.

## Architecture Levels

### Root Contract

- `AGENTS.md`

This is the root operating contract for agents. It routes reading order and non-negotiable stop rules, but it should not become a second full standards library.

### Canonical Framework

- `docs/sdd/`
- `docs/specs/README.md`
- `docs/specs/<feature-id>/`
- `docs/decisions/`

This is the live approval and workflow system.

### Supporting Execution Aids

- `docs/spec-packs/`
- `docs/sdd/prompts/`
- `docs/sdd/foundation/`
- `docs/sdd/ai-ops/`

These help humans and AI agents execute faster. They do not approve changes.

### History And Bridge

- `docs/archive/sdd/`
- `docs/archive/spec-results/`
- `docs/archive/reviews/`
- retained legacy bridge roots such as `agent/` when present

These are not the normal start path for active work.

## Current Canonical Layout

```text
docs/
  archive/
    reviews/
    sdd/
      history/
    spec-results/
  README.md
  decisions/
  spec-packs/
  specs/
    README.md
    <change-id>/
      README.md
      01-requirements.md
      02-design.md
      03-data-model.md
      04-api-contract.md
      05-behavior.md
      06-edge-cases.md
      07-tasks.md
      08-acceptance-criteria.md
      09-test-cases.md
      10-rollout.md
      11-implementation-report.md
      12-review-report.md
      13-risk-log.md
      14-decision-notes.md
      changelog.md
      contracts/
      spec-pack.manifest.yaml
  sdd/
    README.md
    context/
    governance.md
    governance/
    process/
    checklists/
    standards/
    templates/
      feature-package/
      feature-package-plus/
      execution-brief-template.md
      spec-pack-template.md
      feature/
    prompts/
    foundation/
    ai-ops/
    target-architecture.md
optional retained bridge roots when present:
  agent/
```

## Placement Rules

| Artifact type | Location |
| --- | --- |
| Root execution contract | `AGENTS.md` |
| Repository workflow, gates, rules, standards, templates | `docs/sdd/` |
| Governing feature requirements, design, tasks, acceptance, tests, rollout, review | `docs/specs/<change-id>/` |
| Feature-owned machine-readable contracts | `docs/specs/<change-id>/contracts/` |
| Generated execution aids | `docs/spec-packs/<change-id>.pack.md` and related brief files |
| Archived framework history and cleanup records | `docs/archive/sdd/` |
| Archived generated results no longer part of the active execution surface | `docs/archive/spec-results/` |
| Archived review-only evidence outside governing feature packages | `docs/archive/reviews/` |
| Cross-cutting framework or architecture decisions | `docs/decisions/` |
| Repository release history | `CHANGELOG.md` |
| Legacy bridge only when retained | `agent/` |

## Recommended Cleanup Direction

- Keep one obvious canonical path: `AGENTS.md` -> `docs/sdd/context/` -> `docs/sdd/governance.md` -> `docs/specs/README.md` -> governing feature package.
- Keep supporting execution aids, but reduce them to a smaller number of stronger files.
- Keep one canonical template scaffold and treat compatibility aliases as non-authoritative.
- Keep history visible under `docs/archive/`, but do not let it read like active workflow guidance.
- Reduce any retained legacy bridge root such as `agent/` to an explicit bridge only.

## Gate

If a new file creates a second source of truth for an existing role, merge, tighten, or remove the duplicate before treating it as part of the target architecture.
