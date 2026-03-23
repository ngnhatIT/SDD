---
id: "2026-03-19-static-analysis-warning-remediation"
title: "Static-analysis warning remediation implementation report"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-19"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
---

# Implementation Report

## Delivered Scope

- Added `scope` or `scope="colgroup"` metadata to the reported `spor01401ac` table headers.
- Replaced the duplicate `btnSearch` DOM ids in `spmt00241` with unique ids while preserving the existing click handlers and labels.
- Added explicit null guards before the reported `compareTo(...)` calls in `Spor01501acCheckUpdateProcess` and `Spor01501acUpdateProcess`.
- Kept the `Spor01101acUpdateAlarmProcess` zero-divisor protection explicit by switching the reported guard to `orderLot.signum() != 0` before `remainder(...)`.
- Renamed the local `Spor01101acSearchRecCntProcess` helper from `emptyToBlank(...)` to `nullToEmpty(...)` so it no longer duplicates a parent private method name.
- Removed the redundant bare `return;` from `Spor01101acUpdateProcess.beforeProcessing(...)`.
- Removed the unused password-named constants from `Spmt01103ACConstant`.
- Rewrote `Spmt01103ACConstant` comments in English while preserving the remaining constant values and class shape.

## Anchors Reviewed

- Frontend:
  - `src/main/webapp/angular/src/app/components/spor01401ac/spor01401ac.component.html`
  - `src/main/webapp/angular/src/app/components/spmt00241/spmt00241.feature.component.html`
  - `src/main/webapp/angular/src/app/components/spmt00241/spmt00241.feature.component.ts`
- Backend:
  - `src/main/java/jp/co/brycen/kikancen/spmt01103ac/constant/Spmt01103ACConstant.java`
  - `src/main/java/jp/co/brycen/kikancen/spor01501accheckupdate/process/Spor01501acCheckUpdateProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spor01501acupdate/process/Spor01501acUpdateProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spor01101acupdate/process/Spor01101acUpdateAlarmProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spor01101acsearch/process/Spor01101acSearchAllRecProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spor01101acsearch/process/Spor01101acSearchRecCntProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spor01101acupdate/process/Spor01101acUpdateProcess.java`
  - `src/main/java/jp/co/brycen/kikancen/spor01101accreate/process/Spor01101acCreateProcess.java`
- Schema authority:
  - `docs/sdd/context/schema_database.yaml`

## Verification

- `TC-01`: passed by direct inspection of the updated HTML files. Every reported `spor01401ac` `<th>` now carries `scope`, and `spmt00241` now uses `btnAuthGpSearch` plus `btnSetAllAuth` instead of duplicate `btnSearch` ids.
- `TC-02`: passed by direct inspection of the reported `compareTo(...)` and `remainder(...)` sites in the touched Java processes.
- `TC-03`: passed by direct inspection. The duplicate-helper-name warning is addressed in `Spor01101acSearchRecCntProcess`, the redundant bare `return;` is removed from `Spor01101acUpdateProcess`, and the unused password-named constants are absent from `Spmt01103ACConstant`.
- `TC-04`: passed via `mvn -q -DskipTests compile`.

## Self-Review

- Touched-scope enforcement: pass
- Self-review checklist: pass
- Blocking self-findings: none

## Residual Risk And Confidence

- Confidence: `medium`
- Basis: the implemented changes are narrow and compile-clean, but the user-provided warning list contains one `Spor01101acCreateProcess` redundant-return finding that is not reproducible from the current workspace source, so no code diff was applied there.
- Residual risk: if the original static-analysis run was produced from a different source snapshot, one warning in `Spor01101acCreateProcess` may still need a follow-up fix against that other snapshot.
