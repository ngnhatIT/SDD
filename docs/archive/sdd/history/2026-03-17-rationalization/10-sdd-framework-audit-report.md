# SDD Framework Audit Report

## 1. Audit Objective

Audit the current SDD framework before any broader codebase scanning or standards extraction work.

This report captures the pre-cleanup baseline audited on `2026-03-17`. The same branch then executed the highest-confidence cleanup items from this report: the `foundation/` leaf-file merge, the `05/07/08` process-stage merges, and the drop of `docs/sdd/governance/11-ai-agent-policy.md`.

This audit focuses on the active framework surface:

- `AGENTS.md`
- `docs/sdd/`
- `docs/specs/README.md`
- `agent/`

Consulted as governing evidence but not treated as framework inventory scope:

- prior framework feature packages under `docs/specs/`
- `docs/decisions/ADR-0004-sdd2-plus-agent-ready-extension.md`
- generated spec-packs and execution briefs

Out of inventory scope:

- product runtime code
- feature packages other than `docs/specs/README.md`
- `scripts/sdd/` tooling internals

## 2. Audit Criteria

Ratings use `High`, `Med`, and `Low`.

| Criterion | Meaning |
| --- | --- |
| Role clarity | whether the file has one obvious job |
| Canonical authority | whether the file is an approval or policy source, a support artifact, a bridge, or history only |
| Operational value | whether workflow quality materially drops if the file disappears |
| Overlap | how much the file duplicates other live guidance |
| Decision support | whether the file helps an agent or reviewer make a concrete pass/fail or next-step decision |
| Enforceability | whether the file can be applied as a real gate, rule, or deterministic read path |
| AI usability | whether an AI agent can select and apply it correctly without prompt drift |
| Maintenance cost | how expensive it is to keep aligned with the rest of the framework |

## 3. Inventory Summary

In-scope file count: `197`

By area:

| Area | Files | Primary issue |
| --- | ---: | --- |
| `AGENTS.md` + `docs/specs/README.md` | 2 | root authority is clear, but `AGENTS.md` is overstuffed |
| `docs/sdd/` root | 5 | historical and target docs are mixed with live workflow docs |
| `docs/sdd/context/` | 11 | mostly strong, but structure/schema support files are easy to over-read |
| `docs/sdd/foundation/` | 5 | additive guidance split too finely |
| `docs/sdd/ai-ops/` | 4 | overlaps with governance `09-ai-agent-policy.md` |
| `docs/sdd/governance/` + `governance.md` | 16 | strong core, but alias files and some shorthand layers duplicate nearby rules |
| `docs/sdd/process/` | 12 | `a` stages fragment process and duplicate checklists |
| `docs/sdd/checklists/` | 13 | mostly good, but quick-start overlaps intake and specs README |
| `docs/sdd/standards/` | 16 | strong core, some overlap with `AGENTS.md` and `context/code-structure-rules.md` |
| `docs/sdd/prompts/` | 14 | prompt sprawl; several variants differ only by task-profile wording |
| `docs/sdd/templates/` | 42 | dual template system (`feature/` and `feature-package/`) is the biggest internal redundancy |
| `agent/` | 71 | still behaves like a parallel framework even though canonical docs say it is only a bridge |

## 4. Confirmed Structural Conflicts

1. `agent/` still contains active-looking entrypoints (`START_HERE.md`, `PROMPTS.md`, `pipeline/README.md`, `standards/README.md`) even though `AGENTS.md` and `docs/sdd/context/ai-loading-order.md` say canonical docs win and `agent/` is bridge-only.
2. `docs/sdd/migration-notes.md` and `docs/sdd/migration-plan.md` describe `agent/agent/` as removed historical content, but the repo still contains a live `agent/` bridge tree.
3. `docs/sdd/target-architecture.md` omits the current `foundation/`, `prompts/`, and `ai-ops/` SDD2+ layers, so the "target" map is no longer the actual framework target.
4. `AGENTS.md` duplicates substantial code standards already captured in `docs/sdd/governance/10-code-standards.md` and the standards library, which creates double-maintenance pressure.
5. `docs/sdd/ai-ops/agent-operational-rules.md` repeats guidance already enforced by `docs/sdd/governance/09-ai-agent-policy.md`, `12-uncertainty-escalation-policy.md`, and process/checklist docs.
6. `docs/sdd/process/06a-two-pass-execution.md`, `07a-self-review.md`, and `09a-definition-of-done.md` repeat stage detail already enforced by core process files, checklists, and governance.
7. `docs/sdd/templates/feature/*` and `docs/sdd/templates/feature-package/*` duplicate the same artifact set in two parallel template systems.
8. `docs/sdd/governance/11-ai-agent-policy.md` is a compatibility alias to `09-ai-agent-policy.md`; the duplicate name and numbering make it easy for AI to treat both as live policy.

## 5. File-By-File Audit Table

### 5.1 Root And Framework Entry Files

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `AGENTS.md` | first read for any agent task | root operating contract and stop rules | Yes | High | High | High | High | Med | High | KEEP-TIGHTEN | Keep as the root contract, but reduce duplicated low-level code standards and fix encoding drift so it routes rather than re-specifies the whole framework. |
| `docs/specs/README.md` | before creating or judging a governed feature package | feature-package standard | Yes | High | Med | High | High | High | Med | KEEP | Keep as the canonical feature-package contract; it is the clearest approval-source guide in the framework. |
| `docs/sdd/README.md` | entry to repository-level SDD docs | playbook and folder map | Yes | High | Med | High | Med | Med | Med | KEEP-TIGHTEN | Keep as the main framework landing page, but add an explicit canonical/supporting/legacy map and task-type start points. |
| `docs/sdd/governance.md` | before any stage gate or classification | top-level governance gate | Yes | High | Low | High | High | High | Low | KEEP | Keep as the short governance entrypoint that points to the detailed rule library. |
| `docs/sdd/target-architecture.md` | when placing or restructuring framework docs | intended framework hierarchy | Support | Med | High | Med | Low | Low | Med | KEEP-TIGHTEN | Rewrite to the actual current or approved target hierarchy; current content is stale and omits active SDD2+ folders. |
| `docs/sdd/migration-notes.md` | only when tracing framework history | historical migration summary | Historical | Low | High | Low | Low | Low | Med | KEEP-TIGHTEN | Keep only as history and explicitly mark it non-operational; correct the bridge wording so it does not contradict the live repo. |
| `docs/sdd/migration-plan.md` | only when tracing historical moves | historical per-file migration ledger | Historical | Low | Med | Low | Low | Low | High | KEEP-TIGHTEN | Keep as archive-grade history, not as live guidance; add an upfront note that its `agent/agent/` paths are historical. |

### 5.2 Context

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/context/constitution.md` | first-pass task framing | non-negotiable framework constitution | Yes | High | Low | High | High | High | Low | KEEP | Keep; this is the cleanest short source for approval and scope rules. |
| `docs/sdd/context/note.md` | early grounding | project memory and recurring traps | Yes | High | Low | Med | Med | High | Low | KEEP | Keep; it reduces repeated mistakes and is short enough to stay useful. |
| `docs/sdd/context/architecture-context.md` | early grounding | repository architecture shape | Yes | High | Low | Med | Med | High | Low | KEEP | Keep; it gives stable architecture boundaries with low overlap. |
| `docs/sdd/context/product-context.md` | early grounding | product change-shape context | Yes | Med | Low | Med | Med | High | Low | KEEP | Keep; short and task-relevant. |
| `docs/sdd/context/tech-context.md` | early grounding | stack and tooling context | Yes | Med | Low | Med | Med | High | Low | KEEP | Keep; still useful and compact. |
| `docs/sdd/context/ai-loading-order.md` | first-pass AI routing | canonical read order and task-profile trigger rules | Yes | High | High | High | High | High | Med | KEEP-TIGHTEN | Keep as canonical AI read-order logic, but reduce duplicated wording with `AGENTS.md` and explicitly de-prioritize historical docs. |
| `docs/sdd/context/task-profiles.md` | when header exists or routing matters | routing matrix for task types | Yes | High | Med | High | High | High | Med | KEEP | Keep; this is the clearest task-profile routing artifact. |
| `docs/sdd/context/code-structure-rules.md` | code review or code-shape drift checks | structure-level review rules | Support | High | High | High | Med | Med | High | KEEP-TIGHTEN | Keep, but reduce non-structure duplicates now covered by standards and move the DB schema maintenance rule to a more precise home. |
| `docs/sdd/context/repo-structure-schema.md` | structural review on unfamiliar repo areas | repository family classifier | Support | Med | Med | Med | Med | Med | Med | KEEP-TIGHTEN | Keep as an optional structure appendix, not a default read; it is useful but too secondary for the core context layer. |
| `docs/sdd/context/spec-structure-schema.md` | structural review of feature packages | governed package shape schema | Support | Med | Med | Med | Med | Med | Med | KEEP-TIGHTEN | Keep because it supports structure validation and related framework work, but mark it as optional review tooling rather than default context. |
| `docs/sdd/context/database_schema.yaml` | only when DB shape is truly needed | machine-readable repository DB reference | Support | Med | Low | Low | Low | Low | High | KEEP-TIGHTEN | Keep as optional machine-readable reference, but reclassify it clearly as non-default context so small tasks do not over-read a huge schema file. |

### 5.3 Foundation

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/foundation/README.md` | only after core docs are loaded | additive SDD2+ entrypoint | Support | Med | Med | Med | Low | Med | Low | KEEP-TIGHTEN | Keep as the single additive entrypoint, but tighten it to absorb most of the short surrounding overview material. |
| `docs/sdd/foundation/sdd2-plus-overview.md` | after root load, when additive story matters | one-page SDD2+ summary | Support | Low | High | Low | Low | Med | Low | MERGE | Merge into `docs/sdd/foundation/README.md`; it repeats root playbook and ADR-0004 context. |
| `docs/sdd/foundation/compatibility-and-lifecycle.md` | when checking additive compatibility | compatibility explanation | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/foundation/README.md`; unique value is compatibility wording that does not need a separate file. |
| `docs/sdd/foundation/evidence-first-documentation.md` | when shaping reports or evidence sections | evidence-writing guidance | Support | Med | Med | Med | Low | Med | Low | MERGE | Merge into `docs/sdd/foundation/README.md`; it is useful but too small to justify a separate layer file. |
| `docs/sdd/foundation/ai-execution-artifacts.md` | when building packs or briefs | spec-pack and brief intent | Support | Med | Med | Med | Low | Med | Low | MERGE | Merge into `docs/sdd/foundation/README.md`; keep the content, not the extra file split. |

### 5.4 AI Ops

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/ai-ops/README.md` | only for AI-assisted work beyond core flow | AI-ops folder entrypoint | Support | Low | Med | Low | Low | Med | Low | KEEP-TIGHTEN | Keep as a tiny folder index, but explicitly say governance wins on policy and this folder is operational add-on only. |
| `docs/sdd/ai-ops/agent-operational-rules.md` | AI-assisted authoring, implementation, or review | agent-specific operating rules | Support | Med | High | Med | Med | Med | Med | MERGE | Merge into `docs/sdd/governance/09-ai-agent-policy.md`; the file repeats the same grounding, uncertainty, and handoff rules with weaker authority. |
| `docs/sdd/ai-ops/09-recovery-mode.md` | when work loses direction or resumes midstream | recovery procedure | Support | High | Low | High | Med | High | Low | KEEP | Keep; recovery mode is uniquely actionable and not duplicated elsewhere at the same level of usefulness. |
| `docs/sdd/ai-ops/agent-clients-and-handoff.md` | multi-agent or human-agent handoff | client-agnostic handoff packet | Support | Med | Low | Med | Low | Med | Low | KEEP-TIGHTEN | Keep, but present it as a handoff appendix rather than a quasi-policy file. |

### 5.5 Governance

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/governance/README.md` | when choosing a specific rule file | governance rule index | Yes | Med | Med | Med | Med | High | Low | KEEP | Keep; folder READMEs are justified when they route to a stable rule library. |
| `docs/sdd/governance/01-when-a-spec-is-required.md` | before starting or reviewing any non-trivial change | change classification rule | Yes | High | Low | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/governance/02-minimum-completeness-before-coding.md` | before implementation starts | pre-coding completeness rule | Yes | High | Med | High | High | High | Med | KEEP | Keep; it is a real gate and not just advice. |
| `docs/sdd/governance/03-implementation-traceability-rules.md` | during implementation and PR prep | traceability rule | Yes | High | Med | High | High | High | Med | KEEP | Keep; traceability is a canonical cross-stage rule. |
| `docs/sdd/governance/04-review-rules.md` | during review | review rule set | Yes | High | Med | High | High | High | Med | KEEP | Keep. |
| `docs/sdd/governance/05-test-traceability-rules.md` | when validating AC/TC proof | test evidence rule | Yes | High | Med | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/governance/06-release-readiness-rules.md` | before release or done claims | release gate rule | Yes | High | Med | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/governance/07-emergency-change-handling.md` | emergency path only | compact exception path | Yes | Med | Low | Med | High | High | Low | KEEP | Keep; narrow role, low overlap. |
| `docs/sdd/governance/08-decision-log-policy.md` | when changes may need ADRs | ADR trigger rule | Yes | Med | Low | Med | High | High | Low | KEEP | Keep. |
| `docs/sdd/governance/09-ai-agent-policy.md` | any AI-assisted spec or code work | canonical AI policy | Yes | High | High | High | High | Med | Med | KEEP-TIGHTEN | Keep as the single canonical AI policy, but absorb overlapping AI-ops operational content and trim restated rules already in `AGENTS.md`. |
| `docs/sdd/governance/09-documentation-update-policy.md` | when code or docs change | code/docs sync rule | Yes | High | Low | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/governance/10-code-standards.md` | implementation and review | canonical cross-layer code standards | Yes | High | High | High | High | Med | Med | KEEP | Keep here as the canonical code-standard bundle; tighten `AGENTS.md` instead of this file. |
| `docs/sdd/governance/11-ai-agent-policy.md` | only for old bookmarks or prompts | compatibility alias to `09-ai-agent-policy.md` | Bridge | Low | High | Low | Low | Low | Low | DROP | Drop after confirming no external dependency; all internal canonical references already use `09-ai-agent-policy.md`, so capability is preserved. |
| `docs/sdd/governance/12-quality-gate-levels.md` | shorthand status reporting | Q-level shorthand | Support | Med | Med | Med | Med | Med | Low | KEEP-TIGHTEN | Keep as shorthand, but explicitly mark it non-gating so agents do not treat it as a substitute for checklists and rules. |
| `docs/sdd/governance/12-uncertainty-escalation-policy.md` | when evidence is weak or conflicting | uncertainty and ask-before-break rule | Yes | High | Low | High | High | High | Low | KEEP | Keep; this is a core anti-hallucination rule. |
| `docs/sdd/governance/definition-of-done.md` | before completion claims | canonical done rule | Yes | High | Med | High | High | High | Low | KEEP | Keep; this should remain the single policy layer for done claims. |

### 5.6 Process

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/process/README.md` | when navigating stage order | process index | Yes | Med | Med | Med | Med | High | Low | KEEP-TIGHTEN | Keep as the stage index, but collapse references to `a` stages once those are merged into primary stages. |
| `docs/sdd/process/01-intake.md` | start of governed work | intake stage | Yes | High | Low | High | Med | High | Low | KEEP | Keep. |
| `docs/sdd/process/02-requirements.md` | requirements authoring | requirements stage | Yes | High | Low | Med | Med | High | Low | KEEP | Keep. |
| `docs/sdd/process/03-design.md` | design authoring | design stage | Yes | High | Low | Med | Med | High | Low | KEEP | Keep. |
| `docs/sdd/process/04-task-planning.md` | before implementation | task planning stage | Yes | High | Low | Med | Med | High | Low | KEEP | Keep. |
| `docs/sdd/process/05-implementation.md` | implementation stage | implementation stage | Yes | High | Med | High | Med | High | Low | KEEP-TIGHTEN | Keep and absorb the unique pass-1/pass-2 rules from `06a-two-pass-execution.md`. |
| `docs/sdd/process/06a-two-pass-execution.md` | non-trivial implementation only | implementation control sub-stage | Support | Med | High | High | Med | Med | Med | MERGE | Merge into `docs/sdd/process/05-implementation.md`; the concept is important, the extra file is not. |
| `docs/sdd/process/06-tests-and-verification.md` | after implementation | verification stage | Yes | High | Low | High | Med | High | Low | KEEP | Keep. |
| `docs/sdd/process/07a-self-review.md` | after implementation and verification | self-review sub-stage | Support | Med | High | High | Med | Med | Med | MERGE | Merge into `docs/sdd/process/07-review.md`; the checklist and implementation report already carry the actionable gate. |
| `docs/sdd/process/07-review.md` | formal review | review stage | Yes | High | Med | High | Med | High | Low | KEEP-TIGHTEN | Keep and absorb the self-review bridge so stage order becomes simpler. |
| `docs/sdd/process/08-release.md` | release or closeout | release stage | Yes | High | Med | High | Med | High | Low | KEEP-TIGHTEN | Keep and absorb the current definition-of-done stage wording so completion does not need a separate process file. |
| `docs/sdd/process/09a-definition-of-done.md` | final completion claim | done sub-stage | Support | Low | High | Med | Low | Med | Low | MERGE | Merge into `docs/sdd/process/08-release.md`; policy already lives in governance and the actionable checks already live in `done-checklist.md`. |

### 5.7 Checklists

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/checklists/README.md` | stage-boundary navigation | checklist index | Yes | Med | Low | Med | Med | High | Low | KEEP | Keep. |
| `docs/sdd/checklists/quick-start-new-feature.md` | when opening a new governed feature | startup checklist | Support | Med | High | Med | Med | High | Med | MERGE | Merge into `docs/sdd/checklists/01-feature-intake.md`; current content mostly repeats `docs/specs/README.md` plus other intake checklists. |
| `docs/sdd/checklists/01-feature-intake.md` | feature creation start | intake checklist | Yes | High | Low | High | High | High | Low | KEEP-TIGHTEN | Keep as the primary startup checklist and absorb any truly useful quick-start items. |
| `docs/sdd/checklists/02-requirements-review.md` | requirements gate | requirements checklist | Yes | High | Low | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/checklists/03-design-review.md` | design gate | design checklist | Yes | High | Low | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/checklists/04-pre-implementation-gate.md` | before first implementation commit | implementation-start gate | Yes | High | Med | High | High | High | Med | KEEP | Keep; it is one of the strongest operational files in the framework. |
| `docs/sdd/checklists/05-implementation-completion.md` | after implementation before review | completion checklist | Yes | High | Low | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/checklists/self-review-checklist.md` | self-review | self-review gate | Yes | High | Low | High | High | High | Low | KEEP | Keep; this should survive even if `07a-self-review.md` is merged. |
| `docs/sdd/checklists/06-code-review-against-spec.md` | formal review | review checklist | Yes | High | Med | High | High | High | Med | KEEP | Keep. |
| `docs/sdd/checklists/07-qa-validation.md` | QA or manual regression | QA checklist | Yes | Med | Low | Med | High | High | Low | KEEP | Keep. |
| `docs/sdd/checklists/08-release-readiness.md` | pre-release | release checklist | Yes | High | Med | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/checklists/done-checklist.md` | final done check | done checklist | Yes | High | Med | High | High | High | Low | KEEP | Keep; this should be the actionable layer paired with governance definition-of-done. |
| `docs/sdd/checklists/09-post-release-review.md` | after release | post-release checklist | Yes | Low | Low | Med | Med | High | Low | KEEP | Keep; narrow and non-duplicative. |

### 5.8 Standards

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/standards/README.md` | when selecting standards | standards index | Yes | Med | Low | Med | Med | High | Low | KEEP | Keep. |
| `docs/sdd/standards/repository-context.md` | unfamiliar module scoping | repo-specific implementation context | Yes | High | Med | Med | Med | High | Low | KEEP | Keep. |
| `docs/sdd/standards/naming-and-module-organization.md` | when naming or placing files | naming and placement standard | Yes | High | Med | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/standards/style-and-comment-rules.md` | any code edit or review | formatting, comment, import rules | Yes | High | Med | High | High | High | Low | KEEP | Keep. |
| `docs/sdd/standards/backend-process-architecture.md` | backend design or review | backend structure standard | Yes | High | Med | High | Med | High | Low | KEEP | Keep. |
| `docs/sdd/standards/backend-change-rules.md` | backend implementation or review | backend behavioral constraints | Yes | High | Med | High | High | High | Med | KEEP | Keep. |
| `docs/sdd/standards/database-change-rules.md` | SQL, schema, mutation, transaction work | DB rules | Yes | High | Med | High | High | High | Med | KEEP | Keep. |
| `docs/sdd/standards/security-validation-and-logging.md` | auth, validation, logging, error flow | security and validation rules | Yes | High | Med | High | High | High | Med | KEEP | Keep. |
| `docs/sdd/standards/frontend-screen-architecture.md` | frontend design or review | frontend structure standard | Yes | High | Med | High | Med | High | Low | KEEP | Keep. |
| `docs/sdd/standards/frontend-change-rules.md` | frontend implementation or review | frontend behavioral constraints | Yes | High | Med | High | High | High | Med | KEEP | Keep. |
| `docs/sdd/standards/testing-and-quality-signals.md` | verification planning and review | practical quality expectations | Yes | High | Med | High | Med | High | Low | KEEP | Keep. |
| `docs/sdd/standards/conflict-management.md` | linked-screen or shared-contract impact work | conflict-management standard | Yes | Med | Low | Med | Med | Med | Low | KEEP | Keep. |
| `docs/sdd/standards/known-inconsistencies.md` | when touched area contains legacy exceptions | repository exception list | Yes | Med | Low | Med | Low | Med | Low | KEEP | Keep. |
| `docs/sdd/standards/module-patterns/search.md` | search-family work | search module pattern | Yes | High | Low | High | Med | High | Low | KEEP | Keep. |
| `docs/sdd/standards/module-patterns/csv.md` | CSV-family work | CSV module pattern | Yes | High | Low | High | Med | High | Low | KEEP | Keep. |
| `docs/sdd/standards/module-patterns/file-output.md` | PDF, Excel, file-output work | file-output pattern | Yes | High | Low | High | Med | High | Low | KEEP | Keep. |

### 5.9 Prompts

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/prompts/README.md` | only after canonical docs are known | prompt index | Support | Med | Med | Med | Low | Med | Low | KEEP-TIGHTEN | Keep, but clearly mark the minimum prompt set and move the rest to utility or legacy status. |
| `docs/sdd/prompts/create-spec.md` | when no governing package exists | create governed package prompt | Support | High | High | High | Low | High | Med | KEEP-TIGHTEN | Keep as the surviving spec-authoring prompt and absorb the update path via one parameterized prompt. |
| `docs/sdd/prompts/update-spec.md` | when existing package changes | update governed package prompt | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/prompts/create-spec.md`; difference is request state, not prompt shape. |
| `docs/sdd/prompts/implement-feature.md` | governed implementation | main implementation prompt | Support | High | Med | High | Low | High | Med | KEEP | Keep; this is one of the few primary prompts worth retaining. |
| `docs/sdd/prompts/review-feature.md` | governed review | main review prompt | Support | High | High | High | Low | High | Med | KEEP-TIGHTEN | Keep as the single main review prompt and absorb the no-spec-pack variation. |
| `docs/sdd/prompts/review-code-without-spec.md` | rules-first review | alternate review prompt | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/prompts/review-feature.md`; task-profile header already distinguishes the two modes. |
| `docs/sdd/prompts/fix-from-review-report.md` | closing recorded findings | grounded fix prompt | Support | High | Med | High | Low | High | Low | KEEP | Keep. |
| `docs/sdd/prompts/generate-spec-pack.md` | pack generation | spec-pack generation prompt | Support | Med | Low | Med | Low | Med | Low | KEEP | Keep; distinct artifact outcome. |
| `docs/sdd/prompts/generate-execution-brief.md` | brief generation | execution-brief generation prompt | Support | Med | Low | Med | Low | Med | Low | KEEP | Keep; distinct artifact outcome. |
| `docs/sdd/prompts/derive-rules-from-codebase.md` | codebase rule extraction | discovery prompt | Support | Low | Med | Low | Low | Low | Low | DROP | Drop from the default framework set; no operational workflow depends on it, and broader rule extraction is intentionally out of scope for this cleanup. |
| `docs/sdd/prompts/core/README.md` | utility prompt navigation | core utilities index | Support | Low | Low | Low | Low | Med | Low | KEEP | Keep. |
| `docs/sdd/prompts/core/self-review.md` | post-implementation self-review | self-review utility prompt | Support | Med | Med | Med | Low | Med | Low | KEEP | Keep as a utility prompt, not a primary workflow prompt. |
| `docs/sdd/prompts/core/pre-merge-audit.md` | final merge readiness | pre-merge audit utility prompt | Support | Med | Med | Med | Low | Med | Low | KEEP | Keep as a utility prompt. |
| `docs/sdd/prompts/core/recover-context.md` | lost direction or resume | recovery utility prompt | Support | High | Low | High | Low | High | Low | KEEP | Keep; uniquely useful and aligned with recovery mode. |

### 5.10 Templates

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `docs/sdd/templates/README.md` | when selecting artifact templates | template index | Yes | Med | Med | Med | Med | High | Med | KEEP-TIGHTEN | Keep, but explicitly mark the numbered scaffold as canonical and the paired artifact templates as merge candidates. |
| `docs/sdd/templates/execution-brief-template.md` | workflows or tools expecting top-level brief template | top-level brief alias | Support | Low | High | Low | Low | Med | Low | KEEP-TIGHTEN | Keep as a compatibility alias if tools need it; otherwise turn it into a tiny pointer only. |
| `docs/sdd/templates/spec-pack-template.md` | when defining pack structure | pack template | Support | Med | Low | Med | Low | Med | Low | KEEP | Keep; this is a distinct generated-artifact template. |
| `docs/sdd/templates/task-profile-examples.md` | when writing task-profile headers | canonical request examples | Yes | Med | Low | Med | Low | High | Low | KEEP | Keep; this file has clear unique value and is already used by routing work. |
| `docs/sdd/templates/decisions/decision-record-adr.md` | ADR creation | ADR template | Yes | Med | Low | Med | Low | High | Low | KEEP | Keep. |
| `docs/sdd/templates/repository/change-log.md` | repo release note updates | root changelog entry template | Yes | Low | Low | Low | Low | Med | Low | KEEP | Keep. |
| `docs/sdd/templates/feature/specs.md` | high-level package structure reference | package structure summary | Support | Low | High | Low | Low | Med | Low | MERGE | Merge into `docs/sdd/templates/feature-package/README.md`; it adds no unique workflow value beyond package structure summary. |
| `docs/sdd/templates/feature/feature-brief.md` | optional intake write-up | intake summary template | Support | Low | High | Low | Low | Med | Low | MERGE | Merge into `docs/sdd/templates/feature-package/README.md`; current README already covers the same intake shape. |
| `docs/sdd/templates/feature/requirements.md` | one-off requirements authoring | artifact-level requirements template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/01-requirements.md`; dual-source maintenance is not worth keeping. |
| `docs/sdd/templates/feature/design.md` | one-off design authoring | artifact-level design template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/02-design.md`. |
| `docs/sdd/templates/feature/data-model.md` | one-off data-model authoring | artifact-level data template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/03-data-model.md`. |
| `docs/sdd/templates/feature/api-contract.md` | one-off contract authoring | artifact-level contract template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/04-api-contract.md`. |
| `docs/sdd/templates/feature/ui-ux-behavior-spec.md` | one-off behavior authoring | artifact-level behavior template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/05-behavior.md`. |
| `docs/sdd/templates/feature/edge-cases-and-failure-modes.md` | one-off edge-case authoring | artifact-level edge-case template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/06-edge-cases.md`. |
| `docs/sdd/templates/feature/task-breakdown.md` | one-off task authoring | artifact-level task template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/07-tasks.md`. |
| `docs/sdd/templates/feature/acceptance-criteria.md` | one-off AC authoring | artifact-level AC template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/08-acceptance-criteria.md`. |
| `docs/sdd/templates/feature/test-cases.md` | one-off TC authoring | artifact-level TC template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/09-test-cases.md`. |
| `docs/sdd/templates/feature/rollout-plan.md` | one-off rollout authoring | artifact-level rollout template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/10-rollout.md`. |
| `docs/sdd/templates/feature/implementation-report.md` | one-off implementation reporting | artifact-level implementation template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/11-implementation-report.md`. |
| `docs/sdd/templates/feature/review-report.md` | one-off review reporting | artifact-level review template | Support | Med | High | Med | Low | Med | Med | MERGE | Merge into `docs/sdd/templates/feature-package/12-review-report.md`. |
| `docs/sdd/templates/feature/risk-log.md` | one-off risk tracking | risk-log template | Support | Med | High | Med | Low | Med | Low | MERGE | Merge into `docs/sdd/templates/feature-package-plus/13-risk-log.md`. |
| `docs/sdd/templates/feature/decision-notes.md` | one-off decision capture | decision-notes template | Support | Med | High | Med | Low | Med | Low | MERGE | Merge into `docs/sdd/templates/feature-package-plus/14-decision-notes.md`. |
| `docs/sdd/templates/feature/execution-brief.md` | when authoring a brief body | detailed brief template | Support | Med | Med | Med | Low | Med | Low | KEEP | Keep; this is the real working brief template behind the top-level alias. |
| `docs/sdd/templates/feature/conflict-review.md` | shared-contract or linked-screen impact work | conflict-review template | Yes | Med | Low | Med | Low | Med | Low | KEEP | Keep. |
| `docs/sdd/templates/feature/linked-screen-scope.md` | linked-screen impact scoping | linked-scope template | Yes | Med | Low | Med | Low | Med | Low | KEEP | Keep. |
| `docs/sdd/templates/feature-package/README.md` | when copying a new feature package | numbered scaffold entry | Yes | High | Med | High | Med | High | Med | KEEP | Keep as the canonical package-scaffold entrypoint. |
| `docs/sdd/templates/feature-package/01-requirements.md` | new package scaffold | numbered requirements scaffold | Yes | High | Med | High | Med | High | Med | KEEP | Keep as canonical numbered scaffold and absorb paired artifact template content here. |
| `docs/sdd/templates/feature-package/02-design.md` | new package scaffold | numbered design scaffold | Yes | High | Med | High | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/03-data-model.md` | conditional new package scaffold | numbered data-model scaffold | Yes | Med | Med | Med | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/04-api-contract.md` | conditional new package scaffold | numbered contract scaffold | Yes | Med | Med | Med | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/05-behavior.md` | conditional new package scaffold | numbered behavior scaffold | Yes | Med | Med | Med | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/06-edge-cases.md` | conditional new package scaffold | numbered edge-case scaffold | Yes | Med | Med | Med | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/07-tasks.md` | new package scaffold | numbered task scaffold | Yes | High | Med | High | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/08-acceptance-criteria.md` | new package scaffold | numbered AC scaffold | Yes | High | Med | High | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/09-test-cases.md` | new package scaffold | numbered TC scaffold | Yes | High | Med | High | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/10-rollout.md` | new package scaffold | numbered rollout scaffold | Yes | High | Med | High | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/11-implementation-report.md` | implementation reporting scaffold | numbered implementation-report scaffold | Yes | High | Med | High | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/12-review-report.md` | review reporting scaffold | numbered review-report scaffold | Yes | High | Med | High | Med | High | Med | KEEP | Keep. |
| `docs/sdd/templates/feature-package/changelog.md` | feature-local changelog scaffold | numbered changelog scaffold | Yes | Med | Low | Med | Low | High | Low | KEEP | Keep. |
| `docs/sdd/templates/feature-package-plus/README.md` | when adding optional SDD2+ companion files | companion-file index | Yes | Low | Low | Low | Low | High | Low | KEEP-TIGHTEN | Keep, but keep it tiny and clearly subordinate to the numbered scaffold. |
| `docs/sdd/templates/feature-package-plus/13-risk-log.md` | optional companion scaffold | numbered risk-log scaffold | Yes | Med | Low | Med | Low | High | Low | KEEP | Keep. |
| `docs/sdd/templates/feature-package-plus/14-decision-notes.md` | optional companion scaffold | numbered decision-notes scaffold | Yes | Med | Low | Med | Low | High | Low | KEEP | Keep. |

### 5.11 Legacy Bridge: `agent/`

| File | Workflow Use | Role | Canonical | Operational Value | Overlap | Decision Support | Enforceability | AI Usability | Maintenance Cost | Decision | Action |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `agent/START_HERE.md` | only when canonical docs still leave a task-specific gap | bridge landing page | Bridge | Med | High | Low | Low | Low | Med | KEEP-TIGHTEN | Keep only as a thin legacy bridge that immediately points back to `AGENTS.md` and `docs/sdd/README.md`; remove active workflow wording. |
| `agent/PROMPTS.md` | old prompt entrypoint | obsolete prompt library | Bridge | Low | High | Low | Low | Low | High | DROP | Drop after replacing it with a short pointer to `docs/sdd/prompts/`; operational capability is preserved by the canonical prompt library. |
| `agent/checklists/README.md` | old checklist index | bridge checklist index | Bridge | Low | High | Low | Low | Low | Low | DROP | Drop after a bridge notice period; canonical checklist index already exists at `docs/sdd/checklists/README.md`. |
| `agent/checklists/review-quick-gates.md` | old review shortcut | duplicate review checklist | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/checklists/06-code-review-against-spec.md`; it offers no unique gate beyond the canonical review checklist. |
| `agent/checklists/spec-pack-completeness.md` | old pack-start gate | duplicate spec completeness checklist | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/checklists/04-pre-implementation-gate.md`; feature-package completeness already lives in canonical specs docs and that gate. |
| `agent/checklists/sql-change-checklist.md` | old SQL review shortcut | duplicate SQL checklist | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/database-change-rules.md`; SQL gate content already belongs in the DB standards and review checklist. |
| `agent/pipeline/README.md` | old pipeline entry | parallel workflow index | Bridge | Low | High | Low | Low | Low | Med | DROP | Drop after bridge notice; canonical stage order already lives in `docs/sdd/process/README.md`. |
| `agent/pipeline/01-task-intake.md` | old intake stage | duplicate intake stage | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/process/01-intake.md`. |
| `agent/pipeline/02-context-loading.md` | old context-loading stage | duplicate load-order stage | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/README.md`; canonical read order already lives there plus `context/ai-loading-order.md`. |
| `agent/pipeline/03-spec-pack-flow.md` | old spec-pack stage | duplicate pack/spec flow | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/specs/README.md`; spec-pack and feature-package authority are already defined there. |
| `agent/pipeline/04-implementation-flow.md` | old implementation stage | duplicate implementation stage | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/process/05-implementation.md`. |
| `agent/pipeline/05-review-and-verify.md` | old review stage | duplicate review/release flow | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/process/07-review.md`; release detail already lives in `08-release.md`. |
| `agent/pipeline/06-conflict-management-flow.md` | old conflict stage | duplicate conflict flow | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/conflict-management.md`. |
| `agent/rules/00-repo-scope.md` | old fast repo-scope rule | duplicate repo context rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/repository-context.md`. |
| `agent/rules/01-agent-working-mode.md` | old agent entry rule | duplicate agent behavior rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `AGENTS.md`; the root contract already owns this behavior. |
| `agent/rules/10-backend-screen-stack.md` | old backend structure rule | duplicate backend architecture rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/backend-process-architecture.md`. |
| `agent/rules/11-backend-sql-and-transactions.md` | old DB rule | duplicate DB rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/database-change-rules.md`. |
| `agent/rules/12-backend-validation-and-errors.md` | old backend validation rule | duplicate security/validation rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/security-validation-and-logging.md`. |
| `agent/rules/13-backend-security-and-config.md` | old backend security rule | duplicate security/config rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/security-validation-and-logging.md`. |
| `agent/rules/14-backend-sql-review-specifics.md` | old SQL review rule | duplicate DB review rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/database-change-rules.md`. |
| `agent/rules/15-backend-constants-and-parameter-indexing.md` | old constants/index rule | duplicate backend or DB rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/governance/10-code-standards.md`; canonical code standards already cover these checks. |
| `agent/rules/16-backend-common-field-validation.md` | old shared validation rule | duplicate validation rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/security-validation-and-logging.md`. |
| `agent/rules/17-frontend-response-guards.md` | old FE response guard rule | duplicate frontend rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/frontend-change-rules.md`. |
| `agent/rules/20-frontend-screen-pattern.md` | old FE architecture rule | duplicate FE architecture rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/frontend-screen-architecture.md`. |
| `agent/rules/21-frontend-services-state-and-ajax.md` | old FE transport rule | duplicate FE architecture rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/frontend-screen-architecture.md`. |
| `agent/rules/22-commenting-and-hardcoding.md` | old style rule | duplicate style/comment rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/style-and-comment-rules.md`. |
| `agent/rules/30-search-module-pattern.md` | old search pattern rule | duplicate search module pattern | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/module-patterns/search.md`. |
| `agent/rules/31-csv-module-pattern.md` | old CSV pattern rule | duplicate CSV module pattern | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/module-patterns/csv.md`. |
| `agent/rules/32-file-output-module-pattern.md` | old file-output rule | duplicate file-output pattern | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/module-patterns/file-output.md`. |
| `agent/rules/40-testing-expectations.md` | old testing rule | duplicate testing rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/testing-and-quality-signals.md`. |
| `agent/rules/41-review-and-build-workflow.md` | old review/build flow | duplicate review/verification flow | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/process/07-review.md`. |
| `agent/rules/42-quality-gates-and-verdicts.md` | old verdict rule | duplicate done/release rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/governance/definition-of-done.md`. |
| `agent/rules/43-sql-reference-source.md` | old SQL source rule | duplicate DB rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/database-change-rules.md`. |
| `agent/rules/44-conflict-management.md` | old conflict rule | duplicate conflict rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/conflict-management.md`. |
| `agent/rules/45-spec-pack-artifacts.md` | old pack-artifact rule | duplicate spec/package rule | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/specs/README.md`; canonical feature-package artifacts already live there. |
| `agent/rules/90-known-inconsistencies.md` | old inconsistency rule | duplicate inconsistency list | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/known-inconsistencies.md`. |
| `agent/spec-pack/README.md` | old spec-pack entry | obsolete pack guide | Bridge | Low | High | Low | Low | Low | Low | DROP | Drop after bridge notice; canonical pack guidance now lives in `docs/specs/README.md` and `docs/sdd/templates/spec-pack-template.md`. |
| `agent/spec-pack/templates/review-conflict-template.md` | old conflict template | duplicate template | Bridge | Low | High | Low | Low | Low | Low | MERGE | Merge into `docs/sdd/templates/feature/conflict-review.md`. |
| `agent/spec-pack/templates/screen-conflict-scope-template.md` | old linked-scope template | duplicate template | Bridge | Low | High | Low | Low | Low | Low | MERGE | Merge into `docs/sdd/templates/feature/linked-screen-scope.md`. |
| `agent/spec-pack/templates/spec-pack-template.md` | old pack template | duplicate pack template | Bridge | Low | High | Low | Low | Low | Low | MERGE | Merge into `docs/sdd/templates/spec-pack-template.md`. |
| `agent/standards/README.md` | old standards entry | parallel standards index | Bridge | Low | High | Low | Low | Low | Low | DROP | Drop after bridge notice; canonical standards index already exists at `docs/sdd/standards/README.md`. |
| `agent/standards/common/agent-working-contract.md` | old agent contract | duplicate agent contract | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `AGENTS.md`; the root contract now owns this responsibility. |
| `agent/standards/common/backend-api-process-architecture.md` | old backend architecture standard | duplicate standard | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/backend-process-architecture.md`. |
| `agent/standards/common/conflict-management.md` | old conflict standard | duplicate standard | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/conflict-management.md`. |
| `agent/standards/common/database-sql-and-transactions.md` | old DB standard | duplicate standard | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/database-change-rules.md`. |
| `agent/standards/common/frontend-screen-architecture.md` | old FE architecture standard | duplicate standard | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/frontend-screen-architecture.md`. |
| `agent/standards/common/naming-and-repo-organization.md` | old naming standard | duplicate standard | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/naming-and-module-organization.md`. |
| `agent/standards/common/nknhat-migration-notes.md` | old personal migration note | stale personal history | Bridge | Low | Med | Low | Low | Low | Low | DROP | Drop; unique operational value is gone and historical context is already better handled in canonical migration files. |
| `agent/standards/common/repository-summary.md` | old repo context standard | duplicate repo context | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/repository-context.md`. |
| `agent/standards/common/review-build-and-specpack-workflow.md` | old review/build standard | duplicate review flow | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/process/07-review.md`. |
| `agent/standards/common/security-config-and-startup.md` | old security/config standard | duplicate standard | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/security-validation-and-logging.md`. |
| `agent/standards/common/sql-document-reference.md` | old SQL-source standard | duplicate standard | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/database-change-rules.md`. |
| `agent/standards/common/testing-and-quality-signals.md` | old testing standard | duplicate standard | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/testing-and-quality-signals.md`. |
| `agent/standards/common/validation-error-logging.md` | old validation standard | duplicate standard | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/security-validation-and-logging.md`. |
| `agent/standards/modules/search-modules.md` | old search module standard | duplicate module pattern | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/module-patterns/search.md`. |
| `agent/standards/modules/csv-modules.md` | old CSV module standard | duplicate module pattern | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/module-patterns/csv.md`. |
| `agent/standards/modules/pdf-excel-and-download-modules.md` | old file-output module standard | duplicate module pattern | Bridge | Low | High | Med | Low | Low | Low | MERGE | Merge into `docs/sdd/standards/module-patterns/file-output.md`. |

## 6. Merge Candidates

High-confidence merge set:

1. `docs/sdd/ai-ops/agent-operational-rules.md` -> `docs/sdd/governance/09-ai-agent-policy.md`
2. `docs/sdd/process/06a-two-pass-execution.md` -> `docs/sdd/process/05-implementation.md` (`executed in this branch`)
3. `docs/sdd/process/07a-self-review.md` -> `docs/sdd/process/07-review.md` (`executed in this branch`)
4. `docs/sdd/process/09a-definition-of-done.md` -> `docs/sdd/process/08-release.md` (`executed in this branch`)
5. `docs/sdd/checklists/quick-start-new-feature.md` -> `docs/sdd/checklists/01-feature-intake.md`
6. `docs/sdd/foundation/*.md` child files -> `docs/sdd/foundation/README.md` (`executed in this branch`)
7. `docs/sdd/prompts/update-spec.md` -> `docs/sdd/prompts/create-spec.md`
8. `docs/sdd/prompts/review-code-without-spec.md` -> `docs/sdd/prompts/review-feature.md`
9. `docs/sdd/templates/feature/*` paired artifact templates -> matching numbered files under `docs/sdd/templates/feature-package/` or `feature-package-plus/`
10. most `agent/` pipeline, rule, standard, checklist, and template files -> their already-existing canonical `docs/sdd/` or `docs/specs/` targets

## 7. Drop Candidates

High-confidence drop set after bridge-safe transition:

1. `docs/sdd/governance/11-ai-agent-policy.md` (`executed in this branch`)
2. `docs/sdd/prompts/derive-rules-from-codebase.md`
3. `agent/PROMPTS.md`
4. `agent/pipeline/README.md`
5. `agent/checklists/README.md`
6. `agent/standards/README.md`
7. `agent/spec-pack/README.md`
8. `agent/standards/common/nknhat-migration-notes.md`

Operational capability is preserved in each case because the live function already exists in a canonical `docs/sdd/`, `docs/specs/`, or `AGENTS.md` target.

## 8. Canonical Artifacts After Cleanup

Recommended canonical set:

- Root contract: `AGENTS.md`
- Core context: `docs/sdd/context/constitution.md`, `note.md`, `architecture-context.md`, `product-context.md`, `tech-context.md`, `ai-loading-order.md`, `task-profiles.md`
- Core governance: `docs/sdd/governance.md` plus `docs/sdd/governance/01-10`, `12-uncertainty-escalation-policy.md`, `12-quality-gate-levels.md`, `definition-of-done.md`
- Feature-package standard: `docs/specs/README.md`
- Governing work units: `docs/specs/<feature-id>/`
- Core process: `docs/sdd/process/01-intake.md` through `08-release.md`
- Core gates: `docs/sdd/checklists/01-09`, `self-review-checklist.md`, `done-checklist.md`
- Core standards: `docs/sdd/standards/` plus `module-patterns/`
- Core templates: `docs/sdd/templates/feature-package/`, `feature-package-plus/`, `spec-pack-template.md`, `execution-brief-template.md`, `task-profile-examples.md`, unique feature add-ons like conflict review and linked-scope
- Core prompts worth keeping: see next section
- AI-only add-ons: `docs/sdd/ai-ops/09-recovery-mode.md`, `docs/sdd/ai-ops/agent-clients-and-handoff.md`
- Historical only: `docs/sdd/migration-notes.md`, `docs/sdd/migration-plan.md`
- Legacy bridge only: a very small `agent/` landing page, if the bridge remains at all

## 9. Prompt Simplification Plan

Primary prompts worth keeping:

1. `docs/sdd/prompts/create-spec.md` after absorbing update behavior
2. `docs/sdd/prompts/implement-feature.md`
3. `docs/sdd/prompts/review-feature.md` after absorbing no-spec-pack review mode
4. `docs/sdd/prompts/fix-from-review-report.md`
5. `docs/sdd/prompts/generate-spec-pack.md`
6. `docs/sdd/prompts/generate-execution-brief.md`
7. `docs/sdd/prompts/core/recover-context.md`

Utility prompts worth keeping but not presenting as primary workflow prompts:

- `docs/sdd/prompts/core/self-review.md`
- `docs/sdd/prompts/core/pre-merge-audit.md`

Prompts to merge or remove:

- merge `update-spec.md` into `create-spec.md`
- merge `review-code-without-spec.md` into `review-feature.md`
- drop `derive-rules-from-codebase.md` from the default framework set

## 10. AI Smooth-Operation Checklist

- Read `AGENTS.md` first.
- Load only the canonical core context and governance files before any prompts, examples, packs, or bridge docs.
- Treat `docs/specs/<feature-id>/` as the approval source of truth for governed work.
- Treat `docs/spec-packs/` and prompts as execution aids only.
- Do not load `docs/sdd/migration-notes.md` or `docs/sdd/migration-plan.md` during normal feature work.
- Do not load `agent/` unless canonical docs still leave a task-specific gap.
- If `agent/` is opened, treat it as bridge or compatibility material, never as primary authority.
- When a file duplicates a stronger canonical source, prefer the stronger source and record the duplicate as overlap, not as a second authority.
- When framework files conflict, stop and cite the exact file paths; do not silently reconcile by intuition.
- Run change-impact analysis whenever a change touches any of: `AGENTS.md`, `docs/sdd/governance*`, `docs/sdd/process*`, `docs/sdd/checklists*`, `docs/sdd/templates*`, prompt set shape, or legacy bridge structure.
- Stop and report uncertainty when a proposed cleanup would delete compatibility pointers, shrink the `agent/` bridge, or alter SDD2+ additive assumptions without explicit approval.

## 11. Recommended Target Structure

Lean target structure:

```text
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
    history/
      migration-notes.md
      migration-plan.md
    architecture/
      target-architecture.md
agent/
  START_HERE.md    # optional legacy bridge only
```

Design principles behind the target:

- fewer files, stronger files
- one clear role per file
- history separated from live workflow
- bridge content reduced to explicit compatibility notice
- prompts treated as a small execution aid set, not a parallel operating system
- templates centered on one numbered scaffold instead of two overlapping families

## 12. Human-Confirmation Items

These items should not be silently implemented from the audit alone:

1. retiring most of the `agent/` tree instead of merely marking it as legacy
2. dropping `docs/sdd/governance/11-ai-agent-policy.md` if external bookmarks still depend on it
3. collapsing the `docs/sdd/foundation/` multi-file layout into a single file if ADR-0004 owners want the folder split preserved
4. removing the paired `docs/sdd/templates/feature/*` templates instead of keeping them as authoring conveniences
5. moving historical docs into a new `history/` subfolder if the repo wants to avoid path churn for old links
