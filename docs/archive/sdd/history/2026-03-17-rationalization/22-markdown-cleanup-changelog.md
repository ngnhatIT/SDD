# Markdown Cleanup Changelog

## 1. Execution Scope

- Execution date: `2026-03-17`
- Inputs used: `AGENTS.md`, `docs/sdd/governance/20-markdown-cleanup-inventory.md`, `docs/sdd/process/21-markdown-cleanup-plan.md`, `docs/sdd/README.md`, and `docs/sdd/governance.md`
- Approved actions executed: `9` archive moves, `0` markdown deletes

## 2. Archived Markdown Files

| Source | Archive Destination | Reason |
| --- | --- | --- |
| `docs/sdd/cleanup-changelog.md` | `docs/archive/sdd/history/2026-03-17-rationalization/cleanup-changelog.md` | Historical cleanup record from the earlier rationalization pass |
| `docs/sdd/governance/10-sdd-framework-audit-report.md` | `docs/archive/sdd/history/2026-03-17-rationalization/10-sdd-framework-audit-report.md` | Historical audit baseline, not active governance |
| `docs/sdd/migration-notes.md` | `docs/archive/sdd/history/migration/migration-notes.md` | Migration history retained for audit only |
| `docs/sdd/migration-plan.md` | `docs/archive/sdd/history/migration/migration-plan.md` | Migration ledger retained for audit only |
| `docs/sdd/process/11-sdd-framework-cleanup-migration-plan.md` | `docs/archive/sdd/history/2026-03-17-rationalization/11-sdd-framework-cleanup-migration-plan.md` | Historical cleanup-planning artifact |
| `docs/sdd/prompts/10-prompt-template-simplification-report.md` | `docs/archive/sdd/history/2026-03-17-rationalization/10-prompt-template-simplification-report.md` | Historical prompt rationalization report |
| `docs/spec-packs/2026-03-13-spec-graph-extractor.implement-new.brief.md` | `docs/archive/spec-results/briefs/2026-03-13-spec-graph-extractor.implement-new.brief.md` | Generated brief with history value but no active role |
| `docs/specs/2026-03-13-spor00101ac-review-from-rules/12-review-report.md` | `docs/archive/reviews/2026-03-13-spor00101ac-review-from-rules/12-review-report.md` | Review-only evidence moved out of `docs/specs/` |
| `docs/specs/2026-03-13-spor01401ac-review/12-review-report.md` | `docs/archive/reviews/2026-03-13-spor01401ac-review/12-review-report.md` | Review-only evidence moved out of `docs/specs/` |

## 3. Deleted Markdown Files

No markdown files were deleted. The approved plan contained no `DELETE` targets.

## 4. Active Framework Files Retained

- Canonical framework remains in `AGENTS.md`, `docs/sdd/context/`, `docs/sdd/governance.md`, `docs/sdd/governance/`, `docs/sdd/process/01-08`, `docs/sdd/checklists/`, `docs/sdd/standards/`, and `docs/sdd/templates/`.
- Canonical feature-package workflow remains in `docs/specs/README.md` and the governing packages under `docs/specs/<feature-id>/`.
- Supporting active material remains in `docs/sdd/prompts/`, `docs/sdd/foundation/`, `docs/sdd/ai-ops/`, `docs/spec-packs/`, `docs/decisions/`, `docs/sdd/README.md`, and `docs/sdd/target-architecture.md`.
- The inventory and plan remain active as execution records: `docs/sdd/governance/20-markdown-cleanup-inventory.md` and `docs/sdd/process/21-markdown-cleanup-plan.md`.

## 5. References Updated

| File | Update |
| --- | --- |
| `docs/sdd/README.md` | Replaced root-history references with `docs/archive/` locations and clarified active versus archived surfaces |
| `docs/sdd/target-architecture.md` | Updated the architecture map and placement rules to show `docs/archive/` as the history surface |
| `docs/sdd/prompts/README.md` | Repointed the prompt rationalization note to the archived report |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/README.md` | Repointed migration-history traceability to the archived migration paths |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/09-test-cases.md` | Repointed the migration-plan check to the archived migration ledger |
| `docs/specs/2026-03-16-repository-rule-sweep/02-design.md` | Repointed review-evidence anchors to `docs/archive/reviews/` |
| `docs/specs/2026-03-17-sdd-framework-rationalization/README.md` | Repointed cleanup traceability links to archived audit and migration-plan artifacts |
| `docs/specs/2026-03-17-sdd-framework-rationalization/08-acceptance-criteria.md` | Repointed evidence links to archived audit and migration-plan artifacts |
| `docs/specs/2026-03-17-sdd-framework-rationalization/10-rollout.md` | Repointed release checks to archived audit and migration-plan artifacts |

## 6. Skipped Due To Uncertainty

- Left the `docs/sdd/templates/feature/` compatibility alias files untouched pending human confirmation:
  `acceptance-criteria.md`, `api-contract.md`, `data-model.md`, `decision-notes.md`, `design.md`, `edge-cases-and-failure-modes.md`, `execution-brief.md`, `feature-brief.md`, `implementation-report.md`, `requirements.md`, `review-report.md`, `risk-log.md`, `rollout-plan.md`, `specs.md`, `task-breakdown.md`, `test-cases.md`, and `ui-ux-behavior-spec.md`.
- Left `docs/spec-packs/SPMT00101AC.md` untouched because provenance is still unclear.
- Left the pre-execution inventory and plan wording unchanged in `docs/sdd/governance/20-markdown-cleanup-inventory.md` and `docs/sdd/process/21-markdown-cleanup-plan.md` because those files are baseline records of the pre-cleanup state.

## 7. Issues Encountered

- A first bulk PowerShell move command was rejected by the shell tool because of command formatting; the cleanup was rerun as smaller, explicit move operations.
- The two review-only `docs/specs/` folders became empty after their reports moved to `docs/archive/reviews/`, so the empty directories were removed to avoid leaving misleading active-spec paths behind.
