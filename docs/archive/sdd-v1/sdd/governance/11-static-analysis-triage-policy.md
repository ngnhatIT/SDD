# Static-Analysis Triage Policy

## When To Use

Use this rule for SonarQube or equivalent static-analysis finding work, including triage-only passes, triage-plus-safe-fix passes, and later remediation from an approved triage artifact.

## How To Use

1. Treat the static-analysis finding source as advisory input.
2. Inspect each finding against the current codebase before deciding whether it still applies.
3. Classify each finding with the required classification model below.
4. Fix only findings that are both currently valid and safe for the active task profile and governance path.
5. Record every non-fixed, stale, false-positive, risky, deferred, or human-decision item in the canonical triage artifact.
6. For later remediation, read the approved triage artifact first and update it in the same pass.

## Required Output

- finding source used
- current-code validation result for each issue
- classification for each issue
- decision status for each issue
- triage artifact path
- fixed-item summary and non-fixed-item summary

## Gate

No static-analysis finding may be fixed blindly from scanner output alone.

## Mandatory Rules

1. SonarQube findings are advisory inputs, not auto-authoritative commands.
2. Each SonarQube finding must be validated against the current code state before remediation.
3. No finding may be fixed blindly from scanner output alone.
4. Only findings confirmed to still apply and safe to remediate may be auto-fixed.
5. If a finding is stale, not reproducible, likely false positive, behavior-changing, or requires human judgment, it must not be auto-fixed.
6. Such findings must be recorded in a triage artifact for human review and later follow-up.
7. Any fix applied from SonarQube triage must preserve intended business behavior and follow existing coding standards.
8. Comments must be in English.
9. Classification must use exactly these values: `confirmed-fixable`, `confirmed-but-risky`, `not-reproducible`, `likely-false-positive`, `needs-human-decision`, `deferred`.
10. Decision status must remain separate from classification. Recommended decision status values are: `approved-fix`, `approved-later`, `false-positive`, `stale`, `needs-business-confirmation`, `needs-technical-confirmation`, `risky-no-auto-fix`, `done`.
11. `sonar-triage` creates or updates the triage artifact and does not change code.
12. `sonar-triage-and-fix` may fix only findings classified as `confirmed-fixable` that are still safe under the current governance path; every non-fixed finding must still be recorded in the triage artifact.
13. `sonar-fix-from-triage` may fix only findings whose decision status is explicitly `approved-fix` for the current pass.
14. Findings marked `false-positive`, `stale`, `needs-business-confirmation`, `needs-technical-confirmation`, `risky-no-auto-fix`, `approved-later`, or `done` must not be edited in the current remediation pass.
15. When a finding is completed from the triage artifact, update the artifact decision status to `done` and record the remediation note in the same artifact.
16. A triage artifact is the canonical SonarQube working artifact, but it does not replace a governing feature package when the resulting remediation is non-trivial or otherwise governed by the normal spec rules.

## Classification Model

| Classification | Meaning | Auto-Fix Allowed |
| --- | --- | --- |
| `confirmed-fixable` | the issue still applies and a behavior-preserving fix is clear | `yes, if the active task profile and governance path allow it` |
| `confirmed-but-risky` | the issue still applies but the fix may change behavior or widen scope | `no` |
| `not-reproducible` | the issue cannot be reproduced from the current code state | `no` |
| `likely-false-positive` | current evidence strongly suggests the tool warning is not technically valid | `no` |
| `needs-human-decision` | the issue depends on business or architectural judgment | `no` |
| `deferred` | the issue is acknowledged but intentionally held for later work | `no` |

## Artifact Rule

- Canonical path: `docs/sonar/<date>-<scope>-triage.md`
- Use `docs/sdd/templates/sonar-triage-report.md` as the required structure.
- Create the artifact during phase A when SonarQube work starts.
- Update the same artifact during phase B when approved remediation is applied later.

## Stop Conditions

- the current code no longer supports the claimed finding and classification is unclear
- the fix would alter visible behavior, contract shape, schema semantics, or another ask-before-break surface without approval
- the triage artifact is missing or lacks approval state for `sonar-fix-from-triage`
- the scanner output, governing feature package, and current code disagree in a way that cannot be resolved from approved evidence
