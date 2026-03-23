# When A Spec Is Required

## When To Use

Use this rule before starting any change.

## How To Use

Classify the change as `no-spec`, `reduced-path`, or `full-path`.

## Required Output

- one change-path decision
- a feature package when the change is non-trivial

## Gate

Do not start non-trivial implementation or open a non-trivial PR without a governing feature package.

## Classification Rules

Use a feature package when the change includes at least one of these:

- new feature behavior
- behavior-changing bug fix
- UI workflow or validation change
- database, schema, or data lifecycle change
- API, DTO, file, or integration contract change
- security-sensitive logic
- multi-module or multi-layer impact
- non-obvious rollback or release risk

Use the reduced-path package only when all of these are true:

- narrow local change
- no schema or persistence rule change
- no shared contract change
- no complex workflow change
- no non-obvious failure handling

Reduced-path implication:

- `contracts/`, `spec-pack.manifest.yaml`, and `docs/spec-packs/` stay optional unless the reduced-path change still introduces a meaningful machine-readable contract or agent-execution need.
- `fix-from-bug` without a generated spec-pack still requires this reduced-path or full-path package before non-trivial code changes begin.
- `13-risk-log.md` and `14-decision-notes.md` remain optional companion artifacts when the reduced-path change still carries material risk or local design choices worth preserving.

Full-path implication:

- treat `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, `06-edge-cases.md`, `contracts/`, and `spec-pack.manifest.yaml` as expected whenever the change crosses UI, API, SQL, or shared-contract boundaries
- build a spec-pack when agent execution would otherwise need to crawl multiple context and spec files
- add `13-risk-log.md` and `14-decision-notes.md` when risk, rollout sensitivity, or local design reasoning would otherwise stay implicit

No feature package is required for:

- typo-only documentation fixes
- formatting-only changes
- comment-only edits
- non-behavioral metadata cleanup
- SonarQube triage-only artifact creation with no code change

## Task-Profile Notes

- `implement-new`: always works from a governing feature package for non-trivial changes.
- `fix-from-pack`: requires both the governing feature package and the generated spec-pack selected in the request header.
- `fix-from-bug`: may start from a bug description, but it must create or load the required governing feature package before non-trivial code changes.
- `review-from-pack`: generated spec-pack is required as an execution aid, but the governing feature package remains the review source of truth.
- `review-from-rules`: generated spec-pack is optional; a governing feature package is still required for reduced-path and full-path changes.
- `sonar-triage`: may run without a governing feature package only when it performs no code change and only creates or updates the triage artifact.
- `sonar-triage-and-fix`: may start from a SonarQube finding source, but it must still classify the work through `no-spec`, `reduced-path`, or `full-path` before code changes; create or load the governing feature package before any non-trivial remediation.
- `sonar-fix-from-triage`: may start from an approved triage artifact, but it must still create or load the required governing feature package before any non-trivial remediation.

## Examples

- `reduced-path`: one local validation fix on a single screen
- `full-path`: UI, API, SQL, and report changes for the same feature
