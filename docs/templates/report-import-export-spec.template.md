# Report/Import/Export Spec: <function-id> - <title>

- Status: draft | approved | implemented
- Function Type: `report-import-export`
- Owner: <team-or-person>
- Last Updated: YYYY-MM-DD
- Originating Pack: `docs/spec-packs/<feature-id>/spec_pack.md`
- Related ADRs: `none` | `docs/decisions/ADR-XXXX-<slug>.md`

## Purpose

- describe file-oriented or generated-output work in mapping-focused detail without forcing it into a generic API or screen template

## Use When

- the dominant behavior is a report, download, upload, import, export, or other file or render surface
- source or target mapping, filters, format, naming, encoding, limits, or reconciliation are the main risk

## Do Not Use When

- the dominant risk is a pure UI flow with no file or mapping surface
- the work is a background orchestration problem better described as a batch or job

## Mandatory Sections

- `Traceability`
- `Mode And Business Context`
- `Source, Target, And Mapping`
- `Selection Or Input Rules`
- `Format, Naming, And Encoding`
- `Processing Limits, Performance, And Partial Failure Rules`
- `Errors, Audit, And Reconciliation`
- `Risks And Open Questions`

## Optional Sections

- sample row or sample file references
- retention or archive handling
- downstream consumer notes

## Review Focus

- mapping completeness and field ownership
- format, delimiter, encoding, and file-name stability
- row limits, performance, and partial-failure behavior
- auditability, reject handling, and reconciliation

## Typical Risks If Omitted

- missing or incorrect field mappings
- unreadable or incompatible files in production
- imports that fail without actionable reject output
- exports or reports that cannot be reconciled after release

## 1. Traceability

| Field | Required | Value |
| --- | --- | --- |
| Source requirement or ticket | yes | |
| Originating pack | yes | `docs/spec-packs/<feature-id>/spec_pack.md` |
| Report, import, or export id | yes | |
| Related ADRs | conditional | `none` |
| Implementation refs | yes | |
| Validation or evidence refs | yes | |
| Release or change note | no | |

## 2. Mode And Business Context

- mode: `report` | `import` | `export`
- primary actor or trigger:
- business outcome:

## 3. Source, Target, And Mapping

| Source Field Or Input | Target Field Or Output | Transformation | Notes |
| --- | --- | --- | --- |
| | | | |

## 4. Selection Or Input Rules

- filters or selection rules:
- input file rules:
- permission or scope limits:

## 5. Format, Naming, And Encoding

- file or render format:
- file naming rule:
- encoding, delimiter, locale, or timezone rule:

## 6. Processing Limits, Performance, And Partial Failure Rules

- row or size limits:
- performance expectations:
- partial-failure or reject-row handling:

## 7. Errors, Audit, And Reconciliation

- user or operator-visible errors:
- audit trail or history records:
- reconciliation or follow-up checks:

## 8. Risks And Open Questions

- risk or open question
