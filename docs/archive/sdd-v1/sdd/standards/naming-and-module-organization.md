# Naming And Module Organization

## When To Use

Use this file when adding files to an existing module family or naming a new class, DTO, process, or component.

## How To Use

Follow the dominant local naming and folder pattern unless the governing feature package or ADR explicitly changes it.

## Required Output

- new files placed beside the correct screen or action family
- naming choices explained in `02-design.md` when the local pattern cannot be followed

## Gate

Do not introduce a new naming or package pattern silently.

## Repeated Naming Patterns

- backend feature packages use screen and action codes such as `spcm00101login`, `spmt00241search`, and `spvw00031pdf`
- a base screen package often contains shared DTOs, row DTOs, condition DTOs, or constants
- action packages usually contain `dto`, `process`, and `webservice` subfolders
- request and response DTO names are family-based: many backend packages use `*RequestDto` and `*ResponseDto`, while older families also use `*Request` and `*Response`
- process classes usually end in `Process`, `AllRecProcess`, `RecCntProcess`, `OutputPdfProcess`, or `DownloadPdfProcess`
- frontend component filenames usually mirror screen codes such as `spcm00101.component.ts`

## Naming Rules

- preserve the approved screen or API code exactly and mirror the touched family's existing action suffixes
- place new files beside the touched family instead of introducing `controller`, `repository`, `facade`, or `adapter` folders by generic preference
- mirror the touched family's DTO naming and shape instead of inventing a repository-wide DTO pattern
- preserve existing legacy identifiers in place when they are already part of the local family; do not widen unrelated work into a repo-wide rename
- live naming drift such as `Webservice`, `Regist`, `serach`, or mixed-case action suffixes may remain only in place; new files, classes, and docs should use the dominant healthy spelling from sibling anchors such as `WebService`, `Register`, and `search`
- shared registries may import feature components, but ordinary services or common helpers must remain component-agnostic
