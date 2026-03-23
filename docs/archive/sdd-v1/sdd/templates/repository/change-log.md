---
id: "<change-log-entry-id>"
title: "<release or change summary>"
owner: "<team or person>"
status: "draft"
last_updated: "YYYY-MM-DD"
related_specs:
  - "docs/specs/<feature-id>/README.md"
dependencies: []
implementation_refs: []
test_refs:
  - "docs/specs/<feature-id>/12-review-report.md"
---

# Change Log Entry

Use with: `docs/sdd/templates/feature-package/10-rollout.md`, `docs/sdd/templates/feature-package/12-review-report.md`, repository `CHANGELOG.md`

## Required Sections

- Date
- Change Summary
- References

## Optional Sections

- Rollout Notes

## Date (Required)

- Release date: `<YYYY-MM-DD>`

## Change Summary (Required)

### Added

- `<new month filter on order search>`

### Changed

- `<search API accepts optional closingMonth>`

### Fixed

- `<invalid month input now returns validation feedback>`

## References (Required)

- Spec folder: `<docs/specs/<feature-id>/`
- Related ADRs: `<ADR-0001 or none>`
- Review report: `<docs/specs/<feature-id>/12-review-report.md>`

## Rollout Notes (Optional)

- `<feature enabled after backend and frontend deploy completed>`
