# Spec Pack: 2026-03-23-spmt00141-runtime-audit - SPMT00141 Runtime Audit

- Status: approved
- Owner: AI audit task
- Last Updated: 2026-03-23

## 1. Context

- The request is to reconstruct the actual end-to-end runtime behavior of screen `SPMT00141` from code, not from historical specs or intended design.
- The audit must trace the live flow through frontend entry, API calls, backend process chain, SQL or persistence behavior, and any directly affecting async or shared infrastructure.
- The output must distinguish proven runtime behavior from reasonable but unproven inference, and must call out evidence gaps explicitly.

## 2. Scope

### In Scope

- trace `SPMT00141` route, component, and UI event flow in the active Angular frontend
- trace the matching backend `webservice -> process -> SQL` chain actually serving the screen
- inspect database objects, SQL conditions, and schema constraints that directly affect `SPMT00141`
- inspect directly relevant config, shared services, message handling, and tests when they change runtime interpretation
- record the grounded result in `audit.md`

### Out Of Scope

- changing runtime code, contracts, or schemas
- reviewing unrelated screens or shared modules beyond what directly affects `SPMT00141`
- judging intended business behavior from archived specs when code evidence disagrees or is absent

## 3. Functional Requirements

### FR-01 Actual Runtime Path Only

- conclusions must be grounded in runtime-affecting code paths, SQL, schema, or directly relevant tests
- comments, naming, and archived specs may be used only as secondary context and must not override active code behavior

### FR-02 End-To-End Coverage

- the audit must connect frontend trigger, API call, backend processing, and DB read or write behavior into one coherent flow

### FR-03 Evidence Separation

- every major conclusion must state whether it is code-proven or still lacks enough evidence

### FR-04 Edge Cases And Hidden Logic

- the audit must call out null, duplicate, retry, stale-state, default-value, and ordering behavior when evidence exists

## 4. Technical Shape

### Source Anchors

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/execution/task-contracts.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/standards/db-rules.md`
- `docs/standards/schema_database.yaml`
- `src/main/webapp/angular/src/app/components/spmt00141/`
- `src/main/java/jp/co/brycen/kikancen/spmt00141*/`
- directly related shared frontend and backend infrastructure discovered during tracing

## 5. Decisions And Constraints

- prefer active code and active standards over archived SDD-v1 material
- archived `docs/archive/sdd-v1/` may be read only when active docs and code still leave a legacy identification gap
- do not infer hidden business intent that is not supported by current code or schema evidence
- stop and report if `docs/standards/schema_database.yaml` conflicts with the active code path for the authoritative DB structure

## 6. Acceptance Criteria

- the audit identifies the strongest confirmed frontend entry point, backend entry point, and DB source for `SPMT00141`
- the audit reconstructs the main runtime flows and decision points with evidence
- the audit records edge cases, hidden logic, and unresolved evidence gaps explicitly
- the audit leaves `audit.md` in this feature-pack home before closeout

## 7. Required Context

- active governance and routing docs listed above
- only the standards needed for DB and final audit grounding
- code and template files directly participating in `SPMT00141`

## 8. Open Issues / Stop Points

- stop if the inspected DB schema in code conflicts with `docs/standards/schema_database.yaml`
- stop if the actual runtime owner of `SPMT00141` cannot be identified from active code
- stop if a required conclusion would depend on guessing rather than inspected evidence
