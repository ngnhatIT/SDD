# Canonical Task Header

Use this header when a request should route deterministically.

`Agent Profile` is optional. If it is missing, use the current client profile or `auto`.

```md
Task Profile: implement-new | fix-from-pack | fix-from-bug | review-from-pack | review-from-rules | sonar-triage | sonar-triage-and-fix | sonar-fix-from-triage
Feature: docs/specs/<feature-id>/ | n/a
Spec Pack: docs/spec-packs/<feature-id>.pack.md | n/a
Backend Spec: <path> | alias:backend-spec | n/a
Bug Source: <ticket/path/markdown/text> | n/a
Sonar Source: <path/export/markdown/text> | n/a
Triage Artifact: docs/sonar/<date>-<scope>-triage.md | n/a
Review Scope: spec | rules | spec+rules | n/a
Agent Profile: codex | claude | copilot | auto
```

## Rules

- `Task Profile` controls governed workflow routing.
- `Agent Profile` controls operating behavior, not authority.
- The header carries variable routing context only. Stable operating rules stay in `AGENTS.md`, `docs/sdd/context/`, `docs/sdd/governance/`, the selected execution contract, and the selected execution profile.
- Keep current error, failing diff, and issue details outside the header block as task-local context.
- When current issue or log context accompanies the header, keep only the root-cause excerpt plus target files or failing checks unless a longer excerpt is required to resolve the blocker.
- If the header is missing, route through `docs/sdd/execution/task-routing.md`.
- If the header conflicts with governance, governance wins.
- `Sonar Source` is required for `sonar-triage` and `sonar-triage-and-fix`.
- `Triage Artifact` is required for `sonar-fix-from-triage` and optional when phase A updates an existing artifact.
