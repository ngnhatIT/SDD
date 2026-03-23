# AI Agent Policy

## When To Use

Use for any AI-assisted analysis, spec work, implementation, review, or final report.

## Required Evidence Set

- governing feature package under `docs/specs/` when the work is governed
- relevant files under `docs/sdd/context/`
- selected execution contract under `docs/sdd/execution/contracts/`
- selected agent profile under `docs/sdd/execution-profiles/` when agent-specific behavior matters
- approved decisions under `docs/decisions/` when referenced
- applicable `docs/sdd/governance/`, `docs/sdd/standards/`, and `docs/sdd/checklists/` files
- Sonar finding source or approved triage artifact plus inspected current-code anchors when static-analysis finding work is in scope
- inspected codebase anchors or repeated local patterns for the touched area
- generated files under `docs/spec-packs/` only as execution aids

## Evidence Order

1. governing specs and owned contracts
2. approved ADRs in `docs/decisions/`
3. `docs/sdd/context/`
4. `docs/sdd/governance/`
5. `docs/sdd/execution/`
6. `docs/sdd/standards/` and `docs/sdd/checklists/`
7. inspected local code and shared patterns
8. generated spec-packs and execution briefs

## Rules

- AI MUST NOT assume missing facts.
- AI MUST ground every behavior, interface, schema, and code-shape claim in the evidence order above.
- AI MUST keep stable operating context in canonical context, governance, execution-contract, and execution-profile sources, and keep variable task context in the current request, task header, execution brief, handoff note, or report evidence.
- AI MUST use a hypothesis -> verification -> deepen-reading loop for debugging or investigation; agent profiles define the client-specific operating pattern.
- AI MUST follow `docs/sdd/governance/minimal-sufficient-context-policy.md` before widening exploration beyond the current grounded packet.
- AI MUST prefer root-cause log excerpts over full log pastes by default and remove repeated warnings or unrelated noise when a shorter excerpt preserves the issue.
- AI MUST treat generated spec-packs and execution briefs as support only.
- AI MUST use `docs/sdd/spec-authoring/README.md` plus `docs/sdd/checklists/spec-authoring-checklist.md` when spec authoring is in scope.
- AI MUST use `docs/sdd/checklists/touched-scope-enforcement.md` when touched-scope hygiene, parity, reuse, or schema-binding concerns are in scope.
- AI MUST treat static-analysis scanner output as advisory only and validate findings against the current code before remediation.
- AI MUST create or update `docs/sonar/<date>-<scope>-triage.md` when the SonarQube workflow records non-fixed, stale, false-positive, risky, or later-approved items.
- If evidence is missing, stale, or conflicting, AI MUST stop guesswork and report the exact gap.
- Before final output, AI MUST complete `docs/sdd/process/05-self-review.md` and `docs/sdd/process/99-ai-checklist.md`.

## Gate

If a claim cannot be defended from approved artifacts or inspected repository evidence, the work fails this policy.
