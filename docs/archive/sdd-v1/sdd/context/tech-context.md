# Tech Context

## Core Stack

- Java 8 compilation target in `pom.xml`
- Maven WAR packaging
- Jersey / JAX-RS backend stack
- Angular 13 frontend scripts in `package.json`
- Log4j2 logging
- JUnit test dependencies for backend
- CSV, PDF, Excel, and file-download support through shared utilities and process base classes

## Data And Integration Reality

- SQL access is central to many features and review outcomes.
- Both MySQL and SQL Server drivers are present in the build.
- The repo includes JasperReports, Apache POI, OkHttp, JWT libraries, Google Cloud Storage, and SendGrid dependencies.
- Validation, auth context, and error DTO flow are shared concerns rather than per-feature inventions.

## Build And Tooling Reality

- `pom.xml` is the most portable backend build entrypoint.
- `package.json` is the frontend entrypoint.
- `build.xml` contains legacy Ant quality targets, but `build.properties` points to machine-specific paths and Eclipse plugin resources.
- Shell-based spec tooling is acceptable, but it must stay lightweight and not require a new build framework.

## Operational Implications

- Prefer commands that are likely to run on a clean environment before relying on local Eclipse-era Ant wiring.
- Do not assume automated coverage exists for every touched area; much of the repo still depends on manual verification tied to test cases.
- Treat bundled libraries and generated output trees as part of current repo reality, even if they would be unusual in a greenfield repo.
