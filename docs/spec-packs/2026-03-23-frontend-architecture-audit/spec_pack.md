# Spec Pack: 2026-03-23-frontend-architecture-audit - Frontend Architecture Audit

- Status: approved
- Owner: AI audit task
- Last Updated: 2026-03-23

## 1. Context

- The repository request is an audit-only task over the active frontend codebase.
- The audit must identify what the current app actually uses for framework, routing, rendering, state, server-state, form handling, UI system, tests, logging, review scope, and business context.
- Active conclusions must be grounded in code, config, templates, and runtime wiring rather than dependency presence alone.

## 2. Scope

### In Scope

- inspect the active frontend app surface under `src/main/webapp/angular`
- verify actual runtime patterns from module wiring, routes, templates, services, and test setup
- capture mixed or legacy patterns when dependencies or module imports are not backed by active usage
- infer only code-grounded business context from routes, labels, screen IDs, and API naming
- leave a durable `audit.md` trace for this audit task

### Out Of Scope

- backend implementation review
- speculative product requirements not grounded in the repository
- runtime behavior that cannot be verified from checked-in source
- changing application code, contracts, or schemas

## 3. Functional Requirements

### FR-01 Architecture Identification Is Evidence-Backed

- every reported architecture conclusion must map to concrete codebase evidence
- installed but unused dependencies must be called out as secondary or legacy, not primary stack

### FR-02 Mixed Patterns Are Explicit

- if multiple patterns coexist, the audit must name the primary pattern, any secondary pattern, and migration or legacy signals

### FR-03 Review Guidance Matches Project Shape

- the audit must recommend an appropriate frontend PR review scope based on routing, shared services, shared UI, and request wrappers

### FR-04 Business Context Stays Grounded

- business summary must come only from route names, screen names, comments, labels, tests, or API naming
- unknowns must remain explicit

## 4. Technical Shape

### Source Anchors

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `src/main/webapp/angular/package.json`
- `src/main/webapp/angular/angular.json`
- `src/main/webapp/angular/src/main.ts`
- `src/main/webapp/angular/src/app/wms.module.ts`
- `src/main/webapp/angular/src/app/wms-routing.module.ts`
- `src/main/webapp/angular/src/app/components/`
- `src/main/webapp/angular/src/app/services/`

## 5. Decisions And Constraints

- treat the Angular application under `src/main/webapp/angular` as the active frontend unless stronger conflicting evidence appears
- prefer actual imports, providers, template usage, and route wiring over package installation
- record missing evidence explicitly instead of inferring unsupported conclusions

## 6. Acceptance Criteria

- the audit identifies the active frontend framework and rendering mode from entrypoint and build config
- the audit distinguishes actual state and data-fetching patterns from merely installed libraries
- the audit records testing and logging evidence, including any setup gaps
- the audit leaves `audit.md` in this feature-pack home before closeout
