---
id: "2026-03-19-static-analysis-warning-remediation"
title: "Static-analysis warning remediation edge cases"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "01-requirements.md"
  - "09-test-cases.md"
---

# Edge Cases

- When `normalizeDateKey(...)` or `buildExpirationComparisonKey(...)` returns `null`, the `spor01501ac` processes must skip string comparison instead of relying on `ValidateUtility.isEmpty(...)` for analyzer inference.
- When the update request list is empty in `Spor01101acUpdateProcess.beforeProcessing(...)`, the method must still end through the normal validation gate instead of using a redundant bare `return;`.
- When `ORDERLOT` is zero or blank in `Spor01101acUpdateAlarmProcess`, the warning-check path must skip `remainder(...)` safely.
- The current workspace copy of `Spor01101acCreateProcess` must be treated as unchanged unless a reproducible redundant `return` exists in the actual source being edited.

