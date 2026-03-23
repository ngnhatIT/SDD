# Touched-Scope Enforcement

Use this shared checklist during design, implementation, self-review, and formal review.

## Source And Reuse

- [ ] Source-base anchors were inspected before introducing a new abstraction, helper, route, DTO, component, class, interface, or module split.
- [ ] Shared helpers, constants, message catalogs, base-common flows, repository or service patterns, and validation paths were checked before adding local duplicates.
- [ ] Mixed live patterns were classified as `preferred current pattern`, `tolerated legacy pattern`, or `required migration pattern`.

## Hygiene

- [ ] Unused imports were removed from touched files.
- [ ] Redundant code, dead branches, and commented-out placeholder blocks were removed from the touched scope when safe.
- [ ] Formatting and local structure match the named anchors.
- [ ] New or rewritten comments are English-only and minimal.

## Frontend And UX Parity

- [ ] Touched frontend structure matches the sibling screen-family pattern.
- [ ] Responsive smaller-window behavior was checked for touched forms, filters, or result areas.
- [ ] Paired range rows such as FROM-TO remain aligned and usable where applicable.
- [ ] Field-level versus popup error-routing parity was preserved or the divergence is explicitly approved.
- [ ] Frontend-backend validation parity was checked when both layers own the same rule family.

## Backend, Service, And Helper Reuse

- [ ] Touched backend validation, focus-out, shared process, repository, or helper usage follows the existing architecture for that family.
- [ ] Search, count, detail, update, delete, export, import, or sibling lifecycle parity was checked when the family already owns those flows.

## Data And Contracts

- [ ] DB-related work was bound to `docs/sdd/context/schema_database.yaml`.
- [ ] Table, column, nullability, audit-field, and mapping parity was checked when DB-related scope exists.
- [ ] No contract, schema, file-shape, or externally visible behavior change was made without explicit approval.
