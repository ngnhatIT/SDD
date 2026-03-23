# Markdown Cleanup Plan

## 1. Cleanup Objective

Convert the completed markdown inventory into a safe cleanup strategy that keeps the active SDD framework lean while preserving canonical guidance, governed feature traceability, validator fixtures, and historically useful evidence.

This plan covers every non-core markdown file from the inventory: `311` files.

Planning baseline used:

- `AGENTS.md`
- `docs/sdd/README.md`
- `docs/sdd/governance.md` and active `docs/sdd/governance/` rules
- `docs/sdd/governance/20-markdown-cleanup-inventory.md`
- `docs/sdd/process/11-sdd-framework-cleanup-migration-plan.md`
- `docs/specs/2026-03-17-sdd-framework-rationalization/README.md` and `11-implementation-report.md`

No dedicated execution brief exists for this cleanup-planning task, so the plan relies on the canonical framework docs and the completed inventory.

Planned action distribution:

- `KEEP`: `274` files
- `KEEP-TIGHTEN`: `10` files
- `MOVE-TO-ARCHIVE`: `9` files
- `NEEDS-HUMAN-CONFIRMATION`: `18` files

## 2. Cleanup Principles

- Preserve the canonical read path: `AGENTS.md -> docs/sdd/context/ -> docs/sdd/governance.md -> docs/specs/README.md -> governing feature package`.
- Do not remove governed feature packages, examples, or validator fixtures that still anchor traceability, onboarding, or tooling validation.
- Prefer `MOVE-TO-ARCHIVE` over `DELETE` whenever a file has plausible audit, provenance, or historical value.
- Treat generated outputs case by case. Referenced examples and fixtures stay; unreferenced one-off outputs leave the active surface.
- Keep support docs only when they still materially help execution; otherwise move history away from `docs/sdd/` and `docs/specs/` active paths.
- Do not delete compatibility aliases or orphan artifacts until human review clears bookmark, habit, or provenance risk.

## 3. Deletion Rules

- Delete only if the file is clearly redundant, non-canonical, not part of the active SDD process, not required for traceability, not meaningfully referenced, and not plausibly useful as history.
- Generated artifacts do not qualify for deletion by default; they must first fail the history-value test.
- Compatibility files do not qualify for deletion until bookmark and workflow dependence are checked.
- Current plan result: no file is approved for immediate `DELETE`.

## 4. Archive Rules

- Archive files that are historical, one-off, or review-only, but still worth retaining for provenance, audit, or framework evolution history.
- Preserve filenames when archiving so old references remain intelligible in commit history and archive listings.
- Group archived files by history type rather than by original active path to reduce ongoing confusion.
- Update any surviving active references in the same change that performs the archive move.

## 5. Keep Rules

- Keep active governed feature packages under `docs/specs/`, including retrospective draft packages that still help future work re-enter governed flow.
- Keep explicit example packages and validator fixtures even when generated or synthetic; they support onboarding and repository tooling.
- Keep retained prompts, AI-ops helpers, and the single SDD2+ foundation entrypoint because they still serve active execution.
- Use `KEEP-TIGHTEN` for files that stay but need stronger labeling, smaller scope, or clearer placement to avoid becoming a second source of truth.

## 6. File-By-File Action Table

| File | Current Status | Proposed Action | Target Location (if archive/move) | Confidence | Reason |
| --- | --- | --- | --- | --- | --- |
| docs/sdd/ai-ops/09-recovery-mode.md | ai ops helper; Support; inventory=KEEP | KEEP | n/a | High | Support-only helper retained by docs/sdd/README and ai-ops/README; not redundant enough to remove. |
| docs/sdd/ai-ops/agent-clients-and-handoff.md | ai ops helper; Support; inventory=KEEP | KEEP | n/a | High | Support-only helper retained by docs/sdd/README and ai-ops/README; not redundant enough to remove. |
| docs/sdd/ai-ops/README.md | ai ops helper; Support; inventory=KEEP | KEEP | n/a | High | Support-only helper retained by docs/sdd/README and ai-ops/README; not redundant enough to remove. |
| docs/sdd/cleanup-changelog.md | cleanup history; History; inventory=ARCHIVE | MOVE-TO-ARCHIVE | docs/archive/sdd/history/2026-03-17-rationalization/cleanup-changelog.md | High | Executed cleanup log should stay available for traceability, but not inside the active framework root. |
| docs/sdd/foundation/README.md | sdd2+ support; Support; inventory=KEEP | KEEP | n/a | High | Single retained foundation entrypoint still explains additive SDD2+ behavior without replacing governance. |
| docs/sdd/governance/10-sdd-framework-audit-report.md | historical audit report; History; inventory=ARCHIVE | MOVE-TO-ARCHIVE | docs/archive/sdd/history/2026-03-17-rationalization/10-sdd-framework-audit-report.md | High | Baseline audit remains useful as historical evidence, but not as active governance material. |
| docs/sdd/migration-notes.md | migration history; History; inventory=ARCHIVE | MOVE-TO-ARCHIVE | docs/archive/sdd/history/migration/migration-notes.md | High | Historical migration context has audit value but does not belong in the active docs/sdd root surface. |
| docs/sdd/migration-plan.md | migration history; History; inventory=ARCHIVE | MOVE-TO-ARCHIVE | docs/archive/sdd/history/migration/migration-plan.md | High | Historical migration context has audit value but does not belong in the active docs/sdd root surface. |
| docs/sdd/process/11-sdd-framework-cleanup-migration-plan.md | historical cleanup plan; History; inventory=ARCHIVE | MOVE-TO-ARCHIVE | docs/archive/sdd/history/2026-03-17-rationalization/11-sdd-framework-cleanup-migration-plan.md | High | Historical cleanup-planning artifact should move out of the active process folder once archived. |
| docs/sdd/prompts/10-prompt-template-simplification-report.md | historical simplification report; History; inventory=ARCHIVE | MOVE-TO-ARCHIVE | docs/archive/sdd/history/2026-03-17-rationalization/10-prompt-template-simplification-report.md | High | One-off framework rationalization report with history value only. |
| docs/sdd/prompts/core/pre-merge-audit.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/core/README.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/core/recover-context.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/core/self-review.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/create-spec.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/fix-from-review-report.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/generate-execution-brief.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/generate-spec-pack.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/implement-feature.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/quick-guide.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/README.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/prompts/review-feature.md | execution prompt; Support; inventory=KEEP | KEEP | n/a | High | Retained prompt library is part of the active execution-aid surface and was intentionally narrowed already. |
| docs/sdd/target-architecture.md | architecture support; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | Medium | Useful for framework placement and cleanup planning, but non-authoritative and easy to over-read as live process guidance. |
| docs/sdd/templates/feature/acceptance-criteria.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/api-contract.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/conflict-review.md | specialized template; Support; inventory=KEEP | KEEP | n/a | High | Specialized add-on template still owns a role not covered by the numbered scaffold. |
| docs/sdd/templates/feature/data-model.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/decision-notes.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/design.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/edge-cases-and-failure-modes.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/execution-brief.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/feature-brief.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/implementation-report.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/linked-screen-scope.md | specialized template; Support; inventory=KEEP | KEEP | n/a | High | Specialized add-on template still owns a role not covered by the numbered scaffold. |
| docs/sdd/templates/feature/README.md | compatibility template index; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | Medium | Keep as the warning/index for compatibility aliases, but keep it minimal and explicitly non-authoritative. |
| docs/sdd/templates/feature/requirements.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/review-report.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/risk-log.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/rollout-plan.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/specs.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/task-breakdown.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/test-cases.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/sdd/templates/feature/ui-ux-behavior-spec.md | compatibility alias template; Support; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Medium | Alias looks removable, but compatibility notes explicitly preserve it for older bookmarks and habits; confirm real usage before delete or archive. |
| docs/spec-packs/__sdd-validator-suite-fails-classification-mismatch.pack.md | generated spec-pack; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | High | Generated example or validator output is still referenced and operationally useful, but should stay clearly labeled as generated aid only. |
| docs/spec-packs/__sdd-validator-suite-fails-contract-reference.pack.md | generated spec-pack; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | High | Generated example or validator output is still referenced and operationally useful, but should stay clearly labeled as generated aid only. |
| docs/spec-packs/__sdd-validator-suite-fails-spec-pack-drift.pack.md | generated spec-pack; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | High | Generated example or validator output is still referenced and operationally useful, but should stay clearly labeled as generated aid only. |
| docs/spec-packs/__sdd-validator-suite-passes-full-path-valid.pack.md | generated spec-pack; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | High | Generated example or validator output is still referenced and operationally useful, but should stay clearly labeled as generated aid only. |
| docs/spec-packs/2026-03-11-example-customer-export.implement-new.brief.md | generated execution brief; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | High | Generated example brief is still referenced by feature or generator docs and should remain available, but clearly marked as generated. |
| docs/spec-packs/2026-03-11-example-customer-export.pack.md | generated spec-pack; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | High | Generated example or validator output is still referenced and operationally useful, but should stay clearly labeled as generated aid only. |
| docs/spec-packs/2026-03-13-spec-graph-extractor.implement-new.brief.md | generated execution brief; History; inventory=ARCHIVE | MOVE-TO-ARCHIVE | docs/archive/spec-results/briefs/2026-03-13-spec-graph-extractor.implement-new.brief.md | High | Historical generated brief with no active references; preserving it in archive keeps provenance without leaving active clutter. |
| docs/spec-packs/example-feature.implement-new.brief.md | generated execution brief; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | High | Generated example brief is still referenced by feature or generator docs and should remain available, but clearly marked as generated. |
| docs/spec-packs/example-feature.pack.md | generated spec-pack; Support; inventory=KEEP-TIGHTEN | KEEP-TIGHTEN | n/a | High | Generated example or validator output is still referenced and operationally useful, but should stay clearly labeled as generated aid only. |
| docs/spec-packs/SPMT00101AC.md | orphan generated pack; No; inventory=NEEDS-HUMAN-CONFIRMATION | NEEDS-HUMAN-CONFIRMATION | n/a | Low | File looks disposable, but provenance is unclear; confirm owner and purpose before either archive or delete. |
| docs/specs/__sdd-validator-suite-fails-ac-to-tc/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-ac-to-tc/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-ac-to-tc/07-tasks.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-ac-to-tc/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-ac-to-tc/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-ac-to-tc/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-ac-to-tc/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-ac-to-tc/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/03-data-model.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/04-api-contract.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/05-behavior.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/06-edge-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/07-tasks.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-classification-mismatch/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/03-data-model.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/04-api-contract.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/05-behavior.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/06-edge-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/07-tasks.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-contract-reference/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-malformed-id/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-malformed-id/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-malformed-id/07-tasks.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-malformed-id/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-malformed-id/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-malformed-id/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-malformed-id/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-malformed-id/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-missing-required-file/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-missing-required-file/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-missing-required-file/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-missing-required-file/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-missing-required-file/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-missing-required-file/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-missing-required-file/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-placeholder-anchor/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-placeholder-anchor/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-placeholder-anchor/07-tasks.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-placeholder-anchor/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-placeholder-anchor/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-placeholder-anchor/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-placeholder-anchor/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-placeholder-anchor/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/03-data-model.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/04-api-contract.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/05-behavior.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/06-edge-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/07-tasks.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-spec-pack-drift/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-task-to-ac/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-task-to-ac/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-task-to-ac/07-tasks.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-task-to-ac/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-task-to-ac/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-task-to-ac/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-task-to-ac/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-fails-task-to-ac/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/03-data-model.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/04-api-contract.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/05-behavior.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/06-edge-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/07-tasks.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-full-path-valid/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-reduced-path-valid/01-requirements.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-reduced-path-valid/02-design.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-reduced-path-valid/07-tasks.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-reduced-path-valid/08-acceptance-criteria.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-reduced-path-valid/09-test-cases.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-reduced-path-valid/10-rollout.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-reduced-path-valid/changelog.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/__sdd-validator-suite-passes-reduced-path-valid/README.md | validator fixture; Support; inventory=KEEP | KEEP | n/a | High | Reserved validator fixture explicitly allowed by docs/specs/README and needed for validation-suite coverage. |
| docs/specs/2026-03-11-example-customer-export/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/03-data-model.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/04-api-contract.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/05-behavior.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/06-edge-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/12-review-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-example-customer-export/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/12-review-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-11-repository-sdd-bootstrap/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0050ac-validation-dedup/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0050ac-validation-dedup/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0050ac-validation-dedup/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0050ac-validation-dedup/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0050ac-validation-dedup/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0050ac-validation-dedup/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0050ac-validation-dedup/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0050ac-validation-dedup/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0060ac-validation-dedup/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0060ac-validation-dedup/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0060ac-validation-dedup/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0060ac-validation-dedup/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0060ac-validation-dedup/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0060ac-validation-dedup/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0060ac-validation-dedup/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0060ac-validation-dedup/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0070-0080-validation-review/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0070-0080-validation-review/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0070-0080-validation-review/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0070-0080-validation-review/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0070-0080-validation-review/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0070-0080-validation-review/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0070-0080-validation-review/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0070-0080-validation-review/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0080ac-zairyokosei-nonnegative/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0080ac-zairyokosei-nonnegative/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0080ac-zairyokosei-nonnegative/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0080ac-zairyokosei-nonnegative/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0080ac-zairyokosei-nonnegative/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0080ac-zairyokosei-nonnegative/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0080ac-zairyokosei-nonnegative/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-btcc0080ac-zairyokosei-nonnegative/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-execution-brief-generator/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-execution-brief-generator/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-execution-brief-generator/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-execution-brief-generator/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-execution-brief-generator/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-execution-brief-generator/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-execution-brief-generator/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-execution-brief-generator/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-execution-brief-generator/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/12-review-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-sdd-governance-hardening/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spec-graph-extractor/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spec-graph-extractor/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spec-graph-extractor/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spec-graph-extractor/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spec-graph-extractor/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spec-graph-extractor/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spec-graph-extractor/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spec-graph-extractor/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spec-graph-extractor/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-spor00101ac-review-from-rules/12-review-report.md | review-only audit trail; History; inventory=ARCHIVE | MOVE-TO-ARCHIVE | docs/archive/reviews/2026-03-13-spor00101ac-review-from-rules/12-review-report.md | High | Review-only evidence should be preserved, but its current docs/specs placement makes it look like a canonical feature package. |
| docs/specs/2026-03-13-spor00701ac-draft/01-requirements.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/02-design.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/03-data-model.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/04-api-contract.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/05-behavior.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/06-edge-cases.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/07-tasks.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/08-acceptance-criteria.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/09-test-cases.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/10-rollout.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/12-review-report.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/changelog.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor00701ac-draft/README.md | draft feature package; Yes; inventory=KEEP | KEEP | n/a | High | Retrospective draft package still serves the active goal of bringing a legacy area back under governed SDD. |
| docs/specs/2026-03-13-spor01401ac-review/12-review-report.md | review-only audit trail; History; inventory=ARCHIVE | MOVE-TO-ARCHIVE | docs/archive/reviews/2026-03-13-spor01401ac-review/12-review-report.md | High | Review-only evidence should be preserved, but its current docs/specs placement makes it look like a canonical feature package. |
| docs/specs/2026-03-13-task-profile-routing/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-task-profile-routing/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-task-profile-routing/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-task-profile-routing/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-task-profile-routing/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-task-profile-routing/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-task-profile-routing/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-task-profile-routing/12-review-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-task-profile-routing/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-13-task-profile-routing/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-codebase-derived-rule-calibration/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-codebase-derived-rule-calibration/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-codebase-derived-rule-calibration/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-codebase-derived-rule-calibration/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-codebase-derived-rule-calibration/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-codebase-derived-rule-calibration/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-codebase-derived-rule-calibration/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-codebase-derived-rule-calibration/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-codebase-derived-rule-calibration/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-repository-rule-sweep/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-repository-rule-sweep/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-repository-rule-sweep/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-repository-rule-sweep/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-repository-rule-sweep/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-repository-rule-sweep/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-repository-rule-sweep/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-repository-rule-sweep/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-repository-rule-sweep/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/13-risk-log.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/14-decision-notes.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-16-sdd2-plus-framework-upgrade/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/01-requirements.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/02-design.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/07-tasks.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/08-acceptance-criteria.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/09-test-cases.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/10-rollout.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/11-implementation-report.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/13-risk-log.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/14-decision-notes.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/changelog.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/2026-03-17-sdd-framework-rationalization/README.md | feature package; Yes; inventory=KEEP | KEEP | n/a | High | Governed feature-package artifact under docs/specs; active traceability and approval history outweigh cleanup pressure. |
| docs/specs/example-feature/01-requirements.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/02-design.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/03-data-model.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/04-api-contract.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/05-behavior.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/06-edge-cases.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/07-tasks.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/08-acceptance-criteria.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/09-test-cases.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/10-rollout.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/13-risk-log.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/14-decision-notes.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/changelog.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |
| docs/specs/example-feature/README.md | example feature package; Support; inventory=KEEP | KEEP | n/a | High | Intentional example package referenced by framework docs, prompts, rollout notes, and generator examples. |

## 7. Archive Target Structure

Proposed archive layout:

```text
docs/archive/
  sdd/
    history/
      migration/
        migration-notes.md
        migration-plan.md
      2026-03-17-rationalization/
        cleanup-changelog.md
        10-sdd-framework-audit-report.md
        11-sdd-framework-cleanup-migration-plan.md
        10-prompt-template-simplification-report.md
  spec-results/
    briefs/
      2026-03-13-spec-graph-extractor.implement-new.brief.md
  reviews/
    2026-03-13-spor00101ac-review-from-rules/
      12-review-report.md
    2026-03-13-spor01401ac-review/
      12-review-report.md
```

Why this structure is worth introducing:

- It removes history from the active `docs/sdd/` and `docs/specs/` paths without destroying traceability.
- It keeps generated one-off result files separate from active example and fixture outputs under `docs/spec-packs/`.
- It gives review-only evidence a stable long-term home that no longer impersonates a canonical feature package.

## 8. Safe Execution Order

1. Freeze the canonical keep-set: confirm that the `95` canonical core files stay untouched.
2. Create the archive directory structure and, if needed, a short archive README that says archived files are non-authoritative historical material.
3. Move the `9` high-confidence archive files and update all live links in the same change.
4. Tighten retained support surfaces:
   - keep `docs/sdd/target-architecture.md` clearly labeled as support-only
   - keep `docs/sdd/templates/feature/README.md` as the explicit warning for alias-only templates
   - add or update a small `docs/spec-packs/README.md` or equivalent labeling so active packs/briefs are clearly marked as generated examples or fixtures
5. Re-run a repository reference scan after archive moves to catch stale links.
6. Run human review on the `18` uncertain items before any delete or secondary move is attempted.
7. Only after confirmation, decide whether compatibility aliases and the orphan `SPMT00101AC.md` should be deleted or archived.

## 9. Rollback Considerations

- Perform archive moves in one commit and any later delete actions in separate commits; do not mix them.
- Preserve original filenames in archive locations so a revert is path-obvious and low risk.
- Update references atomically with each move; if any active guidance starts pointing to archive unexpectedly, revert the archive-move commit.
- Keep uncertain items in place until review is complete; rollback for those should not be needed because no move should happen yet.
- If generated example or fixture outputs are accidentally moved out of active flow and tooling/examples break, restore them in place and add explicit labeling rather than deleting them.

## 10. Human Review Checkpoints

- Confirm whether any team bookmarks, onboarding notes, or automation still depend on `docs/sdd/templates/feature/*` alias paths.
- Confirm whether `docs/spec-packs/SPMT00101AC.md` has an owner, source feature package, or external consumer. If not, approve delete or archive explicitly.
- Confirm that the two SPOR review-only reports are no longer expected to live under active `docs/specs/` paths.
- Confirm that example and validator generated outputs should stay in `docs/spec-packs/` rather than moving to a separate fixtures directory in this pass.
- Confirm that the proposed `docs/archive/` layout is acceptable before path churn is introduced.

## Final Summary

1. What should remain in the active SDD framework

- All canonical framework files remain exactly where they are.
- Active governed feature packages, the retained prompt library, AI-ops helpers, the SDD2+ foundation entrypoint, the example package, the retrospective SPOR00701AC draft, and validator fixtures remain active.
- Referenced example and validator generated outputs remain in `docs/spec-packs/`, but should stay clearly labeled as generated execution aids.

2. What should move to archive

- Historical migration and rationalization records under `docs/sdd/`.
- The unreferenced `2026-03-13-spec-graph-extractor` generated brief.
- The two review-only SPOR reports that currently sit under active `docs/specs/` paths.

3. What should be deleted

- Nothing in the current approved plan. The safe path is archive-first, not delete-first.

4. What still needs human confirmation

- All `docs/sdd/templates/feature/*` compatibility alias files except the specialized add-ons and the alias README.
- The orphan generated pack `docs/spec-packs/SPMT00101AC.md`.
- The final archive taxonomy, if the repository wants different historical grouping.

5. How this cleanup improves AI navigation and execution quality

- It reduces the chance that AI starts from historical cleanup notes or review-only folders instead of the canonical SDD path.
- It keeps generated examples and fixtures available without letting one-off outputs pollute the active execution-aid surface.
- It makes compatibility aliases an explicit review item instead of letting them silently function as a second template system.
- It narrows the visible active surface for both humans and AI while preserving the audit trail needed for repository history.
