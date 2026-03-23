# API Contract

## Owned Contracts

- `contracts/openapi.yaml`
- `contracts/schemas/sppm00061-search-request.schema.json`
- `contracts/schemas/sppm00061-search-response.schema.json`

## Compatibility

- Compatibility class: `additive`
- Affected consumers: `src/main/webapp/angular/src/app/components/sppm00061/sppm00061.component.ts`, the existing `SPPM00061` search webservices, and the shared CSV export flow that reuses the search request

## Request Change

- Add `expiredOnly` as an optional boolean field on the existing search request.
- Omitted or null values behave as `false`.

## Response Notes

- The response shape does not require a new top-level contract object.
- Existing expiry date information is sufficient for the screen to visually mark expired rows.

## Validation Rules

- Reject non-boolean values when the request passes through a typed contract boundary.
- Preserve existing validation, authorization, company, and tenant rules.
