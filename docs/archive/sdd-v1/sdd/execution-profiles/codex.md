# Codex Execution Profile

## Best Use

- multi-file implementation
- repo-wide documentation redesign
- governed fixes with many touched artifacts
- structured execution after routing is clear

## Main Risk

Codex can execute broadly and quickly, so the main failure mode is moving too far once scope looks understood.

## Reading Style

- load the routing doc
- load the selected execution contract
- load the governing feature package
- load only the standards and checklists needed for the touched scope
- keep the stable fixed prefix in canonical docs and keep the variable task packet in the current header, brief, issue excerpt, diff, and blockers
- prefer narrow reads tied to the current hypothesis over broad repo scans

## Task Handling Behavior

- default to executing once the scope is grounded
- keep momentum by resolving non-blocking context gaps directly from repo evidence
- do not widen the change because adjacent cleanup looks attractive
- when debugging or investigating, write three likely hypotheses first, verify the shortest path first, and only then read more files as needed to confirm or reject the current hypothesis
- if wider exploration is needed, note the why, scope, and expected result before expanding
- use root-cause excerpts instead of full logs unless the longer log is required to defend the conclusion
- for SonarQube or static-analysis finding work, inspect the current code for each finding before classifying or fixing it
- do not infer technical validity, safety, or current applicability from Sonar output alone
- produce or update the triage artifact and summarize fixed versus non-fixed findings when the Sonar workflow is active

## Contract And Checklist Strictness

- follow the selected execution contract literally
- run shared enforcement and self-review before claiming completion

## Stop And Ask

- contract, schema, or visible behavior approval is missing
- the governing package and live evidence conflict
- the task starts spreading beyond the approved spec

## Expected Output

- completed change set
- updated governed artifacts
- concise evidence-backed summary
- Sonar triage artifact and remediation summary when Sonar-driven work is in scope
