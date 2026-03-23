---
id: "2026-03-16-codebase-derived-rule-calibration"
title: "Codebase-derived rule calibration implementation report"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "07-tasks.md"
  - "09-test-cases.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# Implementation Report

## Delivered Scope

- Added a reduced-path governing package for this rule-calibration change.
- Updated canonical standards and bridge rules only where the scanned anchors showed repeated or explicit patterns.
- Added anchored SQL-construction, `TMT050` lookup, and shared constant-catalog guidance from live backend and frontend files.
- Added anchored frontend `.html` template guidance from the scanned search and maintenance screens.
- Left unsupported or conflicting patterns out of new rules and recorded the relevant inconsistencies instead.

## Anchors Reviewed

- Frontend: `spvm00131.component.ts`, `spvm00131.component.html`, `spmt00231.component.ts`, `spmt00231.component.html`, `Const.ts`, `ConstMessageID.ts`, `DisplayScreenId.ts`, `ConstCcd.ts`, `ConstCcdDef.ts`
- Backend: `Spvm00131SearchAllProcess.java`, `Spvm00131UpdateProcess.java`, `Spmt00231SearchAllRecProcess.java`, `Spmt00231CsvImportProcess.java`, `Spmt01102ACCsvImportProcess.java`, `Btcc0080acProcess.java`, `MasterNameGetProcess.java`, `MasterCodeCheckProcess.java`, `Tmt050AllKbnSearchProcess.java`, `Bcc0030acProcess.java`, `ConstantValue.java`, `FuncID.java`, `ConstCcd.java`, `ConstCcdDef.java`
- Web services: `Spvm00131WebService.java`, `Spmt00231DeleteWebService.java`, `Spmt01102ACCsvImportWebService.java`, `Btcc0080acWebService.java`

## Verification

- Manual inspection against `TC-01` to `TC-07`
- `validate_specs.sh 2026-03-16-codebase-derived-rule-calibration` passed via `C:\Program Files\Git\bin\sh.exe`

## Intentionally Not Promoted To Rules

- Clear-button behavior was not promoted because the scanned search screens do not agree on whether clear should reload saved conditions.
- Focus-out master lookup behavior was not promoted beyond existing guarded-search wording because the scanned anchors did not show the same pattern across both frontend screens.
- An absolute repo-wide `TMT050` must always join `VMT050_ALL` rule was not promoted because scanned live modules still contain direct `TMT050_NAME` joins; the rule was narrowed to preserving the touched family and keeping `VMT050_ALL` where that family already uses it.
- `.html` block-name attribute style was not promoted because the scanned screens differ between raw `name=\"block...\"` and bound `[attr.name]` constants.

## Unresolved Items

- None for this docs-only scope
