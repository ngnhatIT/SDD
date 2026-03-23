---
id: "2026-03-19-static-analysis-warning-remediation"
title: "Static-analysis warning remediation test cases"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "08-acceptance-criteria.md"
  - "11-implementation-report.md"
---

# Test Cases

| ID | Test Case | Acceptance |
| --- | --- | --- |
| `TC-01` | Inspect `spor01401ac.component.html` and `spmt00241.feature.component.html` to confirm the reported `<th>` elements include `scope` and the duplicate `btnSearch` ids are replaced with unique values. | `AC-01` |
| `TC-02` | Inspect `Spor01501acCheckUpdateProcess.java`, `Spor01501acUpdateProcess.java`, and `Spor01101acUpdateAlarmProcess.java` to confirm null-safe and non-zero guards are explicit at the reported comparison and remainder sites. | `AC-02` |
| `TC-03` | Inspect `Spor01101acSearchRecCntProcess.java`, `Spor01101acUpdateProcess.java`, and `Spmt01103ACConstant.java` to confirm the helper rename, redundant-return removal, and unused-constant cleanup are present without contract changes. | `AC-03`, `AC-04` |
| `TC-04` | Run `mvn -q -DskipTests compile` to verify the touched Java sources still compile in the current workspace. | `AC-02`, `AC-03`, `AC-04` |

