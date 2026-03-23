# Raw Input Normalization

Normalize raw sources before writing governed specs.

## Accepted Source Types

| Source Type | Normalize Into |
| --- | --- |
| ticket or feature request | problem statement, requested outcome, constraints, open questions |
| bug report | observed defect, reproduction conditions, expected behavior, unknown cause |
| spreadsheet or xlsx | field facts, workflow facts, validation facts, unresolved columns or meanings |
| design note | approved decisions, proposed decisions, assumptions, missing approvals |
| bilingual or JP business note | original phrases plus normalized English meaning and unresolved translation gaps |
| chat or meeting note | attributed decisions, attributed requests, explicit unknowns, non-changes |
| approved Sonar triage artifact | issue classifications, decision statuses, approved follow-up scope, blocked items, unresolved approvals |

## Required Normalization Output

- `Facts`: directly supported by the source
- `Open Questions`: unresolved items that still affect safe authoring
- `Non-Changes`: boundaries the source does not authorize changing
- `Approval Gaps`: anything that would need ask-before-break treatment

## Forbidden Moves

- inventing missing columns, fields, routes, or validation rules from a spreadsheet shape
- translating ambiguous notes into firm behavior without recording uncertainty
- treating examples or existing code as approval when the raw input does not authorize the change
- treating a Sonar triage artifact as blanket approval for non-trivial remediation without the normal governed feature-package path
