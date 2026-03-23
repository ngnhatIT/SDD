# Decisions: 2026-03-23-sdd-v2-framework

## D-01 Archive V1 Instead Of Partially Rewriting It

- context: the old framework had too many overlapping documents to leave active safely
- options considered: partial in-place rewrite, archive-and-replace
- chosen decision: archive the v1 surface and create a clean v2 surface
- impact: active routing is simpler and contradictions are easier to eliminate
- references: `docs/archive/sdd-v1/`, `docs/decisions/ADR-0006-lean-sdd-v2-model.md`

## D-02 Preserve DB Schema Authority As An Active Standard

- context: the old framework treated schema authority as mandatory for DB-related work
- options considered: leave the schema file archived, move it into the new active surface
- chosen decision: move the schema file to `docs/standards/schema_database.yaml`
- impact: DB-related stop rules remain enforceable in the lean model
- references: `docs/standards/db-rules.md`, `docs/standards/schema_database.yaml`

## D-03 Archive Legacy Helper Scripts

- context: an external tool now generates `spec_pack`, so the in-repo v1 shell tooling is no longer the main execution path
- options considered: maintain old scripts as active helpers, archive them
- chosen decision: archive the old SDD scripts under `scripts/archive/sdd-v1/`
- impact: the framework no longer advertises tooling that encodes the old authority model
- references: `scripts/archive/sdd-v1/README.md`
