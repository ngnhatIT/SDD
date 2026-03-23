# Backend Process Architecture

## When To Use

Use this file during backend design and implementation.

## How To Use

Model backend changes on the surrounding process, DTO, and web service structure before adding new abstractions.

## Required Output

- backend package, DTO, process, and web service impact recorded in `02-design.md`
- code that follows the established execution flow

## Gate

Do not inline cross-cutting lifecycle behavior into feature code when the shared base-process pattern already handles it.

## Repeated Endpoint Shape

- JAX-RS web service class under a `webservice` package
- request and response DTOs under a sibling `dto` package
- business logic in a `process` class
- screen-family web services commonly extend `AbstractKikanSystemWebService`, implement `getProcess()`, and delegate through `executeProcess(...)`
- web service delegates into shared execution flow rather than inlining business logic
- web service classes may adapt transport details such as query parameters, download responses, or multipart inputs, but they do not assemble SQL, perform durable writes, or duplicate process-level business validation
- DTO packages remain passive carriers; keep DB access, logging side effects, and business decisions in process or shared-helper layers
- backend DTOs commonly remain Java bean-style classes with getters and setters in the touched family; do not invent records, Lombok DTOs, or builder-only DTOs unless the local family already uses them

## Shared Lifecycle

- shared web service base classes handle entry and exit flow
- shared process base classes handle token checks, auth checks, transaction ownership, commit or rollback, retry, and logging
- shared transaction ownership lives in `AbstractProcess` or `AbstractAPIProcess` plus `DBAccessor`; do not introduce Spring-style `@Transactional` assumptions or separate repository transaction orchestration unless the touched family already owns that shape
- screen-family process classes commonly extend `AbstractKikanSystemProcess` and use `beforeProcessing(...)` plus `processing(...)` when the local family already follows that shape
- feature process classes should focus on validation, SQL assembly, response mapping, and feature-specific side effects
- feature process classes may orchestrate shared helper processes, but they should not depend on peer module webservice classes to complete backend work
- API-local helper services are acceptable only where the touched API family already owns a `service/` layer; do not invent a new repository or service split for a behavior-only change
