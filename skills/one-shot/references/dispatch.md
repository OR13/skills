# Prepare a prompt for coordinated execution

Use this guide only when the final execution prompt needs worker coordination.
The prompt builder does not launch implementation workers. Carry the relevant
instructions below into the executor's handoff; omit them for direct work.

Delegate a bounded result that is worth the coordination cost. Inspect enough
of the task to identify useful work and its dependencies. A worker's context
depends on the harness; supply the facts it needs rather than assuming it sees
your conversation or making it reconstruct everything.

## Brief

Use these fields when they help make the assignment unambiguous:

- **Scope:** the outcome, relevant context, permitted paths and tools, and
  boundaries inherited from the operator.
- **Hunt for:** concrete questions or failure modes suggested by the artifacts.
  Distinguish established requirements from hypotheses. There is no minimum
  number of findings or failure modes.
- **Must hold:** the behavior to preserve and checks that can falsify the result.
  Point to the contract, test, or other source when one exists. Missing project
  documentation is a gap to investigate, not permission to invent a requirement.
- **Return:** the artifact or patch, evidence, checks run and unresolved issues.
  For a review, a supported finding needs a location, the violated requirement,
  impact and a way to reproduce or verify it. No findings is a valid result.
- **Order:** prerequisites, file ownership, dependent tasks, and who integrates.

For example, instead of "audit error handling", point to the relevant job
contract and ask whether its retry and failure paths preserve that contract.
Do not disclose an expected finding to an independent reviewer.

## Ownership and integration

Assign one owner to a shared schema, generated output, migration sequence or
other collision point. Workers may prepare independent changes first; combine
the inputs and regenerate shared outputs at the integration boundary. Isolation
prevents simultaneous writes but does not make conflicting changes compatible.

Inspect each return, resolve disagreements against the artifacts, and run checks
on the combined result. A worker's claim that tests passed does not establish
that the integrated state passes. If a worker cannot finish, take over its
bounded task or state what remains blocked.

## Review when it adds evidence

Use an independent reviewer for a material uncertainty that direct checks do
not settle. Give it the artifact, requirements and scope; omit the author's
conclusions when those would bias the review. A second reviewer is useful when
it brings different evidence or expertise, not merely another vote.

Require support for findings and counterchecks for proposed fixes. A reviewer
may keep every supported finding or report none. Never require it to invent a
defect, delete valid work, or produce a minimum number of criticisms.

The parent owns the decision and final verification. Resolve conflicting
returns; agreement by itself is not evidence of correctness.

## Reuse only when useful

If the same brief keeps recurring, consider a maintained agent definition or
tool. Keep permissions narrow and verify the harness's actual inheritance and
tool controls. Repetition is evidence of a possible reusable pattern, not an
automatic requirement to create another artifact during the current task.
