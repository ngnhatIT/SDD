# AI Checklist

## When To Use

Use for every AI-assisted task before writing, during execution, and before final output.

## Pre-Check

- [ ] Governing scope is identified from approved specs or allowed `no-spec` rules.
- [ ] Required context files are loaded.
- [ ] The task was routed through `docs/sdd/execution/task-routing.md`.
- [ ] The selected execution contract was loaded.
- [ ] The selected agent profile was loaded when agent-specific behavior matters.
- [ ] Stable fixed context versus variable task context is identified.
- [ ] `docs/sdd/spec-authoring/README.md` and `docs/sdd/checklists/spec-authoring-checklist.md` were loaded when spec authoring is in scope.
- [ ] `docs/sdd/context/schema_database.yaml` was checked when DB-related work is in scope.
- [ ] Applicable standards were selected through `docs/sdd/standards/00-rule-engine.md`.
- [ ] `docs/sdd/checklists/touched-scope-enforcement.md` was loaded when touched-scope enforcement concerns are in scope.
- [ ] Missing or conflicting evidence is recorded before work starts.

## During-Check

- [ ] Each change stays inside the grounded scope.
- [ ] No guessing is used for behavior, schema, or code patterns.
- [ ] If debugging or investigating, three likely hypotheses were recorded before deeper reading.
- [ ] Broader exploration is justified with a short why, scope, and expected result note.
- [ ] Existing repository patterns are reused unless approved design says otherwise.
- [ ] Open checklist-driven enforcement items are being addressed instead of postponed silently.
- [ ] No unnecessary files or unrelated edits were introduced.
- [ ] Full logs were not pasted when a smaller root-cause excerpt was sufficient.
- [ ] Open gaps are reported, not silently filled.

## Final-Check

- [ ] `docs/sdd/process/05-self-review.md` was completed.
- [ ] `docs/sdd/checklists/touched-scope-enforcement.md` passed for the relevant touched scope.
- [ ] Spec and spec-pack alignment were checked when a spec-pack exists.
- [ ] Schema alignment was checked when DB-related work is in scope.
- [ ] Standards compliance was checked.
- [ ] A restart or handoff summary exists when the remaining work or session context is long.
- [ ] Final output contains only evidence-grounded claims.
- [ ] No hallucinated logic or unsupported assumptions remain.

## Gate

Do not finalize if any check above fails.
