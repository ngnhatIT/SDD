---
id: "2026-03-19-static-analysis-warning-remediation"
title: "Static-analysis warning remediation tasks"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
---

# Tasks

| ID | Task | Traceability |
| --- | --- | --- |
| `TASK-01` | Update the reported Angular templates so the named `<th>` and duplicate-`id` findings are resolved without changing bound behavior. | `REQ-01`, `DES-01` |
| `TASK-02` | Update the reported Java processes so nullable and zero-divisor warning paths are guarded explicitly. | `REQ-02`, `DES-02` |
| `TASK-03` | Resolve the reported Java code-smell findings by renaming local helpers and restructuring redundant control flow only where the warning is reproducible in current source. | `REQ-03`, `DES-03` |
| `TASK-04` | Remove unused password-named constants from `Spmt01103ACConstant` and record the implementation evidence and residual risk. | `REQ-04`, `DES-04` |

