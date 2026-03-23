# Code Review Against Spec Checklist

## When To Use

Use this checklist during formal code review.

## How To Use

Review the PR and code against the governing feature package and the applicable repository standards.

## Required Output

- review findings tied to the feature package
- completed `12-review-report.md`

## Gate

Review passes only when all blocking items are resolved and all applicable checks are complete.

- [ ] The PR or review notes name the governing feature folder.
- [ ] The PR or review notes list affected spec files and implemented `TASK-` IDs.
- [ ] The reviewer checked the code against `01-requirements.md`, `02-design.md`, `08-acceptance-criteria.md`, and `09-test-cases.md`.
- [ ] The reviewer checked `AGENTS.md`, the selected execution contract, and the relevant standards when agent-generated work is involved.
- [ ] If the feature owns `contracts/`, the reviewer checked the implementation and spec against those machine-readable contracts.
- [ ] If the feature owns `spec-pack.manifest.yaml`, the reviewer confirmed the generated pack is still aligned with the feature package.
- [ ] The reviewer checked that each rule, guide, or template change was placed in the correct owning layer instead of creating duplicate authority.
- [ ] Scope parity, contract parity, and schema parity were checked explicitly.
- [ ] `docs/sdd/checklists/touched-scope-enforcement.md` passed for the touched concerns.
- [ ] If SonarQube or static-analysis findings drove the change, the reviewer checked whether each issue still applied to the current code.
- [ ] If SonarQube or static-analysis findings drove the change, the reviewer checked whether any remediation changed intended behavior or another governed surface.
- [ ] Stale, false-positive, risky, deferred, or human-decision Sonar items were recorded correctly in the triage artifact.
- [ ] Approved follow-up Sonar items remain traceable from issue ID to triage artifact, implementation evidence, and review evidence.
- [ ] Missing evidence is recorded as an unsupported assumption, open question, or blocking finding instead of being guessed away.
- [ ] When logs, errors, or failing output are cited, the review keeps root-cause excerpts only unless a longer excerpt is needed to defend the finding.
- [ ] `12-review-report.md` records findings or states `No blocking findings.`
- [ ] `12-review-report.md` distinguishes observed facts, grounded risks, unsupported assumptions, and confirmed hallucination findings.
- [ ] `12-review-report.md` uses severity-rated findings and includes confidence or uncertainty notes where needed.
- [ ] `12-review-report.md` contains a verdict: `pass`, `pass with notes`, or `fail`.
