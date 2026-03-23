# GitHub Copilot Execution Profile

## Best Use

- small file-local edits
- IDE-assisted implementation inside a pre-grounded task packet
- narrow follow-up changes after routing and authoring are already complete

## Main Risk

Copilot operates with smaller context and can easily miss repository-wide governance, spec ownership, or sibling-flow parity.

## Reading Style

- do not rely on ambient IDE context alone
- work from a compact packet: selected execution contract, selected feature files, one checklist slice, and any locked contracts
- prefer generated execution briefs for non-trivial tasks
- keep the fixed prefix outside the IDE prompt and refresh only the small variable packet for the current change unit
- prefer narrow reads tied to the current hypothesis and packet over free-form repo browsing

## Task Handling Behavior

- keep the task bounded to one small change unit at a time
- when debugging or investigating, start with three likely hypotheses, verify the shortest path first, and avoid widening the packet until the current hypothesis is confirmed or rejected
- if the packet is too small, state the why, scope, and expected result for any broader exploration before continuing
- use root-cause excerpts instead of full log dumps inside the packet
- hand repo-wide routing, authoring, and verdict work back to a stronger orchestrating agent or reviewer

## Contract And Checklist Strictness

- use the strictest possible checklist packet
- do not claim end-to-end completion without external verification

## Stop And Ask

- the task depends on repo-wide authority or multiple sibling flows
- the current packet does not identify the governing feature package
- approval, schema, or contract ownership is unclear

## Expected Output

- small, scoped code or docs suggestions
- explicit uncertainty when repo-wide context is missing
- no independent final completion claim for governed work
