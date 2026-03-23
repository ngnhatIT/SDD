# Reinforcement: 2026-03-23-sdd-v2-framework

- Status: complete
- Last Updated: 2026-03-23

## 1. Grounded Sources

- user request in this task thread
- previous `AGENTS.md`
- `docs/archive/sdd-v1/sdd/README.md`
- `docs/archive/sdd-v1/sdd/governance.md`
- `docs/archive/sdd-v1/specs/README.md`
- `docs/archive/sdd-v1/spec-packs-flat/README.md`
- `scripts/archive/sdd-v1/README.md`
- `docs/archive/sdd-v1/sdd/context/schema_database.yaml`

## 2. Consistency Checks

- active entrypoints were rewritten to point only to the v2 surface
- `spec_pack.md` is named as canonical in `AGENTS.md`, `docs/README.md`, and `docs/governance/core-rules.md`
- reinforcement remains a separate artifact from the feature pack
- DB schema authority was preserved by moving `schema_database.yaml` into the active standards surface

## 3. Ambiguities

- external tooling that generates `spec_pack.md` is outside this repo and was not modified here
- no v2 replacement was written for the archived v1 shell validators

## 4. Risks

- any external automation still pointing to `docs/specs/`, `docs/sdd/`, or `scripts/sdd/` will need human follow-up
- archived legacy files still contain the old model internally by design, so only active docs must be used during execution

## 5. Stop Conditions

- stop if an active doc still promotes an archived path as canonical
- stop if non-trivial work can proceed without reinforcement in the new rules
- stop if `docs/standards/schema_database.yaml` is missing from the active path

## 6. Confidence

- high
- the refactor directly replaced the active framework surface and archived the conflicting one in the same workspace
