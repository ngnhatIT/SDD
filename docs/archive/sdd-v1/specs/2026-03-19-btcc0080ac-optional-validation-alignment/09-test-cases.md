---
id: "2026-03-19-btcc0080ac-optional-validation-alignment"
title: "BTCC0080AC optional-field validation alignment test cases"
owner: "Kikancen API Team"
status: "in-progress"
last_updated: "2026-03-21"
related_specs:
  - "08-acceptance-criteria.md"
---

# Test Cases

| ID | Acceptance Links | Type | Test case | Expected result |
| --- | --- | --- | --- | --- |
| `TC-01` | `AC-01`, `AC-03` | Static review | Inspect the `BTCC0080AC` static rule map and process supplement after the fix. | Optional nullable fields are not marked required, and the remaining key validation is still present. |
| `TC-02` | `AC-01`, `AC-02` | Manual regression | Re-run a `BTCC0080AC` payload that omits optional fields and does not send `templateFlg`. | No `Please enter data into required control` error is returned for those optional omissions, and `templateFlg` does not appear in the error list. |
| `TC-03` | `AC-03`, `AC-04` | Static review | Inspect `Btcc0080acProcess` validation flow after the patch. | Date-range and non-negative custom validators remain intact, and any added key check is limited to the conflicting alias case only. |
| `TC-04` | `AC-04` | Build | Run backend compile for the touched scope. | Build passes without `BTCC0080AC` compile regressions. |
| `TC-05` | `AC-01`, `AC-02`, `AC-03` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_allowsOptionalTemplateFlgAndHaigoSeihinCd`. | Omitted `templateFlg` and omitted `mHaigoKoseiHdrs.seihinCd` do not produce required-validation errors. |
| `TC-06` | `AC-03`, `AC-04` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_keepsSeihinCdRequiredForZairyoKosei`. | `mZairyoKoseiSs.seihinCd` still produces the required-validation error when omitted. |
| `TC-07` | `AC-01`, `AC-03`, `AC-04` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_allowsDeleteHaigoWithoutSeihinCd`. | Omitted `delete.mHaigoKoseiHdrs.seihinCd` does not produce a required-validation error. |
| `TC-08` | `AC-03`, `AC-04` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_keepsSeihinCdRequiredForDeleteZairyoKosei`. | `delete.mZairyoKoseiSs.seihinCd` still produces the required-validation error when omitted. |
| `TC-09` | `AC-04` | Automated process validation | Run `Btcc0080acProcessValidationTest.validateRequestData_allowsValidDeletePayloadWithoutErrors`. | The delete path remains stable for valid payloads after the optional-field calibration. |
| `TC-10` | `AC-01`, `AC-02`, `AC-03` | Webservice JSON integration | POST external JSON to `/api/Bcc0080ac` through `Btcc0080acWebServiceJsonIntegrationTest.search_acceptsExternalJsonAndPreservesOptionalFields` and `Btcc0080acWebServiceJsonIntegrationTest.search_acceptsDeleteHaigoWithoutSeihinCdForExternalJson`. | Omitted `templateFlg` and omitted `mHaigoKoseiHdrs.seihinCd` remain accepted for both upsert and delete at the webservice JSON entrypoint. |
| `TC-11` | `AC-03`, `AC-04` | Webservice JSON integration | POST external JSON to `/api/Bcc0080ac` through `Btcc0080acWebServiceJsonIntegrationTest.search_returnsValidationErrorWhenExternalJsonOmitsRequiredZairyoSeihinCd` and `Btcc0080acWebServiceJsonIntegrationTest.search_returnsDeleteValidationErrorForExternalJson`. | `mZairyoKoseiSs.seihinCd` remains required for both upsert and delete when omitted through the webservice JSON entrypoint. |
| `TC-12` | `AC-03`, `AC-04` | Webservice JSON integration | POST external JSON to `/api/Bcc0080ac` through `Btcc0080acWebServiceJsonIntegrationTest.search_acceptsValidDeleteMenuPlanPayloadForExternalJson`. | The delete path remains stable for a valid external JSON payload after the optional-field alignment changes. |
