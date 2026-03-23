# Spec Pack: <feature-id> - <title>

- Status: draft | approved | implemented
- Owner: <team-or-person>
- Last Updated: YYYY-MM-DD
- Related ADRs: `none` | `docs/decisions/ADR-XXXX-<slug>.md`
- Companion Function Specs: `none` | `function-specs/<function-id>.<type>.md`

Use this template to govern the work item. When one delivery surface needs implementation-facing detail, add the matching companion function spec instead of stretching this pack into a universal template.

## 1. Context

- problem summary
- affected users or operators
- current repo or product constraints that matter

## 2. Scope

### In Scope

- item

### Out Of Scope

- item

## 3. Functional Requirements

### FR-01 <short name>

- requirement detail
- non-change or compatibility note if needed

## 4. Technical Shape

### Source Anchors

- backend: <path or n/a>
- frontend: <path or n/a>
- db/sql: <path or n/a>
- contracts: <path or n/a>

### Planned Shape

- touched modules
- preserved contracts
- data, API, or UI notes
- companion function specs when needed

## 5. Decisions And Constraints

- approved design choice
- rule that must not be broken
- assumption that still needs confirmation, if any

## 6. Execution Slices

| Slice | Goal | Main files or modules | Verification target |
| --- | --- | --- | --- |
| S1 | <goal> | <files> | <AC ids> |

## 7. Acceptance Criteria

### AC-01 <short name>

- expected outcome
- observable proof target

## 8. Required Context

- docs to load
- code anchors to inspect
- standards to apply

## 9. Open Issues / Stop Points

- blocker
- unresolved decision
- explicit stop condition
