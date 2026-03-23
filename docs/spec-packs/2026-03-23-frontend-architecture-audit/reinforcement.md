# Reinforcement: 2026-03-23-frontend-architecture-audit

- Status: complete
- Last Updated: 2026-03-23

## 1. Grounded Sources

- user request in this thread
- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/spec-packs/README.md`
- `docs/templates/audit.template.md`
- active frontend files under `src/main/webapp/angular`

## 2. Consistency Checks

- the active frontend app is bootstrapped from `src/main/webapp/angular/src/main.ts` into `WmsModule`
- source inspection shows custom Angular services plus `Subject` and jQuery `$.ajax` as real runtime patterns
- several libraries are installed or imported at module level without clear template/runtime evidence, so they must not be promoted to primary stack without proof

## 3. Ambiguities

- Angular Material, `NgSelectModule`, `NgMultiSelectDropDownModule`, and `ReactiveFormsModule` are imported but their active runtime usage is weak or absent in the inspected source
- the repository contains Japanese business labels and screen IDs, so business inference is high-confidence at domain level but not at every screen-flow detail
- test config references `src/test.ts`, but that file is missing, so test operability is inferred as at-risk rather than executed

## 4. Risks

- reviewers may overestimate modernization because dependencies suggest NgRx or reactive forms that the app does not actually use
- shared custom services and base components create cross-screen coupling that a diff-only review can miss
- sparse and possibly broken test setup raises regression risk in shared modules

## 5. Stop Conditions

- stop if another active frontend surface with stronger runtime evidence appears
- stop if active docs contradict the identified frontend root
- stop if business conclusions would require speculation beyond labels, routes, or comments

## 6. Confidence

- high
- the app entrypoint, module wiring, routes, templates, and shared services consistently point to one active Angular SPA architecture
