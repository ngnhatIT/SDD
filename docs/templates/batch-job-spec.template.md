# Batch/Job Spec: <function-id> - <title>

- Status: draft | approved | implemented
- Function Type: `batch-job`
- Owner: <team-or-person>
- Last Updated: YYYY-MM-DD
- Originating Pack: `docs/spec-packs/<feature-id>/spec_pack.md`
- Related ADRs: `none` | `docs/decisions/ADR-XXXX-<slug>.md`

## Purpose

- describe a background, scheduled, manual-run, or event-driven job in operational detail so delivery and support teams can defend reruns, failures, and recovery

## Use When

- trigger, schedule, retry, recovery, alerting, reconciliation, or idempotency are the main risk
- the work runs outside a direct user request or continues after the triggering request

## Do Not Use When

- the dominant risk is a synchronous API contract
- the work is primarily a screen flow or a user-driven report or export action

## Mandatory Sections

- `Traceability`
- `Trigger And Operational Context`
- `Inputs, Preconditions, And Dependencies`
- `Processing Steps And State`
- `Outputs, Retry, Idempotency, And Recovery`
- `Monitoring, Alerting, And Reconciliation`
- `Risks And Open Questions`

## Optional Sections

- manual backfill or replay runbook
- throughput or window estimates
- retention or archive rules

## Review Focus

- duplicate-run safety and restart behavior
- dependency readiness and late-data handling
- failure visibility, alerting, and operator action
- reconciliation and compensating steps

## Typical Risks If Omitted

- double processing or missed processing
- orphaned partial state after failure
- silent operational failures with no alert path
- operators cannot recover safely under incident pressure

## 1. Traceability

| Field | Required | Value |
| --- | --- | --- |
| Source requirement or ticket | yes | |
| Originating pack | yes | `docs/spec-packs/<feature-id>/spec_pack.md` |
| Job id or process name | yes | |
| Related ADRs | conditional | `none` |
| Implementation refs | yes | |
| Validation or evidence refs | yes | |
| Release or change note | no | |

## 2. Trigger And Operational Context

- trigger type and owner:
- schedule or invocation rule:
- runtime environment:
- operator or system dependencies:

## 3. Inputs, Preconditions, And Dependencies

| Input | Source | Required | Validation | Notes |
| --- | --- | --- | --- | --- |
| | | | | |

- preconditions:
- external or internal dependencies:

## 4. Processing Steps And State

1. step
2. step
3. step

- state markers or checkpoints:
- concurrency or locking rule:

## 5. Outputs, Retry, Idempotency, And Recovery

- outputs and side effects:
- retry policy:
- idempotency rule:
- recovery or rerun rule:

## 6. Monitoring, Alerting, And Reconciliation

- logs, metrics, and alerts:
- reconciliation source and frequency:
- operator action on failure:

## 7. Risks And Open Questions

- risk or open question
