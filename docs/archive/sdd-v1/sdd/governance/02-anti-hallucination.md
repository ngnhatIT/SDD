# Anti-Hallucination

## When To Use

Use for every AI-generated claim, diff, review finding, and completion statement.

## Forbidden

- inventing requirements, behavior, routes, tables, columns, DTO fields, response keys, tests, or code patterns
- filling missing evidence with unsupported inference
- treating silence in specs or code as approval
- claiming alignment, coverage, or readiness without evidence
- treating scanner output, line numbers, or rule titles as proof that the current code still contains a SonarQube finding

## Required Checks

- Every new claim points to a spec, context doc, decision, standard, or inspected code pattern.
- Every evidence gap is recorded as a blocker, open question, or unsupported assumption.
- If a generated spec-pack omits detail, the missing detail stays unknown until a higher-priority source resolves it.
- For SonarQube or static-analysis work, each finding is checked against current code and the triage result is recorded or explicitly blocked.
- Final output must confirm that no hallucinated logic, schema detail, interface detail, or code pattern remains.

## Stop Rule

Stop and report the gap when:

- a required fact is missing
- two evidence sources conflict
- the touched pattern cannot be identified from approved docs or inspected anchors
- a SonarQube finding cannot be confirmed, safely dismissed, or safely classified from the current code
- the final output still depends on an unverified assumption

## Gate

No AI output is valid while any ungrounded claim or hallucinated item remains.
