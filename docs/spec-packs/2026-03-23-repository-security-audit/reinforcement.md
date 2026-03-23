# Reinforcement: 2026-03-23-repository-security-audit

- Status: active
- Last Updated: 2026-03-23

## 1. Audit Guardrails

- do not classify style, maintainability, or dead-code concerns as security findings unless they create a concrete security impact
- prefer high-confidence repo-specific issues over broad speculative weakness lists
- keep secret handling masked in both chat and artifact output
- when a scanner report exists, treat it as an input signal rather than ground truth until the affected code or dependency path is confirmed

## 2. Evidence Discipline

- start from repository structure, entrypoints, trust boundaries, and existing outputs before deep-diving individual files
- trace attack paths from untrusted input to sink where feasible and record where the path becomes inferred rather than directly proven
- for SCA, distinguish direct from transitive and runtime from dev or test when the manifest and lockfile evidence permits it
- for SBOM, state whether component versions came from lockfiles, manifests, generated metadata, or unresolved inference

## 3. Validation Limits

- use only safe read-only commands, built-in dependency graph or audit commands, config inspection, and existing test or static-analysis outputs unless a stronger check is clearly non-destructive
- if a tool is missing or a command requires network or credentials, record the exact limitation instead of guessing results
- git-history secrets review is only complete if local history depth is sufficient and inspectable

## 4. Stop Conditions

- stop and report if a claimed tenant or company isolation rule cannot be reconciled between active docs, schema authority, and inspected query code
- stop and report if required evidence for a high-severity conclusion cannot be defended from repository facts
