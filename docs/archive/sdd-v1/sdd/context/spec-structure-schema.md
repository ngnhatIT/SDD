# Spec Structure Schema

## When To Use

Use this file during SDD review to validate whether a feature package is structurally complete for the kind of implementation it governs.

## How To Use

1. Classify the change as `no-spec`, `reduced-path`, or `full-path` using governance.
2. Check the feature package against the mandatory structure for that path.
3. Check whether contracts are required by the touched interface shape.
4. Check whether test shape matches the touched implementation risk.

## Required Output

- feature package classification
- package validity result
- required companion contracts
- required test-shape result

## Gate

If a non-trivial implementation does not have a structurally valid feature package, review should fail before code-shape review proceeds.

## Mandatory Structure

### Valid Governing Feature Package

A valid governed feature package must live at:

- `docs/specs/<feature-id>/`

For this repository, the mandatory base files are:

- `README.md`
- `01-requirements.md`
- `02-design.md`
- `07-tasks.md`
- `08-acceptance-criteria.md`
- `09-test-cases.md`
- `10-rollout.md`
- `changelog.md`

The package is not structurally valid for governed implementation without those files.

### Full-Path Additions

These files become mandatory when the feature actually changes the matching concern:

- `03-data-model.md` for schema, table-shape, or durable data lifecycle changes
- `04-api-contract.md` for API, DTO, file, or machine-readable contract changes
- `05-behavior.md` for user-visible workflow or screen behavior changes
- `06-edge-cases.md` for non-trivial failure, validation, timeout, or recovery handling
- `contracts/` when the feature owns machine-readable API or durable data contracts

### Contracts Required

Contracts are structurally required when any of these change:

- HTTP request or response shape
- exported/imported file shape when the feature already owns executable contract artifacts
- durable data interface owned by the feature package

When required, the structure is:

- `docs/specs/<feature-id>/contracts/openapi.yaml` for API contracts
- `docs/specs/<feature-id>/contracts/schemas/*.json` for request, response, or data schemas

### Test Shape Required

Every governed package must include `09-test-cases.md` with test cases linked to acceptance criteria.

The test case set must cover the touched risk area:

- business logic change: at least one concrete functional verification path
- SQL or schema change: normal flow, failure flow, and regression-sensitive data scenarios
- frontend transport change: happy path plus error routing and guarded response handling
- auth or validation change: positive and negative validation/auth cases
- file-output change: output success plus user-safe failure handling

## Recommended Structure

- Use the numbered file order consistently so AI reviewers can load context deterministically.
- Add `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, and `06-edge-cases.md` whenever omission would force reviewers to infer behavior from code.
- Add `spec-pack.manifest.yaml` when the feature needs a generated execution pack, but do not treat it as approval source.
- Add `11-implementation-report.md` once implementation starts.
- Add `12-review-report.md` once review starts.
- Keep traceability visible from `REQ-*` to `DES-*`, `TASK-*`, `AC-*`, and `TC-*`.

## Legacy Tolerated Structure

- Older repo areas may have behavior with no governing feature package; that legacy state is tolerated only for untouched code and does not justify new non-trivial work without a spec.
- Example/reference feature packages may point to illustrative implementation refs outside this repo area; reviewers should use them as structural examples, not as approval evidence for unrelated code.
- Reduced-path packages may omit conditional files only when the change truly stays local and avoids schema, shared contract, and non-obvious edge handling.

## Invalid Feature Package Signals

- Missing one of the mandatory base files for governed work.
- `04-api-contract.md` omitted even though the feature changes request, response, file, or interface shape.
- `contracts/` omitted even though the feature already owns machine-readable contracts and changes that contract.
- `09-test-cases.md` present but not linked to acceptance criteria or missing negative/error-path coverage for the touched risk.
- `02-design.md` does not name impacted backend, frontend, SQL, or contract areas even though code spans them.
- Package scope says one screen or module, but implementation touches multiple neighboring module families without explicit design coverage.

## Reviewer Decision Rules

- Approve the feature package as structurally valid only when mandatory files and required companion artifacts are present for the actual change type.
- Mark the package as structurally incomplete when reviewers would otherwise need to infer contract shape, edge handling, or verification scope from code alone.
- Treat machine-readable contracts as mandatory companion artifacts when the feature already established that contract ownership pattern.
