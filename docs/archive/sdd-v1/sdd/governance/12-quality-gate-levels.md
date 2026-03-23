# Quality Gate Levels

## When To Use

Use this rule to state how far a governed change has progressed and what evidence is still missing.

## Level Definitions

| Level | Meaning | Minimum evidence |
| --- | --- | --- |
| `Q0` | request understood | scope, owner, and classification are explicit |
| `Q1` | spec ready | required numbered spec files exist and design anchors are locked |
| `Q2` | execution ready | tasks, AC, TC, rollout, and any needed contracts are complete; risk and decision notes exist when the feature owns them |
| `Q3` | review ready | implementation report, verification evidence, updated contracts, and generated execution aids are current |
| `Q4` | release ready | review verdict is clear, rollout is current, unresolved high risks are accepted or closed, and changelog is updated |

## Usage Rules

- A feature may only claim the highest level whose evidence is visible in the repository.
- Missing evidence drops the feature to the lower level, even if the code change itself is complete.
- Use this level as a communication shorthand, not as a substitute for the underlying governance checks.
