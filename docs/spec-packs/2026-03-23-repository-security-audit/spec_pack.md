# Spec Pack: 2026-03-23-repository-security-audit - Repository Security Audit

- Status: approved
- Owner: AI audit task
- Last Updated: 2026-03-23

## 1. Context

- The repository request is an audit-only task over the full checked-out repository with defender-first application security focus.
- The audit must cover SAST, secrets detection, IaC and CI-CD review, SCA, and SBOM generation or equivalent inventory grounded in repository evidence.
- The audit must prioritize real exploitability, trust boundaries, tenant or company isolation, authentication and authorization, secret exposure, CI privilege, and supply-chain risk over generic style commentary.

## 2. Scope

### In Scope

- inspect repository-wide source, build, runtime resources, CI or workflow configuration, scripts, manifests, lockfiles, generated reports, and deploy surfaces
- inspect high-risk application paths including API entrypoints, auth and session handling, tenant or company boundaries, file and import flows, database access, command execution, logging, and third-party integration code
- consume existing security artifacts in the repository or workspace when present and de-duplicate them against fresh repo-context analysis
- generate a durable `audit.md` record and security artifacts under `artifacts/security/` when tooling and environment allow

### Out Of Scope

- changing runtime behavior or fixing code as part of this task
- inventing CVEs, exploit proofs, secret values, or runtime behavior not supported by checked-in evidence or safe validation
- relying on archived SDD v1 documents unless active docs leave a proven gap

## 3. Functional Requirements

### FR-01 Coverage Is Explicit

- each review area must report status, evidence source, blockers, and blind spots
- the audit must state what was inspected and what could not be fully covered

### FR-02 Findings Are Evidence-Backed

- each finding must cite concrete files, paths, line anchors, or command output
- uncertain findings must be labeled as needing validation with exact follow-up required

### FR-03 Validation Is Honest

- the audit must distinguish validated checks from read-only inference and from unverified hypotheses
- scanner or generator absence, network limits, shallow history, or missing lockfiles must be recorded explicitly

### FR-04 Remediation Is Actionable

- each real finding must include a smallest-correct fix, a more robust long-term fix, targeted files, and regression test guidance
- secret findings must include rotation or revocation guidance and likely blast radius

## 4. Technical Shape

### Source Anchors

- `AGENTS.md`
- `docs/execution/ai-loading-order.md`
- `docs/execution/task-routing.md`
- `docs/execution/task-contracts.md`
- `docs/governance/core-rules.md`
- `docs/governance/minimal-context.md`
- `docs/standards/api-rules.md`
- `docs/standards/db-rules.md`
- `docs/standards/testing-rules.md`
- `docs/standards/schema_database.yaml`
- `pom.xml`
- `build.xml`
- `package.json`
- `package-lock.json`
- `src/main/java/`
- `src/main/resources/`
- `src/main/webapp/`
- `scripts/`
- existing repository security outputs such as `.scannerwork/`, `static-analysis-report.md`, and any SARIF or SBOM artifacts found during the audit

## 5. Decisions And Constraints

- treat the repository as the authoritative evidence source unless a safe read-only command produces stronger local evidence
- do not expose raw secret values in chat or artifacts; mask to the minimum needed for identification
- prefer repository-context review over raw scanner output when prioritizing risk
- stop and report if code, docs, and `docs/standards/schema_database.yaml` materially disagree on schema or tenant-boundary assumptions

## 6. Acceptance Criteria

- the audit reports grounded coverage and findings across SAST, secrets, IaC or CI-CD, SCA, and SBOM
- the audit records validation commands actually run and clearly separates validated results from partial coverage
- the audit leaves `audit.md` in this feature-pack home before closeout
- if SBOM generators are available, generated artifacts are written under `artifacts/security/`; otherwise the audit records a provisional inventory and the exact completeness gaps
