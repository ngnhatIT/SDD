# Repository Context

## When To Use

Use this file when scoping a change or locating the primary implementation area.

## How To Use

Read it before design work on an unfamiliar module. Use it to identify the backend, frontend, resource, and deployment shape of the repository.

## Required Output

- correct module impact notes in `02-design.md`
- correct folder placement for new code and docs

## Gate

If the touched module family or runtime area is unclear, stop and resolve that before design approval.

## Repository Shape

- Java 8 backend code under `src/main/java`
- Angular frontend code under `src/main/webapp/angular`
- report templates, runtime properties, and supporting assets under `src/main/resources`
- generated or build-related trees such as `bin/` and `target/` already present in repo shape
- WAR packaging and JAX-RS services under `/webapi/*`
- shared frontend transport currently lives in `src/main/webapp/angular/src/app/services/common/webservice.service.ts` and uses jQuery `$.ajax`
- shared frontend registries such as `src/main/webapp/angular/src/app/common/SubWindow.ts` intentionally import feature components
- feature-owned machine-readable contracts live under `docs/specs/<feature-id>/contracts/` when they exist

## Constraints

- naming is strongly influenced by screen or module codes
- shared backend behavior lives under `jp.co.brycen.common` and `jp.co.brycen.kikancen.common`
- business modules are split by screen code and action suffixes such as `search`, `init`, `login`, `update`, `delete`, `csvimport`, and `pdf`
- frontend components mirror backend screen codes under `src/main/webapp/angular/src/app/components`
- backend screen families normally keep thin webservice classes and process-centric business logic
- frontend screens commonly extend `BaseComponent` and reuse shared `<app-table>`, `<wms-page>`, modal, and `DisplayScreenID` patterns
- tracked automated tests are currently scarce; `src/test` and Angular `.spec.ts` coverage are effectively absent, so verification evidence must usually be recorded manually
