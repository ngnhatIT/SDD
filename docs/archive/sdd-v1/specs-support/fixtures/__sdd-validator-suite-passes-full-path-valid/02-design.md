---
id: "fixture-valid-full-path"
title: "Full path validator fixture design"
owner: "SDD Test Suite"
status: "ready-for-implementation"
last_updated: "2026-03-13"
related_specs:
  - "01-requirements.md"
  - "03-data-model.md"
  - "04-api-contract.md"
  - "05-behavior.md"
dependencies:
  - "01-requirements.md"
implementation_refs: []
test_refs:
  - "08-acceptance-criteria.md"
---

# Design

## Overview

- Approach: define one compact full-path feature with explicit contracts and one generated spec-pack.
- Requirement links: `REQ-01`, `REQ-02`

## Current State

- No fixture package exists for contract and spec-pack enforcement tests.

## Target State

- A compact full-path fixture package exists with aligned prose, contracts, and generated pack.

## Impacted Areas

- Backend: one process and one webservice family
- Frontend: none
- Database: one fixture audit entity
- Integrations: generated spec-pack for execution aid coverage

## Design Decisions

| ID | Decision | Requirement Links |
| --- | --- | --- |
| `DES-01` | Keep the fixture endpoint small and synchronous. | `REQ-01` |
| `DES-02` | Treat prose, machine-readable contracts, and the generated spec-pack as one aligned fixture set. | `REQ-02` |

## Source Base Anchors

- Backend process anchor files: `src/main/java/example/full/FixtureExportProcess.java`
- Backend webservice anchor files: `src/main/java/example/full/FixtureExportWebService.java`
- SQL anchor files: `src/main/resources/example/full/fixture-export.sql`
- Frontend .ts anchor files: `n/a`
- Frontend .html anchor files: `n/a`
- Dominant module/style note: Reuse the current backend process plus webservice split and keep the fixture generated-pack content derived directly from the source package.
- New tables/source families/screen structure in scope: `yes` for one additive fixture audit table; `no` for new screen structure.

## Non-Changes

- No shared frontend changes
- No asynchronous job flow
