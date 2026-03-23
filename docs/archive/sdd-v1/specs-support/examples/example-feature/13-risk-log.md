# Risk Log

## Risk Register

| Risk ID | Area | Description | Impact | Likelihood | Mitigation | Owner | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `RISK-01` | parity | search count, search list, and CSV export may drift if one sibling flow misses the new predicate | high | medium | update all sibling flows together and verify with `TC-02` | feature owner | open |
| `RISK-02` | saved conditions | older saved-condition payloads may not carry `expiredOnly` | medium | medium | default missing values to `false` and verify restore behavior with `TC-01` | feature owner | open |
| `RISK-03` | example drift | the generated pack may drift from the example feature package over time | medium | low | rebuild the pack whenever the source package changes and validate with `TC-04` | feature owner | open |

## Release Watch

- `RISK-01` is the main release blocker for a real implementation because it can create user-visible search or export mismatch.

## Resolution Notes

- None yet. This example feature stops before implementation.
