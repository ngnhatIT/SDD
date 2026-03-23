# Feature Specs

## When To Use

Use this folder for every non-trivial change.

## How To Use

1. If you are creating or updating a governed package, start with `docs/sdd/spec-authoring/README.md`.
2. Run `docs/sdd/checklists/spec-authoring-checklist.md` before treating the package as ready.
3. Create `docs/specs/<ticket-id>-<short-slug>/`.
4. Copy `docs/sdd/templates/feature-package/` into the new folder.
5. Add `docs/sdd/templates/feature-package-plus/` companion files when the feature needs explicit risk or local decision tracking.
6. Remove files that are not required for the change.
7. Fill the numbered files in order, and make `02-design.md` record the parseable source-base anchor block before task planning or coding.
8. Keep the package current as code, tests, review, rollout, risk, and local decisions evolve.

## What Is Canonical Here

- governed feature packages under `docs/specs/<feature-id>/`
- `README.md` plus the numbered files for that feature
- feature-owned `contracts/` when present

## What Moved Out

- support examples now live under `docs/specs-support/examples/`
- validator fixtures now live under `docs/specs-support/fixtures/`
- archived review-only evidence now lives under `docs/archive/reviews/`

Do not treat support or archived artifacts as the governing source unless the request names them explicitly and governance still points back to a real governing package.

## Required Output

Every non-trivial change must produce a feature package with these required files:

- `README.md`
- `01-requirements.md`
- `02-design.md`
- `07-tasks.md`
- `08-acceptance-criteria.md`
- `09-test-cases.md`
- `10-rollout.md`
- `changelog.md`

Add these files when they apply:

- `03-data-model.md`
- `04-api-contract.md`
- `05-behavior.md`
- `06-edge-cases.md`
- `contracts/` for machine-readable API or data contracts
- `spec-pack.manifest.yaml` when the feature needs a generated agent execution pack

When `contracts/` exists, `04-api-contract.md` must name the owned files under `contracts/` so prose and machine-readable contract shape stay linked.

Add these once work reaches the stage:

- `11-implementation-report.md`
- `12-review-report.md`

Add these SDD2+ companion files when the feature needs them:

- `13-risk-log.md`
- `14-decision-notes.md`

## Gate

Implementation starts only after the package passes `docs/sdd/checklists/04-pre-implementation-gate.md`, including the source-base anchor and scope-parity checks in `02-design.md`.

Spec authoring is not complete until `docs/sdd/checklists/spec-authoring-checklist.md` passes.

## Task-Profile Routing Notes

- `implement-new` works from the governing feature package and uses a generated spec-pack only when that helps execution.
- `fix-from-pack` and `review-from-pack` may require a generated spec-pack as an execution aid, but the governing feature package still wins on conflicts.
- `fix-from-bug` without a generated spec-pack still requires a reduced-path or full-path feature package before non-trivial code changes begin.
- `review-from-rules` may omit a generated spec-pack, but it does not permit skipping the governing feature package for governed changes.
- `sonar-triage` may operate without a feature package only when it creates or updates a triage artifact and makes no code change.
- `sonar-triage-and-fix` and `sonar-fix-from-triage` may start from Sonar input or a triage artifact, but they still require the normal governance classification and a governing feature package before any non-trivial remediation.
- Generated execution briefs under `docs/spec-packs/` are execution aids only. They do not replace the governing feature package.
- `spec_back.md` or similar backend notes are helper-only inputs; they never replace `docs/specs/<feature-id>/`.

## Design Anchor Block

`02-design.md` must include a `Source Base Anchors` section with these fixed labels:

- `Backend process anchor files:`
- `Backend webservice anchor files:`
- `SQL anchor files:`
- `Frontend .ts anchor files:`
- `Frontend .html anchor files:`
- `Dominant module/style note:`
- `New tables/source families/screen structure in scope:`

Use repo-relative paths. Mark untouched layers as `n/a`. The final line defaults to `no` unless the approved spec explicitly opens that scope.
Template placeholders such as `<...>`, `TODO`, or `TBD` are not valid anchor values.

## Package Layout

```text
docs/specs/<feature-id>/
  README.md
  01-requirements.md
  02-design.md
  03-data-model.md
  04-api-contract.md
  05-behavior.md
  06-edge-cases.md
  07-tasks.md
  08-acceptance-criteria.md
  09-test-cases.md
  10-rollout.md
  11-implementation-report.md
  12-review-report.md
  13-risk-log.md
  14-decision-notes.md
  changelog.md
```

## File Map

| File | Use | Required when |
| --- | --- | --- |
| `README.md` | feature summary, owner, status, traceability index | always |
| `01-requirements.md` | problem, scope, business rules, constraints | always |
| `02-design.md` | solution, design decisions, impacted areas, parseable source-base anchors | always |
| `03-data-model.md` | schema, entities, state rules | data changes |
| `04-api-contract.md` | requests, responses, validation, compatibility | contract changes |
| `05-behavior.md` | user workflow, screen behavior, messages | user-visible behavior changes |
| `06-edge-cases.md` | failure handling, recovery, negative paths | non-trivial edge handling |
| `contracts/` | machine-readable API or data contracts | when interface or durable data shape must be executable by tools or agents |
| `spec-pack.manifest.yaml` | build inputs for generated agent execution pack | when the feature needs a spec-pack under `docs/spec-packs/` |
| `07-tasks.md` | implementation and verification work | always |
| `08-acceptance-criteria.md` | what must be true to accept the change | always |
| `09-test-cases.md` | checks that prove the acceptance criteria | always |
| `10-rollout.md` | deployment order, release checks, rollback | always |
| `11-implementation-report.md` | what was implemented and how it was verified | once implementation starts |
| `12-review-report.md` | findings, verdict, release recommendation | once review starts |
| `13-risk-log.md` | active risks, mitigations, and release impact | when the feature has material delivery or operational risk |
| `14-decision-notes.md` | local design decisions and links to ADRs when needed | when the feature has non-trivial design choices worth preserving |
| `changelog.md` | feature-local release summary | always |

## Naming Rules

- Folder: `docs/specs/<ticket-id>-<short-slug>/`
- No ticket: `docs/specs/<yyyy-mm-dd>-<short-slug>/`
- `REQ-01`, `DES-01`, `TASK-01`, `AC-01`, `TC-01`

Keep IDs stable after review starts.

## Raw Input Rule

When a package starts from a spreadsheet, ticket, bilingual note, design note, bug note, feature request, or approved Sonar triage artifact, normalize the raw input first with `docs/sdd/spec-authoring/raw-input-normalization.md`. Do not convert raw notes or triage artifacts directly into approved behavior without separating facts, open questions, non-changes, and approval gaps.

## Reduced-Path Package

Use the reduced-path package only when all of these are true:

- one module or one local workflow change
- no schema or persistence rule change
- no shared API, DTO, file, or integration contract change
- no non-obvious edge handling

Reduced-path minimum:

- `README.md`
- `01-requirements.md`
- `02-design.md`
- `07-tasks.md`
- `08-acceptance-criteria.md`
- `09-test-cases.md`
- `10-rollout.md`
- `changelog.md`

`contracts/` and `spec-pack.manifest.yaml` remain optional companion artifacts. They do not replace the numbered feature package and they do not change reduced-path governance by themselves.

Even for reduced-path changes, `02-design.md` still records source-base anchors for each touched layer and marks untouched layers as `n/a`.

When `README.md` includes an artifact checklist or package-status table, keep it aligned with the actual files so validation can enforce the declared package shape.

## Reference Example

Use `docs/specs-support/examples/2026-03-11-example-customer-export/` as the reference model for a complete medium-sized feature package. Treat it as format guidance, not approval for unrelated behavior.
