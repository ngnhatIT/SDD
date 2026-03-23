---
id: "2026-03-13-spor00701ac-draft"
title: "SPOR00701AC observed-behavior draft review report"
owner: "Codex"
status: "done"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
  - "03-data-model.md"
  - "04-api-contract.md"
  - "05-behavior.md"
  - "06-edge-cases.md"
  - "08-acceptance-criteria.md"
  - "09-test-cases.md"
dependencies:
  - "11-implementation-report.md"
implementation_refs:
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateNewProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateSaveProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701accreate/process/spor00701acCreateCopyProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/spor00701acupdate/process/spor00701acUpdateProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/common/process/MasterNameGetProcess.java"
  - "src/main/java/jp/co/brycen/kikancen/common/process/MasterCheckExclusionProcess.java"
  - "src/main/webapp/angular/src/app/components/spor00701ac/spor00701ac.component.ts"
test_refs:
  - "09-test-cases.md"
---

# Review Report

## Review Scope

- Reviewed spec files: `README.md`, `01-requirements.md`, `02-design.md`, `03-data-model.md`, `04-api-contract.md`, `05-behavior.md`, `06-edge-cases.md`, `07-tasks.md`, `08-acceptance-criteria.md`, `09-test-cases.md`, `10-rollout.md`
- Reviewed code refs: `spor00701ac.component.ts`, `spor00701acCreateProcess.java`, `spor00701acCreateNewProcess.java`, `spor00701acCreateSaveProcess.java`, `spor00701acCreateCopyProcess.java`, `spor00701acUpdateProcess.java`, `MasterNameGetProcess.java`, `MasterCheckExclusionProcess.java`
- Reviewed test refs: `TC-01` through `TC-11` as planned coverage only
- Review method: static source review against the retrospective draft package

## Findings

| ID | Severity | Spec Link | Summary | Status |
| --- | --- | --- | --- | --- |
| `REV-01` | `high` | `REQ-03`, `REQ-05`, `AC-03`, `AC-05` | `spor00701acCreateProcess.validateProductCdExistsMaster(...)` calls `MasterNameGetProcess.getProductAgreementNm(...)`, but that helper does not filter by the submitted `PRODUCTCD`. Product validation can pass on store/partner/company scope alone. | `open` |
| `REV-02` | `high` | `REQ-04`, `DES-03`, `AC-04` | `MasterCheckExclusionProcess.setResponse(...)` does not add an error when the queried row no longer exists. Missing-row cases can fall through silently instead of returning deleted-data behavior. | `open` |
| `REV-03` | `high` | `REQ-03`, `AC-03`, `TC-09` | The delete success callback in `spor00701ac.component.ts` uses `ME000063`, whose message text means the row has already been deleted. The user-facing result is semantically wrong after successful delete. | `open` |
| `REV-04` | `high` | `REQ-03`, `REQ-05`, `AC-03`, `AC-05` | Alarm-related persistence is inconsistent across mutation flows. `CreateNew` binds `alarmInput` into `AIRLN`, `CreateSave` clears alarm fields, `CreateCopy` preserves `ALARM` but clears `ALARMKBN`, and `Update` ignores alarm fields entirely. | `open` |
| `REV-05` | `medium` | `REQ-03`, `AC-03`, `TC-07` | `CreateCopy` preserves source `ORDERREQUESTDATE`, `ORDERREQUESTUSER`, `ENTPRG`, and `UPDPRG` while also stamping current-user data into other fields. Copy metadata behavior is internally inconsistent and may break audit expectations. | `open` |
| `REV-06` | `medium` | `REQ-06`, `DES-05`, `AC-06` | Temporary-save confirmation reuses the copy confirmation message by replacing text fragments in `MQ000013`. This is brittle localization and wording logic, even if it happens to work today. | `open` |
| `REV-07` | `high` | `AC-01`, `AC-02`, `AC-03`, `AC-04`, `AC-05`, `09-test-cases.md` | Formal review evidence is incomplete. No `11-implementation-report.md` exists for this legacy implementation, no `SPOR00701AC`-specific automated tests were found, and this review did not execute runtime verification against `TC-01` through `TC-11`. | `open` |

## Evidence Gaps

- `11-implementation-report.md` does not exist because the runtime implementation predates this draft feature package.
- No `SPOR00701AC`-specific backend or Angular automated tests were found in the repository.
- This review did not run `TC-01` through `TC-11`; acceptance coverage remains planned rather than proven.

## Verdict

- Verdict: `fail`
- Acceptance coverage: `AC-01` through `AC-06` are documented by the draft package, but not proven by implementation evidence in this review stage
- Release recommendation: `not ready`
- Blocking findings: `REV-01`, `REV-02`, `REV-03`, `REV-04`, `REV-07`

## Open Questions

- Should warning text persist into `AIRLN`, `ALARM`, both, or neither across all mutation paths?
- Should copied rows inherit the original request metadata, or should copy always stamp new request metadata?
- Should missing-row handling in `MasterCheckExclusionProcess.setResponse(...)` be corrected for all consumers, not only `SPOR00701AC`?

## Follow-Up Actions

- Create `11-implementation-report.md` or equivalent verification evidence mapped to `TC-01` through `TC-11`.
- Triage and fix `REV-01` through `REV-04` before treating current implementation as approvable behavior.
- Resolve the contract for alarm persistence and copy metadata, then update both prose spec and implementation consistently.
- Re-run review after verification evidence exists and blockers are resolved.
