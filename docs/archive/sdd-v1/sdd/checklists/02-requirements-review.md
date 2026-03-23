# Requirements Review Checklist

## When To Use

Use this checklist before design starts.

## How To Use

Review the requirements file and linked acceptance intent without referring to code.

## Required Output

- reviewed `01-requirements.md`
- requirement issues or a pass decision

## Gate

Design starts only when all applicable items are checked.

- [ ] `01-requirements.md` contains at least one `REQ-` item.
- [ ] Every `REQ-` item has a testable statement.
- [ ] In-scope and out-of-scope sections are present.
- [ ] Business rules and constraints are written where they affect the design.
- [ ] Open questions are listed instead of implied.
- [ ] `08-acceptance-criteria.md` can be mapped back to the `REQ-` items without guessing.
- [ ] No requirement describes a code-level solution instead of an outcome.
- [ ] Validation ownership, user feedback ownership, and parity expectations are explicit when they matter to the change.
- [ ] When the task starts from logs, errors, or failing output, the requirements keep only the smallest excerpt needed to explain the requirement or blocker.
- [ ] When framework or execution behavior is in scope, stable operating rules and task-local variable inputs are separated explicitly.
