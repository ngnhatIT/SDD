# DB Rules

- `docs/standards/schema_database.yaml` is the single schema authority.
- Stop if code, docs, and schema disagree.
- Do not invent tables, columns, keys, defaults, or audit behavior.
- Preserve tenant and company isolation in queries and updates.
- Apply query logic consistently across related search, count, export, and detail flows.
- Preserve the local SQL assembly and transaction pattern unless the pack explicitly authorizes a different shape.
- Keep audit columns aligned with current repository practice when inserting or updating durable data.
