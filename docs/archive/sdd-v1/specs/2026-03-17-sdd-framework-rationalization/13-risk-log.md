# Risk Log

| Risk ID | Category | Description | Impact | Likelihood | Mitigation | Owner | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `RISK-01` | compatibility | aggressive file merges or drops could conflict with the current additive SDD2+ decision set and break existing external bookmarks or workflows | high | medium | keep destructive cleanup as planned follow-up unless operational safety is obvious; mark human-confirmation points explicitly | repository maintainer | open |
| `RISK-02` | authority drift | legacy `agent/` docs still present themselves as active entrypoints and can misroute AI usage even after canonical docs are clarified | high | high | add explicit legacy-bridge warnings now and record stronger reduction options in the migration plan | repository maintainer | open |
| `RISK-03` | stale history | historical migration docs can be mistaken for active workflow guidance and reinforce obsolete path assumptions | medium | high | tighten stale historical docs and clearly mark them as history, not operating instructions | repository maintainer | open |
