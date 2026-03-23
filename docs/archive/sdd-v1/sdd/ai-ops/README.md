# AI Ops

Use `ai-ops/` only after the canonical AI governance in `../governance/01-ai-agent-policy.md` and `../governance/02-anti-hallucination.md` is loaded.

Load `../governance/03-context-binding.md` first when the task is DB-related.

This folder is not a second policy layer. It keeps only task-specific AI helpers:

1. `09-recovery-mode.md` when the next grounded step is unclear or work resumes after interruption
2. `agent-clients-and-handoff.md` when work is handed between humans or AI agents
3. `framework-health-metrics.md` when maintainers need lightweight delivery-outcome, proof-coverage, and framework-drift signals
4. `framework-self-audit.md` when maintainers need a recurring manual audit for framework drift and validator blind spots

Governance wins on policy. `ai-ops/` adds operational helpers only.
