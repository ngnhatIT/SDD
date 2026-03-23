# API/Service Spec: <function-id> - <title>

- Status: draft | approved | implemented
- Function Type: `api-service`
- Owner: <team-or-person>
- Last Updated: YYYY-MM-DD
- Originating Pack: `docs/spec-packs/<feature-id>/spec_pack.md`
- Related ADRs: `none` | `docs/decisions/ADR-XXXX-<slug>.md`

## Purpose

- describe one request or response surface in contract-first detail so backend, frontend, QA, and reviewers can verify the same behavior

## Use When

- request or response shape, auth, timeout, error handling, dependencies, or versioning are the main risk
- the change adds or changes an endpoint, service contract, or integration boundary

## Do Not Use When

- the dominant risk is screen behavior, button-state, or field-level UX
- the dominant flow is a scheduled job or a report, import, or export mapping

## Mandatory Sections

- `Traceability`
- `Endpoint Or Service Overview`
- `Request Contract`
- `Response And Error Contract`
- `Auth, Validation, Timeout, Idempotency, And Versioning`
- `Dependencies, Side Effects, And Observability`
- `Risks And Open Questions`

## Optional Sections

- machine-readable contract file refs
- migration or compatibility notes
- sequence or state diagrams

## Review Focus

- contract stability across callers
- auth and validation boundaries
- error semantics, timeout, and retry behavior
- versioning, idempotency, and dependency impact

## Typical Risks If Omitted

- DTO drift between caller and service
- undocumented auth or permission gaps
- inconsistent timeout, retry, or error handling
- hidden side effects that surface only in production

## 1. Traceability

| Field | Required | Value |
| --- | --- | --- |
| Source requirement or ticket | yes | |
| Originating pack | yes | `docs/spec-packs/<feature-id>/spec_pack.md` |
| Endpoint or service id | yes | |
| Related ADRs | conditional | `none` |
| Implementation refs | yes | |
| Validation or evidence refs | yes | |
| Release or change note | no | |

## 2. Endpoint Or Service Overview

- method or entrypoint:
- path or invocation surface:
- callers or consumers:
- sync or async:

## 3. Request Contract

| Field | Type | Required | Validation | Source | Notes |
| --- | --- | --- | --- | --- | --- |
| | | | | | |

- caller context supplied outside the body:

## 4. Response And Error Contract

### Success

| Field | Type | Notes |
| --- | --- | --- |
| | | |

### Errors

| Status or Error Key | Meaning | Caller Handling |
| --- | --- | --- |
| | | |

## 5. Auth, Validation, Timeout, Idempotency, And Versioning

- auth and permission rules:
- validation owner:
- timeout or SLA:
- idempotency or duplicate-call rule:
- versioning or compatibility rule:

## 6. Dependencies, Side Effects, And Observability

- upstream or downstream dependencies:
- data writes, events, or external calls:
- logs, metrics, and alerts:

## 7. Risks And Open Questions

- risk or open question
