# Reinforcement: 2026-03-23-sdd-v2-4-upgrade

- Status: complete
- Last Updated: 2026-03-23

## 1. Grounded Sources

- user request in this task thread
- `AGENTS.md`
- `docs/README.md`
- `docs/spec-packs/README.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/execution/task-contracts.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/templates/review.template.md`
- `docs/templates/audit.template.md`
- `docs/checklists/verification-closeout.md`
- `scripts/archive/sdd-v1/README.md`
- `scripts/archive/sdd-v1/validate_framework_docs.sh`
- `scripts/archive/sdd-v1/validate_specs.sh`

## 2. Consistency Checks

- the active repo already uses `spec_pack.md`, `reinforcement.md`, and task-specific closeout artifacts under `docs/spec-packs/<feature-id>/`
- root `README.md` is absent, but active framework history and packs still name it as an entrypoint, so the inconsistency is real
- current task routing uses `implement`, `fix`, `docs`, `review`, `audit`, and `hotfix`; the validator should support those names instead of inventing a replacement workflow
- archived v1 validators are much broader than the requested 2.4 enforcement layer, so the new validator must stay limited to artifact presence

## 3. Ambiguities

- there is no active version ledger file that explicitly declares `2.3` vs `2.4`
- the request names `spec` and `code` tasks, but the active repo task header does not
- the active governance says non-trivial work requires reinforcement, while the requested validator scope is narrower

Current handling:

- surface `v2.4` in the new entrypoint and upgrade pack instead of creating a new version registry
- keep repo-native task types in docs, while allowing simple validator aliases where useful
- document the validator as a minimal gate and keep broader governance requirements in the active docs

## 4. Risks

- over-enforcing the validator would recreate archived process weight
- under-documenting the validator scope would create a false sense of full compliance
- spreading the new rules across too many files would make the framework harder to keep aligned

## 5. Stop Conditions

- stop if validator rules and active docs disagree on the minimum required artifact set
- stop if the root `README.md` becomes a second authority path instead of a router
- stop if any proposed change relies on archived v1 tooling as active policy

## 6. Confidence

- high
- the requested upgrade fits the current lean framework if enforcement stays minimal and the main rules stay consolidated
