# Execution Contract: Recover Context

## Use When

The next safe step is unclear, work resumes after interruption, or confidence drops below a defensible level.

## Required Inputs

- current task or request context
- current feature package or changed-file evidence when present
- latest handoff or restart note when present

## Required Reads

- `docs/sdd/execution/task-routing.md`
- current governing feature package or changed-file evidence
- current implementation or review reports when present
- `docs/sdd/governance/12-uncertainty-escalation-policy.md`

Add schema binding reads when DB-related scope exists.

## Optional Support

- generated brief or spec-pack
- handoff notes
- focused error, log, or diff excerpt

## Forbidden Assumptions

- resuming edits before the next step is grounded
- treating memory of previous work as sufficient evidence

## Expected Outputs

- current objective
- completed work
- remaining work
- blockers
- next grounded step
- restart packet with changed artifacts and the smallest relevant issue excerpt when one still matters
- confidence

## Stop Conditions

- no grounded next step exists after reloading the required evidence
- safe continuation still depends on guessed approval or behavior
