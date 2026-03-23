# Risk Log

## Risk Register

| Risk ID | Area | Description | Impact | Likelihood | Mitigation | Owner | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `RISK-01` | compatibility | new SDD2+ docs could look like a replacement for the current SDD2 lifecycle | high | low | keep compatibility guidance explicit in `docs/sdd/README.md`, governance, and ADR-0004 | repository maintainer | mitigated |
| `RISK-02` | tooling drift | the example feature pack could drift from the source package after script changes | medium | medium | build the pack from the feature package and validate it in the same branch | repository maintainer | mitigated |
| `RISK-03` | adoption | future contributors may ignore the additive companion artifacts and fall back to chat-only reasoning | medium | medium | keep prompts, templates, and AI ops docs concise and repository-centric | repository maintainer | monitor |

## Release Watch

- No runtime release blocker exists because this is a docs and tooling change.
- Adoption risk remains and should be monitored during the next governed feature creation.

## Resolution Notes

- `RISK-01` is mitigated by the compatibility and lifecycle docs plus ADR-0004.
- `RISK-02` is mitigated by building the pack from the source feature package in this branch.
