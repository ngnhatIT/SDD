# Spec Pack: 2026-03-23-sdd-v2-framework - Lean SDD Framework Refactor

- Status: implemented
- Owner: repository maintainers
- Last Updated: 2026-03-23

## 1. Context

The repository previously used a documentation-heavy SDD model with multiple active authority layers:

- `docs/sdd/` for framework rules
- `docs/specs/` for numbered feature packages
- flat `docs/spec-packs/*.md` as execution aids
- root manuals and shell tooling that still routed through the old structure

An external tool now already generates `spec_pack`, so keeping `docs/specs/` as a parallel source of truth creates duplicate authority and wastes context.

## 2. Scope

### In Scope

- rewrite the active framework around `spec_pack.md`, `reinforcement.md`, and `verification.md`
- rewrite `AGENTS.md` and active doc entrypoints
- create lean governance, execution, standards, checklists, and templates
- archive conflicting SDD v1 docs, specs, flat packs, manuals, and helper scripts
- preserve database schema authority

### Out Of Scope

- rewriting archived legacy feature content
- creating a new spec-pack generator
- changing application runtime behavior outside framework documentation and archive moves

## 3. Functional Requirements

### FR-01 Single Feature Authority

- active framework docs must treat `docs/spec-packs/<feature-id>/spec_pack.md` as the canonical feature artifact
- active docs must not imply that `docs/specs/` is still authoritative

### FR-02 Separate Reinforcement Stage

- `reinforcement.md` must remain separate from `spec_pack.md`
- non-trivial changes must require reinforcement before implementation or review completion

### FR-03 Verification-Driven Closeout

- `verification.md` must be the required completion record
- verification must map back to acceptance criteria in `spec_pack.md`

### FR-04 Lean Active Surface

- active framework folders must be reduced to `spec-packs/`, `governance/`, `execution/`, `standards/`, `templates/`, `checklists/`, and `decisions/`
- active docs must be short and execution-oriented

### FR-05 Legacy Isolation

- conflicting SDD v1 materials must be archived or removed from the active path
- active docs must point to archive only as legacy support, not as authority

### FR-06 Minimal Context Support

- the default AI read path must be short and explicit
- active docs must not require broad README or governance traversal for normal work

### FR-07 Operational Strictness

- stop rules, uncertainty escalation, contract preservation, and done-definition must remain explicit
- DB schema authority must remain active

## 4. Technical Shape

### Source Anchors

- active entrypoints: `AGENTS.md`, `README.md`, `docs/README.md`
- legacy comparison anchors: `docs/archive/sdd-v1/sdd/README.md`, `docs/archive/sdd-v1/specs/README.md`, `docs/archive/sdd-v1/spec-packs-flat/README.md`, `scripts/archive/sdd-v1/README.md`
- DB schema authority: `docs/standards/schema_database.yaml`

### Planned Shape

- new active governance: `docs/governance/`
- new active execution docs: `docs/execution/`
- new active standards: `docs/standards/`
- new active checklists: `docs/checklists/`
- new active templates: `docs/templates/`
- new active feature authority: `docs/spec-packs/<feature-id>/`
- new cross-cutting ADR: `docs/decisions/ADR-0006-lean-sdd-v2-model.md`

## 5. Decisions And Constraints

- do not keep a parallel authority model for feature scope
- archive historical material instead of deleting it when it still has reference value
- keep reinforcement separate from the pack; do not fold ambiguity handling into core requirements
- preserve `schema_database.yaml` as the active DB source of truth
- do not leave active docs or scripts pointing to archived surfaces as canonical

## 6. Execution Slices

| Slice | Goal | Main files or modules | Verification target |
| --- | --- | --- | --- |
| S1 | isolate SDD v1 from the active path | `docs/archive/sdd-v1/`, `scripts/archive/sdd-v1/` | AC-05 |
| S2 | establish lean active docs | `AGENTS.md`, `docs/README.md`, `docs/governance/`, `docs/execution/` | AC-01, AC-02, AC-03, AC-04 |
| S3 | establish active standards and templates | `docs/standards/`, `docs/checklists/`, `docs/templates/` | AC-06, AC-07 |
| S4 | record framework decision and closeout | `docs/decisions/`, this feature pack | AC-08, AC-09 |

## 7. Acceptance Criteria

### AC-01 Active Entry Points Use V2 Only

- `AGENTS.md`, `README.md`, and `docs/README.md` point to the new v2 surface
- active entrypoints do not present `docs/specs/` or `docs/sdd/` as canonical

### AC-02 Active Folder Structure Matches V2

- active `docs/` contains `spec-packs/`, `governance/`, `execution/`, `standards/`, `templates/`, `checklists/`, and `decisions/`

### AC-03 Governance Is Collapsed

- active governance is reduced to `core-rules.md`, `uncertainty-escalation.md`, `minimal-context.md`, and `done-definition.md`

### AC-04 Execution Is Collapsed

- active execution is reduced to `task-routing.md`, `task-contracts.md`, and `ai-loading-order.md`

### AC-05 Legacy Authority Is Archived

- old active `docs/sdd/`, `docs/specs/`, flat `docs/spec-packs/`, old manuals, and old SDD shell tooling are no longer on the active path

### AC-06 Checklist Sprawl Is Reduced

- active checklists are limited to `spec-pack-quality.md`, `reinforcement-gate.md`, and `verification-closeout.md`

### AC-07 Templates Match The New Model

- templates exist for `spec_pack`, `reinforcement`, `verification`, and `decisions`
- `spec-pack.template.md` covers context, scope, requirements, design shape, constraints, execution slices, acceptance, required context, and stop points

### AC-08 Schema Authority Is Preserved

- database schema authority remains active and is referenced by active docs

### AC-09 Verification Covers The Refactor

- this framework change has `spec_pack.md`, `reinforcement.md`, `verification.md`, and `decisions.md`
- `verification.md` maps back to these acceptance criteria

## 8. Required Context

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/standards/db-rules.md` and `docs/standards/schema_database.yaml`
- legacy comparison only from `docs/archive/sdd-v1/` and `scripts/archive/sdd-v1/`

## 9. Open Issues / Stop Points

- if any active doc still points to `docs/specs/` or `docs/sdd/` as canonical, the refactor is incomplete
- if any active rule drops reinforcement for non-trivial work, stop and fix the framework before further use
- shell validator replacement for v2 was deferred in this change and is now addressed by `docs/spec-packs/2026-03-23-sdd-v2-4-upgrade/`; archived v1 scripts remain history only
