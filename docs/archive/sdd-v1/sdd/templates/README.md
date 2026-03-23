# SDD Templates

## When To Use

Use these templates when creating or extending governed delivery artifacts.

## How To Use

1. Start with `feature-package/` for the current baseline scaffold.
2. Add `feature-package-plus/` companion files when the feature needs risk or decision tracking.
3. Use the unique standalone templates only when the numbered scaffold does not already own the artifact.
4. Use `decisions/` for ADRs and `repository/` for changelog entries.

## Minimum Canonical Set

| Template | Role | Status |
| --- | --- | --- |
| `feature-package/` | canonical numbered feature-package scaffold | canonical |
| `feature-package-plus/` | optional risk and decision companions | canonical |
| `execution-brief-template.md` | task-scoped execution brief output | canonical |
| `spec-pack-template.md` | feature-wide spec-pack output | canonical |
| `sonar-triage-report.md` | SonarQube triage artifact output | canonical |
| `feature/conflict-review.md` | canonical specialized add-on | canonical |
| `feature/linked-screen-scope.md` | canonical specialized add-on | canonical |
| `decisions/decision-record-adr.md` | ADR output | canonical |
| `repository/change-log.md` | repository changelog entry | canonical |
| `task-profile-examples.md` | support reference for request headers | support |

## Gate

If an existing template fits the artifact, do not invent a new structure.

Before implementation, the filled package must pass `docs/sdd/checklists/04-pre-implementation-gate.md`.
Before approval, use `docs/sdd/checklists/06-code-review-against-spec.md` and `docs/sdd/checklists/08-release-readiness.md`.

## Compatibility Note

`templates/feature/` is a compatibility alias layer plus two specialized add-ons. Do not treat it as a second template source.
