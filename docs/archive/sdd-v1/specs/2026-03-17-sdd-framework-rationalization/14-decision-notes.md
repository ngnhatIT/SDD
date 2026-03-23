# Decision Notes

| Decision ID | Status | Summary | Why it matters | Related spec | ADR |
| --- | --- | --- | --- | --- | --- |
| `NOTE-01` | accepted | treat this effort as a framework-first audit and safe-cleanup pass, not as a codebase-wide rule-extraction pass | keeps the current task aligned with the user request and prevents premature prompt or standards work | `DES-01`, `DES-03` | `n/a` |
| `NOTE-02` | accepted | keep the current approval model intact while auditing and tightening the framework | avoids accidental redefinition of `docs/specs/` authority during cleanup | `DES-05` | `ADR-0004` |
| `NOTE-03` | accepted | defer risky file merges or drops when the audit finds compatibility uncertainty, and record them as human-confirmation items instead of guessing | keeps cleanup grounded and aligned with uncertainty policy | `DES-03`, `DES-04` | `n/a` |
