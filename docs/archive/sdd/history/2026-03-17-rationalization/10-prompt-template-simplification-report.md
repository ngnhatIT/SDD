# Prompt And Template Simplification Report

## 1. Objective

Simplify the SDD prompt library and template library so they are smaller, clearer, and easier for humans and AI agents to execute without prompt drift, format drift, or workflow confusion.

This report stays within the current cleaned SDD scope:

- prompt library under `docs/sdd/prompts/`
- template library under `docs/sdd/templates/`
- governing SDD docs and the active framework-rationalization feature package as source of truth

## 2. Current Prompt Inventory

| Path | Purpose | Trigger Or Use Case | Expected Inputs | Expected Outputs | Overlap | Needed After Cleanup |
| --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/prompts/create-spec.md` | create or update a governed feature package | new governed work, spec change before code change, impact recording in spec | feature path, request or ticket, existing package when updating | updated `docs/specs/<feature-id>/` package and owned contracts | overlaps lightly with impact-analysis work because impact belongs in `02-design.md` | `yes` |
| `docs/sdd/prompts/implement-feature.md` | implement from an approved feature package | approved governed implementation | feature path, optional spec-pack, optional backend helper | repository changes plus updated implementation evidence | overlaps lightly with fix flows on shared implementation constraints | `yes` |
| `docs/sdd/prompts/review-feature.md` | review against approved artifacts or rules | governed review, rules-only review, no-spec discovery audit, test-gap review | review target, feature path when governed, optional spec-pack, review scope | findings-first review note and governed `12-review-report.md` when required | overlaps with codebase audit and test-gap analysis, which it can already absorb | `yes` |
| `docs/sdd/prompts/fix-from-review-report.md` | implement fixes from review findings | approved review findings already exist | feature path, review report, optional spec-pack | targeted fixes plus updated implementation and review evidence | overlaps lightly with implementation prompt on edit discipline | `yes` |
| `docs/sdd/prompts/generate-spec-pack.md` | generate or refresh a spec-pack | feature owns or needs a pack | feature path, output pack path, optional manifest | `docs/spec-packs/<feature-id>.pack.md` | distinct generation workflow | `yes` |
| `docs/sdd/prompts/generate-execution-brief.md` | generate or refresh a task-scoped execution brief | one task needs a deterministic reading packet | feature path, task profile, optional spec-pack, helper inputs | `docs/spec-packs/<feature-id>.<task-profile>.brief.md` | distinct generation workflow | `yes` |
| `docs/sdd/prompts/core/recover-context.md` | regain grounded task state | interrupted work, uncertainty spike, lost direction | current task header, feature path when governed, changed files or reports | recovery note with next grounded step | distinct utility | `yes` |
| `docs/sdd/prompts/core/self-review.md` | run implementation self-review | after implementation and verification, before completion claim | current task header, feature path when governed | self-review findings and updated `11-implementation-report.md` | overlaps slightly with pre-merge audit, but timing and artifact target are different | `yes` |
| `docs/sdd/prompts/core/pre-merge-audit.md` | run final merge-readiness audit | before merge, release signoff, or final done claim | current task header, feature path when governed, review scope | merge-readiness findings and completion recommendation | overlaps slightly with review, but covers final gate rather than first-pass review | `yes` |

## 3. Current Template Inventory

### 3.1 Canonical Templates

| Path | Purpose | Canonical Status | Prompts That Should Point To It | Overlap | Simplification Note | Decision |
| --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/templates/README.md` | template library entrypoint | canonical index | all prompt selection docs | low | now tightened to show the minimum canonical set explicitly | keep and tighten |
| `docs/sdd/templates/feature-package/README.md` | canonical package README template | canonical | `create-spec.md` | low | strong already; no structural duplication issue | keep |
| `docs/sdd/templates/feature-package/01-requirements.md` | requirements file structure | canonical | `create-spec.md` | low | tightened into a direct section skeleton | keep and tighten |
| `docs/sdd/templates/feature-package/02-design.md` | design and source-base-anchor structure | canonical | `create-spec.md` | low | retains the anchor contract and now gives a stable output skeleton | keep and tighten |
| `docs/sdd/templates/feature-package/03-data-model.md` | data-model structure | canonical | `create-spec.md` | low | tightened with data-scope, guard-rule, and compatibility sections | keep and tighten |
| `docs/sdd/templates/feature-package/04-api-contract.md` | prose contract structure | canonical | `create-spec.md` | low | tightened with explicit request, response, and compatibility sections | keep and tighten |
| `docs/sdd/templates/feature-package/05-behavior.md` | user-visible behavior structure | canonical | `create-spec.md` | low | tightened with flow and validation sections | keep and tighten |
| `docs/sdd/templates/feature-package/06-edge-cases.md` | failure and edge handling structure | canonical | `create-spec.md` | low | tightened with an edge-case matrix and failure-routing sections | keep and tighten |
| `docs/sdd/templates/feature-package/07-tasks.md` | task plan structure | canonical | `create-spec.md` | low | tightened with a stable task table and sequencing block | keep and tighten |
| `docs/sdd/templates/feature-package/08-acceptance-criteria.md` | acceptance criteria structure | canonical | `create-spec.md` | low | tightened with a stable evidence table | keep and tighten |
| `docs/sdd/templates/feature-package/09-test-cases.md` | test case structure | canonical | `create-spec.md` | low | tightened with a stable coverage table | keep and tighten |
| `docs/sdd/templates/feature-package/10-rollout.md` | rollout and rollback structure | canonical | `create-spec.md` | low | tightened with release, rollback, and post-release sections | keep and tighten |
| `docs/sdd/templates/feature-package/11-implementation-report.md` | implementation evidence structure | canonical | `implement-feature.md`, `fix-from-review-report.md`, `core/self-review.md` | low | tightened into a reusable evidence skeleton | keep and tighten |
| `docs/sdd/templates/feature-package/12-review-report.md` | review report structure | canonical | `review-feature.md` | low | tightened with findings table and verdict shape | keep and tighten |
| `docs/sdd/templates/feature-package/changelog.md` | feature changelog pointer | canonical | `create-spec.md`, `implement-feature.md` | medium with repository changelog template | okay, but depends on repository template clarity | keep |
| `docs/sdd/templates/feature-package-plus/README.md` | companion-template entrypoint | canonical | `create-spec.md` | low | tightened to clarify when companion artifacts should exist | keep and tighten |
| `docs/sdd/templates/feature-package-plus/13-risk-log.md` | risk log structure | canonical | `create-spec.md`, `implement-feature.md`, `fix-from-review-report.md` | low | tightened with a reusable risk table | keep and tighten |
| `docs/sdd/templates/feature-package-plus/14-decision-notes.md` | decision notes structure | canonical | `create-spec.md`, `implement-feature.md` | low | tightened with a reusable decision table | keep and tighten |
| `docs/sdd/templates/spec-pack-template.md` | feature-wide pack structure | canonical | `generate-spec-pack.md` | low | tightened into a stable section order with field expectations | keep and tighten |
| `docs/sdd/templates/execution-brief-template.md` | task-scoped brief structure | canonical | `generate-execution-brief.md` | low | tightened into a stable section order with field expectations | keep and tighten |
| `docs/sdd/templates/task-profile-examples.md` | task-profile request examples | support reference | `README.md`, quick guide | low | support file, not an output template | keep as support |
| `docs/sdd/templates/decisions/decision-record-adr.md` | ADR output structure | canonical | `create-spec.md` when ADR is required | low | already distinct and sufficiently clear | keep |
| `docs/sdd/templates/repository/change-log.md` | repository changelog entry structure | canonical | `implement-feature.md`, `fix-from-review-report.md` | low | tightened to point at canonical numbered paths | keep and tighten |
| `docs/sdd/templates/feature/conflict-review.md` | linked-code and shared-value conflict review | canonical specialized add-on | `review-feature.md`, `create-spec.md` when shared-value analysis is needed | low | distinct and structured enough | keep |
| `docs/sdd/templates/feature/linked-screen-scope.md` | linked-screen impact note | canonical specialized add-on | `create-spec.md`, `review-feature.md` when shared-screen scope matters | low | distinct and structured enough | keep |

### 3.2 Compatibility Alias Templates

| Path | Purpose | Canonical Status | Prompts That Should Point To It | Overlap | Simplification Note | Decision |
| --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/templates/feature/README.md` | explains alias layer | compatibility only | none directly | low | should stay explicit that it is not a second template source | keep |
| `docs/sdd/templates/feature/specs.md` | alias for package README | compatibility alias | none directly | complete overlap with `feature-package/README.md` | alias only | keep as alias |
| `docs/sdd/templates/feature/requirements.md` | alias for `01-requirements.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/design.md` | alias for `02-design.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/data-model.md` | alias for `03-data-model.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/api-contract.md` | alias for `04-api-contract.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/ui-ux-behavior-spec.md` | alias for `05-behavior.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/edge-cases-and-failure-modes.md` | alias for `06-edge-cases.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/task-breakdown.md` | alias for `07-tasks.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/acceptance-criteria.md` | alias for `08-acceptance-criteria.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/test-cases.md` | alias for `09-test-cases.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/rollout-plan.md` | alias for `10-rollout.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/implementation-report.md` | alias for `11-implementation-report.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/review-report.md` | alias for `12-review-report.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/risk-log.md` | alias for `13-risk-log.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/decision-notes.md` | alias for `14-decision-notes.md` | compatibility alias | none directly | complete overlap | alias only | keep as alias |
| `docs/sdd/templates/feature/feature-brief.md` | alias-style shortcut to package README | compatibility alias | none directly | complete overlap with `feature-package/README.md` | alias naming can mislead new users | keep as alias |
| `docs/sdd/templates/feature/execution-brief.md` | alias for execution brief template | compatibility alias | none directly | complete overlap with `execution-brief-template.md` | alias only | keep as alias |

## 4. Overlap Analysis

Biggest remaining prompt overlap:

1. `implement-feature.md` and `fix-from-review-report.md` legitimately share edit-discipline rules, but they stay distinct because their triggers and expected evidence differ.
2. `review-feature.md`, test-gap analysis, and no-spec audit scenarios overlap. The cleaner answer is to make `review-feature.md` explicitly cover those modes instead of reintroducing separate audit prompts.
3. `core/self-review.md` and `core/pre-merge-audit.md` are adjacent but distinct. One is the implementer gate; one is the final ship gate.

Biggest remaining template overlap:

1. The numbered scaffold is canonical, while `templates/feature/*` remains an alias layer. The duplication burden is already removed, but the aliases still need to stay clearly non-canonical.
2. `feature-package/changelog.md` and `repository/change-log.md` intentionally split local and repository release outputs; the split is acceptable once the path references are canonical.
3. No separate canonical template currently exists for change-impact reports, handover reports, or codebase-audit reports. Adding them now would expand the template surface without a stronger approved workflow need.

## 5. Retained Prompt Set

### 5.1 Primary Prompts

| Prompt | Clear Purpose | Clear Trigger | Expected Output | Canonical Template Link |
| --- | --- | --- | --- | --- |
| `create-spec.md` | author or update governed specs | feature package creation, spec change, governed impact capture | updated feature package | `docs/sdd/templates/feature-package/`, `docs/sdd/templates/feature-package-plus/` |
| `implement-feature.md` | implement approved governed change | implementation starts after package approval | code plus updated implementation evidence | `docs/sdd/templates/feature-package/11-implementation-report.md` |
| `review-feature.md` | review governed work or rules-only audit | formal review, discovery audit, test-gap review | findings-first review note and governed review report when required | `docs/sdd/templates/feature-package/12-review-report.md` |
| `fix-from-review-report.md` | close review findings | existing review report or approved findings | code fixes plus updated implementation and review evidence | `docs/sdd/templates/feature-package/11-implementation-report.md`, `docs/sdd/templates/feature-package/12-review-report.md` |
| `generate-spec-pack.md` | build execution pack | spec-pack creation or refresh | generated spec-pack | `docs/sdd/templates/spec-pack-template.md` |
| `generate-execution-brief.md` | build task brief | task-specific startup brief needed | generated execution brief | `docs/sdd/templates/execution-brief-template.md` |

### 5.2 Utility Prompts

| Prompt | Clear Purpose | Clear Trigger | Expected Output | Canonical Template Link |
| --- | --- | --- | --- | --- |
| `core/recover-context.md` | restore grounded context | interruption or uncertainty | recovery note | `n/a` |
| `core/self-review.md` | self-check before completion | after implementation and verification | self-review findings plus updated implementation report | `docs/sdd/templates/feature-package/11-implementation-report.md` |
| `core/pre-merge-audit.md` | final merge gate | before merge or final done claim | merge-readiness findings | `docs/sdd/templates/feature-package/12-review-report.md` when governed |

## 6. Dropped Or Merged Prompt Set

No new prompt files are dropped in this pass because the previous rationalization already removed the redundant variants.

Historical merges that remain correct:

| Old Prompt | Canonical Replacement | Why It Stays Merged |
| --- | --- | --- |
| `update-spec.md` | `create-spec.md` | create and update flows are one operational prompt |
| `review-code-without-spec.md` | `review-feature.md` | rules-only review is a review mode, not a separate prompt |
| `derive-rules-from-codebase.md` | none retained | encouraged scope expansion beyond the cleaned SDD path |

## 7. Retained Template Set

Minimum useful canonical template set:

| Template | Purpose | Status |
| --- | --- | --- |
| `docs/sdd/templates/feature-package/` | canonical numbered feature-package scaffold | retained |
| `docs/sdd/templates/feature-package-plus/` | optional risk and decision companions | retained |
| `docs/sdd/templates/spec-pack-template.md` | canonical spec-pack output shape | retained |
| `docs/sdd/templates/execution-brief-template.md` | canonical execution-brief output shape | retained |
| `docs/sdd/templates/feature/conflict-review.md` | specialized shared-value conflict review | retained |
| `docs/sdd/templates/feature/linked-screen-scope.md` | specialized linked-screen scope note | retained |
| `docs/sdd/templates/decisions/decision-record-adr.md` | ADR output | retained |
| `docs/sdd/templates/repository/change-log.md` | repository changelog entry | retained |
| `docs/sdd/templates/task-profile-examples.md` | request-format support reference | retained as support, not as an output template |

## 8. Dropped Or Merged Template Set

No new template files are removed in this pass.

The previously merged state remains the right canonical direction:

| Previous Duplicate Set | Canonical Replacement | Current Status |
| --- | --- | --- |
| full artifact bodies under `docs/sdd/templates/feature/*` | matching files under `feature-package/` or `feature-package-plus/` | keep aliases only; do not point prompts at them |
| old execution-brief body under `docs/sdd/templates/feature/execution-brief.md` | `docs/sdd/templates/execution-brief-template.md` | keep alias only |

Human-confirmation item that remains open:

- whether the compatibility alias files under `docs/sdd/templates/feature/` can be removed later without breaking bookmarks or team habits

## 9. Recommended Prompt-Template Mappings

| Prompt | Primary Artifact Produced | Canonical Template(s) | Notes |
| --- | --- | --- | --- |
| `create-spec.md` | `docs/specs/<feature-id>/` numbered files | `feature-package/`, `feature-package-plus/` | use `02-design.md` for governed change-impact capture |
| `implement-feature.md` | implementation plus `11-implementation-report.md` | `feature-package/11-implementation-report.md` | update other numbered files only when behavior or contracts changed |
| `review-feature.md` | `12-review-report.md` or standalone audit note | `feature-package/12-review-report.md` | rules-only audit and test-gap review are modes of this prompt |
| `fix-from-review-report.md` | code fixes plus refreshed evidence | `feature-package/11-implementation-report.md`, `feature-package/12-review-report.md` | keep fixes grounded to findings |
| `generate-spec-pack.md` | `docs/spec-packs/<feature-id>.pack.md` | `spec-pack-template.md` | execution aid only |
| `generate-execution-brief.md` | `docs/spec-packs/<feature-id>.<task-profile>.brief.md` | `execution-brief-template.md` | task-scoped execution aid only |
| `core/recover-context.md` | recovery note | none | utility prompt |
| `core/self-review.md` | self-review summary in implementation evidence | `feature-package/11-implementation-report.md` | utility prompt |
| `core/pre-merge-audit.md` | merge-readiness note | `feature-package/12-review-report.md` when governed | utility prompt |

## 10. Final Simplification Summary

The prompt set is already near the minimum useful size after the prior cleanup. This pass improves it by tightening selection guidance and making each retained prompt explicitly distinct by trigger, output, and stop condition rather than by small wording differences.

The template set is also already close to the right minimum shape. The main remaining improvement is not more consolidation, but stronger canonical bodies for the numbered scaffold so AI agents can fill them consistently without inventing section structures.

Key simplification outcomes:

- keep one prompt for spec authoring, one for implementation, one for review, one for review-fix work, two generation prompts, and three utilities
- keep one canonical numbered template scaffold and one optional companion scaffold
- keep alias templates only as compatibility shims, not as a second output source
- avoid introducing separate prompts or templates for change-impact, handover, test-gap, or codebase-audit work when the current retained set can absorb those modes safely

Remaining human confirmation:

1. whether the compatibility alias files under `docs/sdd/templates/feature/` should eventually be removed
2. whether the framework should later introduce dedicated change-impact or handover outputs, instead of keeping those concerns inside the current numbered artifacts
