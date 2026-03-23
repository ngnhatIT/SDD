# Requirements

## Scope Classification

- Path: `full-path docs-only`
- Reason: the change touches governance, routing, prompts, checklists, templates, and spec authoring across the active SDD framework.

## Scope

### In Scope

- redesign the live SDD operating path around governance, execution, agent profiles, prompt adapters, and governed spec authoring
- reduce active-path noise by isolating historical migration and cleanup records
- separate non-canonical support examples and validator fixtures from governed approval-source packages
- keep supporting generators and validators working after the path cleanup

### Out Of Scope

- product runtime behavior changes
- schema or durable data changes
- replacing ADR governance
- rewriting archived history so it reads like a new canonical document set

## Requirements

### REQ-01 Governance Must Stay Canonical

The upgraded SDD MUST preserve the repository authority order, source-of-truth rules, stop rules, anti-hallucination discipline, schema binding policy, and ask-before-break discipline.

### REQ-02 Execution Must Be Explicit

The upgraded SDD MUST provide one canonical execution layer that tells an agent:

- how to route the task
- what minimum inputs are required
- what files must be read
- what outputs must be produced
- when to stop instead of guessing

### REQ-03 Multi-Agent Operation Must Be First-Class

The upgraded SDD MUST provide explicit execution guidance for:

- Codex
- Claude
- GitHub Copilot

The guidance MUST cover strengths, limitations, reading style, operating behavior, stop thresholds, and expected output shape.

### REQ-04 Prompt Architecture Must Stop Repeating Governance

The upgraded SDD MUST reduce prompt duplication by moving reusable operational rules into canonical execution contracts and keeping prompts concise, task-intent driven, and agent-aware.

### REQ-05 Spec Authoring Must Be Governed

The upgraded SDD MUST define a first-class spec-authoring workflow that can start from raw inputs such as spreadsheets, bilingual notes, tickets, design notes, bug descriptions, or feature requests.

The workflow MUST define:

- minimum required inputs
- normalization rules
- mandatory output files
- review gates
- traceability expectations

### REQ-06 Fragile Rules Must Become Reusable Checks

The upgraded SDD MUST convert recurring failure-prone rules into reusable checklists or enforcement contracts that cover:

- unused imports
- dead or redundant code
- formatting parity
- English-only new comments
- frontend structure reuse
- responsive and paired-field layout parity
- frontend-backend validation parity
- shared helper and service reuse
- schema binding
- source-base-anchor checks before new abstractions

### REQ-07 Main-Path Noise Must Be Reduced

The upgraded SDD MUST make the active execution path smaller and clearer by demoting or isolating historical reports, migration records, compatibility notes, and duplicate routing material.

### REQ-08 Backward Compatibility Must Be Thin

The upgraded SDD MAY keep compatibility bridges where needed, but the bridges MUST stay obviously non-canonical and MUST NOT create a second active authority path.

## Constraints

- Use the repository's existing authority model unless a conflict is explicitly repaired.
- Do not invent new runtime behavior, schema rules, or contracts.
- Preserve `docs/decisions/` as the ADR source.
- Preserve `docs/specs/<feature-id>/` as the approval source for governed work.

## Non-Goals

- redesigning product architecture
- rewriting archived historical snapshots to hide their original paths
- introducing new runtime build tooling
