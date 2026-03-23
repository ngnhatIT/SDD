# Coding Rules

- Preserve the dominant local module family before introducing a new abstraction.
- Inspect sibling flows when touching search, count, export, update, delete, or save behavior.
- Keep diffs narrow. Do not mix unrelated cleanup into governed work.
- Reuse shared error, logging, and transport paths instead of inventing new ones.
- Do not claim repo-wide style changes from one local pattern.
- Keep comments and formatting changes minimal unless the pack explicitly asks for broader cleanup.
- When behavior depends on nearby legacy code, mirror the proven local pattern and record any exception in the feature pack.
