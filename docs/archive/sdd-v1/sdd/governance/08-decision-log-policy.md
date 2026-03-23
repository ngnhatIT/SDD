# Decision Log Policy

## When To Use

Use this rule during design when a choice may affect future work outside the current feature.

## How To Use

Decide whether the choice belongs only in `02-design.md` or also requires an ADR.

## Required Output

- ADR file under `docs/decisions/` when the choice is cross-cutting
- `14-decision-notes.md` when the choice is local to the current feature but worth preserving
- link from the feature package to the ADR

## Gate

If future teams would need to rediscover why a cross-cutting choice was made, the design is incomplete without an ADR.

## ADR Required When

- the choice affects multiple future features
- a shared module pattern changes
- a delivery rule changes
- a compatibility, security, or architecture choice has lasting impact
- the agent loading contract, context-layer structure, or spec-pack generation model changes for the repository
- a contract policy changes in a way that future features must follow

## ADR Not Required When

- the choice is local to one feature and fully captured in `02-design.md`
- the choice is local to one feature and is captured in `14-decision-notes.md`
- the change is trivial and has no lasting design consequence
