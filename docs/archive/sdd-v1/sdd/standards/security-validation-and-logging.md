# Security, Validation, And Logging

## When To Use

Use this file when a change touches authentication, authorization, validation, request handling, or error logging.

## How To Use

Preserve the shared security and validation flow unless the feature package explicitly changes it.

## Required Output

- security and validation impact documented in the feature package
- non-obvious error handling reflected in `06-edge-cases.md` and tests

## Gate

Do not weaken token, auth, tenant isolation, or error-routing behavior without an ADR and explicit approval.

## Rules

- preserve shared token and auth checks when modifying backend process flow
- reuse property-driven config and existing encrypted credential flow
- report backend validation failures through message IDs and the established error DTO flow
- prefer existing `beforeProcessing(...)` validation in module families that already use it
- keep `processing(...)` focused on query or mutation execution after `beforeProcessing(...)` has finished request and business validation
- reuse shared validation helpers before adding new ones
- when the module family already uses shared checker processes such as `MasterCodeCheckProcess` or `MasterCheckExclusionProcess`, reuse those helpers instead of open-coding the same lookup logic
- for API import families that already run shared list validation, place custom validation after the shared pass and avoid emitting duplicate errors for the same row and field
- when the same validation or business rule exists in both frontend and backend, keep backend as the final authority but review and update both layers together or document the intentional difference
- when the touched frontend family already uses `BaseComponent` validation helpers or shared focus-out validation flow, reuse those paths instead of adding screen-local validation copies
- normalize validation feedback through existing message IDs and shared lookup utilities instead of adding fresh raw English validation text
- when frontend field errors are bound from backend `fatalError.controlID` values, keep those control IDs stable or update the frontend mapping in the same branch
- for common relation-sensitive fields such as `STORECD`, `SECTIONCD`, `GROUPCD`, and `PRODUCTCD`, preserve existence and relation checks where the screen family expects them
- preserve shared logging paths and existing log-level helpers
- legacy `printStackTrace()` still exists in older helpers, but it is not an approved pattern for new or touched code
- do not add new `printStackTrace()` calls or swallow backend exceptions where the local family already uses shared logging plus error routing
- do not add new generic `throw new RuntimeException(e)` wrappers in validation, search, or process helpers when shared checked-exception routing already exists
- if non-standard transport handling needs a local catch block, route the exception through `logSend(...)` and the established error DTO or fatal-error path instead of exposing raw exception text
- mutation families that already use exclusion helpers or hidden update timestamps must return stale-write and deleted-row outcomes through the established error DTO flow rather than overwriting silently
- keep transport-level and common frontend error routing aligned with the shared web service error flow
- the shared frontend transport path currently lives in `services/common/webservice.service.ts`; do not bypass that shared error flow with direct transport calls or silent component-local catches
- when a screen already calls `callWs(...)` or `callSilentWs(...)`, do not append empty `.catch(() => {})` handlers without a documented shared-error reason
- preserve `accessInfo`-driven company, user, language, and token handling rather than trusting raw request fields for auth-sensitive behavior
- stray `console.log(...)` calls in live screens are legacy tolerated only; do not use them as a precedent in new or touched code

## Examples

Compliant frontend error flow:

```ts
return this.webService.callWs(serviceName, request, (response) => {
  if (Ultility.fnSetErrorMsg(this, response.fatalError)) {
    return;
  }
  this.rows = response.rows;
});
```

Non-compliant frontend error flow:

```ts
this.webService.callWs(serviceName, request).catch(() => {});
```

Compliant backend exception flow:

```java
catch (SQLException e) {
    throw new DBException(e);
}
```

Non-compliant backend exception flow:

```java
catch (Exception e) {
    e.printStackTrace();
    throw new RuntimeException(e);
}
```
