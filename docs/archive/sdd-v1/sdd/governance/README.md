# Governance Rule Library

## When To Use

Use this folder when a stage gate, exception, or approval decision depends on repository policy.

## How To Use

Read only the rule that matches the decision you need to make.

Route the task first through `docs/sdd/execution/task-routing.md`, then use this folder to answer the policy question that remains.

Read `../goal-and-success-metrics.md` when the policy decision depends on delivery intent, operating principles, success signals, or the framework feedback loop.

## Core Decisions

| Decision | File |
| --- | --- |
| How must AI-assisted work behave? | `01-ai-agent-policy.md` |
| How are unsupported assumptions and hallucinated claims blocked? | `02-anti-hallucination.md` |
| What schema binding is mandatory for DB-related work? | `03-context-binding.md` |
| Does this change need a feature package? | `01-when-a-spec-is-required.md` |
| Can coding start? | `02-minimum-completeness-before-coding.md` |
| Is implementation traceable? | `03-implementation-traceability-rules.md` |
| Is review valid? | `04-review-rules.md` |
| Do tests prove the acceptance criteria? | `05-test-traceability-rules.md` |
| Is the change release-ready? | `06-release-readiness-rules.md` |
| Can the emergency path be used? | `07-emergency-change-handling.md` |
| Does this need an ADR? | `08-decision-log-policy.md` |
| What is the smallest sufficient canonical read set? | `minimal-sufficient-context-policy.md` |
| Which docs must change with the code? | `09-documentation-update-policy.md` |
| Does coded implementation follow standards? | `10-code-standards.md` |
| How are static-analysis findings triaged and remediated safely? | `11-static-analysis-triage-policy.md` |
| What happens when evidence is insufficient? | `12-uncertainty-escalation-policy.md` |
| What quality gate level has this change reached? | `12-quality-gate-levels.md` |
| Is the change done? | `definition-of-done.md` |

## Gate

If a rule fails, the change does not advance until the missing artifact or evidence is added.
