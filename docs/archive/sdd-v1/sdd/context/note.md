# Project Memory

## Common Mistakes

- Treating `README.md` at repo root as the operating source of truth. It is still boilerplate; use `AGENTS.md` and `docs/`.
- Implementing from prompt wording without reading the governing feature package and standards.
- Updating backend behavior without checking matching frontend transport flow, SQL criteria logic, and error routing.
- Changing SQL without documenting affected tables, rollback notes, and regression-sensitive cases in the feature package.
- Claiming automated coverage where only manual verification exists.
- Adding `e.printStackTrace()` in module code instead of using `logSend()` through the shared `ILogSender` chain.
- Copying legacy `printStackTrace()`, `console.log(...)`, empty `.catch(() => {})`, or stray jQuery imports from nearby files as if they were approved current style.
- Introducing `regist` as an action suffix when the standard is `register`.
- Adding Angular component-local `.catch()` blocks without delegating to the shared `WebServiceService` error path.
- Updating a `SearchProcess` SQL WHERE clause without applying the same change to its `SearchRecCntProcess` or `SearchAllRecProcess` sibling.
- Creating an `INSERT` without all audit columns (`ENTUSRCD`, `ENTDATETIME`, `ENTPRG`, `UPDUSRCD`, `UPDDATETIME`, `UPDPRG`) or without using `SYSDATE(6)` for timestamps.
- Leaving `console.log()` debug calls in committed frontend code instead of removing them before merge.
- Silently swallowing errors with empty `.catch(() => {})` on `callWs()` promises instead of routing the error to the user.
- Not extending `BaseComponent` in feature screen components or duplicating its shared methods locally.
- Not registering a new modal sub-window in `common/SubWindow.ts` and importing the component ad-hoc from feature code.
- Replacing a touched module family with invented `controller`, `repository`, `facade`, `store`, or hook layers because they look cleaner in isolation.
- Inventing a DTO style for the whole repo instead of mirroring the touched family; backend bean-style DTOs are common in live code.
- Rewriting comments or formatting across a file when the change only needs behavior updates.
- Claiming the task is done before self-review, required artifacts, and acceptance evidence are checked.
- Pushing through low-confidence work instead of escalating uncertainty or using recovery mode.

## Recurring Review Failures

- Missing traceability from code or PR notes back to `TASK-`, `AC-`, and `TC-` items.
- Company or tenant isolation accidentally weakened in data-access changes.
- Raw SQL concatenation or unsafe parameter handling.
- Search/count/export drift caused by copy-paste changes in one path only.
- Frontend error handling that assumes indexed responses or error objects always exist.
- Hardcoded screen IDs or constants where shared constants already exist in the module family.
- Direct transport calls or invented helper abstractions that bypass the shared `webservice.service.ts` or the touched family's normal process flow.
- Style drift: non-local DTO shapes, comment churn, import-boundary violations, or broad formatting edits that make review harder without changing behavior.
- Review findings that are not severity-rated, making it harder to distinguish blockers from follow-up items.
- Completion claims that ignore missing contracts, stale reports, or unresolved low-confidence gaps.

## Legacy Traps

- `build.xml` and `build.properties` reference machine-specific paths under `C:/java_projects/...` and Eclipse plugin directories.
- Naming and package casing are not fully consistent across the repo.
- Shared frontend transport intentionally still uses jQuery `$.ajax`; do not treat that as permission to add new transport paths.
- `src/test` and Angular `.spec.ts` coverage are effectively absent today; do not imply automated coverage that the repo does not have.
- Older areas may over-enforce affected-row checks on normal `executeUpdate()` calls; do not spread that pattern blindly.
- Bundled libraries and generated output trees are part of current repo shape and should not be removed during unrelated work.
- Older branches or retained bridge trees such as `agent/` may still appear; when present they are bridge-only and never the canonical source of truth.

## Non-ADR Decisions Worth Remembering

- `docs/specs/` remains the human authoring unit.
- `docs/spec-packs/` is for generated agent execution artifacts, not approval.
- `docs/specs-support/examples/2026-03-11-example-customer-export/` is the pilot support package for contracts and spec-pack flow.
- `reduced-path` and `full-path` remain valid and should not be collapsed into one path.
- New V2 artifacts should be added only when they improve context loading, contract clarity, or agent execution.
