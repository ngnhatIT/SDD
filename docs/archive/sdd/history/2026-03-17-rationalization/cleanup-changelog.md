# SDD Cleanup Changelog

## 2026-03-17

### What Changed

- consolidated duplicate AI policy guidance into `docs/sdd/governance/09-ai-agent-policy.md`
- removed the duplicate AI-ops policy leaf and kept `docs/sdd/ai-ops/` focused on recovery and handoff helpers
- merged startup checklist content into `docs/sdd/checklists/01-feature-intake.md`
- reduced the default prompt surface to one create-or-update spec prompt, one review prompt, implementation and fix prompts, generation prompts, and three core utilities
- added a prompt quick guide plus a dedicated prompt-and-template simplification report
- tightened retained prompts to a shared structure with explicit use cases, inputs, outputs, template links, and stop conditions
- made `docs/sdd/templates/feature-package/` and `docs/sdd/templates/feature-package-plus/` the explicit canonical template scaffold
- made `docs/sdd/templates/execution-brief-template.md` the canonical execution-brief template
- rewrote duplicated `docs/sdd/templates/feature/*` artifact templates as compatibility aliases instead of maintaining full duplicate bodies
- tightened the canonical numbered template scaffold so each file has a direct section skeleton instead of only a short description

### Files Merged

- `docs/sdd/ai-ops/agent-operational-rules.md` into `docs/sdd/governance/09-ai-agent-policy.md`
- `docs/sdd/checklists/quick-start-new-feature.md` into `docs/sdd/checklists/01-feature-intake.md`
- `docs/sdd/prompts/update-spec.md` into `docs/sdd/prompts/create-spec.md`
- `docs/sdd/prompts/review-code-without-spec.md` into `docs/sdd/prompts/review-feature.md`
- `docs/sdd/templates/feature/execution-brief.md` into `docs/sdd/templates/execution-brief-template.md`

### Files Removed

- `docs/sdd/ai-ops/agent-operational-rules.md`
- `docs/sdd/checklists/quick-start-new-feature.md`
- `docs/sdd/prompts/update-spec.md`
- `docs/sdd/prompts/review-code-without-spec.md`
- `docs/sdd/prompts/derive-rules-from-codebase.md`

### Files Renamed

- none in this pass

### Files Tightened

- `docs/sdd/README.md`
- `docs/sdd/target-architecture.md`
- `docs/sdd/process/11-sdd-framework-cleanup-migration-plan.md`
- `docs/sdd/ai-ops/README.md`
- `docs/sdd/prompts/README.md`
- `docs/sdd/templates/README.md`
- `docs/sdd/checklists/README.md`
- `docs/sdd/governance/09-ai-agent-policy.md`

### Canonical Hierarchy Now

1. `AGENTS.md`
2. `docs/sdd/context/`
3. `docs/sdd/governance.md` and `docs/sdd/governance/`
4. `docs/specs/README.md`
5. `docs/specs/<feature-id>/`
6. `docs/sdd/process/`, `docs/sdd/checklists/`, and `docs/sdd/standards/`
7. `docs/sdd/templates/feature-package/`, `docs/sdd/templates/feature-package-plus/`, `docs/sdd/templates/execution-brief-template.md`, and `docs/sdd/templates/spec-pack-template.md`
8. `docs/sdd/prompts/`, `docs/sdd/foundation/`, `docs/sdd/ai-ops/`, and `docs/spec-packs/` as execution aids only
9. `docs/sdd/migration-notes.md`, `docs/sdd/migration-plan.md`, and `agent/` as history or bridge only

### Minimum Prompt Set Retained

- `docs/sdd/prompts/create-spec.md`
- `docs/sdd/prompts/implement-feature.md`
- `docs/sdd/prompts/review-feature.md`
- `docs/sdd/prompts/fix-from-review-report.md`
- `docs/sdd/prompts/generate-spec-pack.md`
- `docs/sdd/prompts/generate-execution-brief.md`
- `docs/sdd/prompts/core/recover-context.md`
- `docs/sdd/prompts/core/self-review.md`
- `docs/sdd/prompts/core/pre-merge-audit.md`

### Still Needs Human Review

- whether the compatibility alias files under `docs/sdd/templates/feature/` can be removed entirely after teams stop linking to them
- whether `agent/` should shrink beyond the current bridge notices in the same branch or a later approved branch
- whether `docs/sdd/migration-notes.md` and `docs/sdd/migration-plan.md` should move under a dedicated history folder
- whether the remaining detailed standards in `AGENTS.md` should be tightened further now that canonical rules in `docs/sdd/` are clearer
