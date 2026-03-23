# Framework Self-Audit

## When To Use

Use this helper when maintainers need to audit the SDD4 framework itself for structural drift, authority drift, duplication drift, prompt drift, template drift, bridge ambiguity, or validator blind spots.

## How To Use

1. Start from canonical docs, not from bridge or archive material.
2. Run the lightweight validators first so the mechanical issues are already visible.
3. Audit only active framework surfaces unless a canonical doc explicitly requires historical context.
4. Record grounded findings, blind spots, and next actions in tracked artifacts instead of chat-only notes.

## Required Output

- a short self-audit summary with confirmed drift signals, blind spots, and next actions
- file references for every confirmed issue
- explicit separation between validator findings, manual observations, and unresolved uncertainty

## Gate

This document is helper-only. It does not replace governance, review, or the governing feature package for framework changes.

## Audit Scope

Audit these framework surfaces periodically:

- `AGENTS.md`
- `docs/README.md`
- `docs/sdd/README.md`
- `docs/sdd/context/`
- `docs/sdd/governance.md` and `docs/sdd/governance/`
- `docs/sdd/templates/`
- `docs/sdd/prompts/`
- `docs/sdd/ai-ops/`
- `docs/specs/README.md`
- `docs/spec-packs/` only as generated execution aids
- `scripts/sdd/`
- retained bridge roots such as `agent/` when present

## Structural Drift Signals

- canonical entrypoint docs no longer route to the current canonical files
- required feature-package files, report files, or helper docs are missing from navigation or templates
- validator fixtures no longer cover the documented checks they claim to cover
- generated spec-pack or execution-brief conventions drift from their templates or scripts
- package-shape summaries in README artifact checklists no longer match actual artifacts

## Authority Drift Signals

- prompt or helper docs restate governance as if they were the approval source
- bridge docs read like active canonical entrypoints
- generated spec-packs or execution briefs claim approval authority
- docs outside `docs/sdd/` or `docs/specs/` become de-facto rule sources without canonical adoption
- framework change guidance appears in chat-only notes but not tracked canonical artifacts

## Duplication Drift Signals

- the same rule exists in multiple active files with materially different wording
- template guidance and governance require the same thing but disagree on section names or evidence depth
- prompt notes duplicate routing or gate logic already owned by context or governance
- bridge docs duplicate canonical content instead of pointing back to it

## Prompt-To-Governance Drift Signals

- prompt guides suggest paths, shortcuts, or exceptions not present in governance or context docs
- prompt examples use outdated task-profile names or header fields
- execution-aid templates stop reflecting current anti-hallucination or ask-before-break rules
- operator shortcuts become more detailed than the canonical rule they summarize

## Template And Report Drift Signals

- `11-implementation-report.md` and `12-review-report.md` examples drift from the current canonical templates
- validators stop checking required report markers that governance depends on
- new feature packages omit sections or front matter fields that templates still advertise as standard
- older report shapes remain in use without explicit drift notes or migration follow-up

## Bridge Ambiguity Signals

- retained bridge roots such as `agent/` do not label themselves as legacy, bridge, or compatibility material
- bridge landing docs do not point back to `AGENTS.md`, `docs/sdd/README.md`, and `docs/specs/README.md`
- active canonical docs mention bridge roots without bridge-only or helper-only wording
- bridge content introduces rule text that conflicts with canonical docs and is not clearly subordinated

## Validation Blind Spots

The validators still cannot safely decide these without human review:

- whether prose content is substantively correct, not just structurally present
- whether a design choice truly requires an ADR when the trigger is judgment-heavy
- whether a legacy report shape should be migrated immediately or tolerated with a warning
- whether a bridge reference is harmful duplication or necessary compatibility context when wording is nuanced
- whether acceptance or review evidence is actually strong enough beyond the explicit recorded markers
- whether a generated pack summarized the right nuance when the source itself is ambiguous

## When To Run The Audit

- after any non-trivial framework change touching `AGENTS.md`, `docs/sdd/`, `docs/specs/README.md`, or `scripts/sdd/`
- before broad cleanup or rationalization work that could collapse files, prompts, or bridge surfaces
- when validator warnings start recurring across multiple framework features
- on a lightweight periodic cadence such as monthly or after every 5 to 10 framework changes
- when maintainers notice repeated confusion about source of truth, task routing, or report expectations

## Suggested Audit Sequence

1. Run `scripts/sdd/validate_framework_docs.sh`.
2. Run `scripts/sdd/test_validate_specs.sh` and `scripts/sdd/test_validate_framework_docs.sh`.
3. Spot-check active feature packages or framework feature packages that recently changed validator or template behavior.
4. Review retained bridge landing docs when `agent/` is present.
5. Record confirmed drift, warnings worth promoting, and blind spots that still need manual handling.

## Audit Outputs

Produce one short output bundle:

- audit date and scope
- validators run and their result
- confirmed structural or authority drift findings
- duplication or prompt-drift findings
- bridge ambiguity findings
- blind spots that remain manual
- recommended follow-up actions with owner or suggested location

## Recording Guidance

- record framework findings in the governing feature package when the audit is part of a change
- use implementation or review reports for tracked evidence
- if no governed feature package exists because the audit is exploratory only, record findings in a dedicated tracked audit note before acting on them
