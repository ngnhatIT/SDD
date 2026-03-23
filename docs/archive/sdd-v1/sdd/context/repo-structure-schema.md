# Repository Structure Schema

## When To Use

Use this file during SDD review to classify the touched repository area before evaluating code shape, contract obligations, and test expectations.

## How To Use

1. Identify the primary touched family.
2. Apply the matching mandatory structure rules first.
3. Treat recommended structure as the default review target.
4. Treat legacy tolerated structure as existing debt, not as approval guidance for new patterns.

## Required Output

- touched structure family
- expected mandatory folders and artifacts
- deviation notes when implementation crosses family boundaries

## Gate

If the touched implementation cannot be classified into one of the repository families below, stop review and resolve the structure mismatch first.

## Structure Families

### Mandatory Structure

#### Repository Root

- `docs/specs/` is the canonical human-authored feature package area for governed work.
- `docs/sdd/` is the canonical governance and context area.
- `src/main/java/` is the backend implementation area.
- `src/main/webapp/angular/` is the Angular frontend implementation area.
- `src/main/resources/` is the runtime resource area.
- `src/main/webapp/WEB-INF/` is the bundled web artifact and library area used by the current WAR packaging.

#### Backend Shared Common Family

- Shared backend infrastructure lives under `src/main/java/jp/co/brycen/common/`.
- Application-shared backend behavior lives under `src/main/java/jp/co/brycen/kikancen/common/`.
- Cross-cutting behavior such as auth checks, process lifecycle, DTO base classes, DB wrappers, and shared utilities should attach to these common families rather than to one screen package.

#### Backend Screen Family

- Screen-oriented backend modules live under `src/main/java/jp/co/brycen/kikancen/<screen-or-screen+action>/`.
- Base screen packages such as `spcm00101/` or `spvw10311/` may hold constants, row DTOs, condition DTOs, and shared screen DTOs.
- Action-specific packages such as `spcm00101login/`, `spvw10311search/`, or `spvw10321csv/` are the normal place for request DTOs, response DTOs, process classes, and web services.

#### Backend API Family

- API-oriented modules live under `src/main/java/jp/co/brycen/kikancen/api/<api-code>/`.
- API modules use sibling `dto/`, `process/`, and `webservice/` folders.
- Some API modules also use a sibling `service/` folder for query constants and API-local helper logic.

#### Frontend Screen Family

- Angular screens live under `src/main/webapp/angular/src/app/components/<screen-code>/`.
- Shared frontend UI pieces live under `src/main/webapp/angular/src/app/components/common/`.
- Shared frontend services live under `src/main/webapp/angular/src/app/services/common/`.
- Screen-family or function-family singleton services may live under `src/main/webapp/angular/src/app/services/<family>/`.
- The main Angular shell is currently centered on `wms.module.ts` and `wms-routing.module.ts`.

### Recommended Structure

- Keep one review scope inside one primary family unless the governing feature package explicitly spans frontend, backend, and contract changes together.
- For screen-family backend changes, preserve the existing base-screen package plus action-package split instead of moving all code into one folder.
- For API-family backend changes, keep API code inside `api/<api-code>/` and do not mix it into screen-style `sp*` packages.
- For frontend work, reuse the existing `components/<screen-code>/`, `services/common/`, and `common/DisplayScreenId.ts` structure before adding new shared folders.
- For governed changes, align touched repo areas with the impacted areas listed in `02-design.md`, `07-tasks.md`, `08-acceptance-criteria.md`, and `09-test-cases.md`.

### Legacy Tolerated Structure

- `target/` exists in the repository shape and may appear during review, but it is not a source-of-truth implementation area.
- `src/main/webapp/angular/node_modules/` and `src/main/webapp/angular/.angular/` are present in the current repository shape, but reviewers should treat them as environmental baggage, not as design inputs.
- Bundled JARs under `src/main/webapp/WEB-INF/lib/` are part of the current runtime shape and must not be removed during unrelated work.
- Retained legacy bridge roots such as `agent/` may appear in some working trees, but they are not the canonical review source when `docs/` already answers the question.

## Reviewer Classification Rules

- If the change touches `docs/specs/<feature-id>/`, review it as feature-package structure.
- If the change touches `contracts/` under a feature package, review it as machine-readable contract structure in the same feature scope.
- If the change touches `src/main/java/jp/co/brycen/kikancen/api/`, review it against API-family structure, not screen-family structure.
- If the change touches `src/main/java/jp/co/brycen/kikancen/sp*`, `tmt*`, `tsm*`, or similar screen-coded packages, review it against screen-family structure.
- If the change touches `src/main/webapp/angular/src/app/components/`, review it against frontend screen structure and shared transport/error-handling rules.

## Deviation Signals

- A backend screen change that introduces a new package pattern without matching the surrounding screen family is a structure deviation.
- An API change that bypasses the `api/<code>/` family and lands in screen-style packages is a structure deviation.
- A governed feature that changes contracts but only updates prose or only updates machine-readable files is a structure deviation.
- A frontend change that adds a new screen without route integration, `DisplayScreenID` alignment, or shared service usage is a structure deviation.
