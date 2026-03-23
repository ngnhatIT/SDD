# Spec Authoring Checklist

Use this checklist before a new or updated feature package is treated as ready for implementation or governed review.

- [ ] Raw source inputs are listed explicitly.
- [ ] Facts, open questions, non-changes, and approval gaps were separated before writing the package.
- [ ] The change was classified as `reduced-path` or `full-path`, or the blocker is explicit.
- [ ] `README.md` names scope, request source, owner, status, and required conditional artifacts.
- [ ] `01-requirements.md` states outcomes rather than code-level solutions.
- [ ] `02-design.md` identifies touched surfaces, source-base anchors, reuse rules, and scope boundaries.
- [ ] `07-tasks.md`, `08-acceptance-criteria.md`, and `09-test-cases.md` are present and traceable.
- [ ] Conditional files are created only when needed, otherwise marked `n/a`.
- [ ] Validation ownership, error-routing expectations, and parity requirements are explicit when they matter to the change.
- [ ] Rollout and rollback intent exists.
- [ ] No placeholder text, invented rules, or hidden approval assumptions remain.
