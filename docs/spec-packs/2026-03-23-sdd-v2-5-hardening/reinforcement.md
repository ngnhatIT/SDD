# Reinforcement: 2026-03-23-sdd-v2-5-hardening

- Status: complete
- Last Updated: 2026-03-23

## 1. Grounded Sources

- user request in this task thread
- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/execution/task-contracts.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/structure.md`
- `docs/governance/failure-modes.md`
- `docs/operator/quick-start-prompts.md`
- `scripts/validate-task.py`
- active folders under `docs/spec-packs/`

## 2. Consistency Checks

- active governed task folders currently use date-first slugs almost exclusively, so canonical naming should follow existing usage rather than introduce mixed standards
- the active validator still checks file presence only, so artifact quality hardening is a real missing control
- review and audit already live inside governed folders, so tying them back to `spec_pack.md` strengthens an existing pattern instead of redesigning the model
- the current docs still mention aliases and minimal validation, which conflicts with the requested low-ambiguity upgrade

## 3. Ambiguities

- some historical archived folders use external feature IDs, but those are not the dominant active pattern
- “equivalent section” wording for acceptance and findings must stay simple enough for regex checks rather than semantic parsing
- lifecycle enforcement must remain lean even though folders can accumulate evidence over time

Current handling:

- choose date-first slug naming for active governed folders and treat external IDs as spec content rather than folder naming authority
- implement keyword-based section checks with documented equivalents instead of free-form semantic validation
- enforce that one folder carries one primary lifecycle rooted in `spec_pack.md`, with review and audit treated as downstream evidence inside that same folder

## 4. Risks

- overly loose regex checks would allow placeholder artifacts to pass
- overly strict regex checks could reject legitimate concise artifacts
- documentation drift between validator rules and governance docs would recreate ambiguity instead of removing it

## 5. Stop Conditions

- stop if active docs and validator disagree on canonical task types
- stop if review or audit validation can succeed without a clear spec reference
- stop if the gap checker starts depending on language-specific parsers or broad repo indexing

## 6. Confidence

- high
- the requested hardening fits the active lean model if the validator remains heuristic-based and the docs stay tightly aligned with it
