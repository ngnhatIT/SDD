# QA Validation Checklist

## When To Use

Use this checklist when validating the implemented feature against the acceptance criteria.

## How To Use

Check each item against the test-case file and recorded evidence.

## Required Output

- recorded QA evidence
- unresolved QA findings or a pass decision

## Gate

Release readiness starts only when all applicable items are checked.

- [ ] Every `AC-` item has at least one matching `TC-` item.
- [ ] Every critical `TC-` item has a recorded result.
- [ ] Main flow test results are recorded.
- [ ] Negative-path or validation test results are recorded.
- [ ] Edge-case results are recorded when `06-edge-cases.md` exists.
- [ ] When automated tests are absent in the touched area, manual regression paths are recorded for the highest-risk flows.
- [ ] SQL or validation changes include regression-sensitive checks such as soft-delete or active-record behavior, sibling-flow parity, or duplicated frontend or backend validation where relevant.
- [ ] Where the feature touched shared messages, focus-out behavior, or table rendering, QA evidence covers the normalized message path and the reused shared flow instead of only the happy path.
- [ ] Where the feature touched frontend validation or fatal-error routing, QA evidence covers field-level versus popup error behavior, not only the final blocking message.
- [ ] Where the feature touched search screens, QA evidence covers saved-condition hydration, count-then-list behavior, and zero-result clearing where applicable.
- [ ] API or frontend transport changes include response-shape and common error-routing results where relevant.
- [ ] Manual test environment or data context is recorded when needed.
- [ ] Compile, startup, or integration evidence is recorded when relevant.
- [ ] QA findings are reflected in `12-review-report.md` or linked review notes.
- [ ] QA findings that change expected behavior, acceptance, or proof are reflected in the governing feature artifacts or explicitly recorded as backfill.
