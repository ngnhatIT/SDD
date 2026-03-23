# Decision Notes

| Decision ID | Decision | Reason |
| --- | --- | --- |
| `DEC-01` | Keep `context/` as the stable repository context layer. | The repository already depends on this load order; replacing it would add risk without adding execution clarity. |
| `DEC-02` | Add a new `execution/` layer rather than overloading `context/` or `prompts/`. | Routing and task contracts are operational concerns, not stable repository context and not prompt-specific wording. |
| `DEC-03` | Keep top-level prompt filenames as thin adapters instead of deleting them. | This preserves compatibility while removing them from the authority path. |
| `DEC-04` | Introduce shared enforcement checklists instead of repeating hygiene and parity rules in every stage file. | The same rules already appear in too many active documents and are being skipped or reinterpreted. |
| `DEC-05` | Tighten classification for examples, fixtures, and review-only specs before attempting a large physical relocation. | The immediate priority is to fix the live execution path without breaking validator or example references. |
