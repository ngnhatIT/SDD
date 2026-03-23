---
id: "2026-03-19-static-analysis-warning-remediation"
title: "Static-analysis warning remediation acceptance criteria"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
---

# Acceptance Criteria

| ID | Acceptance Criterion | Traceability |
| --- | --- | --- |
| `AC-01` | Every reported `<th>` in `spor01401ac.component.html` includes a compliant `scope` attribute, and `spmt00241.feature.component.html` no longer contains duplicate `id="btnSearch"` usage. | `TASK-01` |
| `AC-02` | `Spor01501acCheckUpdateProcess` and `Spor01501acUpdateProcess` use explicit null-safe conditions before `compareTo(...)`, and `Spor01101acUpdateAlarmProcess` keeps an explicit non-zero guard before `remainder(...)`. | `TASK-02` |
| `AC-03` | `Spor01101acSearchRecCntProcess` no longer declares a local helper with the same name as a parent private method, and `Spor01101acUpdateProcess.beforeProcessing(...)` no longer contains a redundant bare `return;`. | `TASK-03` |
| `AC-04` | `Spmt01103ACConstant` no longer contains unused password-named constants that trigger the reported warning, and no touched SQL insert values or column names change. | `TASK-04` |

