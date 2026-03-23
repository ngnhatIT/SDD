# Self-Review

## When To Use

Use before any AI-assisted completion claim or final output.

## Scope

This is a mandatory control loop. It does not replace the numbered delivery stages.

## Required Flow

1. reload the governing package, selected execution contract, relevant standards, and current evidence
2. confirm scope, non-changes, contracts, anchors, and applicable edge cases
3. run `docs/sdd/checklists/touched-scope-enforcement.md` for the touched concerns
4. run `docs/sdd/checklists/self-review-checklist.md`
5. run `docs/sdd/process/99-ai-checklist.md`
6. stop on blocking gaps, conflicts, hallucinated logic, schema mismatch, or standards drift
7. update implementation evidence before any completion claim

## Gate

Do not finalize while any blocking self-review finding remains.
