# Architecture Context

## Runtime Layout

- Backend Java code: `src/main/java`
- Shared infrastructure: `src/main/java/jp/co/brycen/common`
- Application-specific backend code: `src/main/java/jp/co/brycen/kikancen`
- Frontend Angular app: `src/main/webapp/angular`
- Runtime resources and properties: `src/main/resources`
- Bundled web artifacts and libs: `src/main/webapp/WEB-INF`
- API surface: JAX-RS endpoints under `/webapi/*`

## Dominant Structural Pattern

- Backend module families usually span DTO, webservice, process, SQL or DAO access, and shared utility layers.
- Screen and API codes strongly influence package naming.
- Action suffixes such as `search`, `init`, `update`, `delete`, `csvimport`, and download/file-output variants are part of the repo's architecture vocabulary.
- Frontend components mirror backend-oriented screen structure rather than a greenfield domain-driven structure.
- SQL and transaction behavior are architectural concerns; they are not safe to treat as isolated implementation details.

## Boundaries That Must Be Preserved

- Preserve existing tenant and company isolation when touching search, export, or update flows.
- Preserve shared auth, validation, and error-routing behavior unless the governing spec explicitly changes it.
- Reuse the dominant local module pattern before introducing a new layer split or naming convention.

## SDD V2 Placement

- Repository-wide operating rules remain under `docs/sdd/`.
- Human-authored feature packages remain under `docs/specs/`.
- Feature-owned machine-readable contracts stay beside the owning feature package.
- Generated agent execution artifacts live under `docs/spec-packs/`.
