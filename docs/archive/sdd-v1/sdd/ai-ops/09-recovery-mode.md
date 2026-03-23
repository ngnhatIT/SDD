# Recovery Mode

## When To Use

Use this mode when an agent loses task direction, resumes after interruption, accumulates too many open threads, or cannot explain the next grounded step.

## How To Use

1. Stop editing.
2. Reload `AGENTS.md`, the required context files, governance, and the governing feature package.
3. Inspect current changed files, reports, the latest handoff note, and the smallest relevant error, log, or diff excerpt when the blocker is still active.
4. Restate the current objective, completed work, remaining work, blockers, and next smallest grounded step.
5. If evidence is still insufficient, trigger uncertainty escalation instead of guessing.

## Required Output

- recovery note with current scope, completed work, remaining work, blockers, next action, and confidence

## Gate

No new code or review action should continue until recovery mode identifies a grounded next step.

## Recovery Note Minimum

- task profile and governing feature
- current objective
- changed files already in play
- what is complete
- what remains
- blockers or uncertainty
- root-cause excerpt or failing diff excerpt: `n/a` when no live blocker remains
- next smallest grounded action
- confidence: `high`, `medium`, or `low`
