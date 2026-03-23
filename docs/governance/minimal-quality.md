# Minimal Quality Bar

This file defines the minimum acceptable content for governed artifacts. Anything below this bar is invalid.

| Artifact | Too Weak | Acceptable |
| --- | --- | --- |
| `spec_pack.md` | empty, placeholder, or no acceptance criteria | at least one real section and an acceptance-criteria section or equivalent |
| `reinforcement.md` | empty, placeholder, or no rule, constraint, or stop condition | at least one grounded rule, constraint, or stop condition |
| `verification.md` | empty, placeholder, or no verification steps/checklist | explicit verification steps, checklist, or acceptance coverage |
| `review.md` | empty, placeholder, missing findings, or missing scope/files reviewed | explicit findings plus scope reviewed or files inspected and a reference to `spec_pack.md` |
| `audit.md` | empty, placeholder, missing compliance result, or no no-code-change statement | explicit compliance status, explicit no-code-modified statement, and a reference to `spec_pack.md` |

## Rule

If a human can replace the body with `TODO`, `pending`, `none`, or a template stub and still pass validation, the artifact is too weak.
