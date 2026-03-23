# Risk Log

| Risk ID | Description | Impact | Mitigation | Status |
| --- | --- | --- | --- | --- |
| `RISK-01` | Entrypoint docs may still reference duplicate routing files and leave authority ambiguous. | High | Update `AGENTS.md`, `docs/README.md`, `docs/sdd/README.md`, prompt entrypoints, and `docs/specs/README.md` together. | `mitigated` |
| `RISK-02` | New layers could add volume instead of reducing noise. | High | Keep execution contracts short, keep prompts thin, and move repeated enforcement into shared checklists. | `monitor` |
| `RISK-03` | Historical or compatibility files may still look live to agents. | Medium | Label bridges and history explicitly as non-canonical and remove them from the main read path. | `monitor` |
| `RISK-04` | `docs/specs/` fixtures and examples may still confuse future agents. | Medium | Tighten `docs/specs/README.md` now and leave deeper relocation as explicit follow-up if needed. | `open` |
