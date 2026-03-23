# Intake

## When To Use

Use this stage when a new non-trivial request, defect, or change request is opened.

## How To Use

1. Create the feature folder under `docs/specs/`.
2. Fill `README.md` with owner, status, request source, scope, and required artifact flags.
3. Decide whether the change follows `reduced-path` or `full-path`.
4. Decide whether the feature also needs `contracts/` or `spec-pack.manifest.yaml`.
5. Record assumptions, dependencies, open questions, and out-of-scope items.
6. Flag any repository-derived shared patterns that will need proof during design and implementation, such as SQL style, shared null or empty helpers, empty-string constants, message catalogs, focus-out or base-common reuse, table-column helpers, frontend structure reuse, responsive layout or paired-field alignment, comment-language expectations, touched-scope import cleanup, and frontend-backend validation parity.

## Required Output

- `docs/specs/<feature-id>/README.md`
- initial decision on whether `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, and `06-edge-cases.md` will be required
- initial decision on whether machine-readable `contracts/` and a generated spec-pack manifest are needed
- initial list of repository-derived shared patterns that must be verified later if the change touches them, including touched-scope cleanup and responsive-layout checks when applicable

## Gate

Advance only when:

- the request can be understood without reading code
- the package owner, scope, and requested outcome are explicit
- required conditional artifacts are identified or marked `tbd`
- open questions are explicit
- `docs/sdd/checklists/01-feature-intake.md` passes
