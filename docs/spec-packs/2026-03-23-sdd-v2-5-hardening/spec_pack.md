# Spec Pack: 2026-03-23-sdd-v2-5-hardening - Lean SDD v2.5 System Hardening

- Status: approved
- Owner: repository maintainers
- Last Updated: 2026-03-23

## 1. Context

- the active v2.4 framework validates file presence but still allows weak or ambiguous task artifacts to pass
- task-folder naming and task-type aliases create avoidable operator ambiguity in a framework that is supposed to be low-ambiguity
- review and audit artifacts exist, but traceability back to the originating spec is not yet enforced by the local validator
- the next upgrade must harden enforcement without restoring the archived v1 process weight

## 2. Scope

### In Scope

- upgrade `scripts/validate-task.py` from file-presence checks to artifact-quality checks
- define one canonical folder naming strategy for active governed work
- remove active task-type alias ambiguity from docs and validator behavior
- formalize one-folder-one-primary-task lifecycle rules with review and audit traceability requirements
- add a lightweight spec-to-code gap checker
- strengthen operator prompts and governance guidance only where the new rules are enforceable or testable

### Out Of Scope

- redesigning the lean SDD v2 operating model
- adding CI-only or mandatory infrastructure beyond optional local hook guidance
- restoring the archived v1 validator suite or numbered artifact workflow
- performing deep static analysis beyond lightweight string and path checks

## 3. Functional Requirements

### FR-01 Validator Checks Artifact Quality

- `scripts/validate-task.py` must still enforce required file presence
- it must also reject empty, placeholder, or structurally weak governed artifacts using simple keyword or regex checks
- failures must be human-readable and exit non-zero

### FR-02 Canonical Naming Is Singular

- active docs must define one naming contract for `docs/spec-packs/<feature-id>/`
- the naming contract must match dominant active repo usage and reject dual-standard wording

### FR-03 Canonical Task Types Are Singular

- active docs and validator behavior must use one canonical task type set only: `implement`, `fix`, `review`, `docs`, `audit`, `hotfix`
- alias wording such as `spec` or `code` must be removed from the active contract

### FR-04 One Folder One Lifecycle

- `docs/structure.md` must define one primary task lifecycle per folder
- allowed evolution remains `spec_pack` -> change work -> `review` -> `audit`
- `review.md` and `audit.md` must reference the originating `spec_pack.md`
- validator checks must fail when review or audit artifacts exist without spec traceability

### FR-05 Lightweight Spec Gap Check Exists

- `scripts/check-gap.py` must inspect a `spec_pack.md` against the repo with lightweight checks only
- it must report missing referenced files and missing code tokens called out by the spec

### FR-06 Operator Prompts Are Harder To Misuse

- `docs/operator/quick-start-prompts.md` must force explicit task type, target folder, and expected output artifact in each prompt
- prompts must make the correct artifact choice obvious for review, audit, implementation, and governed docs work

### FR-07 Minimal Quality Bar Is Explicit

- `docs/governance/minimal-quality.md` must define a short binary threshold for each governed artifact
- the thresholds must match validator behavior closely enough to be enforceable in practice

### FR-08 Failure Modes Cover Hardened Misuse Patterns

- `docs/governance/failure-modes.md` must add anti-patterns for empty-content validation passes, lifecycle mixing, coding without grounding in the spec, and review without evidence
- each anti-pattern must state why it is dangerous and how to detect it quickly

## 4. Technical Shape

### Source Anchors

- governance root: `AGENTS.md`
- active execution docs: `docs/execution/`
- structure contract: `docs/structure.md`
- validator surface: `scripts/validate-task.py`
- lightweight comparison tool: `scripts/check-gap.py`
- operator prompts: `docs/operator/quick-start-prompts.md`

### Planned Shape

- extend `scripts/validate-task.py` with content checks, strict mode, lifecycle checks, and canonical task-type enforcement
- create `scripts/check-gap.py`
- add `docs/governance/minimal-quality.md`
- update active docs that currently reference v2.4, aliases, or dual naming guidance
- add optional local hook guidance only if it stays strictly optional and lean

## 5. Decisions And Constraints

- use date-first slug folders as the canonical active naming strategy because that is the dominant pattern already in `docs/spec-packs/`
- keep validator heuristics simple, explicit, and reviewable; do not add NLP or language-model style interpretation
- treat review and audit as lifecycle evidence tied to a spec-governed folder, not as standalone arbitrary folders
- keep the framework lean by adding only rules that can be validated locally or audited quickly

## 6. Execution Slices

| Slice | Goal | Main files or modules | Verification target |
| --- | --- | --- | --- |
| S1 | govern the v2.5 hardening itself | `docs/spec-packs/2026-03-23-sdd-v2-5-hardening/` | AC-08 |
| S2 | harden validator and add gap checker | `scripts/validate-task.py`, `scripts/check-gap.py` | AC-01, AC-05 |
| S3 | remove ambiguity from active execution docs | `AGENTS.md`, `docs/execution/`, `docs/structure.md`, `docs/spec-packs/README.md` | AC-02, AC-03, AC-04 |
| S4 | harden operator and governance guidance | `docs/operator/quick-start-prompts.md`, `docs/governance/`, `README.md`, `docs/README.md` | AC-06, AC-07, AC-08 |

## 7. Acceptance Criteria

### AC-01 Weak Artifacts Fail Validation

- `scripts/validate-task.py` rejects empty or placeholder `spec_pack.md`, `reinforcement.md`, `verification.md`, `review.md`, and `audit.md`
- required sections or equivalent markers are enforced per artifact type
- `--strict` enables stronger checks without changing canonical task types

### AC-02 Naming Ambiguity Is Removed

- active docs define one folder naming strategy only
- active docs no longer say both date-slug and external feature ID are canonical active options

### AC-03 Task-Type Ambiguity Is Removed

- validator and active docs accept only canonical task types
- active docs no longer present `spec` or `code` as active aliases

### AC-04 Lifecycle Traceability Is Enforced

- `docs/structure.md` contains `Task Lifecycle Rules`
- `review.md` and `audit.md` must reference the originating `spec_pack.md`
- validator fails review or audit validation when spec traceability is missing

### AC-05 Lightweight Gap Report Exists

- `scripts/check-gap.py` runs against a spec-pack folder or file
- it reports missing referenced files and missing named code tokens with a non-zero exit when gaps are found

### AC-06 Operator Prompts Are Explicit

- prompt stubs require `Mode`, `Target`, and `Output`
- review and audit prompts explicitly prevent wrong-artifact output

### AC-07 Quality Bar And Anti-Patterns Are Lean And Enforceable

- `docs/governance/minimal-quality.md` exists and uses binary acceptable vs too-weak guidance
- `docs/governance/failure-modes.md` includes the required anti-patterns with danger and quick-detection guidance

### AC-08 Framework Stays Lean But Stricter

- active docs stay short and aligned with validator behavior
- no active change restores archived v1 process weight or dual-standard ambiguity

## 8. Required Context

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/structure.md`
- `scripts/validate-task.py`
- `docs/operator/quick-start-prompts.md`
- `docs/governance/failure-modes.md`

## 9. Open Issues / Stop Points

- stop if validator heuristics drift away from the documented minimal quality bar
- stop if any active doc continues to present dual naming or alias task typing as canonical
- stop if the lifecycle rule would allow review or audit artifacts with no originating spec traceability
- stop if the gap checker expands into heavy analysis rather than lean existence checks
