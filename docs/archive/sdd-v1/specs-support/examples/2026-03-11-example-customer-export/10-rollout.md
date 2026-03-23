---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging rollout"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "02-design.md"
  - "08-acceptance-criteria.md"
dependencies:
  - "02-design.md"
implementation_refs:
  - "example: db/migration/V20260311__create_customer_export_audit.sql"
test_refs:
  - "09-test-cases.md"
---

# Rollout

## Deployment Order

1. Apply the additive database migration for `crm_customer_export_audit`.
2. Deploy backend services with the new export endpoint and audit persistence.
3. Deploy frontend assets with the `Export CSV` action.
4. Run smoke checks.

## Smoke Checks

- Search with a known filter set and export successfully.
- Attempt export over `10,000` rows and confirm the business message.
- Verify one success audit row and one failed audit row.
- Confirm users without export permission cannot download data.

## Rollback

1. Revert frontend deployment if the button or client handling is broken.
2. Revert backend deployment if export or audit persistence fails.
3. Leave the additive audit table in place; it does not affect existing runtime paths.
4. Re-run the customer search smoke test after rollback.

## Release Risks

- Long-running exports near the row limit
- Audit insert failure blocking otherwise valid exports
- Drift between search and export criteria if query builders diverge

## Monitoring

- Export success count
- Export failure count by error code
- Average export duration
- Audit row growth against retention target

