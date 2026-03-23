# Repository Standards

## When To Use

Use this folder during design and implementation for repository-specific engineering rules.

## How To Use

1. Start with `00-rule-engine.md`.
2. Then load `repository-context.md`.
3. Open only the standards that match the touched area.
4. Apply the dominant local pattern unless the governing feature package or ADR says otherwise.

## Required Output

- design notes and code that follow the repository pattern for the touched area
- explicit deviation notes in the feature package when a standard is not followed

## Gate

If a change introduces a new pattern without a design update or ADR, it does not pass review.

## Standard Map

| File | Use |
| --- | --- |
| `00-rule-engine.md` | rule source and resolution order for standards |
| `auto-codebase-rules.md` | promoted repository-derived pattern rules |
| `repository-context.md` | repo layout, runtime shape, and delivery context |
| `naming-and-module-organization.md` | naming and module placement |
| `style-and-comment-rules.md` | local formatting, comments, and import-boundary rules |
| `backend-process-architecture.md` | backend flow and package structure |
| `frontend-screen-architecture.md` | frontend screen and service structure |
| `backend-change-rules.md` | backend implementation constraints |
| `frontend-change-rules.md` | frontend implementation constraints |
| `database-change-rules.md` | SQL, schema, and transaction rules |
| `security-validation-and-logging.md` | validation, security, and logging rules |
| `testing-and-quality-signals.md` | verification expectations |
| `known-inconsistencies.md` | existing repo exceptions and known mismatches |
| `module-patterns/` | search, CSV, and file-output module families |
