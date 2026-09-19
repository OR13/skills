---
name: one-shot
description: "Chooses an approach and carries one bounded task through implementation and verification with minimal operator input. Use when the operator asks to one-shot or handle a task end to end, delegates an outcome without prescribing the method, or needs a choice between direct work, workers, and an installed workflow. For a simple question or an already specified small edit, answer or act directly."
license: Apache-2.0
metadata:
  author: Orie Steele
  version: "4.6.0"
  homepage: https://github.com/OR13/skills
---

# One-Shot

Finish one agreed outcome with as little operator attention as it needs. Choose
the approach, do the work, and verify the result. Aim for zero interruptions;
combine missing decisions into one checkpoint when possible.

One shot is one bounded attempt, including investigation and corrections. It
does not mean one tool call, skipping tests, or promising success on any task.
If asked only for a plan or review, that is the outcome; do not start execution.

## Establish what done means

Inspect the task's instructions, relevant artifacts, callers, and available
checks before choosing the approach. Separate facts you can discover from
decisions only the operator can make. Read the source of a requirement rather
than replacing it with a familiar convention.

Identify the requested result, what must keep working, and how to check both.
For several related steps, keep a short completion checklist. Do not silently
drop part of the requested outcome to make it easier to finish.

Use reasonable, reversible defaults when they preserve the operator's intent.
Ask when missing information or contradictory requirements materially change
the result and cannot be resolved from the available context. Bundle those
questions. Prior authorization still applies; a plan does not need another
approval just because this skill produced it.

## Choose the approach

Use the least coordination that can meet the outcome and constraints:

- **Direct work:** a small task, tightly coupled changes, or work you can finish
  more cheaply than you can brief and integrate workers.
- **Workers in-session:** separable work where parallel progress or independent
  checking justifies the extra context and review. Name ownership and dependencies
  before dispatching.
- **Separate sessions:** work that needs independent lifetimes or isolation and
  a harness that supports them. Establish how results will be collected and
  integrated before launching.
- **An installed workflow:** a capability that fits better than doing the work
  here. Invoke it when available and authorized; otherwise identify the exact
  operator command from the installed documentation.

Shared outputs need an owner. Parallelize independent preparation if useful,
then sequence shared changes and integration. A shared generated file need not
make every subtask serial. For repeated mechanical work, validate a representative
case before applying the same transformation to the rest.

For involved work, briefly state the outcome, chosen approach, checks, and any
needed input. Keep this inline unless a plan file will help execution or handoff.
Then proceed within the existing authorization.

## Discover a workflow only when it helps

Use the harness's advertised capabilities and project instructions first. If the
task suggests an installed but unavailable workflow, inspect the relevant local
skill metadata or documentation with permitted tools. Some harnesses hide
operator-only skills from the model's advertised list; absence there is not
proof of absence on disk.

Keep discovery scoped to a plausible location or capability. Do not scan every
plugin directory for an unrelated task, invent a command, install a dependency,
or retry a denied access path by another means. If a fitting workflow is not
available, use the capabilities you have or state the specific missing input.

Optional pack pointers: [references/packs.md](references/packs.md). These are
discovery leads, not evidence of what is installed or invocable here.

## Execute, integrate, verify

For delegated work, read [references/dispatch.md](references/dispatch.md) before
writing the briefs. Keep task ownership until the returned work is integrated
and checked; worker completion is not task completion.

Work through the completion criteria. Run the relevant checks and inspect their
actual results. Correct failures within scope without requiring the operator to
steer each repair. If an approach stalls, investigate the cause before repeating
it; change the approach when the evidence warrants it.

Check the integrated result against the original requirements, including
relevant boundaries, failure paths and existing behavior. Passing an example or
a narrow test is not evidence that untested requirements hold. Add focused
checks when a material requirement has no coverage; do not weaken the contract
or its tests to make a result pass. Review the final changes for scope and
unintended edits before reporting.

Finish with the delivered outcome, checks actually run, and remaining limitations.
Distinguish a passing result from an untested claim. If completion needs new
authority or an unavailable prerequisite, preserve useful progress and report
the blocker. The one-checkpoint target never permits inventing an answer,
bypassing a boundary, or concealing unfinished work.
