# Rule Engine

## When To Use

Use before applying repository standards to implementation or review work.

## Rule Sources

A standard is enforceable only when it comes from:

- the governing feature package or owned contracts
- an approved ADR
- canonical `docs/sdd/` context or standards files that are grounded in repository evidence
- inspected source-base anchors or repeated live codebase patterns

## Resolution Order

1. governing feature package
2. owned contracts and schema authority
3. approved ADRs
4. `docs/sdd/context/`
5. this standards folder
6. inspected local module-family evidence

## Rules

- Reuse the touched family's existing pattern by default.
- Repository-promoted shared rules apply during analysis, spec authoring, implementation, bug fixing, refactor, self-review, formal review, frontend work, and backend work.
- When canonical standards promote a repeated shared utility, constant, message path, base-common flow, or validation pattern, that promoted rule outranks a weaker file-local duplicate inside the touched scope.
- Promoted repository rules for touched-scope import cleanup, formatting alignment, redundant-code removal, frontend structure reuse, responsive layout checks, paired-field alignment, and English-only new comments are mandatory across analysis, spec authoring, task planning, implementation, bug fixing, refactor, self-review, formal review, frontend work, and backend work.
- When repository evidence is mixed, classify it explicitly as `preferred current pattern`, `tolerated legacy pattern`, or `required migration pattern` instead of flattening it into a false universal rule.
- `Preferred current pattern` means repeated live evidence plus shared or newer anchor support; new or touched work should move toward it when the touched family already supports that path.
- `Tolerated legacy pattern` means live legacy evidence that may stay untouched, but it is not precedent for extending the same weaker duplicate inside a touched scope that already supports the preferred current path.
- `Required migration pattern` means the touched scope already intersects a promoted shared helper, constant, validation flow, focus-out path, table-builder path, or lifecycle pattern strongly enough that analysis, implementation, self-review, and formal review must treat migration or explicit exception recording as mandatory.
- Do not introduce a new pattern, layer, naming rule, or code-shape rule without explicit justification in approved design or an ADR.
- Do not enforce a rule that cannot be traced to real repository evidence.
- Use `auto-codebase-rules.md` only for rules already promoted from repeated repository evidence.
- Minimal-patch scope is not a valid reason to ignore a promoted repository rule that already applies to the touched concern.
- Analysis, design, implementation, self-review, and review must record which promoted rule classification was applied for each touched SQL, validation, helper, message, focus-out, table, search-lifecycle, responsive-layout, comment-language, or transport concern that has mixed repository evidence.

## Gate

If a rule choice cannot be traced to repository evidence or approved design, or if the rule classification for mixed evidence is missing, stop and record the gap instead of inventing a new standard.
