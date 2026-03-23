# Test Cases

| TC ID | Covers | Method | Steps | Expected Result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01` | Manual review | Inspect `AGENTS.md`, `docs/sdd/context/ai-loading-order.md`, `docs/sdd/governance.md`, and the live governance docs referenced by the new path. | Authority order, stop rules, and source-of-truth handling remain explicit and unweakened. |
| `TC-02` | `AC-02` | Manual review | Inspect `docs/sdd/execution/task-routing.md` and every file under `docs/sdd/execution/contracts/`. | Routing and minimum contracts are explicit, concise, and task-family specific. |
| `TC-03` | `AC-03` | Manual review | Inspect `docs/sdd/execution-profiles/` plus the rewritten prompt entrypoints under `docs/sdd/prompts/`. | Agent-specific operating guidance exists and prompts no longer duplicate the full workflow body. |
| `TC-04` | `AC-04` | Manual review | Inspect `docs/sdd/spec-authoring/`, `docs/sdd/checklists/spec-authoring-checklist.md`, and `docs/specs/README.md`. | Spec authoring is a governed workflow from raw inputs to approved outputs. |
| `TC-05` | `AC-05` | Manual review | Inspect `docs/sdd/checklists/touched-scope-enforcement.md`, `docs/sdd/process/99-ai-checklist.md`, `docs/sdd/checklists/self-review-checklist.md`, `docs/sdd/checklists/05-implementation-completion.md`, `docs/sdd/checklists/06-code-review-against-spec.md`, and `docs/sdd/checklists/done-checklist.md`. | Shared enforcement checks exist and duplicated rule bodies are materially reduced. |
| `TC-06` | `AC-06` | Manual review | Inspect `docs/README.md`, `docs/sdd/README.md`, `docs/sdd/prompts/README.md`, and `docs/specs/README.md`. | Main-path entrypoints steer agents to canonical live docs and demote historical or compatibility material. |
| `TC-07` | `AC-07` | Manual review | Inspect retained bridge files such as `docs/sdd/context/task-profiles.md`, `docs/sdd/context/task-mode-matrix.md`, `docs/sdd/prompts/HEADER_TEMPLATE.md`, and any top-level prompt aliases kept for compatibility. | Compatibility bridges are short, clearly labeled, and point back to live canonical sources. |
