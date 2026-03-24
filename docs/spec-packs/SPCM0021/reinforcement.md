# Reinforcement

- Originating spec: `docs/spec-packs/SPCM0021/spec_pack.md`
- Review task: feature review for `SPCM0021` across `FE+BE+DB`
- Requested method: combine exactly these prompts in order
  - `00_Codex_CICD-CheckPrompt_FeatureLevel_Wrapper_Japanese_v2.md`
  - `11_Codex_CICD-CheckPrompt_FrontEnd_Japanese_v2.md`
  - `12_Codex_CICD-CheckPrompt_BackEnd_Japanese_v2.md`
  - `13_Codex_CICD-CheckPrompt_DB_Japanese_v2.md`
- Schema authority: `docs/standards/schema_database.yaml`

## Grounded Sources

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-contracts.md`
- `docs/structure.md`
- `docs/standards/schema_database.yaml`
- repository prompt inventory under `docs/`

## Grounded Constraints

- `AGENTS.md`, `docs/execution/ai-loading-order.md`, `docs/execution/task-contracts.md`, and `docs/structure.md` make this a non-trivial governed `review`, so `reinforcement.md` and `review.md` are required before closeout.
- The user explicitly required the review to use the exact prompt set above and to start with prompt `00` at the feature level.
- `docs/standards/schema_database.yaml` is the single source of truth for DB structure and must be used for any DB-layer verification.

## Stop Conditions

- Do not substitute `00_Codex_CICD-CheckPrompt_FeatureLevel_Wrapper_Japanese_v2.md` with `v1` or any other prompt without explicit user approval.
- Do not claim FE, BE, or DB review findings when the required wrapper prompt is unavailable and the requested review method therefore cannot be executed as instructed.
- If prompt `00` is provided or the user approves using `v1`, resume from the wrapper review first, then proceed to prompts `11`, `12`, and `13` according to scope.
