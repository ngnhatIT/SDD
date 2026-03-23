# Prompt Alias: Fix From Review

Use `fix-from-review-report.md` as the canonical prompt.

Mandatory carry-over rules:

- fix only grounded findings
- do not widen scope
- reuse repository-promoted shared helpers, constants, messages, base-common flows, table helpers, and validation parity checks when the touched finding requires them
- if DB-related scope exists, load `docs/sdd/governance/03-context-binding.md` and `docs/sdd/context/schema_database.yaml` before editing
- re-run self-review before claiming the finding is closed
