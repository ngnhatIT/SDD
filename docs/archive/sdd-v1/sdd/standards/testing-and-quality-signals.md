# Testing And Quality Signals

## When To Use

Use this file when deciding how a change will be proven safe enough to accept, merge, or release.

## How To Use

1. Classify the change path, risk, and likely regression surface.
2. Name a `quality proof strategy` before claiming the work is complete.
3. Choose the strongest practical mix of automated and controlled manual evidence for that risk.
4. Map the proof to `TC-` items and record what stayed manual, deferred, or unknown.
5. When the change comes from a finding or incident, verify the triggering path and the highest-risk adjacent regression path.

## Required Output

- a quality-proof strategy proportionate to risk
- realistic verification evidence tied to `TC-` items
- an explicit statement of what is automated versus manual
- residual risk or backfill note when proof is limited

## Gate

Do not claim acceptance complete without recorded proof, and do not imply automated coverage that does not exist.

## Current Reality

- tracked automated coverage is minimal
- the current repository has no tracked backend files under `src/test` and only a trivial Angular `.spec.ts` smoke test, so meaningful automated coverage is still effectively absent
- much of the repo still relies on manual verification and production-like behavior matching

## Core Rule

SDD does not stop at rendering code from specs. It should also render the verification assets needed to defend the change for its actual risk.

The strongest practical proof may be:

- `unit` evidence for local logic or branching
- `integration` evidence for process, data, or cross-layer behavior
- `end-to-end` or screen-flow evidence for user-visible journeys
- `contract` evidence for request, response, file, or data-shape compatibility
- `static-analysis` or diff inspection as supporting evidence
- controlled `manual` proof when automation is not practical in the touched area

## Quality Proof Strategy

Every change should name:

- the change risk or blast radius
- the triggering path and highest-risk adjacent regression path
- the proof assets to add, run, or inspect
- what remains manual and why
- residual risk or required backfill when proof stays partial

## Proof Selection By Path And Risk

| Path Or Risk | Expected Proof Mix | Notes |
| --- | --- | --- |
| `tiny-fix` or low-risk `docs-only` | targeted inspection plus the smallest relevant check | keep it light, but still explicit |
| reduced-path behavior change | targeted `unit` or `integration` proof when practical, otherwise controlled manual proof of the touched path and one regression-sensitive adjacent path | bounded work still needs visible proof |
| full-path or higher-risk workflow or contract change | strongest practical mix of `unit`, `integration`, `contract`, `end-to-end` or screen-flow, and manual regression proof | higher-risk changes should accumulate stronger evidence, not just more prose |
| hotfix | strongest targeted pre-deploy proof practical in the time window, plus rollback verification and recorded backfill when normal proof is deferred | urgency reduces ceremony, not honesty |

## Feedback-Driven Retest Triggers

When the change comes from review comments, QA findings, SonarQube findings, bug reports, or production incidents:

- confirm the finding still applies to current code or current docs before fixing
- prove the fix on the exact triggering path
- prove the highest-risk adjacent regression path
- update `09-test-cases.md` or the governing artifacts when the finding exposes missing proof or missing acceptance intent

## Quality Signals To Watch

- duplicate Angular routes or declarations
- transaction boundary mistakes in process classes
- raw SQL concatenation of user input
- copy-paste drift across search/count, CSV, and file-output families
- missing parity checks across search/count, `checkLink`, `checkDetail`, `getDetail`, `update`, and `delete` sibling flows
- missing error-path handling in frontend transport flows
- new `printStackTrace()`, `console.log(...)`, or empty `.catch(() => {})` introduced into touched code
- direct `HttpClient`, `fetch`, or component-local `$.ajax` bypassing the shared frontend transport
- DTO shape drift, naming drift, or invented abstraction layers inside an existing module family
- unused imports or feature-component imports added to shared services or common utilities
- formatting or comment churn that is not tied to behavior, contract, or safety
- duplicated round trips or row-by-row follow-up calls added to flows that are currently batch-oriented
- contract drift between `docs/specs/<feature-id>/contracts/`, the prose feature package, and implementation
- manual-only verification claims that do not name the concrete high-risk regression path for the touched screen, search, mutation, or API family
- findings fixed without proving the triggering path and the most likely adjacent regression path
- high-risk changes that still rely on manual-only proof without an explicit residual-risk or backfill note
