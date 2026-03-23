# Release

## When To Use

Use this stage after review passes and the change is being prepared for QA signoff, shipment, merge, or closeout.

This stage includes the final definition-of-done check before the change is declared complete.

## How To Use

1. Confirm QA results and rollout steps.
2. Update the feature-local `changelog.md` and root `CHANGELOG.md` when the change is releasable.
3. Record final rollout status, rollback triggers, and any post-release checks.
4. Run `docs/sdd/checklists/done-checklist.md`.
5. Confirm the governing definition-of-done rule still passes.
6. Verify acceptance evidence, required artifacts, self-review, formal review, and rollout state.
7. Record any remaining blocker instead of claiming completion.
8. Close the feature only after post-release actions are complete or explicitly handed off.
9. Run the pre-merge audit and the done checklist before declaring the change complete.

## Required Output

- final QA status
- release-ready or not-ready decision
- current rollout and rollback notes
- changelog updates for releasable behavior changes
- pre-merge audit and done-check evidence
- explicit `done` or `not done` decision
- visible remaining blockers, deferrals, or residual risks when not done

## Gate

Close the feature only when:

- QA evidence covers the release scope
- rollout and rollback steps are current
- pre-merge audit and done-check do not show unresolved blockers
- `docs/sdd/checklists/07-qa-validation.md`, `08-release-readiness.md`, and `09-post-release-review.md` pass

The feature is not done until both `docs/sdd/governance/definition-of-done.md` and `docs/sdd/checklists/done-checklist.md` pass.

## Done Requires

- in-scope `AC-` items have visible evidence
- required artifacts are current
- contracts and schema notes are updated or their ownership gap is explicit
- self-review is complete
- formal review verdict is clear
- pre-merge audit is complete
- rollout and changelog state are current when applicable
- confidence is not low for any claimed complete scope
