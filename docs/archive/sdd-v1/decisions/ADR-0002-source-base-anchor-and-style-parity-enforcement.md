# ADR-0002 Source-Base Anchor And Style Parity Enforcement

- Status: accepted
- Date: 2026-03-13
- Owners: repository maintainers
- Related specs: `docs/specs/2026-03-13-sdd-governance-hardening/`

## Context

The repository already requires spec-governed delivery, but several critical implementation constraints are still enforced mostly by prose and reviewer memory:

- source-base anchors are mentioned in `AGENTS.md`, but not consistently required across all downstream gates and templates
- SQL and Angular HTML style parity are described in standards, but spec-pack generation and validation do not surface or enforce them clearly
- review expectations around scope parity, contract parity, and traceability are spread across multiple docs without one consistent executable shape
- the current validator only works for manifest-owning feature packages and does not check the minimum semantic sections needed before implementation

That gap makes it easier for agent-generated or manually authored changes to drift from the local source base, invent new families, or miss required traceability.

## Decision

This repository will harden governance and SDD execution around a parseable source-base contract.

1. `02-design.md` becomes the authoritative place to record source-base anchors with fixed labels for:
   - backend process anchor files
   - backend webservice anchor files
   - SQL anchor files
   - frontend `.ts` anchor files
   - frontend `.html` anchor files
   - dominant module or style note
   - new tables, source families, or screen structure in scope
2. Pre-implementation and code-review gates must fail when the anchor block is missing, incomplete, or contradicted by implementation scope.
3. Spec-pack generation must surface anchors, scope guardrails, traceability, and execution constraints directly in the generated pack.
4. Spec validation must work for all feature packages, with manifest and generated-pack checks applied only when a feature owns a manifest.
5. Validation uses semantic minimum checks rather than exact heading lockstep so existing feature packages can remain valid after limited retrofit.

## Consequences

- Feature authors must name concrete anchor files before implementation when a touched layer is applicable.
- Reviewers have a stable place to verify SQL and HTML style parity against the named anchors instead of relying on memory.
- Reduced-path and full-path packages can both be validated without forcing manifests on every feature.
- Existing sample feature packages need small retrofit updates so they continue to represent valid repository examples.
- Future script or governance changes should extend this fixed anchor vocabulary instead of introducing alternate labels ad hoc.
