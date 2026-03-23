# Minimum Completeness Before Coding

## When To Use

Use this rule before the first implementation commit for a non-trivial change.

## How To Use

Check the feature package against the required file list and the clarity rules below.

## Required Output

- pass or fail decision for coding start
- list of missing files, IDs, or unresolved questions when the gate fails

## Gate

Coding starts only when the feature package removes guesswork.

## Required Before Coding

- `README.md` names the owner, status, scope, and required conditional files
- `01-requirements.md` contains stable `REQ-` items
- `02-design.md` contains the selected solution and `DES-` items
- `07-tasks.md` contains `TASK-` items
- `08-acceptance-criteria.md` contains `AC-` items
- `09-test-cases.md` contains `TC-` items
- `10-rollout.md` contains rollout and rollback intent

Add these before coding when they apply:

- `03-data-model.md`
- `04-api-contract.md`
- `05-behavior.md`
- `06-edge-cases.md`
- `contracts/`
- `spec-pack.manifest.yaml`
- source-base anchors in `02-design.md` with fixed labels for backend process, backend web service, SQL, frontend `.ts`, frontend `.html`, dominant module or style note, and new tables or source families or screen structure in scope
- related code references for the touched module family, sibling flows, existing tests, and locked contracts or schema sources when the change affects current behavior or interfaces
- local code-shape constraints for the touched family when they materially affect implementation, such as DTO style, shared transport path, prepared-statement index style, comment or formatting style, or registry-only import exceptions

Add these before agent-assisted implementation or review when they apply:

- `AGENTS.md` and the required context files under `docs/sdd/context/` must already be present and current
- `docs/spec-packs/<feature>.pack.md` should be built when the feature declares a spec-pack manifest
- `scripts/sdd/build_spec_pack.sh` and `scripts/sdd/validate_specs.sh` should run without unresolved path or artifact errors

## Completeness Rules

- scope is clear
- out-of-scope is stated when needed
- open questions are visible
- no major behavior is left to implementation-time invention
- source-base anchors and dominant module or style notes remove guesswork for each touched layer
- `02-design.md` states whether new tables, source families, or screen structure are in scope instead of leaving scope parity implicit
- the implementation can identify the existing code, tests, and contract artifacts that were inspected before any write begins
- the implementation can explain which local family conventions must be preserved so agents do not "clean up" the touched area into a non-repository pattern
- new APIs, schema, modules, or externally visible fields are either explicitly approved in the governing artifacts or clearly out of scope
- the minimum `REQ -> DES -> TASK -> AC -> TC` chain is visible in the feature package
- tests can be planned directly from the written acceptance criteria
- if machine-readable contracts apply, they are not left as prose-only intent

## Examples

- `pass`: `AC-02` and `TC-02` already define the invalid-input behavior
- `fail`: the design says "handle errors as needed" with no failure behavior or tests
