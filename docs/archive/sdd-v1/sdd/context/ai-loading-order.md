# AI Loading Order

## Required Order

1. `AGENTS.md`
2. `docs/sdd/context/constitution.md`
3. `docs/sdd/context/note.md`
4. `docs/sdd/context/architecture-context.md`
5. `docs/sdd/context/product-context.md`
6. `docs/sdd/context/tech-context.md`
7. `docs/sdd/execution/task-routing.md` when routing is needed or no header is present
8. `docs/sdd/execution/task-input-header.md` when a header is present or must be written
9. `docs/sdd/context/code-structure-rules.md` when implementation, fixing, review, contracts, or code-shape drift is in play
10. `docs/sdd/governance.md`
11. `docs/sdd/governance/01-ai-agent-policy.md` when AI-assisted work is in scope
12. `docs/sdd/governance/02-anti-hallucination.md` when AI-assisted work is in scope
13. `docs/sdd/governance/03-context-binding.md` before any DB-related work
14. `docs/sdd/governance/minimal-sufficient-context-policy.md` when choosing the smallest compliant read set
15. the selected profile under `docs/sdd/execution-profiles/` when adapting to Codex, Claude, or GitHub Copilot
16. the selected task contract under `docs/sdd/execution/contracts/`
17. `docs/sdd/spec-authoring/README.md` when spec authoring is in scope, otherwise `docs/specs/README.md` when governed work is in scope
18. the governing feature package under `docs/specs/<feature-id>/`
19. feature-owned `contracts/`
20. `07-tasks.md`, `08-acceptance-criteria.md`, and `09-test-cases.md`
21. only the relevant standards, process files, checklists, prompts, and templates needed for the current task
22. generated spec-pack only when the selected task profile or feature explicitly uses it

## Task Profile Selection

If the request includes a task-profile header, resolve it in this order:

1. `Task Profile`
2. `Feature`
3. `Spec Pack`
4. `Bug Source`
5. fallback to the default loading order if the header is missing

Use `docs/sdd/execution/task-routing.md` as the canonical routing matrix.

The live formal profile values remain:

- `implement-new`
- `fix-from-pack`
- `fix-from-bug`
- `review-from-pack`
- `review-from-rules`
- `sonar-triage`
- `sonar-triage-and-fix`
- `sonar-fix-from-triage`

The live practical modes remain:

- `tiny-fix`
- `review-only`
- `docs-only`
- `audit-only`
- `hotfix`
- `recovery`

Compatibility bridges such as `docs/sdd/context/task-profiles.md` and `docs/sdd/context/task-mode-matrix.md` point back here. They are not the canonical routing source.

## Standard Selection Rules

- Load `docs/sdd/standards/00-rule-engine.md` before selecting repository standards for implementation or review.
- Always load `docs/sdd/standards/repository-context.md` for unfamiliar areas.
- Load `docs/sdd/standards/auto-codebase-rules.md` when choosing between competing local patterns or promoted repository-derived rules.
- Load `docs/sdd/standards/style-and-comment-rules.md` for any code edit or review that can drift formatting, comments, imports, or abstraction shape.
- Load `docs/sdd/standards/database-change-rules.md` for SQL, schema, migration, or transaction changes.
- Load `docs/sdd/governance/03-context-binding.md` before any DB-related analysis, design, implementation, review, SQL, mapping, entity, DTO, repository, or query work.
- Load `docs/sdd/standards/security-validation-and-logging.md` for auth, validation, request, logging, or error-flow changes.
- Load `docs/sdd/standards/backend-process-architecture.md` for backend flow changes.
- Load `docs/sdd/standards/frontend-screen-architecture.md` and `docs/sdd/standards/frontend-change-rules.md` for Angular screen or transport changes.
- Load the matching module pattern under `docs/sdd/standards/module-patterns/` for search, CSV, or file-output work.
- Load `docs/sdd/standards/known-inconsistencies.md` when the touched area already shows legacy pattern conflicts.
- Load `docs/sdd/governance/12-uncertainty-escalation-policy.md` when evidence is insufficient, conflicting, or a possible breaking change is in play.
- Load `docs/sdd/ai-ops/09-recovery-mode.md` when the agent loses task direction or resumes after interruption.
- Load `docs/sdd/checklists/touched-scope-enforcement.md` when the touched scope includes hygiene, parity, reuse, or schema-binding concerns that must be enforced explicitly.
- Load `docs/sdd/goal-and-success-metrics.md` when framework intent, operating-principle tradeoffs, proof strategy expectations, or feedback-loop rules are part of the task.

## Minimal Sufficient Context Discipline

- Preferred Route 1 operating pattern: stable fixed prefix plus the smallest variable task packet that still supports the next safe step.
- Treat the stable fixed prefix as: `AGENTS.md`, the required context docs, governance, the selected execution contract, and the selected agent profile.
- Treat the variable task packet as: the current request or header, focused issue or log excerpts, current target files, current diff, current brief, and current blockers.
- Keep the fixed prefix stable across related work; refresh only the variable task packet when the active task changes.
- Do not push task-local logs, diffs, or temporary investigation notes into the fixed-prefix layer.
- Use `docs/sdd/governance/minimal-sufficient-context-policy.md` to choose the baseline read set for the active mode.
- Do not bulk-load full standards, process, prompts, or template folders by default.
- Load only the specific standard, process file, checklist, contract, or helper that resolves the current task or uncertainty.
- Execution briefs may substitute for reopening many support docs only when the minimal-sufficient-context policy explicitly allows it.

## Usage Rules

- Read the feature package before treating any generated spec-pack as authoritative.
- Read `docs/sdd/spec-authoring/README.md` plus the create-spec contract before authoring or updating a governed package from raw inputs.
- When `fix-from-pack` or `review-from-pack` is selected, load the generated spec-pack only after the governing feature package and resolve conflicts in favor of the feature package.
- When `fix-from-bug` is selected and no governing feature package exists yet, create the required reduced-path or full-path feature package before non-trivial code changes begin.
- When `review-from-rules` is selected, spec-pack is optional, but the governing feature package remains required for governed changes.
- When `sonar-triage` or `sonar-triage-and-fix` is selected, load the Sonar finding source, `docs/sdd/governance/11-static-analysis-triage-policy.md`, the selected Sonar execution contract, and the current code anchors before classifying or fixing any finding.
- When `sonar-fix-from-triage` is selected, load the approved triage artifact, revalidate the current code first, and create or load the governing feature package before any non-trivial remediation starts.
- For non-trivial implementation or fix work, run the selected execution contract plus self-review before completion claims.
- Before formal review or completion claims, run self-review and the applicable done checks.
- Load `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, and `06-edge-cases.md` when the feature owns them.
- Use machine-readable contracts for interface shape, but use the feature package for intent, scope, rollout, and approval.
- Treat `spec_back.md` or similar backend notes as helper-only input; if `Backend Spec: alias:backend-spec` is used, map it to the backend-facing subset of canonical feature artifacts.
- Load `docs/decisions/` only when the feature, standards, or governance point to an ADR.
- Use retained legacy bridge material only if canonical docs still leave a task-specific gap and the referenced path exists in the current working tree.
