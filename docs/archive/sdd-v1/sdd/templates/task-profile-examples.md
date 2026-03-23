# Task Header Examples

Use these examples when writing task requests that need deterministic routing.

Canonical routing and header rules now live in:

- `docs/sdd/execution/task-routing.md`
- `docs/sdd/execution/task-input-header.md`

## Implement New Feature

```md
Task Profile: implement-new
Feature: docs/specs/2026-03-18-sdd-multi-agent-os-upgrade/
Spec Pack: n/a
Backend Spec: alias:backend-spec
Bug Source: n/a
Sonar Source: n/a
Triage Artifact: n/a
Review Scope: spec
Agent Profile: codex
```

## Fix From Pack

```md
Task Profile: fix-from-pack
Feature: docs/specs-support/examples/2026-03-11-example-customer-export/
Spec Pack: docs/spec-packs/2026-03-11-example-customer-export.pack.md
Backend Spec: n/a
Bug Source: n/a
Sonar Source: n/a
Triage Artifact: n/a
Review Scope: spec
Agent Profile: codex
```

## Review From Rules

```md
Task Profile: review-from-rules
Feature: docs/specs/2026-03-18-sdd-multi-agent-os-upgrade/
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Sonar Source: n/a
Triage Artifact: n/a
Review Scope: rules
Agent Profile: claude
```

## Sonar Triage

```md
Task Profile: sonar-triage
Feature: n/a
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Sonar Source: static-analysis-report.md
Triage Artifact: docs/sonar/2026-03-19-order-import-triage.md
Review Scope: n/a
Agent Profile: codex
```

## Sonar Triage And Fix

```md
Task Profile: sonar-triage-and-fix
Feature: n/a
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Sonar Source: docs/sonar-inputs/order-import-sonar.md
Triage Artifact: docs/sonar/2026-03-19-order-import-triage.md
Review Scope: n/a
Agent Profile: codex
```

## Sonar Fix From Triage

```md
Task Profile: sonar-fix-from-triage
Feature: docs/specs/2026-03-19-static-analysis-warning-remediation/
Spec Pack: n/a
Backend Spec: n/a
Bug Source: n/a
Sonar Source: n/a
Triage Artifact: docs/sonar/2026-03-19-order-import-triage.md
Review Scope: n/a
Agent Profile: codex
```

## Notes

- If `Agent Profile` is missing, use the current client profile or `auto`.
- Prompts are adapters only; use the selected execution contract as the operational source.
- `docs/specs-support/` examples are acceptable for tooling or format examples, but governed delivery still points at `docs/specs/<feature-id>/`.
