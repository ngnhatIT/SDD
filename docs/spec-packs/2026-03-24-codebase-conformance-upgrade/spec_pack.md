# Spec Pack: 2026-03-24-codebase-conformance-upgrade - Lean v2 Codebase Conformance Upgrade

- Status: approved
- Owner: repository maintainers
- Last Updated: 2026-03-24
- Related ADRs: `none`
- Companion Function Specs: `none`

## 1. Context

- active lean SDD v2 already blocks guessing and preserves contracts, but codebase conformance rules are still scattered across governance and layer-specific standards
- `implement`, `fix`, and `review` do not yet load or apply one short active rule that forces anchor-based implementation, sibling-family parity, and reuse-before-create behavior
- archived SDD v1 contains stronger conformance rules, but the upgrade must extract only the high-value behavior and keep v1 archived

## 2. Scope

### In Scope

- create one active standard dedicated to codebase conformance
- wire that standard into the active execution and minimal-context surface
- keep conformance recording inside the existing `spec_pack.md` sections instead of creating a second artifact path
- preserve lean v2 while making `implement`, `fix`, and `review` stricter on local-family reuse and pattern drift

### Out Of Scope

- restoring archived numbered artifacts, manifests, or old authority paths
- expanding lean v2 into a heavy checklist system
- changing templates, validators, or other active docs outside the minimum wiring needed for this upgrade
- changing runtime API, DB, schema, or code behavior

## 3. Functional Requirements

### FR-01 Active Conformance Standard Exists

- `docs/standards/codebase-conformance-rules.md` must exist as an active v2 standard
- it must define purpose, when to use, core rules, anchor identification, reuse-before-create, no-new-layer-by-preference, stop conditions, review implications, and minimal acceptable vs unacceptable examples

### FR-02 Active Standard Stays Lean And Operational

- the new standard must stay short, concrete, and repository-applicable
- it must strengthen local-family conformance without restoring archived v1 process weight

### FR-03 Implement And Fix Explicitly Use The Rule

- active execution docs must require the conformance standard when `implement` or `fix` work chooses naming, folder placement, abstraction, DTO shape, transport path, validation path, or SQL style
- contract text must require preservation of local-family shape or an explicitly recorded approved exception

### FR-04 Review Explicitly Checks Conformance Drift

- active execution docs must require `review` to use the conformance standard when findings depend on code-shape choices
- review rules must treat silent new layers, silent new naming patterns, missed reuse, and sibling-family drift as findings rather than style notes

### FR-05 Existing Pack Sections Stay The Recording Surface

- the upgrade must keep conformance recording inside the current `spec_pack.md` sections, especially `## 4. Technical Shape` and `## 5. Decisions And Constraints`
- the active framework must not introduce a second authority path for anchor or conformance decisions

## 4. Technical Shape

### Source Anchors

- active execution docs: `docs/execution/ai-loading-order.md`, `docs/execution/task-contracts.md`
- active governance doc: `docs/governance/minimal-context.md`
- active standards surface: `docs/standards/`
- active baseline rules: `docs/governance/core-rules.md`, `docs/governance/uncertainty-escalation.md`, `docs/standards/coding-rules.md`, `docs/standards/db-rules.md`
- active pack template: `docs/templates/spec-pack.template.md`
- archived v1 conformance sources: `docs/archive/sdd-v1/decisions/ADR-0002-source-base-anchor-and-style-parity-enforcement.md`, `docs/archive/sdd-v1/sdd/standards/auto-codebase-rules.md`, `docs/archive/sdd-v1/sdd/standards/naming-and-module-organization.md`, `docs/archive/sdd-v1/sdd/standards/backend-change-rules.md`, `docs/archive/sdd-v1/sdd/standards/frontend-change-rules.md`, `docs/archive/sdd-v1/sdd/standards/database-change-rules.md`
- live code evidence: `src/main/java/jp/co/brycen/kikancen/api/btcc0050ac/webservice/Btcc0050acWebService.java`, `src/main/java/jp/co/brycen/kikancen/api/btcc0050ac/process/Btcc0050acProcess.java`, `src/main/java/jp/co/brycen/kikancen/common/focusout/process/FocusOutGetNameProcess.java`, `src/main/webapp/angular/src/app/components/common/base/base.component.ts`, `src/main/webapp/angular/src/app/services/common/search-condition-management.service.ts`, `src/main/webapp/angular/src/app/common/SubWindow.ts`

### Planned Shape

- add `docs/standards/codebase-conformance-rules.md` as the single active standard for anchor-based conformance behavior
- update `docs/execution/ai-loading-order.md` so `implement`, `fix`, and code-shape `review` load the new standard at `extended`
- update `docs/execution/task-contracts.md` so `implement`, `fix`, and `review` explicitly require conformance checks, preserved local-family shape, and stop conditions for ungrounded new patterns
- update `docs/governance/minimal-context.md` so the conformance standard is a conditional read whenever the next step must choose between local patterns or decide whether to create a new abstraction

## 5. Decisions And Constraints

- keep archived v1 archived; extract rules into active docs instead of reactivating archived authority
- keep the new standard generic enough to apply across backend, frontend, DB, and review work, but concrete enough to block silent pattern drift
- reuse current `spec_pack.md` sections for anchor and exception recording; do not add a new artifact type or validator gate in this pass
- do not duplicate layer-specific rules already covered by `api-rules.md`, `db-rules.md`, or `coding-rules.md`

## 6. Execution Slices

| Slice | Goal | Main files or modules | Verification target |
| --- | --- | --- | --- |
| S1 | govern the upgrade itself | `docs/spec-packs/2026-03-24-codebase-conformance-upgrade/` | AC-05 |
| S2 | add the active conformance standard | `docs/standards/codebase-conformance-rules.md` | AC-01, AC-02 |
| S3 | wire execution and context loading | `docs/execution/ai-loading-order.md`, `docs/execution/task-contracts.md`, `docs/governance/minimal-context.md` | AC-03, AC-04 |

## 7. Acceptance Criteria

### AC-01 Active Standard Exists And Covers The Required Sections

- `docs/standards/codebase-conformance-rules.md` exists in the active surface
- it contains the required sections and explicit acceptable vs unacceptable examples

### AC-02 Standard Preserves Lean v2

- the new standard remains short and operational
- no active change restores archived v1 authority, numbered artifacts, or heavy checklists

### AC-03 Implement And Fix Load And Apply Conformance Rules

- `docs/execution/ai-loading-order.md` and `docs/execution/task-contracts.md` explicitly require the conformance standard for `implement` and `fix`
- the active contract now requires preservation of local-family shape or an approved recorded exception

### AC-04 Review Checks Conformance Drift Explicitly

- `docs/execution/ai-loading-order.md`, `docs/execution/task-contracts.md`, and `docs/governance/minimal-context.md` make the conformance standard an explicit input when code-shape review matters
- review contract text treats silent new layers, silent new naming patterns, missed reuse, and weak anchors as findings or stop conditions

### AC-05 Existing Pack Sections Remain The Only Recording Surface

- the new standard points conformance recording back to active `spec_pack.md` sections rather than a new authority path
- no other active doc is changed unless needed to wire the standard into current execution flow

## 8. Required Context

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-contracts.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/standards/coding-rules.md`
- `docs/standards/db-rules.md`
- `docs/templates/spec-pack.template.md`
- `docs/archive/sdd-v1/decisions/ADR-0002-source-base-anchor-and-style-parity-enforcement.md`
- `docs/archive/sdd-v1/sdd/standards/auto-codebase-rules.md`
- `docs/archive/sdd-v1/sdd/standards/naming-and-module-organization.md`
- `docs/archive/sdd-v1/sdd/standards/backend-change-rules.md`
- `docs/archive/sdd-v1/sdd/standards/frontend-change-rules.md`
- `docs/archive/sdd-v1/sdd/standards/database-change-rules.md`

## 9. Open Issues / Stop Points

- stop if the new standard duplicates or conflicts with existing active standards instead of filling the execution gap cleanly
- stop if any edit reintroduces archived v1 as active authority rather than keeping it as comparison-only evidence
- stop if wiring the rule into active execution would force broader template or validator expansion than this upgrade authorizes
