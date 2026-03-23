# SDD Script Notes

## Spec Graph Extraction

Generate a first-pass machine-readable graph from a feature package with:

```sh
sh scripts/sdd/build_spec_graph.sh <feature-id>
```

Bare feature IDs resolve in this order:

- `docs/specs/<feature-id>/`
- `docs/specs-support/examples/<feature-id>/`
- `docs/specs-support/fixtures/<feature-id>/`

Optional output override:

- `--output <path>`

Current behavior:

- output defaults to `<resolved-feature-dir>/spec.graph.yaml`
- the governing markdown package remains the approval source of truth
- the extractor emits only nodes and links that are explicit in current markdown tables, headings, and contract-file lists
- non-extractable relationships are not guessed; they are recorded under `extraction.warnings` and `extraction.manual_authoring_needed`

Current limitations:

- contract-to-requirement and contract-to-decision links still require human authoring unless markdown states them explicitly
- entity or table links to requirements, decisions, and tasks still require human authoring unless markdown states them explicitly
- touched component nodes beyond source-base anchor file lists are not extracted in this first pass
- the extractor is deterministic, but not optimized for speed on larger full-path example packages
- no graph validator or CI gate is added by this script

## Spec-Pack Generation

Generate a spec-pack execution aid with:

```sh
sh scripts/sdd/build_spec_pack.sh <feature-id>
```

Current behavior:

- output defaults to `docs/spec-packs/<feature-id>.pack.md`
- the source package may come from `docs/specs/` or `docs/specs-support/`
- when the source package is governed work, the governing feature package remains the source of truth
- spec-packs surface source-base anchors as related code references for read-before-write
- spec-packs surface locked contract sources from owned `contracts/` or prose contract artifacts
- implementation constraints are emitted directly from repository rules instead of being inferred from prompts
- open questions are carried from the governing feature package when they exist
- incomplete source details remain explicit instead of being guessed

## Execution Brief Generation

Generate a task-specific execution brief with:

```sh
sh scripts/sdd/build_execution_brief.sh <feature-id> [--task-profile <profile>]
```

Optional request-scoped inputs:

- `--spec-pack <path|auto|n/a>`
- `--backend-spec <path|alias:backend-spec|n/a>`
- `--bug-source <path|text|n/a>`
- `--review-scope <spec|rules|spec+rules|n/a>`
- `--output <path>`

Current behavior:

- output defaults to `docs/spec-packs/<feature-id>.<task-profile>.brief.md`
- the source package may come from `docs/specs/` or `docs/specs-support/`
- when the source package is governed work, the governing feature package remains the source of truth
- classification is inferred from owned numbered feature files
- `13-risk-log.md` and `14-decision-notes.md` are surfaced automatically when the feature owns them
- unknown routing or scope inputs are written as `unknown (...)` instead of guessed
- generated briefs surface required inputs, locked contracts, task scope, constraints, done criteria, and open questions from canonical feature artifacts

## SDD2+ Companion Artifacts

When a feature owns `13-risk-log.md` or `14-decision-notes.md`, the current pack and brief generators surface them automatically.

Compatibility rule:

- older feature packages without those files still build normally
- the companion artifacts remain additive and do not change which numbered files are required

## Validation Tests

Run the validator coverage suite with:

```sh
sh scripts/sdd/test_validate_specs.sh
```

Coverage includes:

- valid reduced-path and full-path fixture packages
- missing required files
- malformed `REQ/DES/TASK/AC/TC` identifiers
- broken `TASK -> AC` and `AC -> TC` traceability
- missing prose references for owned `contracts/`
- placeholder source-base anchors such as `<...>` or `TODO`
- README artifact or classification drift
- generated spec-pack drift from the current feature package
- implementation-report and review-report baseline completeness

## Feature Package Validation

Validate one feature package with:

```sh
sh scripts/sdd/validate_specs.sh <feature-id>
```

Current checks include:

- required governed package files and baseline headings
- front matter references that should resolve to current repo or feature artifacts
- `REQ -> DES -> TASK -> AC -> TC` structure and coverage checks
- source-base anchor presence and placeholder detection
- README artifact checklist drift, including report-stage mismatch
- owned `contracts/` presence, prose references, and referenced contract file resolution
- generated spec-pack presence, required sections, and drift from canonical inputs
- implementation-report and review-report baseline completeness, plus warnings for current-template drift

Current limits:

- the validator checks structure, references, and explicit markers, not whether prose content is semantically correct
- template-drift warnings do not automatically decide whether a legacy report must be migrated now
- absence of an automated test is only checked through explicit review markers, not inferred from source code

Output format:

- `[ERROR]` means hard failure and non-zero exit
- `[WARNING]` means actionable drift that still passed validation
- every issue includes a rule source, why the rule exists, and a next action

## Framework Surface Validation

Validate canonical framework navigation and retained bridge docs with:

```sh
sh scripts/sdd/validate_framework_docs.sh
```

Current checks include:

- canonical pointers in `docs/README.md`
- self-audit and helper discoverability in `docs/sdd/README.md` and `docs/sdd/ai-ops/README.md`
- retained bridge landing docs under `agent/` when that bridge root exists
- ambiguous `agent/` mentions in selected active canonical docs

This validator does not replace the manual framework audit in `docs/sdd/ai-ops/framework-self-audit.md`.

Run the framework-surface fixture suite with:

```sh
sh scripts/sdd/test_validate_framework_docs.sh
```

Fixtures live under `scripts/sdd/test-fixtures/`. The feature-package suite copies package fixtures into temporary `docs/specs/` folders, and the framework-surface suite copies framework fixtures into temporary root folders. Both suites remove temporary artifacts when they finish.
