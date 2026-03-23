---
id: "fixture-valid-full-path"
title: "Full path validator fixture API contract"
owner: "SDD Test Suite"
status: "ready-for-implementation"
last_updated: "2026-03-13"
related_specs:
  - "02-design.md"
  - "03-data-model.md"
dependencies:
  - "02-design.md"
implementation_refs: []
test_refs:
  - "09-test-cases.md"
---

# API Contract

## Endpoint

- Method: `POST`
- Path: `/webapi/fixture/export`
- Auth: existing authenticated session

## Request

| Field | Type | Required | Notes |
| --- | --- | --- | --- |
| `fixtureId` | string | yes | Fixture export target |

## Success Response

| Field | Value |
| --- | --- |
| Status | `200 OK` |
| Content-Type | `text/csv` |

## Error Response

| Status | Code | Meaning |
| --- | --- | --- |
| `400` | `FIXTURE_INVALID_REQUEST` | Request body is invalid |

## Compatibility Rules

- Request fields remain explicit.
- Response stays synchronous for the fixture.

## Machine-Readable Contract Files

- `contracts/openapi.yaml`
- `contracts/schemas/fixture-export-request.schema.json`
