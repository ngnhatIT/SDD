---
id: "SPMT00141"
title: "SPMT00141 rollout"
owner: "WMS Delivery Team"
status: "in_progress"
last_updated: "2026-03-18"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
dependencies:
  - "07-tasks.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Current Status

- Current rollout state: `partial`
- Reason: non-numbering work may proceed, but the approved `KANRIKBN` selector for the numbering row is still unresolved.

## Preconditions

- Non-numbering slices are implemented and verified.
- The canonical package is approved for implementation.
- Frontend and backend changes are ready in the same release unit.

## Deployment Shape

- Release frontend and backend family changes together.
- No feature flag is defined by this package.
- The required schema authority entries now exist.
- Numbering-dependent behavior and copy remain deferred until the approved numbering selector rule exists.

## Smoke Checklist

1. Verify init master data and new mode state.
2. Verify register and update paths for the implemented non-numbering slice.
3. Verify update preserves `PRODUCTCDHANDMADE`.
4. Verify the four new fields persist and reload correctly.
5. Verify search, delete, and CSV smoke checks remain stable.

## Rollback

- Roll back the frontend and backend family changes together if runtime behavior diverges from this package during the partial non-numbering release or after the blocker is cleared and numbering-dependent behavior is deployed.
- If future schema authority introduces additive database changes, rollback planning must include that separate schema release artifact.

## Release Notes Draft

- `SPMT00141` partially aligns the screen to the requested detail fields and manual-code handling.
- The current release adds the four new input fields, corrects master-data sources, and preserves stored manual-code data on update.
- Backend-generated `PRODUCTCD` and copy remain deferred until the numbering selector is approved.
