# Codebase Conformance Rules

## Purpose

Keep `implement`, `fix`, and `review` work inside proven repository patterns. This standard strengthens lean SDD v2 without restoring archived v1 artifacts or authority paths.

## When To Use

Use when work touches code, DTOs, transports, SQL, file placement, module structure, or review findings about local pattern drift. Use it with layer-specific standards, not instead of them.

## Core Rules

- start from the touched local family, not from a generic best-practice pattern
- mirror the dominant sibling pattern for naming, folder placement, module split, DTO shape, process flow, transport path, validation path, and SQL style
- treat mixed or legacy patterns as local exceptions, not as permission to invent a third pattern
- do not widen a behavior-only change into structural redesign without explicit approval in `spec_pack.md` or an ADR
- record conformance-critical decisions in the active `spec_pack.md`, not in a parallel document

## Anchor Identification Rules

- before implementation or scope-expanding fix work, identify concrete source anchors for each touched layer in `spec_pack.md`
- use the existing `## 4. Technical Shape -> ### Source Anchors` section to name backend, frontend, DB or SQL, contract, or shared-common anchor files
- anchors must be real repository paths or `n/a`, not placeholders or generic folder names
- inspect enough sibling evidence to defend the claimed dominant pattern
- use `### Planned Shape` or `## 5. Decisions And Constraints` to record any approved exception, new family creation, or structural divergence
- review work must verify the change against the same anchors or record why they were insufficient

## Reuse-Before-Create Rules

- check the touched family and nearby shared or common paths before adding a new helper, DTO, component, service, process, constant, SQL family, or transport path
- reuse existing shared helpers, constants, message catalogs, base or common flows, and sibling family structure when they already solve the same concern
- prefer extending the existing family over creating a parallel file, folder, or abstraction for the same behavior
- a new reusable abstraction is allowed only when the current family cannot safely absorb the change and the approved spec or ADR explicitly opens that scope
- minimal patch size is not a valid reason to extend a weaker local duplicate inside a touched scope that already has a stronger shared path

## No-New-Layer-By-Preference Rules

- do not introduce new controller, repository, facade, adapter, store, hook, view-model, helper, or similar layers by generic preference
- do not introduce a new naming, package, folder, or source-family pattern silently
- new structure is allowed only when the touched family already uses it, `spec_pack.md` explicitly authorizes it, or an accepted ADR explicitly authorizes it
- behavior-only work must stay inside the existing family shape unless the approved scope says otherwise

## Stop Conditions

- stop if the local family or contract owner cannot be identified from active docs and inspected code
- stop if anchor files are missing, contradictory, placeholder-like, or too weak to defend the next step
- stop if the change would require a new layer, naming pattern, package pattern, or source family that is not explicitly approved
- stop if shared reuse was not checked and the next step would create a parallel local path for an existing concern
- stop if sibling flows show no defensible dominant pattern and the next decision would be guesswork
- stop if implementation or review finds conformance drift that the active pack does not authorize

## Review Implications

- `review` treats ungrounded structure changes, silent new layers, silent new naming patterns, missed reuse, and sibling-parity drift as findings, not style notes
- `implement` and `fix` verification records any approved exception or unresolved conformance risk
- when behavior, DTO, validation, transport, or SQL logic changes, review checks nearby sibling flows for parity instead of only the edited file
- if review cannot defend the chosen pattern from anchors and inspected siblings, the review fails or records a blocking uncertainty

## Minimal Examples Of Acceptable Vs Unacceptable Behavior

Acceptable:

- a fix reuses the touched screen family's existing component, service, and DTO split and records sibling anchors in `spec_pack.md`
- a backend change mirrors the family's existing `webservice/` -> `process/` -> `dto/` flow instead of adding a new repository layer
- a SQL change follows the touched family's existing assembly and parameter-binding style

Unacceptable:

- a small fix adds a new `repository/` or `store/` layer because it feels cleaner
- a change picks one weak legacy file as precedent while ignoring stronger sibling patterns in the same family
- a reviewer accepts a new DTO or transport path without checking whether the touched family already has a proven shared path
