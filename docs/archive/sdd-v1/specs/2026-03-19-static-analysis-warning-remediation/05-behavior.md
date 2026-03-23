---
id: "2026-03-19-static-analysis-warning-remediation"
title: "Static-analysis warning remediation behavior notes"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "08-acceptance-criteria.md"
---

# Behavior

## User-Facing Behavior

- `spor01401ac` keeps the existing table layout, captions, and checkbox behavior; the change is limited to screen-reader header metadata on the existing `<th>` cells.
- `spmt00241` keeps the existing buttons, captions, and click handlers; the change is limited to unique DOM ids so the template no longer contains duplicate identifiers.

## Non-User-Facing Behavior

- `spor01501ac` and `spor01101ac` keep the current validation and update flow, but null and zero-value handling becomes explicit in code paths that static analysis reported as unsafe.
- `spmt01103ac` keeps the current supplier CSV-import write behavior for `TMT002_USER`; the remediation only removes unused constant definitions that triggered the warning.

