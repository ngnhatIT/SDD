# Execution Profiles

Use this folder after task routing and before execution.

The selected profile changes operating behavior, not authority.

## Selection

- explicit `Agent Profile` header wins
- otherwise use the current client profile
- use `auto` only when the agent type is genuinely unknown

## Profiles

- `codex.md`
- `claude.md`
- `copilot.md`

## Shared Rule

Every profile must still obey:

- `AGENTS.md`
- `docs/sdd/context/`
- `docs/sdd/governance.md`
- `docs/sdd/governance/`
- the selected execution contract
- the governing feature package
