# Architecture Decision Records

## When To Use

Use this folder when a technical or delivery decision will outlive a single feature package.

## How To Use

1. Check whether the decision affects multiple features, modules, or future work.
2. If yes, create the next `ADR-####-short-title.md`.
3. Link the ADR from the governing feature package and PR.

## Required Output

An ADR with:

- status
- context
- decision
- consequences
- related specs

## Gate

If future teams would need to rediscover why a cross-cutting choice was made, the change does not pass design review without an ADR.

## ADR Naming

- `ADR-0001-short-title.md`
- increment the number
- do not rename published ADR IDs

## Current Records

- [ADR-0001-spec-driven-delivery-framework.md](ADR-0001-spec-driven-delivery-framework.md)
- [ADR-0002-source-base-anchor-and-style-parity-enforcement.md](ADR-0002-source-base-anchor-and-style-parity-enforcement.md)
- [ADR-0003-task-profile-routing.md](ADR-0003-task-profile-routing.md)
- [ADR-0004-sdd2-plus-agent-ready-extension.md](ADR-0004-sdd2-plus-agent-ready-extension.md)
- [ADR-0005-sdd-delivery-outcome-alignment.md](ADR-0005-sdd-delivery-outcome-alignment.md)
