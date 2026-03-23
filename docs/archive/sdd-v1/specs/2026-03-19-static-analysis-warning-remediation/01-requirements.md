---
id: "2026-03-19-static-analysis-warning-remediation"
title: "Static-analysis warning remediation requirements"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
---

# Requirements

| ID | Requirement |
| --- | --- |
| `REQ-01` | The reported Angular templates must satisfy the named static-analysis findings by adding compliant table-header accessibility attributes and removing duplicate DOM `id` usage without changing button captions, layout structure, or bound handlers. |
| `REQ-02` | The reported `spor01501ac` and `spor01101ac` backend processes must guard nullable or zero-divisor paths explicitly so the current runtime flow cannot rely on implicit null-safety or analyzer-unfriendly assumptions. |
| `REQ-03` | The reported `spor01101ac` class-level code-smell findings must be resolved by removing redundant control flow and renaming local helpers that shadow parent private methods without changing current SQL, DTO, or response behavior. |
| `REQ-04` | The reported `spmt01103ac` hard-coded-password finding must be resolved without introducing secrets, without changing stored values, and without changing the `TMT002_USER` insert shape used by the current supplier CSV-import flow. |

