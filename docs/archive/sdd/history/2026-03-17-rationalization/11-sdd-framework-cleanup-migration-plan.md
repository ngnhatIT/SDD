# SDD Framework Cleanup Migration Plan

## 1. Current Structure Summary

This plan was authored from the pre-cleanup audit baseline on `2026-03-17`. The branch already executed the highest-confidence merges in `foundation/`, the `05/07/08` process stages, the drop of `docs/sdd/governance/11-ai-agent-policy.md`, the prompt-set consolidation, the quick-start checklist merge, and the conversion of duplicated `templates/feature/*` artifact bodies into compatibility aliases.

Current framework surface:

- root contract: `AGENTS.md`
- canonical repository framework: `docs/sdd/`
- canonical feature-package standard: `docs/specs/README.md`
- legacy bridge still present: `agent/`

Current strengths:

- the repo already has a usable canonical framework under `docs/sdd/`
- governance, process, checklists, and standards are mostly coherent
- feature-package governance under `docs/specs/` is clear and enforceable

Current drag:

- authority is not visually obvious once `agent/`, migration docs, additive SDD2+ docs, and prompt/template variants enter the picture
- several directories are split more finely than the workflow needs
- some historical files now read like live guidance
- the template and prompt surfaces are larger than necessary for smooth AI execution

## 2. Key Structural Problems

1. `agent/` remains a full parallel doc system instead of a minimal bridge.
2. `AGENTS.md` duplicates too many detailed standards already owned by canonical docs.
3. `foundation/`, `ai-ops/`, and `prompts/` contain multiple short files whose roles blur together.
4. `process/06a-two-pass-execution.md`, `07a-self-review.md`, and `09a-definition-of-done.md` fragment the stage flow and duplicate checklists or governance.
5. `templates/feature/*` and `templates/feature-package/*` create a dual-source template system.
6. `migration-notes.md`, `migration-plan.md`, and `target-architecture.md` are mixed into the live framework root even though two are historical and one is stale.
7. Several prompt variants differ only by header or task-profile wording, which creates prompt sprawl without new operational value.

## 3. Target Structure

Target principles:

- keep one obvious canonical path for normal work
- keep history visible but out of the default read path
- shrink the bridge to a thin compatibility layer
- keep additive SDD2+ capability, but reduce file-count and overlap inside that layer
- keep one numbered template scaffold as the primary template system

Recommended target layout:

```text
AGENTS.md
docs/
  README.md
  decisions/
  specs/
    README.md
    <feature-id>/
  spec-packs/
  sdd/
    README.md
    context/
    governance.md
    governance/
    process/
    checklists/
    standards/
    templates/
      README.md
      feature-package/
      feature-package-plus/
      spec-pack-template.md
      execution-brief-template.md
      task-profile-examples.md
      decisions/
      repository/
    prompts/
      README.md
      create-spec.md
      implement-feature.md
      review-feature.md
      fix-from-review-report.md
      generate-spec-pack.md
      generate-execution-brief.md
      core/
    foundation/
      README.md
    ai-ops/
      09-recovery-mode.md
      agent-clients-and-handoff.md
    architecture/
      target-architecture.md
    history/
      migration-notes.md
      migration-plan.md
agent/
  START_HERE.md
```

## 4. Old-To-New Mapping

### 4.1 Current Canonical Files That Stay Canonical

| Current | Target | Notes |
| --- | --- | --- |
| `AGENTS.md` | `AGENTS.md` | keep as root contract, but narrow to routing and stop rules |
| `docs/specs/README.md` | `docs/specs/README.md` | no path change |
| `docs/sdd/governance.md` | `docs/sdd/governance.md` | no path change |
| `docs/sdd/governance/` core rules | same | drop alias file only after confirmation |
| `docs/sdd/checklists/` core stage checklists | same | merge quick-start into intake |
| `docs/sdd/standards/` | same | no major path change needed |
| `docs/sdd/process/01-08` | same | merge `a` stages into main stages |
| `docs/sdd/templates/feature-package/` | same | primary template scaffold |
| `docs/sdd/templates/feature-package-plus/` | same | optional companion scaffold |

### 4.2 Merge Map

| Source | Target | Why |
| --- | --- | --- |
| `docs/sdd/foundation/sdd2-plus-overview.md` | `docs/sdd/foundation/README.md` | same audience and same additive-story role |
| `docs/sdd/foundation/compatibility-and-lifecycle.md` | `docs/sdd/foundation/README.md` | compatibility belongs in the single additive entrypoint |
| `docs/sdd/foundation/evidence-first-documentation.md` | `docs/sdd/foundation/README.md` | too small to stand alone |
| `docs/sdd/foundation/ai-execution-artifacts.md` | `docs/sdd/foundation/README.md` | same additive execution role |
| `docs/sdd/ai-ops/agent-operational-rules.md` | `docs/sdd/governance/09-ai-agent-policy.md` | policy and operational rules are currently duplicated |
| `docs/sdd/process/06a-two-pass-execution.md` | `docs/sdd/process/05-implementation.md` | keep concept, remove extra stage file |
| `docs/sdd/process/07a-self-review.md` | `docs/sdd/process/07-review.md` | keep gate, reduce stage fragmentation |
| `docs/sdd/process/09a-definition-of-done.md` | `docs/sdd/process/08-release.md` | done flow already depends on governance + checklist |
| `docs/sdd/checklists/quick-start-new-feature.md` | `docs/sdd/checklists/01-feature-intake.md` | startup duplication |
| `docs/sdd/prompts/update-spec.md` | `docs/sdd/prompts/create-spec.md` | one spec-authoring prompt is enough |
| `docs/sdd/prompts/review-code-without-spec.md` | `docs/sdd/prompts/review-feature.md` | task profile already distinguishes these modes |
| `docs/sdd/templates/feature/*` paired artifact files | matching `docs/sdd/templates/feature-package/*` or `feature-package-plus/*` | one scaffold should own the live template body |
| most `agent/` rule, pipeline, checklist, standard, and template files | canonical `docs/sdd/` or `docs/specs/` target already named in the audit report | bridge should not preserve a full parallel tree |

### 4.3 Drop Map

| Source | Operational capability preserved by |
| --- | --- |
| `docs/sdd/governance/11-ai-agent-policy.md` | `docs/sdd/governance/09-ai-agent-policy.md` |
| `docs/sdd/prompts/derive-rules-from-codebase.md` | direct audited rule work from canonical docs when needed |
| `agent/PROMPTS.md` | `docs/sdd/prompts/README.md` and canonical prompt files |
| `agent/pipeline/README.md` | `docs/sdd/process/README.md` |
| `agent/checklists/README.md` | `docs/sdd/checklists/README.md` |
| `agent/standards/README.md` | `docs/sdd/standards/README.md` |
| `agent/spec-pack/README.md` | `docs/specs/README.md` and `docs/sdd/templates/spec-pack-template.md` |
| `agent/standards/common/nknhat-migration-notes.md` | `docs/sdd/migration-notes.md` and the new framework audit |

### 4.4 Rewrite Or Reclassify Map

| Current | Rewrite or reclassify needed |
| --- | --- |
| `docs/sdd/README.md` | add canonical/supporting/legacy map and task-type start points |
| `docs/sdd/target-architecture.md` | rewrite to the current approved target, not the old one |
| `docs/sdd/migration-notes.md` | mark history-only and correct stale bridge wording |
| `docs/sdd/migration-plan.md` | mark history-only and explain historical path names |
| `agent/START_HERE.md` | reduce to legacy bridge notice |
| `agent/PROMPTS.md` | reduce to pointer or remove |
| `agent/pipeline/README.md` | reduce to pointer or remove |
| `agent/standards/README.md` | reduce to pointer or remove |
| `agent/checklists/README.md` | reduce to pointer or remove |
| `agent/spec-pack/README.md` | reduce to pointer or remove |

## 5. What Stays

- core context and governance
- feature-package governance under `docs/specs/`
- standards library
- checklist library
- numbered feature-package scaffold
- `docs/spec-packs/` as execution aids
- `docs/sdd/ai-ops/09-recovery-mode.md`
- `docs/sdd/ai-ops/agent-clients-and-handoff.md`

## 6. What Merges

- fine-grained foundation docs into `foundation/README.md`
- `a` process stages into their parent stages
- duplicate prompt variants into a smaller prompt set
- paired artifact templates into the numbered scaffold
- most bridge rules and templates into already-existing canonical destinations

## 7. What Drops

- compatibility aliases and duplicate bridge indexes with no unique operational value
- low-value prompt sprawl
- stale personal migration notes in `agent/`

## 8. What Needs Rewrite

- `docs/sdd/README.md`
- `docs/sdd/target-architecture.md`
- `docs/sdd/migration-notes.md`
- selected `agent/` entry files that still present themselves as active first-class entrypoints

## 9. Safe Migration Order

1. Create and approve the framework audit report.
2. Create and approve this migration plan.
3. Apply safe clarity rewrites to `docs/sdd/README.md`, `docs/sdd/target-architecture.md`, and `docs/sdd/migration-notes.md`.
4. Rewrite `agent/` entry files as legacy bridge notices so AI does not start from the wrong layer.
5. Confirm whether any external links still depended on `docs/sdd/governance/11-ai-agent-policy.md`; internal references were already clear enough to remove it in this branch.
6. Collapse the prompt set.
7. Collapse dual template sources into the numbered scaffold.
8. Shrink `agent/` from a full parallel tree to the smallest bridge the team still needs.
9. Move historical framework notes under a dedicated history area only if the team accepts the path churn.

## 10. Immediate Safe Changes In This Branch

- add the audit report
- add this migration plan
- clarify canonical versus bridge versus history in the main framework entrypoints
- add legacy warnings to `agent/` entry files
- merge short `foundation/` leaf files into `docs/sdd/foundation/README.md`
- merge `06a-two-pass-execution.md` into `05-implementation.md`
- merge `07a-self-review.md` into `07-review.md`
- merge `09a-definition-of-done.md` into `08-release.md`
- drop `docs/sdd/governance/11-ai-agent-policy.md` after confirming internal canonical references already used `09-ai-agent-policy.md`
- merge `docs/sdd/ai-ops/agent-operational-rules.md` into `docs/sdd/governance/09-ai-agent-policy.md`
- merge `docs/sdd/checklists/quick-start-new-feature.md` into `docs/sdd/checklists/01-feature-intake.md`
- collapse prompt variants into `create-spec.md`, `review-feature.md`, and the retained generation or utility prompts
- convert paired `docs/sdd/templates/feature/*` artifact templates into compatibility aliases and keep the canonical scaffold in `feature-package/` and `feature-package-plus/`

## 11. Follow-Up Changes Requiring Human Confirmation

- broad deletion of `agent/` files
- removal of any remaining compatibility aliases that may still have external readers
- path moves for historical framework files
- removal of the paired `templates/feature/*` layer if authors still use it directly
