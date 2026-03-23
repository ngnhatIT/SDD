# SonarQube Triage Report

Use this canonical template for `docs/sonar/<date>-<scope>-triage.md`.

Classification must use exactly:

- `confirmed-fixable`
- `confirmed-but-risky`
- `not-reproducible`
- `likely-false-positive`
- `needs-human-decision`
- `deferred`

Decision status stays separate from classification. Recommended values are:

- `approved-fix`
- `approved-later`
- `false-positive`
- `stale`
- `needs-business-confirmation`
- `needs-technical-confirmation`
- `risky-no-auto-fix`
- `done`

## Template

```md
# SonarQube Triage Report

- Scope: `<scope>`
- Source: `<Sonar export, markdown, pasted findings, or link>`
- Reviewer: `<name>`
- Date: `YYYY-MM-DD`

## Summary

- Total issues: `<count>`
- Confirmed fixable: `<count>`
- Confirmed but risky: `<count>`
- Not reproducible: `<count>`
- Likely false positive: `<count>`
- Needs human decision: `<count>`
- Deferred: `<count>`

## Issue Details

### `<issue key or local id>`

- Issue ID: `<issue id>`
- Rule: `<rule key>`
- Severity: `<severity>`
- File: `<path>`
- Line: `<line or n/a>`
- Sonar message: `<message>`
- Current code status: `<still applies | not reproducible | likely false positive | already resolved | other>`
- Classification: `<confirmed-fixable | confirmed-but-risky | not-reproducible | likely-false-positive | needs-human-decision | deferred>`
- Decision status: `<approved-fix | approved-later | false-positive | stale | needs-business-confirmation | needs-technical-confirmation | risky-no-auto-fix | done>`
- Reason: `<why this classification and status were chosen>`
- Proposed action: `<fix now | fix later | hold for review | no action>`
- Risk / notes: `<risk, blocker, approval note, or none>`

## Fixed in this pass

| Issue ID | Files | Validation | Notes |
| --- | --- | --- | --- |
| `<issue id>` | `<files>` | `<how it was validated>` | `<notes>` |

## Not fixed in this pass

| Issue ID | Classification | Decision status | Reason | Proposed action |
| --- | --- | --- | --- | --- |
| `<issue id>` | `<classification>` | `<status>` | `<reason>` | `<action>` |

## User decision items

- `<issue id>: <decision needed>`

## Next actions

- `<next step>`
```
