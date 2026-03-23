# Context Binding

## When To Use

Use before any DB-related analysis, design, implementation, review, SQL, mapping, entity, DTO, repository, or query work.

## Mandatory Read

Read `docs/sdd/context/schema_database.yaml` before touching the DB-related surface.

## Required Binding

AI MUST identify and record:

- relevant tables
- relevant columns
- mapping consistency between schema, specs, SQL, DTO or entity naming, and repository or query usage

## Forbidden

- guessing schema
- inventing table names
- inventing column names
- claiming mapping alignment without checking the schema file

## Stop Rule

If `docs/sdd/context/schema_database.yaml` is missing, incomplete for the touched surface, or inconsistent with the governing specs or inspected code, stop and report the exact gap or conflict.

## Gate

No DB-related work may proceed until schema binding is explicit and defensible.
