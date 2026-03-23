# Failure Modes

| Failure Mode | Symptom | Detection | Corrective Action |
| --- | --- | --- | --- |
| skipped reinforcement when required | non-trivial work proceeds with no grounded ambiguity or risk record | `reinforcement.md` is missing, stale, or too thin to defend the next step | stop, write or refresh `reinforcement.md`, then continue from the grounded scope |
| implementation not aligned with `spec_pack.md` | changed behavior, files, or claims are outside approved scope | diff or `verification.md` cannot map work back to the pack or acceptance criteria | narrow the change back to the pack, or update `spec_pack.md` before continuing |
| review with weak evidence | `review.md` has generic findings, no inspected files, or no scoped basis | findings cannot be traced to inspected code, files, or standards | reopen the review, list files inspected, restate the basis, and rewrite findings against real evidence |
| audit that mutates code | an audit task leaves repo edits behind | `git status` shows changes or the audit cannot honestly say `Code Modified: no` | revert your own audit-only edits, reroute to `fix` or `implement` if changes are needed, and keep `audit.md` findings-only |
| closeout without the required artifact | work ends in chat or in code only | `verification.md`, `review.md`, or `audit.md` is missing or the validator fails | update the correct artifact, rerun the validator, and do not close the task until the folder is consistent |
