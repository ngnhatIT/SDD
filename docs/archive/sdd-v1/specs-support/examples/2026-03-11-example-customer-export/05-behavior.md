---
id: "2026-03-11-example-customer-export"
title: "Example customer search CSV export with audit logging behavior"
owner: "CRM Delivery Team"
status: "done"
last_updated: "2026-03-11"
related_specs:
  - "01-requirements.md"
  - "02-design.md"
dependencies:
  - "01-requirements.md"
implementation_refs:
  - "example: src/main/webapp/angular/src/app/components/customer-search/customer-search.component.html"
  - "example: src/main/webapp/angular/src/app/components/customer-search/customer-search.component.ts"
test_refs:
  - "09-test-cases.md"
---

# Behavior

## Preconditions

- User is on the customer search screen.
- Search filters are available on screen.
- User has the export permission assigned for this screen.

## Screen Behavior

| Scenario | Expected behavior |
| --- | --- |
| Search has results and user has permission | `Export CSV` button is enabled |
| Search has zero results | `Export CSV` button is disabled |
| Export in progress | Button is disabled and loading indicator is shown |
| Export succeeds | Browser downloads the CSV file |
| Export blocked by row limit | Screen shows a business error message and no file is downloaded |
| Export fails unexpectedly | Screen shows a user-safe generic error message and re-enables the button |

## User Flow

1. User runs a search.
2. User confirms the result set.
3. User clicks `Export CSV`.
4. Screen freezes only the export action, not the full page.
5. On success, the file download starts and the button returns to enabled state.
6. On failure, the button returns to enabled state and the screen shows the message.

## User Messages

| Condition | Message |
| --- | --- |
| Over limit | `Export is limited to 10,000 rows. Narrow the search criteria and try again.` |
| Forbidden | `You do not have permission to export this data.` |
| Unexpected failure | `Export could not be completed. Try again later or contact support.` |

