# Migration Plan And Applied Inventory

## When To Use

Use this file when you need the per-file migration record for repository markdown content.

## How To Use

Read the inventory rows to see how a legacy file was classified, where its useful content went, and whether it was merged, moved, rewritten, or deleted.

## Required Output

- a traceable answer for where migrated markdown content lives now
- a record of what was deleted versus preserved

## Gate

Do not use this file as an active workflow guide. It is a historical migration record.

This file records how the repository markdown files were classified and migrated into the canonical SDD structure.

Historical path note:

- references to `agent/agent/` in this file describe the earlier migration inventory, not the current live `agent/` bridge tree
- for active workflow authority, use `AGENTS.md`, `docs/sdd/README.md`, and `docs/specs/README.md`
## Classification Key

- `keep`: file remains the canonical version in place
- `move`: file content survives under a new canonical path
- `merge`: useful content is folded into one or more canonical files, then the source file is removed
- `rewrite`: file stays but its contents are substantially replaced to fit the target structure
- `delete`: file is obsolete and removed with no surviving unique value
- `split`: one source file is broken into smaller canonical files

## Pre-Migration Moves Already Applied

| Source | Action | Destination | Why | Duplicated With | Split Notes |
| --- | --- | --- | --- | --- | --- |
| `docs/adr/README.md` | move | `docs/decisions/README.md` | canonical decision folder renamed from adr to decisions | docs/decisions/README.md | none |
| `docs/adr/ADR-0001-spec-driven-delivery-framework.md` | move | `docs/decisions/ADR-0001-spec-driven-delivery-framework.md` | canonical ADR location renamed | docs/decisions/ADR-0001-spec-driven-delivery-framework.md | none |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/requirements.md` | move | `docs/specs/2026-03-11-repository-sdd-bootstrap/01-requirements.md` | feature package standardized to numbered artifacts | 01-requirements.md | none |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/design.md` | move | `docs/specs/2026-03-11-repository-sdd-bootstrap/02-design.md` | feature package standardized to numbered artifacts | 02-design.md | none |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/tasks.md` | move | `docs/specs/2026-03-11-repository-sdd-bootstrap/07-tasks.md` | feature package standardized to numbered artifacts | 07-tasks.md | none |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/acceptance.md` | split | `docs/specs/2026-03-11-repository-sdd-bootstrap/08-acceptance-criteria.md; docs/specs/2026-03-11-repository-sdd-bootstrap/09-test-cases.md` | acceptance criteria and test cases must be separate artifacts | 08-acceptance-criteria.md; 09-test-cases.md | split acceptance from test cases |

## Markdown Inventory

| Source | Action | Destination | Why | Duplicated With | Split Notes |
| --- | --- | --- | --- | --- | --- |
| `.github/PULL_REQUEST_TEMPLATE.md` | keep | `.github/PULL_REQUEST_TEMPLATE.md` | canonical PR review contract | none | none |
| `agent/agent/checklists/README.md` | merge | `docs/sdd/checklists/README.md` | canonical checklist library replaced local-only checklist index | docs/sdd/checklists/README.md | none |
| `agent/agent/checklists/review-quick-gates.md` | merge | `docs/sdd/checklists/06-code-review-against-spec.md` | review quick gates preserved in canonical review checklist | docs/sdd/checklists/06-code-review-against-spec.md | none |
| `agent/agent/checklists/spec-pack-completeness.md` | merge | `docs/specs/README.md; docs/sdd/checklists/04-pre-implementation-gate.md` | spec completeness is now part of package standard and pre-implementation gate | docs/specs/README.md | none |
| `agent/agent/checklists/sql-change-checklist.md` | merge | `docs/sdd/standards/database-change-rules.md; docs/sdd/checklists/06-code-review-against-spec.md` | SQL-specific review rules preserved in canonical standards and review checklist | docs/sdd/standards/database-change-rules.md | none |
| `agent/agent/pipeline/01-task-intake.md` | merge | `docs/sdd/process/01-intake.md` | intake flow migrated into canonical process docs | docs/sdd/process/01-intake.md | none |
| `agent/agent/pipeline/02-context-loading.md` | merge | `docs/sdd/process/01-intake.md; docs/sdd/README.md` | context-loading guidance is now part of playbook usage, not a separate process file | docs/sdd/README.md | none |
| `agent/agent/pipeline/03-spec-pack-flow.md` | merge | `docs/specs/README.md; docs/sdd/process/04-task-planning.md` | spec-pack concept replaced by numbered feature package standard | docs/specs/README.md | none |
| `agent/agent/pipeline/04-implementation-flow.md` | merge | `docs/sdd/process/05-implementation.md; docs/sdd/process/06-tests-and-verification.md` | implementation and verification flow split into separate canonical stages | docs/sdd/process/05-implementation.md; docs/sdd/process/06-tests-and-verification.md | split implementation from tests and verification |
| `agent/agent/pipeline/05-review-and-verify.md` | merge | `docs/sdd/process/07-review.md; docs/sdd/process/08-release.md; docs/sdd/checklists/06-code-review-against-spec.md` | review and release flow split into separate canonical stages and checklist gates | docs/sdd/process/07-review.md; docs/sdd/process/08-release.md | split review from release |
| `agent/agent/pipeline/06-conflict-management-flow.md` | merge | `docs/sdd/standards/conflict-management.md` | conflict workflow preserved as standards guidance | docs/sdd/standards/conflict-management.md | none |
| `agent/agent/pipeline/README.md` | merge | `docs/sdd/README.md` | SDD playbook is the canonical flow entrypoint | docs/sdd/README.md | none |
| `agent/agent/PROMPTS.md` | delete | `none` | local prompting aid, not a repo source of truth | AGENTS.md | none |
| `agent/agent/rules/00-repo-scope.md` | merge | `docs/sdd/standards/repository-context.md` | repo scope belongs in canonical repository context | docs/sdd/standards/repository-context.md | none |
| `agent/agent/rules/01-agent-working-mode.md` | merge | `AGENTS.md; docs/sdd/governance/03-implementation-traceability-rules.md` | agent execution rules belong in AGENTS and governance | AGENTS.md | none |
| `agent/agent/rules/10-backend-screen-stack.md` | merge | `docs/sdd/standards/backend-process-architecture.md` | backend screen stack guidance preserved in backend architecture standards | docs/sdd/standards/backend-process-architecture.md | none |
| `agent/agent/rules/11-backend-sql-and-transactions.md` | merge | `docs/sdd/standards/database-change-rules.md` | SQL and transaction rules preserved in canonical DB standards | docs/sdd/standards/database-change-rules.md | none |
| `agent/agent/rules/12-backend-validation-and-errors.md` | merge | `docs/sdd/standards/security-validation-and-logging.md` | validation and error rules preserved in canonical standards | docs/sdd/standards/security-validation-and-logging.md | none |
| `agent/agent/rules/13-backend-security-and-config.md` | merge | `docs/sdd/standards/security-validation-and-logging.md` | security and config rules preserved in canonical standards | docs/sdd/standards/security-validation-and-logging.md | none |
| `agent/agent/rules/14-backend-sql-review-specifics.md` | merge | `docs/sdd/standards/database-change-rules.md; docs/sdd/checklists/06-code-review-against-spec.md` | SQL review specifics preserved in DB standards and code-review checklist | docs/sdd/standards/database-change-rules.md | none |
| `agent/agent/rules/15-backend-constants-and-parameter-indexing.md` | merge | `docs/sdd/standards/database-change-rules.md; docs/sdd/standards/backend-change-rules.md` | parameter-indexing and constant reuse preserved in canonical standards | docs/sdd/standards/database-change-rules.md | none |
| `agent/agent/rules/16-backend-common-field-validation.md` | merge | `docs/sdd/standards/security-validation-and-logging.md` | common field validation rules preserved in canonical standards | docs/sdd/standards/security-validation-and-logging.md | none |
| `agent/agent/rules/17-frontend-response-guards.md` | merge | `docs/sdd/standards/frontend-change-rules.md; docs/sdd/checklists/06-code-review-against-spec.md` | frontend response guards preserved in canonical standards and review checklist | docs/sdd/standards/frontend-change-rules.md | none |
| `agent/agent/rules/20-frontend-screen-pattern.md` | merge | `docs/sdd/standards/frontend-screen-architecture.md` | frontend screen pattern preserved in canonical frontend architecture standards | docs/sdd/standards/frontend-screen-architecture.md | none |
| `agent/agent/rules/21-frontend-services-state-and-ajax.md` | merge | `docs/sdd/standards/frontend-screen-architecture.md` | frontend service and transport pattern preserved in canonical frontend architecture standards | docs/sdd/standards/frontend-screen-architecture.md | none |
| `agent/agent/rules/22-commenting-and-hardcoding.md` | merge | `AGENTS.md; docs/sdd/standards/naming-and-module-organization.md` | commenting and hardcoding guidance belongs in agent instructions and standards | AGENTS.md | none |
| `agent/agent/rules/30-search-module-pattern.md` | merge | `docs/sdd/standards/module-patterns/search.md` | search module rules preserved in canonical module patterns | docs/sdd/standards/module-patterns/search.md | none |
| `agent/agent/rules/31-csv-module-pattern.md` | merge | `docs/sdd/standards/module-patterns/csv.md` | CSV module rules preserved in canonical module patterns | docs/sdd/standards/module-patterns/csv.md | none |
| `agent/agent/rules/32-file-output-module-pattern.md` | merge | `docs/sdd/standards/module-patterns/file-output.md` | file-output rules preserved in canonical module patterns | docs/sdd/standards/module-patterns/file-output.md | none |
| `agent/agent/rules/40-testing-expectations.md` | merge | `docs/sdd/standards/testing-and-quality-signals.md` | testing expectations preserved in canonical quality signals | docs/sdd/standards/testing-and-quality-signals.md | none |
| `agent/agent/rules/41-review-and-build-workflow.md` | merge | `docs/sdd/process/07-review.md; docs/sdd/process/08-release.md; docs/sdd/standards/testing-and-quality-signals.md` | review and build workflow preserved in review, release, and quality docs | docs/sdd/process/07-review.md; docs/sdd/process/08-release.md | split review from release |
| `agent/agent/rules/42-quality-gates-and-verdicts.md` | merge | `docs/sdd/governance/definition-of-done.md; docs/sdd/checklists/08-release-readiness.md` | quality verdict rules preserved in definition of done and release gates | docs/sdd/governance/definition-of-done.md | none |
| `agent/agent/rules/43-sql-reference-source.md` | merge | `docs/sdd/standards/database-change-rules.md` | SQL reference policy preserved in canonical DB rules | docs/sdd/standards/database-change-rules.md | none |
| `agent/agent/rules/44-conflict-management.md` | merge | `docs/sdd/standards/conflict-management.md; docs/sdd/templates/feature/conflict-review.md; docs/sdd/templates/feature/linked-screen-scope.md` | conflict-management workflow preserved in standards and templates | docs/sdd/standards/conflict-management.md | none |
| `agent/agent/rules/45-spec-pack-artifacts.md` | merge | `docs/specs/README.md; docs/sdd/templates/feature-package/README.md` | spec-pack artifacts replaced by numbered package artifacts | docs/specs/README.md | none |
| `agent/agent/rules/90-known-inconsistencies.md` | merge | `docs/sdd/standards/known-inconsistencies.md` | known repo inconsistencies preserved in canonical standards | docs/sdd/standards/known-inconsistencies.md | none |
| `agent/agent/spec-pack/README.md` | merge | `docs/specs/README.md; docs/sdd/templates/README.md` | spec-pack concept replaced by numbered feature-package standard | docs/specs/README.md | none |
| `agent/agent/spec-pack/templates/review-conflict-template.md` | move | `docs/sdd/templates/feature/conflict-review.md` | template preserved under canonical template library | docs/sdd/templates/feature/conflict-review.md | none |
| `agent/agent/spec-pack/templates/screen-conflict-scope-template.md` | move | `docs/sdd/templates/feature/linked-screen-scope.md` | template preserved under canonical template library | docs/sdd/templates/feature/linked-screen-scope.md | none |
| `agent/agent/spec-pack/templates/spec-pack-template.md` | merge | `docs/sdd/templates/feature-package/README.md; docs/specs/README.md` | spec-pack template replaced by numbered feature package scaffold | docs/sdd/templates/feature-package/README.md | split into ordered numbered files |
| `agent/agent/standards/common/agent-working-contract.md` | merge | `AGENTS.md; docs/sdd/governance/03-implementation-traceability-rules.md` | agent working contract belongs in root agent guide and governance | AGENTS.md | none |
| `agent/agent/standards/common/backend-api-process-architecture.md` | move | `docs/sdd/standards/backend-process-architecture.md` | backend architecture standard preserved as canonical file | docs/sdd/standards/backend-process-architecture.md | none |
| `agent/agent/standards/common/conflict-management.md` | move | `docs/sdd/standards/conflict-management.md` | conflict-management standard preserved as canonical file | docs/sdd/standards/conflict-management.md | none |
| `agent/agent/standards/common/database-sql-and-transactions.md` | merge | `docs/sdd/standards/database-change-rules.md` | database and transaction standard preserved in canonical DB rules | docs/sdd/standards/database-change-rules.md | none |
| `agent/agent/standards/common/frontend-screen-architecture.md` | move | `docs/sdd/standards/frontend-screen-architecture.md` | frontend architecture standard preserved as canonical file | docs/sdd/standards/frontend-screen-architecture.md | none |
| `agent/agent/standards/common/naming-and-repo-organization.md` | move | `docs/sdd/standards/naming-and-module-organization.md` | naming standard preserved as canonical file | docs/sdd/standards/naming-and-module-organization.md | none |
| `agent/agent/standards/common/nknhat-migration-notes.md` | delete | `none` | personal legacy migration note superseded by canonical migration docs | docs/sdd/migration-notes.md; docs/sdd/migration-plan.md | none |
| `agent/agent/standards/common/repository-summary.md` | merge | `docs/sdd/standards/repository-context.md` | repository summary absorbed into canonical repository context | docs/sdd/standards/repository-context.md | none |
| `agent/agent/standards/common/review-build-and-specpack-workflow.md` | merge | `docs/sdd/process/07-review.md; docs/sdd/process/08-release.md; docs/sdd/standards/testing-and-quality-signals.md` | review/build workflow preserved in canonical review, release, and quality docs | docs/sdd/process/07-review.md; docs/sdd/process/08-release.md | split review from release |
| `agent/agent/standards/common/security-config-and-startup.md` | merge | `docs/sdd/standards/security-validation-and-logging.md` | security and startup guidance preserved in canonical standards | docs/sdd/standards/security-validation-and-logging.md | none |
| `agent/agent/standards/common/sql-document-reference.md` | merge | `docs/sdd/standards/database-change-rules.md` | SQL document reference policy preserved in canonical DB rules | docs/sdd/standards/database-change-rules.md | none |
| `agent/agent/standards/common/testing-and-quality-signals.md` | move | `docs/sdd/standards/testing-and-quality-signals.md` | quality signals preserved as canonical standard | docs/sdd/standards/testing-and-quality-signals.md | none |
| `agent/agent/standards/common/validation-error-logging.md` | merge | `docs/sdd/standards/security-validation-and-logging.md` | validation and logging guidance preserved in canonical standards | docs/sdd/standards/security-validation-and-logging.md | none |
| `agent/agent/standards/modules/csv-modules.md` | move | `docs/sdd/standards/module-patterns/csv.md` | module pattern preserved as canonical standard | docs/sdd/standards/module-patterns/csv.md | none |
| `agent/agent/standards/modules/pdf-excel-and-download-modules.md` | move | `docs/sdd/standards/module-patterns/file-output.md` | module pattern preserved as canonical standard | docs/sdd/standards/module-patterns/file-output.md | none |
| `agent/agent/standards/modules/search-modules.md` | move | `docs/sdd/standards/module-patterns/search.md` | module pattern preserved as canonical standard | docs/sdd/standards/module-patterns/search.md | none |
| `agent/agent/standards/README.md` | merge | `docs/sdd/standards/README.md` | canonical standards index replaced local-only standards index | docs/sdd/standards/README.md | none |
| `agent/agent/START_HERE.md` | merge | `docs/README.md; docs/sdd/README.md; AGENTS.md` | entrypoint guidance now lives in canonical docs | docs/README.md; docs/sdd/README.md | none |
| `AGENTS.md` | keep | `AGENTS.md` | canonical agent instructions | agent/agent/START_HERE.md; agent/agent/standards/common/agent-working-contract.md | none |
| `CHANGELOG.md` | keep | `CHANGELOG.md` | root release history | docs/specs/*/changelog.md | none |
| `docs/decisions/ADR-0001-spec-driven-delivery-framework.md` | keep | `docs/decisions/ADR-0001-spec-driven-delivery-framework.md` | canonical decision record location | old docs/adr equivalents | none |
| `docs/decisions/README.md` | keep | `docs/decisions/README.md` | canonical decision record location | old docs/adr equivalents | none |
| `docs/README.md` | keep | `docs/README.md` | canonical docs entrypoint | agent/agent/START_HERE.md | none |
| `docs/sdd/checklists/01-feature-intake.md` | keep | `docs/sdd/checklists/01-feature-intake.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/02-requirements-review.md` | keep | `docs/sdd/checklists/02-requirements-review.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/03-design-review.md` | keep | `docs/sdd/checklists/03-design-review.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/04-pre-implementation-gate.md` | keep | `docs/sdd/checklists/04-pre-implementation-gate.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/05-implementation-completion.md` | keep | `docs/sdd/checklists/05-implementation-completion.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/06-code-review-against-spec.md` | keep | `docs/sdd/checklists/06-code-review-against-spec.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/07-qa-validation.md` | keep | `docs/sdd/checklists/07-qa-validation.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/08-release-readiness.md` | keep | `docs/sdd/checklists/08-release-readiness.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/09-post-release-review.md` | keep | `docs/sdd/checklists/09-post-release-review.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/quick-start-new-feature.md` | keep | `docs/sdd/checklists/quick-start-new-feature.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/checklists/README.md` | keep | `docs/sdd/checklists/README.md` | canonical operational checklist library | agent/agent/checklists/* | none |
| `docs/sdd/governance.md` | keep | `docs/sdd/governance.md` | short governance entrypoint | agent/agent/rules/42-quality-gates-and-verdicts.md | split detailed rules into docs/sdd/governance/ |
| `docs/sdd/governance/01-when-a-spec-is-required.md` | keep | `docs/sdd/governance/01-when-a-spec-is-required.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/02-minimum-completeness-before-coding.md` | keep | `docs/sdd/governance/02-minimum-completeness-before-coding.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/03-implementation-traceability-rules.md` | keep | `docs/sdd/governance/03-implementation-traceability-rules.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/04-review-rules.md` | keep | `docs/sdd/governance/04-review-rules.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/05-test-traceability-rules.md` | keep | `docs/sdd/governance/05-test-traceability-rules.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/06-release-readiness-rules.md` | keep | `docs/sdd/governance/06-release-readiness-rules.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/07-emergency-change-handling.md` | keep | `docs/sdd/governance/07-emergency-change-handling.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/08-decision-log-policy.md` | keep | `docs/sdd/governance/08-decision-log-policy.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/09-documentation-update-policy.md` | keep | `docs/sdd/governance/09-documentation-update-policy.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/definition-of-done.md` | keep | `docs/sdd/governance/definition-of-done.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/governance/README.md` | keep | `docs/sdd/governance/README.md` | canonical detailed governance library | agent/agent/rules/*; agent/agent/checklists/* | none |
| `docs/sdd/migration-notes.md` | rewrite | `docs/sdd/migration-notes.md` | needs final post-migration summary | agent/agent/standards/common/nknhat-migration-notes.md | none |
| `docs/sdd/migration-plan.md` | keep | `docs/sdd/migration-plan.md` | per-file migration inventory and plan | none | none |
| `docs/sdd/process/01-intake.md` | keep | `docs/sdd/process/01-intake.md` | canonical SDD stage flow | agent/agent/pipeline/* | none |
| `docs/sdd/process/02-requirements.md` | keep | `docs/sdd/process/02-requirements.md` | canonical SDD stage flow | agent/agent/pipeline/* | split intake from requirements |
| `docs/sdd/process/03-design.md` | keep | `docs/sdd/process/03-design.md` | canonical SDD stage flow | agent/agent/pipeline/* | none |
| `docs/sdd/process/04-task-planning.md` | keep | `docs/sdd/process/04-task-planning.md` | canonical SDD stage flow | agent/agent/pipeline/* | none |
| `docs/sdd/process/05-implementation.md` | keep | `docs/sdd/process/05-implementation.md` | canonical SDD stage flow | agent/agent/pipeline/* | split implementation from verification |
| `docs/sdd/process/06-tests-and-verification.md` | keep | `docs/sdd/process/06-tests-and-verification.md` | canonical SDD stage flow | agent/agent/pipeline/* | split implementation from verification |
| `docs/sdd/process/07-review.md` | keep | `docs/sdd/process/07-review.md` | canonical SDD stage flow | agent/agent/pipeline/* | split review from release |
| `docs/sdd/process/08-release.md` | keep | `docs/sdd/process/08-release.md` | canonical SDD stage flow | agent/agent/pipeline/* | split review from release |
| `docs/sdd/README.md` | keep | `docs/sdd/README.md` | SDD playbook entrypoint | agent/agent/START_HERE.md; agent/agent/pipeline/README.md | none |
| `docs/sdd/standards/backend-change-rules.md` | keep | `docs/sdd/standards/backend-change-rules.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/backend-process-architecture.md` | keep | `docs/sdd/standards/backend-process-architecture.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/conflict-management.md` | keep | `docs/sdd/standards/conflict-management.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/database-change-rules.md` | keep | `docs/sdd/standards/database-change-rules.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/frontend-change-rules.md` | keep | `docs/sdd/standards/frontend-change-rules.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/frontend-screen-architecture.md` | keep | `docs/sdd/standards/frontend-screen-architecture.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/known-inconsistencies.md` | keep | `docs/sdd/standards/known-inconsistencies.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/module-patterns/csv.md` | keep | `docs/sdd/standards/module-patterns/csv.md` | canonical module-family patterns | agent/agent/standards/modules/* | none |
| `docs/sdd/standards/module-patterns/file-output.md` | keep | `docs/sdd/standards/module-patterns/file-output.md` | canonical module-family patterns | agent/agent/standards/modules/* | none |
| `docs/sdd/standards/module-patterns/search.md` | keep | `docs/sdd/standards/module-patterns/search.md` | canonical module-family patterns | agent/agent/standards/modules/* | none |
| `docs/sdd/standards/naming-and-module-organization.md` | keep | `docs/sdd/standards/naming-and-module-organization.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/README.md` | keep | `docs/sdd/standards/README.md` | canonical standards index | agent/agent/standards/README.md | none |
| `docs/sdd/standards/repository-context.md` | keep | `docs/sdd/standards/repository-context.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/security-validation-and-logging.md` | keep | `docs/sdd/standards/security-validation-and-logging.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/standards/testing-and-quality-signals.md` | keep | `docs/sdd/standards/testing-and-quality-signals.md` | canonical repo-specific standards | agent/agent/standards/common/*; agent/agent/rules/* | none |
| `docs/sdd/target-architecture.md` | rewrite | `docs/sdd/target-architecture.md` | adjust to final migrated structure | agent/agent/spec-pack/README.md | none |
| `docs/sdd/templates/decisions/decision-record-adr.md` | keep | `docs/sdd/templates/decisions/decision-record-adr.md` | canonical decision template | none | none |
| `docs/sdd/templates/feature/acceptance-criteria.md` | keep | `docs/sdd/templates/feature/acceptance-criteria.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/api-contract.md` | keep | `docs/sdd/templates/feature/api-contract.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/conflict-review.md` | keep | `docs/sdd/templates/feature/conflict-review.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/data-model.md` | keep | `docs/sdd/templates/feature/data-model.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/design.md` | keep | `docs/sdd/templates/feature/design.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/edge-cases-and-failure-modes.md` | keep | `docs/sdd/templates/feature/edge-cases-and-failure-modes.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/feature-brief.md` | keep | `docs/sdd/templates/feature/feature-brief.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/implementation-report.md` | keep | `docs/sdd/templates/feature/implementation-report.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/linked-screen-scope.md` | keep | `docs/sdd/templates/feature/linked-screen-scope.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/requirements.md` | keep | `docs/sdd/templates/feature/requirements.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/review-report.md` | keep | `docs/sdd/templates/feature/review-report.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/rollout-plan.md` | keep | `docs/sdd/templates/feature/rollout-plan.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/task-breakdown.md` | keep | `docs/sdd/templates/feature/task-breakdown.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/test-cases.md` | keep | `docs/sdd/templates/feature/test-cases.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature/ui-ux-behavior-spec.md` | keep | `docs/sdd/templates/feature/ui-ux-behavior-spec.md` | canonical artifact-level templates | agent/agent/spec-pack/templates/* | none |
| `docs/sdd/templates/feature-package/01-requirements.md` | keep | `docs/sdd/templates/feature-package/01-requirements.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/02-design.md` | keep | `docs/sdd/templates/feature-package/02-design.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/03-data-model.md` | keep | `docs/sdd/templates/feature-package/03-data-model.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/04-api-contract.md` | keep | `docs/sdd/templates/feature-package/04-api-contract.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/05-behavior.md` | keep | `docs/sdd/templates/feature-package/05-behavior.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/06-edge-cases.md` | keep | `docs/sdd/templates/feature-package/06-edge-cases.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/07-tasks.md` | keep | `docs/sdd/templates/feature-package/07-tasks.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/08-acceptance-criteria.md` | keep | `docs/sdd/templates/feature-package/08-acceptance-criteria.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/09-test-cases.md` | keep | `docs/sdd/templates/feature-package/09-test-cases.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/10-rollout.md` | keep | `docs/sdd/templates/feature-package/10-rollout.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/11-implementation-report.md` | keep | `docs/sdd/templates/feature-package/11-implementation-report.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/12-review-report.md` | keep | `docs/sdd/templates/feature-package/12-review-report.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/changelog.md` | keep | `docs/sdd/templates/feature-package/changelog.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/feature-package/README.md` | keep | `docs/sdd/templates/feature-package/README.md` | copy-ready numbered feature package scaffold | agent/agent/spec-pack/* | none |
| `docs/sdd/templates/README.md` | keep | `docs/sdd/templates/README.md` | template usage guide | agent/agent/spec-pack/README.md | none |
| `docs/sdd/templates/repository/change-log.md` | keep | `docs/sdd/templates/repository/change-log.md` | canonical repository changelog template | none | none |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/01-requirements.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/01-requirements.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/02-design.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/02-design.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/07-tasks.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/07-tasks.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/08-acceptance-criteria.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/08-acceptance-criteria.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/09-test-cases.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/09-test-cases.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/10-rollout.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/10-rollout.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/11-implementation-report.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/11-implementation-report.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/12-review-report.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/12-review-report.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/changelog.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/changelog.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/README.md` | rewrite | `docs/specs/2026-03-11-repository-sdd-bootstrap/README.md` | bootstrap example migrated to numbered feature package | older unnumbered bootstrap files | split acceptance into acceptance criteria and test cases |
| `docs/specs/README.md` | rewrite | `docs/specs/README.md` | feature package standard evolved to numbered artifacts | agent/agent/spec-pack/README.md | none |
| `README.md` | rewrite | `README.md` | root entrypoint rewritten for SDD | old minimal README | none |
| `src/main/webapp/angular/README.md` | rewrite | `src/main/webapp/angular/README.md` | replace Angular CLI boilerplate with repo-specific guide | none | none |

## Applied Migration Actions

1. Moved or rewrote canonical files into the target `docs/`, `docs/sdd/`, `docs/specs/`, and `docs/decisions/` structure.
2. Merged reusable content from `agent/agent/` into canonical standards, checklists, templates, and process docs.
3. Removed the obsolete duplicate `agent/agent/` markdown tree after preserving useful content.
4. Rewrote low-quality files such as the Angular CLI boilerplate README.
5. Updated the bootstrap feature package to the numbered artifact standard and fixed cross-links.
