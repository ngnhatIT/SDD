# API Rules

- `spec_pack.md` owns approved API intent and compatibility decisions.
- Do not change request fields, response fields, DTO keys, file shapes, or error keys unless the pack explicitly approves it.
- Update machine-readable contract files in the same change when they exist.
- Default to additive and backward-compatible behavior unless a breaking change is explicitly approved.
- Preserve auth, tenant, company, and validation boundaries on API changes.
- If the contract owner is unclear, stop before editing the interface.
