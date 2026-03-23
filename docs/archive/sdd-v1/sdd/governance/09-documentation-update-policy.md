# Documentation Update Policy

## When To Use

Use this rule whenever code changes behavior, contracts, rollout, or verification.

## How To Use

Update only the artifacts affected by the code change or finding-driven correction, but update them in the same branch.

## Required Output

- current spec files that match the implemented behavior
- current changelog entries for releasable behavior changes

## Gate

If code changes behavior and the matching spec files did not change, the branch is incomplete.

## Update Map

- `01-requirements.md` when the requirement changes
- `02-design.md` when the solution changes
- `03-data-model.md` when data shape or lifecycle rules change
- `04-api-contract.md` when contracts change, including compatibility class (`additive`, `behavior-tightening`, `breaking`, or `internal-only`) and affected-consumer notes
- `05-behavior.md` when UX or workflow changes
- `06-edge-cases.md` when failure handling changes
- `07-tasks.md` when planned work changes
- `08-acceptance-criteria.md` when expected outcomes change
- `09-test-cases.md` when acceptance proof changes
- `10-rollout.md` when rollout or rollback changes
- `11-implementation-report.md` as implementation evidence is produced
- `12-review-report.md` as review proceeds
- `13-risk-log.md` when risk status, mitigation, or release impact changes
- `14-decision-notes.md` when a local feature decision is introduced, revised, or superseded
- `docs/sonar/<date>-<scope>-triage.md` when Sonar-driven triage or remediation changes issue classification, decision status, or remediation state
- `changelog.md` and root `CHANGELOG.md` when releasable behavior changes

When machine-readable contract ownership is still absent for a changed interface, the branch must explicitly record whether it is creating ownership now or carrying a known contract gap forward.

When review, QA, SonarQube, bug, or production feedback reveals that the current governing source is wrong, incomplete, or missing proof, the same branch must either:

- update the affected requirement, design, acceptance, test, rollout, or report artifact, or
- record the blocker, residual risk, or required backfill explicitly before the work is claimed complete

Emergency compact-path exception:

- `docs/sdd/governance/07-emergency-change-handling.md` may defer non-blocking documentation normalization until stabilization, but rollback notes, incident scope, and the required compact artifact set still must exist before deployment.
