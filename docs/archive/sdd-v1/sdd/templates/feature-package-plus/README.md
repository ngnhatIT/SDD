# SDD2+ Feature Package Add-On

Use this folder together with `docs/sdd/templates/feature-package/`.

Purpose:

- keep the baseline SDD2 numbered scaffold unchanged
- add SDD2+ companion artifacts only when the feature needs them

Use these templates when:

- the feature has delivery, release, migration, or regression risks that should stay visible
- local design decisions should be preserved without promoting them to an ADR

Do not add these files by default when the feature does not need them.

Copy these files into the feature package when applicable:

- `13-risk-log.md`
- `14-decision-notes.md`

Do not use this folder to replace the required numbered package files.
