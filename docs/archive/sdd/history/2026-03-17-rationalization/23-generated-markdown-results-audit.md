# Generated Markdown Results Audit

## 1. Objective

Audit markdown files that were produced as SDD execution outputs, generated execution aids, intermediate plans, cleanup artifacts, or one-off result documents, and separate them from canonical framework documents.

This audit focuses on generated or stage-output markdown only. It does not reclassify canonical governance, process, standards, or template files.

Audit date: `2026-03-17`

## 2. Scope And Method

1. Reused the active operating contract and current cleanup records:
   `AGENTS.md`, `docs/sdd/README.md`, `docs/sdd/governance.md`, `docs/specs/README.md`,
   `docs/sdd/governance/20-markdown-cleanup-inventory.md`,
   `docs/sdd/process/21-markdown-cleanup-plan.md`,
   and `docs/sdd/governance/22-markdown-cleanup-changelog.md`.
2. Enumerated markdown files in these result-heavy areas:
   `docs/spec-packs/`, `docs/archive/spec-results/`, `docs/specs/**/11-implementation-report.md`,
   `docs/specs/**/12-review-report.md`, `docs/archive/reviews/`, `docs/sdd/governance/`,
   `docs/sdd/process/`, and `docs/archive/sdd/history/`.
3. Treated a file as a generated or result artifact when it was one of:
   generated spec-pack or execution brief output, implementation-stage output, review-stage output,
   cleanup inventory or plan, historical audit report, migration ledger, or change-execution changelog.
4. Checked whether each file still has a living role:
   approval traceability, example or validator support, active cleanup governance, or historical audit retention.

Candidate result-file totals reviewed:

- Generated packs and briefs: `10`
- Implementation and review reports: `17`
- Cleanup and historical result artifacts: `9`
- Total generated/result markdown files in scope: `36`

## 3. Classification Rules

- `KEEP-ACTIVE`: the file is a generated output, but it still has an active role as governed traceability evidence, an intentional example, or a validator fixture.
- `ARCHIVE`: the file still has historical or audit value, but it should not remain in the active working surface.
- `DELETE-CANDIDATE`: the file is a generated artifact with no source package, no manifest, no meaningful active references, and no credible traceability obligation.
- `TRACEABILITY-SENSITIVE`: a keep or archive decision that should not be converted to delete without explicit evidence that approvals, reviews, or audit history remain intact elsewhere.

Interpretation rules used in this audit:

- Review reports inside a governing feature package are treated as approval evidence, not clutter.
- Implementation reports inside a governing feature package are treated as delivery evidence, not clutter.
- Generated packs and briefs stay active only when they are deliberate examples, fixtures, or current execution aids.
- Historical one-off plans, audits, and cleanup notes belong in `docs/archive/`, not the active framework surface.

## 4. Generated Result File Inventory

| File | Generated During SDD Run | Traceability Value | Still Referenced | Proposed Action | Reason |
| --- | --- | --- | --- | --- | --- |
| `docs/spec-packs/2026-03-11-example-customer-export.implement-new.brief.md` | Yes; generated execution brief | Medium | Yes | KEEP-ACTIVE | Referenced by the execution-brief generator feature and serves as the canonical example brief output. |
| `docs/spec-packs/2026-03-11-example-customer-export.pack.md` | Yes; generated spec-pack | High | Yes | KEEP-ACTIVE | Long-lived sample pack tied to the example customer export feature and generator documentation. |
| `docs/spec-packs/example-feature.implement-new.brief.md` | Yes; generated execution brief | Medium | Yes | KEEP-ACTIVE | Intentional example brief used by the SDD2+ example layer. |
| `docs/spec-packs/example-feature.pack.md` | Yes; generated spec-pack | High | Yes | KEEP-ACTIVE | Intentional example pack referenced broadly by the example feature and upgrade docs. |
| `docs/spec-packs/__sdd-validator-suite-fails-classification-mismatch.pack.md` | Yes; generated validator spec-pack | High | Yes | KEEP-ACTIVE | Validator fixture output; operationally useful for validation-suite coverage. |
| `docs/spec-packs/__sdd-validator-suite-fails-contract-reference.pack.md` | Yes; generated validator spec-pack | High | Yes | KEEP-ACTIVE | Validator fixture output; operationally useful for validation-suite coverage. |
| `docs/spec-packs/__sdd-validator-suite-fails-spec-pack-drift.pack.md` | Yes; generated validator spec-pack | High | Yes | KEEP-ACTIVE | Validator fixture output; operationally useful for validation-suite coverage. |
| `docs/spec-packs/__sdd-validator-suite-passes-full-path-valid.pack.md` | Yes; generated validator spec-pack | High | Yes | KEEP-ACTIVE | Validator fixture output; operationally useful for validation-suite coverage. |
| `docs/archive/spec-results/briefs/2026-03-13-spec-graph-extractor.implement-new.brief.md` | Yes; generated execution brief | Medium | Yes | ARCHIVE | Historical generated brief with no continuing active role; correctly retained in archive only. |
| `docs/spec-packs/SPMT00101AC.md` | Yes; ad hoc generated spec-pack | Low | No meaningful workflow refs | DELETE-CANDIDATE | No owning feature package, no `spec-pack.manifest.yaml`, no canonical traceability chain, and only audit docs mention it. |
| `docs/specs/2026-03-11-example-customer-export/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Required delivery evidence inside an active governed feature package. |
| `docs/specs/2026-03-11-example-customer-export/12-review-report.md` | Yes; review-stage output | High | Yes | KEEP-ACTIVE | Required review evidence inside an active governed feature package. |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Governing traceability evidence for the repository bootstrap feature package. |
| `docs/specs/2026-03-11-repository-sdd-bootstrap/12-review-report.md` | Yes; review-stage output | High | Yes | KEEP-ACTIVE | Governing review evidence for the repository bootstrap feature package. |
| `docs/specs/2026-03-13-execution-brief-generator/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Delivery evidence for the execution-brief generator feature. |
| `docs/specs/2026-03-13-sdd-governance-hardening/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Delivery evidence for the governance-hardening feature package. |
| `docs/specs/2026-03-13-sdd-governance-hardening/12-review-report.md` | Yes; review-stage output | High | Yes | KEEP-ACTIVE | Review evidence for the governance-hardening feature package. |
| `docs/specs/2026-03-13-spec-graph-extractor/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Delivery evidence for the spec-graph extractor feature package. |
| `docs/specs/2026-03-13-spor00701ac-draft/12-review-report.md` | Yes; retrospective review-stage output | High | Yes | KEEP-ACTIVE | Only formal review evidence tied to the retrospective SPOR00701AC draft package. |
| `docs/specs/2026-03-13-task-profile-routing/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Delivery evidence for the task-profile-routing feature package. |
| `docs/specs/2026-03-13-task-profile-routing/12-review-report.md` | Yes; review-stage output | High | Yes | KEEP-ACTIVE | Review evidence for the task-profile-routing feature package. |
| `docs/specs/2026-03-16-codebase-derived-rule-calibration/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Delivery evidence for the rule-calibration feature package. |
| `docs/specs/2026-03-16-repository-rule-sweep/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Delivery evidence for the repository rule-sweep feature package. |
| `docs/specs/2026-03-16-sdd2-plus-framework-upgrade/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Delivery evidence for the SDD2+ framework upgrade package. |
| `docs/specs/2026-03-17-sdd-framework-rationalization/11-implementation-report.md` | Yes; implementation-stage output | High | Yes | KEEP-ACTIVE | Delivery evidence for the framework rationalization package. |
| `docs/archive/reviews/2026-03-13-spor00101ac-review-from-rules/12-review-report.md` | Yes; review-stage output | High | Yes | ARCHIVE | Review-only evidence with no governing feature package; archive preserves audit history without polluting `docs/specs/`. |
| `docs/archive/reviews/2026-03-13-spor01401ac-review/12-review-report.md` | Yes; review-stage output | High | Yes | ARCHIVE | Review-only evidence with no governing feature package; archive preserves audit history without polluting `docs/specs/`. |
| `docs/sdd/governance/20-markdown-cleanup-inventory.md` | Yes; audit output | High | Yes | KEEP-ACTIVE | Current cleanup baseline still referenced by the active SDD playbook and follow-up governance work. |
| `docs/sdd/process/21-markdown-cleanup-plan.md` | Yes; cleanup planning output | High | Yes | KEEP-ACTIVE | Approved execution basis for the cleanup already performed; still useful during follow-up governance work. |
| `docs/sdd/governance/22-markdown-cleanup-changelog.md` | Yes; cleanup execution output | High | Yes | KEEP-ACTIVE | Current active record of archive moves, reference updates, and unresolved boundaries. |
| `docs/archive/sdd/history/2026-03-17-rationalization/10-prompt-template-simplification-report.md` | Yes; rationalization report | Medium | Yes | ARCHIVE | One-off framework simplification result with historical value only. |
| `docs/archive/sdd/history/2026-03-17-rationalization/10-sdd-framework-audit-report.md` | Yes; framework audit output | High | Yes | ARCHIVE | Historical audit baseline; still referenced for provenance, but no longer active governance. |
| `docs/archive/sdd/history/2026-03-17-rationalization/11-sdd-framework-cleanup-migration-plan.md` | Yes; migration/cleanup plan output | High | Yes | ARCHIVE | Historical cleanup-planning artifact; correctly preserved outside active process docs. |
| `docs/archive/sdd/history/2026-03-17-rationalization/cleanup-changelog.md` | Yes; execution changelog | Medium | Yes | ARCHIVE | Historical cleanup log from the earlier rationalization pass. |
| `docs/archive/sdd/history/migration/migration-notes.md` | Yes; migration note output | Medium | Yes | ARCHIVE | Historical migration summary with audit value only. |
| `docs/archive/sdd/history/migration/migration-plan.md` | Yes; migration ledger output | Medium | Yes | ARCHIVE | Historical migration ledger with audit value only. |

## 5. Keep, Archive, And Delete Recommendations

### Keep-Active

- `26` files should remain active.
- These are not framework-definition files, but they still have a live role as:
  governed implementation evidence,
  governed review evidence,
  example execution aids,
  validator fixtures,
  or the currently active cleanup record set.

### Archive

- `9` files should remain archived.
- These are valuable as history, audit baseline, or review-only evidence, but they do not belong in the active SDD surface.

### Delete-Candidate

- `1` file currently qualifies:
  `docs/spec-packs/SPMT00101AC.md`
- It is the only in-scope artifact that is both generated and structurally orphaned.

## 6. Traceability-Sensitive Files

These generated result files should not be deleted even though they are outputs, because they still anchor approvals, implementation history, or review evidence:

- All `docs/specs/**/11-implementation-report.md` files in governed feature packages.
- All `docs/specs/**/12-review-report.md` files in governed feature packages.
- `docs/archive/reviews/2026-03-13-spor00101ac-review-from-rules/12-review-report.md`
- `docs/archive/reviews/2026-03-13-spor01401ac-review/12-review-report.md`
- `docs/sdd/governance/20-markdown-cleanup-inventory.md`
- `docs/sdd/process/21-markdown-cleanup-plan.md`
- `docs/sdd/governance/22-markdown-cleanup-changelog.md`

## 7. Stale Clutter Patterns

### A. One-Off Generated Packs Land In The Same Directory As Long-Lived Examples

`docs/spec-packs/` currently mixes:

- intentional examples
- validator fixtures
- current execution aids
- orphan ad hoc outputs

This is the main clutter source for generated markdown.

### B. Review-Only Evidence Starts Life Under `docs/specs/`

When a rules-only review has no governing feature package, writing the report under `docs/specs/` makes the folder look canonical even when it is not.

### C. Cleanup Audits And Plans Accumulate In Active `docs/sdd/`

Cleanup inventory, plans, and changelogs are useful during the cleanup cycle, but they are stage outputs, not long-term framework definitions.

### D. Generated Files Lack Explicit Retention Metadata

Most generated outputs do not state whether they are:

- example fixtures
- validator fixtures
- current execution aids
- archive-only history
- disposable temporary output

That omission increases later cleanup ambiguity.

## 8. Recommended Archive Locations

Use these archive targets consistently for future generated markdown residue:

| Artifact type | Recommended location | Why |
| --- | --- | --- |
| one-off execution briefs | `docs/archive/spec-results/briefs/` | separates stale generated briefs from active `docs/spec-packs/` examples |
| stale or superseded generated spec-packs | `docs/archive/spec-results/packs/` | prevents ad hoc packs from living beside validator and example packs |
| review-only evidence without a governing feature package | `docs/archive/reviews/<review-id>/` | preserves audit history without masquerading as a canonical spec package |
| completed framework audits, cleanup plans, and migration notes | `docs/archive/sdd/history/<date-topic>/` | keeps one-off governance outputs available but out of the active read path |

## 9. Safe Delete Candidates

| File | Why it is a delete candidate | Safer fallback if delete is not approved |
| --- | --- | --- |
| `docs/spec-packs/SPMT00101AC.md` | orphan generated spec-pack; no governing feature package; no manifest; no current execution role; only mentioned by cleanup audit docs | move to `docs/archive/spec-results/packs/SPMT00101AC.md` if the team wants maximum caution instead of deletion |

No other in-scope generated markdown file currently meets the same confidence bar for deletion.

## 10. Process Changes To Reduce Future Markdown Residue

1. Add front matter to every generated markdown output with:
   `generator`, `source_feature`, `output_class`, and `retention_class`.
2. Reserve `docs/spec-packs/` for:
   active examples, validator fixtures, and current execution aids only.
   Route one-off generated packs and briefs to `docs/archive/spec-results/` by default.
3. Change `review-from-rules` output routing so that reviews without a governing feature package write directly to `docs/archive/reviews/`.
4. Require every generated pack to map back to either:
   `docs/specs/<feature-id>/` plus `spec-pack.manifest.yaml`,
   or an explicit validator/example designation.
   If neither exists, treat the output as archive-or-delete by default.
5. After each cleanup or framework audit cycle closes, move its inventory, plan, and changelog triad into `docs/archive/sdd/history/` and leave only an active summary pointer.

## 11. Final Summary

1. Generated markdown files that still have value are:
   example spec-packs and briefs,
   validator-pack outputs,
   implementation reports inside governed feature packages,
   review reports inside governed feature packages,
   and the current cleanup inventory-plan-changelog triad.
2. Files that should live in archive are:
   historical framework audits and cleanup plans,
   migration notes and ledgers,
   the archived spec-graph extractor brief,
   and review-only evidence that has no governing feature package.
3. The only current safe delete candidate is:
   `docs/spec-packs/SPMT00101AC.md`.
4. The recurring clutter patterns are:
   mixed-use `docs/spec-packs/`,
   review-only reports created under `docs/specs/`,
   and cleanup-stage outputs staying in active `docs/sdd/` longer than needed.
5. Future markdown residue will drop if generators emit retention metadata, route one-off outputs straight to archive, and require every generated pack to prove either feature ownership or explicit example/fixture status.
