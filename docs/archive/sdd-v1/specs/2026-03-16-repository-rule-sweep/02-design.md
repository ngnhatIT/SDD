---
id: "2026-03-16-repository-rule-sweep"
title: "Repository-wide rule sweep design"
owner: "Codex"
status: "in-progress"
last_updated: "2026-03-16"
related_specs:
  - "01-requirements.md"
  - "07-tasks.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "AGENTS.md"
  - "docs/sdd/standards/backend-change-rules.md"
  - "docs/sdd/standards/frontend-change-rules.md"
  - "docs/sdd/standards/security-validation-and-logging.md"
  - "docs/sdd/checklists/06-code-review-against-spec.md"
  - "docs/sdd/checklists/07-qa-validation.md"
  - "docs/sdd/governance/04-review-rules.md"
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: derive only repository-wide rules that are supported by multiple code areas, multiple review findings, or clear shared foundations.
- Requirement links: `REQ-01`, `REQ-02`, `REQ-03`, `REQ-04`, `REQ-05`, `REQ-06`

## Current State

- Backend runtime behavior is concentrated in `process` classes that inherit shared lifecycle from `jp.co.brycen.common` and `jp.co.brycen.kikancen.common`.
- Frontend runtime behavior is concentrated in large Angular components that rely on shared services, a common base component, and `callWs(...)` transport wrappers.
- Review reports show repeated drift risk around delete or active filters, duplicated validation, silent frontend catches, and contract-by-implementation APIs.
- No meaningful `src/test` tree or Angular `.spec.ts` coverage was found in the current repository, so manual verification evidence is often the only realistic regression proof.

## Target State

- Root operating rules tell implementers to check sibling flows, cross-layer validation parity, and constant reuse before changing code.
- Standards formalize the highest-risk recurring patterns without inventing new architecture.
- Review and QA guidance explicitly check contract gaps, silent transport failures, sibling-flow parity, and manual regression evidence where automated tests are absent.

## Impacted Areas

- Backend: rule guidance only
- Frontend: rule guidance only
- Contracts: review guidance only
- Testing and QA: checklist guidance only
- Runtime code, schema, and APIs: no change

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Add root operating rules for sibling-flow SQL parity, frontend or backend validation parity, constant-catalog scanning, explicit contract-gap handling, and manual regression evidence. | `REQ-01`, `REQ-06` |
| `DES-02` | Add backend rule text that makes sibling-flow parity explicit for shared tables and module families. | `REQ-02` |
| `DES-03` | Add frontend rule text that blocks new silent `.catch(...)` handling and requires explicit parity management when frontend mirrors backend validation. | `REQ-03` |
| `DES-04` | Add validation guidance stating that duplicated frontend and backend validation must be reviewed together, with backend remaining authoritative. | `REQ-04` |
| `DES-05` | Add review-checklist items for sibling-flow parity, silent catches, cross-layer validation parity, contract gaps, and missing automated tests. | `REQ-05`, `REQ-06` |
| `DES-06` | Add QA and review-rule guidance that treats manual regression evidence as mandatory when automated tests do not exist in the touched area. | `REQ-06` |

## Source Base Anchors

- Backend process anchor files: `src/main/java/jp/co/brycen/common/process/AbstractProcess.java`, `src/main/java/jp/co/brycen/common/process/AbstractAPIProcess.java`, `src/main/java/jp/co/brycen/kikancen/api/bcc0030ac/process/Bcc0030acProcess.java`, `src/main/java/jp/co/brycen/kikancen/spmt01102accsvimport/process/Spmt01102ACCsvImportProcess.java`
- Backend webservice anchor files: `src/main/java/jp/co/brycen/common/webservice/AbstractWebService.java`, `src/main/java/jp/co/brycen/kikancen/api/bcc0030ac/webservice/Bcc0030acWebService.java`
- SQL anchor files: `src/main/java/jp/co/brycen/common/database/DBAccessor.java`, `src/main/java/jp/co/brycen/kikancen/api/common/service/ApiExportProcessHelper.java`, `src/main/java/jp/co/brycen/kikancen/api/bcc0030ac/process/Bcc0030acProcess.java`, `src/main/java/jp/co/brycen/kikancen/spmt01102accsvimport/process/Spmt01102ACCsvImportProcess.java`
- Frontend .ts anchor files: `src/main/webapp/angular/src/app/components/common/base/base.component.ts`, `src/main/webapp/angular/src/app/services/common/webservice.service.ts`, `src/main/webapp/angular/src/app/services/common/search-condition-management.service.ts`, `src/main/webapp/angular/src/app/wms-routing.module.ts`
- Frontend .html anchor files: `n/a (this rule sweep did not derive new template-structure rules from `.html` changes)`
- Dominant module/style note: Preserve the existing process plus webservice backend structure and shared-service frontend structure; add drift-prevention guardrails instead of inventing repository, service-layer, or route-normalization rules.
- New tables/source families/screen structure in scope: `no`

## Supporting Evidence

- Review-evidence anchors: `docs/archive/reviews/2026-03-13-spor01401ac-review/12-review-report.md`, `docs/archive/reviews/2026-03-13-spor00101ac-review-from-rules/12-review-report.md`
- Build and test anchors: `pom.xml`, `src/main/webapp/angular/package.json`, `build.xml`, `build.properties`
- Test-footprint anchors: repository scan results showing `src/test` is absent and Angular `.spec.ts` files are absent

## Rejected Generalizations

- Do not force all APIs to gain machine-readable contracts immediately; current review evidence supports explicit gap tracking, not an unconditional repo-wide mandate.
- Do not force all frontend transport code to the same route or state-management style; the live frontend is already large and inconsistent in those areas.
- Do not force one SQL or lookup normalization beyond the repeated rules already grounded in the current codebase.

## Non-Changes

- No runtime Java, Angular, SQL, or contract files change
- No feature-specific behavior changes
- No `agent/` bridge rule changes in this scope
