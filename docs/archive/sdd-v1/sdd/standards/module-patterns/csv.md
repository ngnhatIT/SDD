# CSV Module Patterns

## When To Use

Use this file when adding or changing CSV import or export behavior.

## How To Use

Reuse the shared CSV family first, then keep feature-specific CSV behavior in a dedicated package only when the flow is not generic.

## Required Output

- CSV module choice documented in `02-design.md`
- CSV-specific verification in `09-test-cases.md`

## Gate

Do not invent a new CSV flow while an equivalent shared CSV pattern already exists nearby.

## Rules

- CSV behavior exists in shared common packages and feature-specific packages
- import and export flows reuse shared processes and DTO families where possible
- feature CSV modules usually add feature-specific request and response DTOs plus a process class
- frontend CSV import or export screens should reuse the shared modal or subwindow components and endpoint naming conventions before adding feature-local upload or download flows
- CSV import processes in this repo commonly map raw `CsvImportRequest` rows into typed row DTOs before feature preprocessing starts
- `beforeProcessing(...)` commonly performs preprocess checks, evaluates `IMPSETTING`, updates CSV history for incomplete imports, then throws `ProcessCheckErrorException` when the import must stop
- row-level preprocess failures commonly write back to `TWK004_CSVIMPHISTORYDETAIL` and mark the in-memory row status as `ERROR_ROW`
- import-level blocking messages commonly return as fatal errors with control id `Popup`
- `processing(...)` commonly dispatches by `req.settingInfo.IMPTYPE` and only implements the import modes that the touched module already supports
- import and export messages should stay on the existing message-id path instead of embedding new raw English text in screen or process code
- when a nearby CSV import counts insert or update results from `executeBatch()`, preserve that counting style instead of inventing a new counter scheme
