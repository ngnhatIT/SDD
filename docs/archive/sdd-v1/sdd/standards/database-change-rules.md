# Database Change Rules

## When To Use

Use these rules when the change affects SQL, schema, stored logic, data migration, or transactional behavior.

## How To Use

Document the database impact before coding, verify unknown schema facts, and preserve the established SQL and transaction pattern of the touched module family.

## Required Output

- affected tables, queries, and rollback notes recorded in `02-design.md`
- SQL anchor files and dominant local SQL style note recorded in `02-design.md`
- test coverage for normal, failure, and regression-sensitive data scenarios

## Gate

Do not implement a schema or SQL change while table shape, rollback, concurrency behavior, or SQL anchor files are still guessed.

## Rules

- name the affected tables, views, queries, procedures, or data jobs in `02-design.md`
- lock SQL source-base anchors in `02-design.md` (existing process/query files to mirror) before implementation
- review SQL style parity against the named SQL anchor files, not against memory of the module family
- capture data safety, concurrency, tenant or company isolation, and rollback notes before implementation
- do not guess missing schema facts; record them as open questions and block design approval until resolved
- if a schema change is required, document forward and rollback steps in the spec
- add acceptance test cases for normal flow, failure flow, and regression-sensitive data scenarios
- if the database decision will affect multiple future changes, add an ADR
- verify touched tables, views, columns, nullability, and audit fields against `docs/sdd/context/schema_database.yaml` before approving SQL or schema changes
- match the existing inline SQL style for the touched module family
- keep SQL line formatting, alias layout, and clause ordering consistent with the dominant local module pattern
- in backend process families that already build inline SQL in Java, use `StringBuilder` with `.append(...)` rather than long `+`-concatenated SQL fragments
- when the anchor family already splits `SELECT`, `FROM`, `WHERE`, or similar clauses into helper methods or clear blocks, keep that clause-by-clause formatting instead of collapsing it into compressed SQL text
- use bound parameters rather than concatenated user input
- reuse shared schema-backed constants for common DB identifiers or audit fields when the touched family already defines them instead of scattering raw column-name literals
- repeated active search, delete, and API batch families use `AtomicInteger` for mutable sequential bind counters; in new or touched Java process code where parameter position spans branches, loops, batch binds, or helper calls, prefer `AtomicInteger` initialized from `ConstantValue.INDEX/_1` and advance with `getAndIncrement()`
- do not introduce new prepared-statement bind chains that rely on `int index++` when `AtomicInteger` would carry the mutable position more safely
- leave untouched legacy `int index = ConstantValue.INDEX/_1` families in place unless the approved change explicitly includes that cleanup
- when the touched table family already owns `DELFLG`, `ENTUSRCD`, `ENTDATETIME`, `ENTPRG`, `UPDUSRCD`, `UPDDATETIME`, and `UPDPRG`, inserts populate the full set and update or delete paths preserve create-audit columns while refreshing only allowed business columns plus `UPD*`, unless the local import contract explicitly treats upstream metadata as authoritative
- when a local import or sync family intentionally replays external audit metadata on upsert, document that contract and keep the family's existing write pattern instead of mixing it with interactive screen rules
- when a touched query resolves `TMT050` code names, mirror the join target used by the anchor family; where that family already uses `VMT050_ALL`, keep `VMT050_ALL` and its company or language filters rather than reverting to raw `TMT050_NAME`
- if joining `TMT002_USER` for creator or updater data, include the established safe join shape
- match the touched family's audit timestamp function and review note any divergence; do not widen mixed `NOW()` and `SYSDATE(6)` usage casually in audit-column flows
- do not auto-enforce affected-row checks on every normal non-batch `executeUpdate()` unless the touched module already depends on that behavior
- for batch SQL, avoid trailing `;` and check the batch result array
- avoid introducing new row-by-row follow-up queries where the touched family already resolves the data set in one SQL path plus sibling count or detail flows
- preserve local mutation safety for existing-row writes: existence check, delete-state check, update-time comparison, and row lock or shared exclusion-helper parity where that family already uses them
- when a table has paired `checkLink`, `checkDetail`, `getDetail`, `update`, or `delete` flows, compare key, tenant or company, `DELFLG`, active-period, and update-time predicates across the sibling family before changing any one path
- do not replace logical delete with physical delete on `DELFLG` tables unless the governing feature package explicitly changes lifecycle semantics
- do not create new table definitions or new SQL source families unless the governing feature package explicitly requires schema-level change and marks that scope in `02-design.md`

## Counter Examples

Compliant:

```java
AtomicInteger index = new AtomicInteger(ConstantValue.INDEX);
ps.setString(index.getAndIncrement(), cmpnyCd);
ps.setString(index.getAndIncrement(), usrCd);
```

Non-compliant for new or touched mutable bind flows:

```java
int index = ConstantValue.INDEX;
ps.setString(index++, cmpnyCd);
if (useKana) {
    ps.setString(index++, userNmKana);
}
ps.setString(index++, delFlg);
```
