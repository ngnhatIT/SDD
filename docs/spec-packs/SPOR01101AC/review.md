# SPOR01101AC Review

- Review type: `review`
- Review date: `2026-03-24`
- Feature ID: `SPOR01101AC`
- Feature name: `仕入先発注入力`
- Review scope: `FE + BE + DB`
- Canonical spec: `docs/spec-packs/SPOR01101AC/spec_pack.md`
- DB schema authority: `docs/standards/schema_database.yaml`
- Prompt execution note: the requested wrapper prompt `docs/00_Codex_CICD-CheckPrompt_FeatureLevel_Wrapper_Japanese_v2.md` does not exist in the repository. The wrapper review was therefore grounded on `docs/00_Codex_CICD-CheckPrompt_FeatureLevel_Wrapper_Japanese_v1.md`, while `docs/11_Codex_CICD-CheckPrompt_FrontEnd_Japanese_v2.md`, `docs/12_Codex_CICD-CheckPrompt_BackEnd_Japanese_v2.md`, and `docs/13_Codex_CICD-CheckPrompt_DB_Japanese_v2.md` were available and used.
- Validation note: `scripts/validate-task.py` was not run because no `python` runtime was available in this environment.

## 1. Review scope / constraints

- Feature ID: `SPOR01101AC`
- Feature name: `仕入先発注入力`
- spec_pack path: `docs/spec-packs/SPOR01101AC/spec_pack.md`
- DB schema yaml path: `docs/standards/schema_database.yaml`
- Review scope: `FE+BE+DB`
- Provided inputs:
  - feature spec pack and reinforcement artifact
  - requested FE / BE / DB review prompts `11/12/13 ... v2`
  - repository fallback wrapper prompt `00 ... v1`
  - Angular implementation for `SPOR01101AC`
  - Java search / detail / create / update / trash processes and DTOs
- Missing inputs:
  - requested wrapper prompt `docs/00_Codex_CICD-CheckPrompt_FeatureLevel_Wrapper_Japanese_v2.md`
  - active schema authority entries for `TAOR59_ANACORDERREQUEST`, `TAOR70_ANACORDER`, `TAOR71_REQUESTNOCONTROL`, `TAOR72_ANACORDERHISTRY`, `TAPR04_SCHEDULEDFORDELIVERYFILE`, and `TAPR11_ANACPURCHASESLIPDETAIL`
  - automated test evidence for this feature
- Review constraints:
  - this review is grounded only on active spec, active standards, and inspected code
  - DB-structure sign-off is limited to tables present in `schema_database.yaml`
  - exact reproduction of the requested `00 ... v2` wrapper prompt was not possible from the repository contents
  - validator execution was blocked by the missing Python runtime
- Other layers: `Not in scope`

## 2. Feature-level review (Wrapper)

### Feature understanding summary

- The feature is a dual-area screen: a search/list surface for `ANAC発注依頼` requests and an input area for existing-detail update or new-detail registration.
- Governed states are `Init`, `Search`, `Trash search`, `Existing detail edit`, and `New detail`.
- The spec explicitly constrains behavior by permission mode, deadline cutoff, release override, qty-only edit for existing details, and formula-based amount calculation.

### Scenario / state summary

- `Init`: clear search and input defaults.
- `Search`: factory required, three date pairs validated, list rendered with alarm count and planned payment amount.
- `Trash search`: same list surface, but trash rows become the target set and trash button semantics invert to restore.
- `Existing detail edit`: opened from `発注番号`; only `発注数` should remain editable.
- `New detail`: opened from `新規`; only fields intended for new registration should be editable.

### AC traceability

- AC-01 Search requires factory and complete date-pair validation: partially implemented, but broken by `F4`.
- AC-02 Release-valid rows remain actionable after cutoff and are surfaced first/red: partially implemented, but broken by `F3`.
- AC-03 Existing detail edit is qty-only: broken by `F1`.
- AC-04 `発注金額 = 発注数 x 発注単価`: partially implemented in FE, but broken end-to-end by `F1` and `F2`.
- AC-05 Bulk update creates downstream order/schedule data from selected rows: at risk because of `F2`, `F3`, and `F7`.
- AC-06 Permission modes `更新可能 / 閲覧のみ / 使用不能` are enforced: broken by `F6`.

### Feature-level findings

- `F1` Existing-detail mode is not constrained to qty-only update.
- `F2` The edited quantity is not the quantity that search/detail/bulk-update logic reads.
- `F3` Deadline-release behavior is inconsistent across FE and BE.
- `F4` Search date validation/message routing and SQL filtering do not match the governed search contract.
- `F5` Supplier-search UI is rendered but not wired.
- `F6` Function-level permission modes are not implemented end-to-end.
- `F7` Bulk update does not apply the governed supplier fallback path.
- `F8` Active schema authority does not cover the main transaction tables used by this feature.
- `F9` No automated coverage was found for the core flows.

### Guidance for FE / BE / DB deep review

- FE review should focus on input enablement, modal wiring, permission gating, and whether the UI truly models the state contract.
- BE review should focus on source-of-truth fields, deadline/release validation, search semantics, and fallback/master-data rules.
- DB review should focus on whether the active schema authority can defend the table structure and whether migration/release steps are needed for quantity and supplier consistency.

### Pre-release checks

- Reconcile one canonical quantity field across detail save, search, and bulk update.
- Enforce the same deadline-release policy in UI state and backend validation.
- Lock existing-detail mode down to qty-only editing.
- Restore governed permission handling for `閲覧のみ` and `使用不能`.
- Confirm supplier fallback behavior for blank request suppliers before bulk generation.
- Publish or update active schema authority for the main transaction tables before DB sign-off.

### Areas reviewed and found safe

- Search and input forms already contain basic required/max-length/date validation surfaces on the FE.
- Trash / restore semantics are implemented as an `ORDERCATEGORY` toggle in the backend.
- New-detail registration uses a consistent default constant set in `Spor01101acCreateNewProcess`.
- Master-table authority exists for `TAMT024_PARTNERSTORE`, `TAMT026_PRODUCTAGREEMENT`, and `TAMT029_GROUP`.

### Easy-to-miss points

- The list sort does not explicitly prioritize release rows first even though the UI colors them red.
- `approvalStatus` is expected by the FE but is not present in the detail response DTO.
- Search target/status logic contains extra backend branches that are not clearly grounded by the spec.

### Spec questions needing confirmation

- Are the extra backend search-target branches intentionally governed, or should they be removed?
- Should the displayed/requested number for this screen always follow the spec-preferred `R` path, or is mixed `R/P` behavior approved elsewhere?
- Should `発注金額` be strictly read-only everywhere because the spec defines it as a formula field?

## 3. FrontEnd review

### Scenario / state summary

- The FE supports search, row selection, trash/update actions, detail opening from the list, and new registration in one component.
- The UI models some state flags such as `isUpdateDisabled`, `isBtnTrashSubmitDisabled`, and the deadline banner, but those flags do not cover all governed behavior.

### End-to-end consistency check

- FE breaks the existing-detail contract (`F1`), deadline-release contract (`F3`), supplier modal contract (`F5`), and permission contract (`F6`).
- FE search validation largely exists, but the backend search contract mismatch in `F4` means the user can still get unexpected results after a valid submission.

### Findings

- `F1` Existing-detail mode sets `isUpdateDisabled = true` in `spor01101ac.component.ts:1484`, but supplier, quantity, unit price, and amount fields remain editable in `spor01101ac.component.html:511-512`, `spor01101ac.component.html:583-584`, `spor01101ac.component.html:618-619`, and `spor01101ac.component.html:651-652`.
- `F3` The FE only displays deadline information via `deadLineTime` in `spor01101ac.component.ts:1315` and `spor01101ac.component.html:257`, but it does not model the governed lock/release behavior.
- `F5` Supplier search fields are rendered in search and input areas, but unlike section/group/procurement, there is no supplier button click binding in the template around `spor01101ac.component.html:111-123` and `spor01101ac.component.html:506-519`.
- `F6` Route access is open at `wms-routing.module.ts:376`, the base redirect is commented at `base.component.ts:114`, and the feature component contains no evidence of distinct `更新可能 / 閲覧のみ / 使用不能` mode handling.

### Missing tests / test proposals

- Component test for existing-detail mode proving that only quantity remains editable.
- E2E test covering post-cutoff behavior for a normal row and a release-valid row.
- UI test proving supplier-search modal launch from both search and input areas.
- Permission test proving `閲覧のみ` disables mutating controls and `使用不能` cannot open the screen.

### Areas safe

- FE has basic required/date/max-length validation hooks for search and detail inputs.
- FE supports section, group, and procurement lookup modals in both search and input contexts.

### Easy-to-miss points

- `orderAmountInput` is user-editable even though FE also recalculates it on blur.
- The FE posts `approvalStatus` and `orderAmountInput` as if both were trustworthy detail payload fields.

### Spec questions

- Should supplier search be modal-only, code-entry-only, or both?
- Should the amount field be read-only with formatting only, not validation as a user input?

## 4. BackEnd review

### Scenario / state summary

- The backend covers search, count summary, detail retrieval, create/update confirmation, bulk update, alarm refresh, and trash/restore.
- The main logic risk is not missing endpoints; it is disagreement between spec intent and the fields/conditions the backend actually uses.

### End-to-end consistency check

- BE breaks governed behavior in `F1`, `F2`, `F3`, `F4`, and `F7`.
- BE also introduces unsupported behavior via extra search-target branching, which increases regression and compatibility risk even where the UI looks stable.

### Findings

- `F1` `Spor01101acCreateUpdateProcess` updates more than quantity, including `PARTNERCD` and `ORDERREQUESTQTYCHANGES`, starting at `Spor01101acCreateUpdateProcess.java:38-41`, while `Spor01101acCreateProcess` only checks approval status when it is non-empty at `Spor01101acCreateProcess.java:86`.
- `F2` Search and detail read `ORDERREQUESTQTY` in `Spor01101acSearchAllRecProcess.java:252,504` and `Spor01101acGetDetailProcess.java:83,142,231`, but existing-detail save writes `ORDERREQUESTQTYCHANGES` in `Spor01101acCreateUpdateProcess.java:41`, and bulk update groups on `SUM(TAOR59.ORDERREQUESTQTY)` in `Spor01101acUpdateProcess.java:481`.
- `F3` Deadline validation rejects rows after cutoff in `Spor01101acCreateProcess.java:247-249` and `Spor01101acUpdateProcess.java:92-94`, but the spec explicitly keeps release-valid rows actionable.
- `F4` Delivery-date validation writes the wrong message field in `Spor01101acSearchAllRecProcess.java:69`, and the three date ranges are OR-combined instead of independently applied in `Spor01101acSearchAllRecProcess.java:211-221`.
- `F7` Supplier fallback is missing because `getAgreeMent` returns no data when `partnerCdInput` is empty in `Spor01101acCreateProcess.java:191` and `Spor01101acUpdateAlarmProcess.java:213`, while bulk update joins agreements only on `TAOR59.PARTNERCD` at `Spor01101acUpdateProcess.java:556`.

### Missing tests / test proposals

- Service/integration test proving existing-detail update cannot change non-qty fields.
- Repository/service test proving quantity edits affect the same quantity field used by search, detail, and bulk update.
- Search contract test covering all three date pairs simultaneously and validating message routing.
- Deadline/release contract test covering normal rows vs release-valid rows after cutoff.
- Supplier fallback test covering blank request supplier plus agreement-master fallback.

### Areas safe

- Count summary behavior for alert count and planned payment amount is implemented separately from list rendering.
- Trash / restore processing is explicit and easy to reason about as an `ORDERCATEGORY` update.
- New registration uses a consistent request-number prefix path via `TYPEPREFIXREQUEST = "R"`.

### Easy-to-miss points

- The detail DTO omits `approvalStatus`, which weakens a later backend guard rather than failing loudly.
- The backend sort is deadline-based, not explicitly release-flag-based, so release rows are not guaranteed to lead the list by the same rule the UI presents.

### Spec questions

- Which quantity column is canonical for the screen contract: `ORDERREQUESTQTY` or `ORDERREQUESTQTYCHANGES`?
- Are the extra search-target states in backend code approved anywhere in active docs?

## 5. DB review

### Scenario / state summary

- The feature touches agreement/group/store master tables plus multiple transaction tables for request, order, numbering, history, schedule, and purchase-slip detail.
- The active schema authority only covers the master-table side of that footprint.

### End-to-end consistency check

- DB confidence is materially limited by `F8`.
- The quantity-field split in `F2`, deadline policy drift in `F3`, and supplier fallback gap in `F7` all create DB-level consistency and rollout risk.

### Findings

- `F2` Existing-detail updates write `ORDERREQUESTQTYCHANGES`, but search/detail/bulk-update keep using `ORDERREQUESTQTY`, so persisted state can diverge across workflows.
- `F7` When request supplier is blank, the governed agreement fallback path is not implemented consistently, so downstream order-generation records can miss the intended supplier source.
- `F8` `schema_database.yaml` confirms `tamt024_partnerstore` at line 587, `tamt026_productagreement` at line 1417, and `tamt029_group` at line 1885, but it does not contain the main transaction tables that this feature reads and writes.

### Validation points

- Authority confirmed: `TAMT024_PARTNERSTORE`, `TAMT026_PRODUCTAGREEMENT`, `TAMT029_GROUP`.
- Authority missing: `TAOR59_ANACORDERREQUEST`, `TAOR70_ANACORDER`, `TAOR71_REQUESTNOCONTROL`, `TAOR72_ANACORDERHISTRY`, `TAPR04_SCHEDULEDFORDELIVERYFILE`, `TAPR11_ANACPURCHASESLIPDETAIL`.
- Because those tables are absent from the active authority file, DB structure, constraints, and column-level sign-off for the main transaction flow are not defensible from the governed surface alone.

### Missing tests / test proposals

- Integration test proving quantity persistence stays consistent across request detail, list search, and generated order rows.
- Integration test covering bulk update with blank request supplier and agreement fallback.
- Data-level regression test for post-cutoff release-valid rows.

### Release / migration procedure proposals

- Publish or restore active schema authority entries for every transaction table this feature uses before release approval.
- Run a one-time consistency query comparing `ORDERREQUESTQTY` and `ORDERREQUESTQTYCHANGES` on existing feature data before rollout.
- Dry-run bulk update in a release-valid scenario and a non-release scenario before production deployment.
- Add a rollback note for any hotfix that changes quantity-field mapping or supplier fallback, because both affect downstream generated records.

### Areas safe

- The master-data dependencies visible in this feature are represented in the active schema authority.
- Trash / restore appears to be a logical state change, not a destructive delete path.

### Easy-to-miss points

- The authority gap is not cosmetic; it blocks defendable DB sign-off for the core transaction path.
- The quantity split is a data-contract issue, not only an application-layer bug.

### Spec questions

- Should the schema authority be updated as part of this feature, or is there another active governed source for the missing transaction tables?
- Is there any approved data-migration strategy for reconciling old rows if quantity-field mapping changes?

## 6. Cross-layer issues

### FE / BE / DB mismatches

- `F1` FE exposes editable fields that the spec forbids in existing-detail mode, while BE also persists non-qty fields and does not receive a reliable approval-status contract.
- `F2` FE lets the user edit quantity and amount, but BE reads and groups a different quantity field than the one update writes.
- `F3` FE presents deadline information as a banner, while BE applies a hard rejection that does not honor the governed release override.
- `F7` FE/BE allow blank supplier paths, but DB-side generation logic does not consistently recover supplier data from the agreement master.

### Hidden regression risks

- Users can believe an edited quantity was saved even though later search/bulk update still uses the pre-edit quantity source.
- Rows that should remain actionable after deadline can be blocked at confirmation time, creating operational rollback pressure.
- Permission drift can let read-only or forbidden users reach mutation-capable surfaces without a formal mode model.

### Compatibility / migration / rollout risks

- The schema-authority gap prevents a defensible DB approval for the main transaction path.
- Any fix to quantity-field alignment can change downstream generated order totals and should be treated as a compatibility-sensitive change.
- The absence of automated tests raises the probability of silent regressions in search, deadline, and bulk-update flows.

## 7. Consolidated findings

### F1

- Severity: `Blocker`
- Title: Existing-detail mode is not qty-only and the approval-status guard is incomplete
- Scenario: user opens an existing row from the list, edits fields beyond quantity, and confirms.
- Why: the spec restricts existing-detail edit to `発注数` only, but FE leaves multiple fields editable and BE persists non-qty columns.
- Evidence: FE sets `isUpdateDisabled` in `src/main/webapp/angular/src/app/components/spor01101ac/spor01101ac.component.ts:1484`, yet editable inputs remain in `src/main/webapp/angular/src/app/components/spor01101ac/spor01101ac.component.html:511-512`, `src/main/webapp/angular/src/app/components/spor01101ac/spor01101ac.component.html:583-584`, `src/main/webapp/angular/src/app/components/spor01101ac/spor01101ac.component.html:618-619`, and `src/main/webapp/angular/src/app/components/spor01101ac/spor01101ac.component.html:651-652`. BE updates non-qty fields in `src/main/java/jp/co/brycen/kikancen/spor01101accreate/process/Spor01101acCreateUpdateProcess.java:38-41`, and approval-status validation is conditional in `src/main/java/jp/co/brycen/kikancen/spor01101accreate/process/Spor01101acCreateProcess.java:86`.
- Affected layers: `FE + BE`
- Fix: lock all non-qty fields in existing-detail mode, return `approvalStatus` explicitly in the detail response if it is part of the contract, and reject non-qty mutations server-side.
- Validation: open an existing row and verify that only quantity is editable and only quantity changes are accepted server-side.
- Test: component test for control disablement plus service test for server-side field immutability.
- Confidence: `High`
- Release gate: `Must fix before release`

### F2

- Severity: `Blocker`
- Title: Quantity source of truth is split between update, detail, search, and bulk update
- Scenario: user edits quantity in existing detail, saves, searches again, and then performs bulk update.
- Why: the workflow can show one quantity in detail/save while downstream search and generation still use another column.
- Evidence: update writes `ORDERREQUESTQTYCHANGES` in `src/main/java/jp/co/brycen/kikancen/spor01101accreate/process/Spor01101acCreateUpdateProcess.java:41`; detail reads `ORDERREQUESTQTY` in `src/main/java/jp/co/brycen/kikancen/spor01101acgetdetail/process/Spor01101acGetDetailProcess.java:83`, `:142`, `:231`; search reads `ORDERREQUESTQTY` in `src/main/java/jp/co/brycen/kikancen/spor01101acsearch/process/Spor01101acSearchAllRecProcess.java:252`, `:504`; bulk update groups `SUM(TAOR59.ORDERREQUESTQTY)` in `src/main/java/jp/co/brycen/kikancen/spor01101acupdate/process/Spor01101acUpdateProcess.java:481`.
- Affected layers: `BE + DB`
- Fix: choose one governed quantity source and align detail save, detail fetch, search, and bulk generation to it.
- Validation: save a quantity edit, reload detail, reload search, and bulk-generate order data from that row.
- Test: integration test covering edit -> search -> bulk update on the same row.
- Confidence: `High`
- Release gate: `Must fix before release`

### F3

- Severity: `Blocker`
- Title: Deadline-release policy is inconsistent between UI behavior and backend validation
- Scenario: user works with a row that is after the normal cutoff but still release-valid by group deadline-release rules.
- Why: the spec explicitly keeps release-valid rows actionable after cutoff, but FE only shows a banner and BE still rejects by cutoff logic.
- Evidence: FE only surfaces `deadLineTime` in `src/main/webapp/angular/src/app/components/spor01101ac/spor01101ac.component.ts:1315` and `src/main/webapp/angular/src/app/components/spor01101ac/spor01101ac.component.html:257`. BE uses cutoff checks in `src/main/java/jp/co/brycen/kikancen/spor01101accreate/process/Spor01101acCreateProcess.java:247-249` and `src/main/java/jp/co/brycen/kikancen/spor01101acupdate/process/Spor01101acUpdateProcess.java:92-94`.
- Affected layers: `FE + BE + DB`
- Fix: implement one shared release policy so the FE lock state and BE validation agree on normal rows vs release-valid rows.
- Validation: test both before-cutoff and after-cutoff flows for normal rows and release-valid rows.
- Test: end-to-end scenario test for post-cutoff release override.
- Confidence: `High`
- Release gate: `Must fix before release`

### F4

- Severity: `Major`
- Title: Search date validation and filtering do not match the governed three-range search contract
- Scenario: user enters valid values for one or more of the three date pairs and expects the list to respect all provided ranges independently.
- Why: wrong error routing confuses the UI, and OR-combined SQL can return rows that satisfy only one date range instead of all supplied filters.
- Evidence: delivery-date validation writes to `orderDateSearchMessage` in `src/main/java/jp/co/brycen/kikancen/spor01101acsearch/process/Spor01101acSearchAllRecProcess.java:69`. The search query OR-combines the three ranges in `src/main/java/jp/co/brycen/kikancen/spor01101acsearch/process/Spor01101acSearchAllRecProcess.java:211-221`.
- Affected layers: `BE`
- Fix: route delivery-date validation to the correct message field and apply each provided date range as its own AND filter.
- Validation: execute search cases for each date pair alone and then in combination.
- Test: repository/service tests for date-filter combinations and message routing.
- Confidence: `High`
- Release gate: `Must fix before release`

### F5

- Severity: `Major`
- Title: Supplier-search UI is rendered but not wired
- Scenario: user tries to search supplier from search criteria or input detail the same way they can search section, group, or procurement item.
- Why: the UI advertises a lookup capability that is not actually invokable from the rendered buttons.
- Evidence: section/group/procurement buttons are wired at `src/main/webapp/angular/src/app/components/spor01101ac/spor01101ac.component.html:35`, `:54`, `:137`, `:369`, `:393`, `:459`, but no equivalent supplier click binding exists around `src/main/webapp/angular/src/app/components/spor01101ac/spor01101ac.component.html:111-123` and `:506-519`.
- Affected layers: `FE`
- Fix: add supplier modal/button handlers for both search and input contexts or remove the button affordance if the feature is intentionally unsupported.
- Validation: open supplier lookup from both contexts and confirm the selected value populates code and name.
- Test: component or E2E test for supplier lookup from search and detail.
- Confidence: `High`
- Release gate: `Must fix before release`

### F6

- Severity: `Major`
- Title: Permission modes are not implemented end-to-end
- Scenario: a user with `閲覧のみ` or `使用不能` permission accesses the screen.
- Why: the spec gives distinct behavior for all three permission modes, but the current route/base/component setup does not show evidence of enforcing them.
- Evidence: the feature route is directly exposed in `src/main/webapp/angular/src/app/wms-routing.module.ts:376`, the base redirect is commented in `src/main/webapp/angular/src/app/components/common/base/base.component.ts:114`, and the feature component only exposes local enable/disable flags, not a governed permission-mode model.
- Affected layers: `FE`
- Fix: restore or implement explicit permission gating for screen access and mutating controls.
- Validation: verify behavior separately for `更新可能`, `閲覧のみ`, and `使用不能`.
- Test: route/access-control tests plus UI-state tests per permission mode.
- Confidence: `Medium`
- Release gate: `Must fix before release`

### F7

- Severity: `Major`
- Title: Bulk update misses the governed supplier fallback when request supplier is blank
- Scenario: a selected row has no request supplier but agreement master data could still define the supplier context for downstream generation.
- Why: the current logic drops out early or joins only on request supplier, so generated data can miss the governed fallback source.
- Evidence: `getAgreeMent` returns empty when `partnerCdInput` is blank in `src/main/java/jp/co/brycen/kikancen/spor01101accreate/process/Spor01101acCreateProcess.java:191` and `src/main/java/jp/co/brycen/kikancen/spor01101acupdate/process/Spor01101acUpdateAlarmProcess.java:213`. Bulk update joins agreements using `TAOR59.PARTNERCD` in `src/main/java/jp/co/brycen/kikancen/spor01101acupdate/process/Spor01101acUpdateProcess.java:556`.
- Affected layers: `BE + DB`
- Fix: implement the governed agreement-master fallback path for blank request suppliers in create, alarm refresh, and bulk generation.
- Validation: run the same scenario with blank request supplier and confirm generated rows still resolve supplier data correctly.
- Test: integration test for supplier fallback during bulk update.
- Confidence: `Medium`
- Release gate: `Must fix before release`

### F8

- Severity: `Major`
- Title: Active DB schema authority does not cover the main transaction tables used by the feature
- Scenario: the feature is reviewed or released with DB sign-off expected from active governed sources.
- Why: DB approval cannot be defended when the active authority file omits the main tables the feature reads and writes.
- Evidence: `docs/standards/schema_database.yaml` contains `tamt024_partnerstore` at line 587, `tamt026_productagreement` at line 1417, and `tamt029_group` at line 1885, but no entries were found for `TAOR59_ANACORDERREQUEST`, `TAOR70_ANACORDER`, `TAOR71_REQUESTNOCONTROL`, `TAOR72_ANACORDERHISTRY`, `TAPR04_SCHEDULEDFORDELIVERYFILE`, or `TAPR11_ANACPURCHASESLIPDETAIL`.
- Affected layers: `DB`
- Fix: publish active authority entries or another active governed source for all transaction tables touched by this feature.
- Validation: rerun DB review against the updated authority source.
- Test: n/a until the authority gap is closed.
- Confidence: `High`
- Release gate: `Must fix before release`

### F9

- Severity: `Major`
- Title: No automated coverage exists for the core feature flows
- Scenario: search, existing-detail edit, deadline/release behavior, and bulk update change over time.
- Why: the feature already contains cross-layer contract drift, and no automated tests were found to catch regressions.
- Evidence: no feature-specific FE or BE test matches were found for `SPOR01101AC` / `Spor01101ac` under `src/test` and Angular spec files.
- Affected layers: `FE + BE + DB`
- Fix: add focused FE, service, and integration tests around the governed flows that are currently drifting.
- Validation: run the new automated suite on every change touching this feature.
- Test: add tests for `F1` through `F7` priority scenarios.
- Confidence: `High`
- Release gate: `Should fix before release`

## 8. Final conclusion

- Must fix:
  - `F1`, `F2`, `F3`, `F4`, `F5`, `F6`, `F7`, `F8`
- Should fix:
  - `F9`
  - remove or formally govern extra backend search-target/status branches
- Nice to have:
  - clarify `R` vs `P` numbering ambiguity in active docs
  - make amount explicitly read-only if the formula rule is intended to be strict
- Final release readiness: `Not ready`
- Remaining spec points to confirm:
  - canonical quantity field for this screen contract
  - approved permission model implementation path
  - approved source for the missing DB transaction-table authority
