# Feature Intake Checklist

## When To Use

Use this checklist when a feature folder is first created.

## How To Use

Start with `docs/sdd/spec-authoring/README.md`, then copy `docs/sdd/templates/feature-package/` into the new feature folder.

## Required Output

- feature folder name
- `README.md` with initial metadata and scope
- minimum required package files created before design or coding starts

## Gate

The intake stage passes only when all applicable items are checked.

- [ ] The feature folder exists under `docs/specs/`.
- [ ] `docs/sdd/spec-authoring/README.md` was used to classify and start the package.
- [ ] `README.md` contains feature title, owner, status, and target release.
- [ ] `README.md` states at least one in-scope item.
- [ ] `README.md` states at least one out-of-scope item when scope drift is possible.
- [ ] `README.md` identifies whether `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, and `06-edge-cases.md` are required or `n/a`.
- [ ] The feature folder name uses `<ticket-id>-<short-slug>` or `<yyyy-mm-dd>-<short-slug>`.
- [ ] The request source is written in `README.md`.
- [ ] The feature is classified as `reduced-path` or `full-path`.
- [ ] The numbered package minimum exists before the work leaves intake.
- [ ] The next gate is clear: run requirements review, design review, spec-authoring review, and pre-implementation gate before coding starts.
