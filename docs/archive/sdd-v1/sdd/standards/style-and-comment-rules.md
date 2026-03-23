# Style, Comments, And Imports

## When To Use

Use this file when code, imports, comments, or formatting change.

## How To Use

Mirror the touched module family's local style before introducing any repository-wide preference.

## Required Output

- code that matches the touched family's formatting and import shape, with new or rewritten comments in English only
- explicit note in `02-design.md` when the approved change intentionally deviates from the local family

## Gate

Do not introduce style churn, comment churn, or import-boundary drift as unrelated cleanup.

## Rules

- match the touched family's formatting, import ordering, quote style, line wrapping, and comment density before applying a generic preference
- do not bundle broad formatting rewrites, comment rewrites, or whitespace-only churn into a behavior change
- remove unused imports from touched files before completion; do not leave touched-scope import cleanup as optional follow-up work
- remove redundant dead code and commented-out placeholder blocks inside the touched scope when safe instead of preserving them as legacy clutter
- add comments only for non-obvious guards, SQL clauses, transport exceptions, concurrency behavior, or contract-sensitive logic
- do not add narrator comments that restate the next line or placeholder comments presented as completed implementation
- write newly added or rewritten comments and Javadoc in English only
- untouched legacy non-English comments may remain only when they are outside the touched scope; do not mass-rewrite unrelated files
- shared services and common utilities must not import feature components outside explicit registries such as routing modules, Angular module declarations, or `common/SubWindow.ts`
- do not replace the repository's current thin webservice or process split, shared jQuery transport, inline `StringBuilder` SQL, or large stateful screen components with invented abstractions during unrelated work
- do not treat legacy debug code such as `console.log(...)`, empty `.catch(() => {})`, or `printStackTrace()` as acceptable style to spread into new code
