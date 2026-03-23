# Test Cases

## TC-01

- Acceptance link: AC-01
- Scenario: A maintainer opens the repo root and needs to find the required delivery documents.
- Preconditions: repository is checked out
- Steps:
  1. open `README.md`
  2. follow links into `docs/`
- Expected result: the maintainer can find the SDD playbook, spec workspace, decision records, and changelog

## TC-02

- Acceptance link: AC-02
- Scenario: A contributor needs to start a new change.
- Preconditions: contributor has a new ticket or dated change request
- Steps:
  1. open `docs/specs/README.md`
  2. open `docs/sdd/templates/`
  3. open `docs/sdd/process/`
- Expected result: the contributor can create a feature folder and follow the defined stage order without inventing structure

## TC-03

- Acceptance link: AC-03
- Scenario: A reviewer opens a pull request.
- Preconditions: PR template is enabled by GitHub
- Steps:
  1. open `.github/PULL_REQUEST_TEMPLATE.md`
  2. compare required fields with governance rules
- Expected result: the review flow asks for governing spec, traceability, verification, and documentation updates

## TC-04

- Acceptance link: AC-04
- Scenario: A maintainer wants to understand how the old local documentation was migrated into the canonical SDD structure.
- Preconditions: migration is complete
- Steps:
  1. open `docs/archive/sdd/history/migration/migration-plan.md`
  2. open `docs/sdd/standards/`
  3. open this feature package
- Expected result: the maintainer can see the migration inventory, the canonical docs, and the example feature package

## Results

- TC-01: passed by manual doc review
- TC-02: passed by manual doc review
- TC-03: passed by manual doc review
- TC-04: passed by manual doc review
