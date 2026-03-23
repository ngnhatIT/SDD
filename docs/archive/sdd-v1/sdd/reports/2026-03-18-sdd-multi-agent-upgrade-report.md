# SDD Multi-Agent Upgrade Report

## What Was Wrong Before

- routing logic was duplicated across `AGENTS.md`, context files, and multiple prompt files
- prompts repeated governance and stop rules instead of adapting behavior by agent type
- spec authoring existed as a prompt plus templates, not as a governed workflow from raw inputs
- repeated hygiene, parity, and reuse rules were spread across policy, process, and checklists
- historical and compatibility material still sat near the main path and increased reading noise

## What Changed

- added `docs/sdd/execution/` for canonical routing, task header, and minimum execution contracts
- added `docs/sdd/execution-profiles/` for Codex, Claude, and GitHub Copilot
- added `docs/sdd/spec-authoring/` plus `docs/sdd/checklists/spec-authoring-checklist.md`
- added `docs/sdd/checklists/touched-scope-enforcement.md`
- rewired `AGENTS.md`, docs entrypoints, loading order, governance, and prompts around the new layers
- reduced prompts to thin adapters and compatibility bridges
- moved historical migration and cleanup records under `docs/archive/sdd/history/`
- moved non-canonical examples and validator fixtures under `docs/specs-support/`

## Canonical Files Now

- root contract: `AGENTS.md`
- stable context: `docs/sdd/context/`
- governance: `docs/sdd/governance.md`, `docs/sdd/governance/`
- routing and contracts: `docs/sdd/execution/`
- agent behavior: `docs/sdd/execution-profiles/`
- governed spec authoring: `docs/sdd/spec-authoring/`
- approval source: `docs/specs/README.md` and `docs/specs/<feature-id>/`

## Multi-Agent Operating Model

- Codex: use for end-to-end execution once the route is grounded; follow contracts literally and avoid widening scope.
- Claude: use for analysis-heavy and reasoning-heavy work; force contract-bound checkpoints to prevent drift and over-design.
- GitHub Copilot: use only from a compact packet; do not rely on ambient IDE context for repo-wide governance or completion claims.

## Remaining Gaps

- no formal review report exists yet for this upgrade
