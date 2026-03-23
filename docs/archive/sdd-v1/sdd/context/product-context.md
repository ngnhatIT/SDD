# Product Context

## Product Shape

`kikancen` is a legacy enterprise business application with a Java backend, Angular frontend, and SQL-heavy data flows. The repo has a modern SDD layer, but the application itself is still organized around long-lived screen, API, and data-handling patterns.

## Common Change Types

- screen behavior and validation changes
- backend process and webservice changes under `/webapi/*`
- SQL query, schema, transaction, and audit-flow changes
- CSV, Excel, PDF, and download/export behavior
- shared code-table, master-data, and permission-sensitive behavior

## Product Constraints That Matter To Delivery

- Naming is often driven by screen codes or module family conventions rather than clean business-domain terms.
- Many changes must preserve parity across frontend behavior, backend process flow, and SQL criteria logic.
- Tenant or company isolation is a recurring constraint whenever data access changes.
- Export and file-output changes often need auditability, explicit limits, and user-safe error handling.
- The repo already assumes spec-governed review and traceability; changes are expected to link back to a feature package.
