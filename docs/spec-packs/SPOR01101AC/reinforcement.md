# Reinforcement: SPOR01101AC

- Status: complete
- Last Updated: 2026-03-23

## 1. Grounded Sources

- `AGENTS.md`
- `docs/spec-packs/SPOR01101AC/spec_pack.md`
- `docs/execution/ai-loading-order.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/structure.md`
- `docs/standards/api-rules.md`
- `docs/standards/db-rules.md`
- `docs/standards/testing-rules.md`
- `docs/standards/schema_database.yaml`
- ordered review prompts:
  - `docs/00_Codex_CICD-CheckPrompt_FeatureLevel_Wrapper_Japanese_v1.md`
  - `docs/11_Codex_CICD-CheckPrompt_FrontEnd_Japanese_v2.md`
  - `docs/12_Codex_CICD-CheckPrompt_BackEnd_Japanese_v2.md`
  - `docs/13_Codex_CICD-CheckPrompt_DB_Japanese_v2.md`
- inspected implementation:
  - Angular component/template
  - Java init/search/check-link/get-detail/create/check-warning/update/trash processes, DTOs, and webservices

## 2. Consistency Checks

- pack vs code:
  - the function exists across FE/BE/DB-touching layers and is not a diff-only surface
  - confirmed mismatches exist in search date filtering, deadline-release handling, detail edit scope, bulk update validation, and permissions
- pack vs standards:
  - this is non-trivial review work because it spans multiple module families and DB-touching logic
  - a reinforcement artifact was missing before this review and has now been added to satisfy the governed flow
- pack/code vs schema authority:
  - `schema_database.yaml` confirms `TAMT024_PARTNERSTORE`, `TAMT026_PRODUCTAGREEMENT`, and `TAMT029_GROUP`
  - the same authority file does not contain the main transaction tables used by the implementation (`TAOR59_ANACORDERREQUEST`, `TAOR70_ANACORDER`, `TAOR71_REQUESTNOCONTROL`, `TAOR72_ANACORDERHISTRY`, `TAPR04_SCHEDULEDFORDELIVERYFILE`, `TAPR11_ANACPURCHASESLIPDETAIL`)
  - DB-structure correctness for those objects is therefore not fully defensible from the active authority surface alone

## 3. Ambiguities

- `ステータス` vs `検索対象`
  - why it matters: search branching and UI enablement can drift if the dropdown meaning is assumed incorrectly
  - current handling: use the canonical spec's grounded cases only; treat extra branch logic as unsupported
- `表示区分` binding/default
  - why it matters: the layout shows the field but the item metadata source is incomplete
  - current handling: judge only the explicit filter behavior, not an inferred master binding
- `発注番号` `R`/`P` ambiguity
  - why it matters: numbering service and UI/search consistency depend on it
  - current handling: follow the canonical spec's preferred `R` handling and do not infer broader approval for `P`

## 4. Risks

- deadline-release logic is inconsistent across the UI banner/state model and backend validation
  - impact: rows that should remain actionable can be blocked, while the UI can remain editable without the modeled lock state
  - mitigation: implement a single release policy across FE and BE
- edited quantity is persisted to a field that the rest of the workflow does not use as the source of truth
  - impact: detail save, search display, and bulk order creation can disagree
  - mitigation: align save/read/grouping on one quantity source
- unsupported search-target branch behavior exists in code without grounded spec approval
  - impact: users can get behavior outside the canonical contract
  - mitigation: remove or formally govern the extra branches
- no automated coverage exists for the feature
  - impact: regressions in search, deadline logic, and bulk update are unguarded
  - mitigation: add focused FE/BE/integration tests

## 5. Stop Conditions

- do not claim DB-structure alignment for tables absent from `docs/standards/schema_database.yaml`
- do not infer message text, transaction boundaries, rollback detail, or physical `ANAC発注` table names beyond what the canonical spec explicitly states
- do not approve extra `検索対象` behavior beyond the grounded spec cases without a governed spec update or ADR
- do not treat partial UI validation as sufficient proof when the spec requires end-to-end behavior across FE/BE/DB

## 6. Confidence

- high
- the review is grounded in direct inspection of the canonical spec, active governance/standards, ordered review prompts, and the actual implementation files; confidence is reduced only by the active schema-authority gap and the absence of test evidence
