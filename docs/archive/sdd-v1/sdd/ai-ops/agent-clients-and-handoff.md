# Agent Clients And Handoff

## Supported Client Pattern

The SDD2+ framework is written so the same repository artifacts can be used by:

- Claude
- Codex
- GitHub Copilot
- Cursor
- GPT

The framework does not assume a specific memory model, tool API, or chat UI.

## Minimum Handoff Packet

When one human or agent hands work to another, point to:

- the governing `docs/specs/<feature-id>/`
- the current task profile, if one is being used
- the latest spec-pack or execution brief, if the feature owns one
- the current objective and touched files or docs
- the smallest root-cause error, log, or diff excerpt when a live blocker remains
- the validation command or manual regression path
- the open items in `13-risk-log.md` or `12-review-report.md`

## Short Handoff Summary Pattern

```md
Objective: <current goal>
Changed Artifacts: <paths>
Completed: <done items>
Remaining: <remaining items>
Blockers: <blocker or none>
Root-Cause Excerpt: <excerpt or n/a>
Next Grounded Step: <next action>
Confidence: <high | medium | low>
```

## Recommended Handoff Order

1. Governing feature package
2. Contracts and generated execution aids
3. Short handoff summary
4. Changed implementation files
5. Validation evidence
6. Open risks and follow-up items
