---
id: "<feature-id>"
title: "<feature title> behavior"
owner: "<team or person>"
status: "draft"
last_updated: "YYYY-MM-DD"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Behavior

Canonical numbered template for `05-behavior.md`.

Use this file when user-visible behavior, workflow, validation feedback, or UX handling changes.

## Entry Points

- Screen, API, or process: `<list>`
- Actors: `<user or system roles>`

## Main Flows

| Flow | Trigger | Expected Behavior | Notes |
| --- | --- | --- | --- |
| `<flow name>` | `<trigger>` | `<what the user or system sees>` | `<notes>` |

## Validation And Messages

| Case | Trigger | Expected Feedback | Owner | Shared Message Or Helper Path |
| --- | --- | --- | --- | --- |
| `<case>` | `<trigger>` | `<message or behavior>` | `<frontend or backend or both>` | `<ConstMessageID, ConstantMessageID, shared validator, or n/a>` |

## State And Guard Rules

- Preconditions: `<rules>`
- Blocking conditions: `<rules>`
- Non-changes: `<locked behavior>`
