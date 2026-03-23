# ADR-0004 SDD2+ Agent-Ready Extension

- Status: accepted
- Date: 2026-03-16
- Owners: repository maintainers
- Related specs: `2026-03-16-sdd2-plus-framework-upgrade`

## Context

The repository already has an SDD2 operating model, but AI-assisted work still has to assemble context, prompts, risk framing, and execution aids from several places.

The goal is to improve execution speed and handoff quality without replacing the current approval model or invalidating existing SDD2 artifacts.

## Decision

This repository adopts an additive SDD2+ layer with these rules:

1. Existing SDD2 artifacts remain valid and are not replaced.
2. `docs/sdd/foundation/`, `docs/sdd/prompts/`, and `docs/sdd/ai-ops/` become the new extension layer.
3. Feature-level `13-risk-log.md` and `14-decision-notes.md` are supported as additive companion artifacts.
4. Generated spec-packs and execution briefs may surface those companion artifacts when present, but they remain execution aids only.
5. The framework must remain usable from Claude, Codex, GitHub Copilot, Cursor, and GPT-class assistants.
6. `tools/sdd/` becomes a stable tool index while `scripts/sdd/` stays the active executable surface.

## Consequences

- New features can carry richer risk, decision, and execution context without changing the base SDD lifecycle.
- Older feature packages do not need backfill to remain governed and valid.
- Tooling and docs should enrich AI execution artifacts when companion files exist, but must degrade safely when they do not.
- Humans and AI agents can share the same repository artifacts instead of keeping parallel agent-specific playbooks.
