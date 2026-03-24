# Reinforcement: 2026-03-24-codebase-conformance-upgrade

- Status: complete
- Last Updated: 2026-03-24

## 1. Grounded Sources

- user request and approved implementation plan in this task thread
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
- live code evidence from `src/main/java/jp/co/brycen/kikancen/api/btcc0050ac/`, `src/main/java/jp/co/brycen/kikancen/common/focusout/process/FocusOutGetNameProcess.java`, `src/main/webapp/angular/src/app/components/common/base/base.component.ts`, `src/main/webapp/angular/src/app/services/common/search-condition-management.service.ts`, and `src/main/webapp/angular/src/app/common/SubWindow.ts`

## 2. Consistency Checks

- active v2 already exposes `Source Anchors` in `spec_pack.md`, so v1 anchor rules can be migrated without creating a new artifact type
- active v2 already bans guessing and already preserves contracts, but it does not yet bind one short conformance standard into `implement`, `fix`, and `review`
- archived v1 contains many helper-specific and process-heavy rules, but the reusable value is concentrated in anchor locking, sibling-family parity, reuse-before-create, no-silent-new-layer behavior, and strong stop conditions
- live code still supports the migrated rules: backend families still use `webservice/`, `process/`, and `dto/`; frontend still uses `BaseComponent`, `SearchConditionManagementService`, and `SubWindow`; shared backend lookup flows still use `FocusOutGetNameProcess`

## 3. Ambiguities

- the active surface already has short conformance hints in `coding-rules.md`, so the new standard must tighten execution behavior without duplicating layer-specific detail
- existing template anchor labels are intentionally flexible for framework work, so the migration should point back to the current `Source Anchors` section rather than recreate the old fixed `02-design.md` block
- review wording must stay short while still making conformance drift a finding category

Current handling:

- keep the new standard focused on cross-cutting conformance behavior and let existing layer-specific standards keep their detailed rules
- reuse current `spec_pack.md` sections for anchor and exception recording
- wire the standard into only the three active docs identified in the approved plan

## 4. Risks

- if the new standard is too broad, it will duplicate existing standards and become another vague policy file
- if execution docs do not name the new standard explicitly, the upgrade will remain advisory and fail the goal of immediate behavior change
- if the migration copies v1 rule catalogs too literally, lean v2 will regress into a heavier documentation system

## 5. Stop Conditions

- stop if any proposed edit reactivates archived v1 as active authority
- stop if a new rule depends on validator or template changes outside the approved minimal scope
- stop if the conformance standard cannot stay short and operational without losing the required anchor, reuse, and stop behavior

## 6. Confidence

- high
- the required upgrade fits the active v2 model because the repository already has the core pieces; the missing step is one active standard plus explicit execution wiring
