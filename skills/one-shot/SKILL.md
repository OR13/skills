---
name: one-shot
description: "Turns a simple request into a grounded, execution-ready prompt that another agent can use to complete the task in one autonomous attempt. Use when the operator asks to develop a one-shot prompt, prepare a task for an agent, or make a rough request ready for autonomous execution. Producing the prompt does not itself authorize executing it."
license: Apache-2.0
metadata:
  author: Orie Steele
  version: "5.0.1"
  homepage: https://github.com/OR13/skills
---

# One-Shot

Turn the operator's simple request into an execution-ready prompt. Do the
context work that would otherwise require the operator to keep steering the
executing agent. The deliverable is the prompt, not an implementation or a
generic plan. More precise is useful; more elaborate is not necessarily better.

One shot means one autonomous execution attempt, including investigation,
testing and corrections within that attempt. It is a target, not a guarantee.

## Ground the request

Identify the requested outcome, existing authorization and scope. Inspect the
relevant project instructions, artifacts, callers and checks with permitted
read-only tools. Follow evidence far enough to locate the source of material
requirements; do not scan unrelated projects or solve the task while preparing
its prompt.

Separate three kinds of uncertainty:

- Facts available in the workspace: discover them and carry the relevant facts
  or precise source locations into the prompt.
- Reversible implementation choices: leave these to the executor unless the
  operator or project requires a particular choice.
- Missing decisions that materially change the outcome or authority: ask the
  operator together. Do not invent a preference to make the prompt look ready.

When context is unavailable, say what is unknown. An execution prompt may direct
the agent to inspect an available source; it must not describe an uninspected
source as verified. If a decision is essential before work can proceed, return
the questions and mark the prompt blocked instead of handing off a false start.

## Develop the execution prompt

Write for an agent in a fresh session. It will not inherit this conversation.
Include the original intent and enough context to act without reconstructing
the operator's decisions. Use workspace-relative paths when the executor shares
the project; include or arrange access to essential context otherwise.

When the executor shares the project, prefer precise file and interface
references over copying source, fixture data or whole contracts. Carry forward
non-obvious invariants and resolved decisions; keep the original sources
authoritative over your summary. Do not pre-solve the implementation or compute
sample outputs merely to fill the prompt.

Use only the structure the task needs; a small change may need one paragraph.
Cover the relevant points below once, without turning them into required headings:

- **Outcome:** the concrete deliverable and what is explicitly out of scope.
- **Grounding:** relevant files, interfaces, observed behavior, source-of-truth
  requirements and resolved decisions. Distinguish facts from hypotheses.
- **Constraints:** behavior to preserve, allowed changes, permissions and any
  actual resource limits. Carry restrictions forward without expanding them.
- **Completion evidence:** observable acceptance criteria and available checks,
  including material failure paths and integration. Where coverage is missing,
  ask for focused checks derived from requirements, not a test-count quota.
- **Execution latitude:** what the agent may investigate, decide and repair
  independently. Require it to report an unavailable prerequisite or new
  authority boundary rather than fabricate success or silently reduce scope.
- **Return:** changed paths, verification actually performed, and unresolved
  limitations. Do not require full file contents when the operator can inspect
  the artifacts. A plan or a worker's success claim is not delivery.

Recommend an approach only when the context justifies it. A tightly coupled task
may need direct work; separable work may benefit from workers. If coordination
is material, read [references/dispatch.md](references/dispatch.md) and carry
ownership, dependencies and integration checks into the prompt. Do not mandate
workers merely to make a prompt look advanced.

Mention an installed workflow only after checking its actual availability and
instructions. Optional [pack pointers](references/packs.md) are discovery leads,
not proof that a tool exists. Never invent commands or require unrelated setup.

## Check the handoff

Compare the draft against the original request and the inspected sources:

- Does it preserve the outcome, authorization and important existing behavior?
- Are material requirements supported, and assumptions identified?
- Can a fresh agent find the necessary artifacts and tell when it is done?
- Have unresolved business choices been disguised as implementation details?
- Does it prescribe unnecessary architecture, work or process?

Remove unsupported requirements and repetition. Do not embed a speculative
solution as a mandatory implementation. For a small request, a short prompt
with the right context and checks can be sufficient.

Return one clearly delimited execution prompt, with any readiness limitation
outside it. Follow a requested output format when provided. Do not claim the
task passed verification merely because the prompt describes good checks.

If the operator also requested execution, hand the finalized prompt to a fresh
execution session when the harness supports it and authority permits. Preserve
the prompt and verify the resulting artifacts separately. If a fresh session
is unavailable, disclose that limitation before proceeding in the existing
session; do not claim an isolated one-shot test. Prompt-only requests stop at
the handoff and do not authorize code changes or external actions.
