# Screen/Module Spec: <function-id> - <title>

- Status: draft | approved | implemented
- Function Type: `screen-module`
- Owner: <team-or-person>
- Last Updated: YYYY-MM-DD
- Originating Pack: `docs/spec-packs/<feature-id>/spec_pack.md`
- Related ADRs: `none` | `docs/decisions/ADR-XXXX-<slug>.md`

## Purpose

- describe one screen or tightly coupled UI module in implementation-facing detail without stretching the whole pack into a universal template

## Use When

- UI behavior, field rules, state transitions, permissions, or modal or subscreen flows are the main risk
- the screen has non-trivial validation, button-state, or save or submit behavior

## Do Not Use When

- the dominant risk is an API contract with little UI behavior
- the dominant flow is a background job or a file-oriented import or export

## Mandatory Sections

- `Traceability`
- `Scope And Roles`
- `UI Structure`
- `Fields And Validation`
- `State And User Flow`
- `Backend Touchpoints, Permissions, And Messages`
- `Risks And Open Questions`

## Optional Sections

- linked screens or modal inventory
- wireframe or visual references
- accessibility or localization notes
- downstream report, import, or batch impacts

## Review Focus

- user-visible state transitions and unsaved-change handling
- field-level validation and defaulting
- permission boundaries and button-state rules
- backend touchpoint correctness and message behavior

## Typical Risks If Omitted

- UI and backend drift
- hidden state bugs and stale data
- permission or validation regressions
- reviewers cannot trace field behavior to implementation or tests

## 1. Traceability

| Field | Required | Value |
| --- | --- | --- |
| Source requirement or ticket | yes | |
| Originating pack | yes | `docs/spec-packs/<feature-id>/spec_pack.md` |
| Screen or module id | yes | |
| Related ADRs | conditional | `none` |
| Implementation refs | yes | |
| Validation or evidence refs | yes | |
| Release or change note | no | |

## 2. Scope And Roles

- primary user roles and permission gate
- entry points, linked screens, and out-of-scope UI pieces

## 3. UI Structure

| Area or Component | Purpose | Notes |
| --- | --- | --- |
| | | |

## 4. Fields And Validation

| Field | Source | Required | Default | Validation or Format | Notes |
| --- | --- | --- | --- | --- | --- |
| | | | | | |

## 5. State And User Flow

- init or load flow
- search, view, edit, save, delete, submit, and refresh flow as applicable
- button enable or disable rules
- concurrency, discard, and reset behavior

## 6. Backend Touchpoints, Permissions, And Messages

| Touchpoint | Direction | When Used | Key Contract Notes |
| --- | --- | --- | --- |
| | | | |

- permissions:
- user-facing messages:

## 7. Risks And Open Questions

- risk or open question
