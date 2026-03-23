# Constitution

1. Non-trivial changes MUST be governed by a feature package in `docs/specs/`.
2. Requirements, design, tasks, acceptance criteria, and test cases MUST exist before governed implementation starts.
3. Prompts MUST NOT override repository context, governance, or the governing feature package.
4. API, DTO, file, and durable data shape changes MUST update machine-readable contracts when the feature owns them.
5. Generated spec-packs MUST NOT replace the feature package as the approval or review source of truth.
6. Business logic changes MUST have verification tied to `TC-` items and recorded evidence.
7. Service, tenant, company, and auth boundaries MUST be preserved unless the governing spec explicitly changes them.
8. UTC MUST be used for new machine-readable timestamps unless an existing external contract requires another format.
9. Scope MUST stay within the governing feature package; unrelated cleanup MUST NOT be bundled into the same change.
10. Cross-cutting architectural or delivery decisions MUST be captured in `docs/decisions/`.
