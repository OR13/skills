---
name: one-shot
description: "One shot a problem: choose how to attack it, take one approval, then run to the end. Use when the operator describes a tangled problem instead of giving an instruction, asks how to approach or tackle something, says they are not sure which tool or pattern fits, or when the work spans many files, has no spec yet, or splits into independent parts."
license: Apache-2.0
metadata:
  author: Orie Steele
  version: "4.3.0"
  homepage: https://github.com/OR13/skills
---

# One-Shot

Take one problem. Choose how to attack it. Run one attempt that finishes it,
spending at most **one stop** of the operator's attention.

In prompt engineering, "one-shot" means providing a single demonstration
example. In this skill, **one-shot execution** means single-checkpoint task
delegation: choosing the approach, taking one approval gate, and running
straight to completion without conversational thrash.

The operator is not asking you to be careful. They are asking you to pick well,
because picking well is now a specialist job they do not have time to do. Your
choice of approach matters more here than your care in executing it.

## Run

### 1. Confirm it is one problem

Done when you can state the problem in one sentence with one finished state.

Several problems: name each part, recommend which to one shot now, and say what
the rest are waiting on. Then carry that one part into step 2. A recommendation
is the deliverable here; handing back a list is not.

### 2. Choose the attack

Consider all four before committing. Most sessions default to the last one
without weighing the others, and that is the failure this skill exists to stop.

- **Hand back to the operator.** A skill exists that you cannot invoke. See
  below.
- **Fan out in-session.** Independent subtasks, using the harness's subagent or
  workflow primitive. You review the results; the operator reads one summary.
- **Fan out to separate sessions.** One agent per subtask, isolated in its own
  git worktree.
- **Straight through.** You do it yourself, now.

### 3. Write the plan

Five lines, no more:

- **Problem** — the one sentence from step 1.
- **Approach** — which of the four, and the one reason it beat the others.
- **Steps** — what runs, in order or in parallel.
- **Verification** — how the result gets checked, and by whom. Name a check
  that can fail, like a test command or assertion.
- **Operator input** — anything only the operator can type, or nothing.

### 4. Take the stop, once

Five minutes to write a plan is worth thirty minutes of wasted work. Stop, show
the plan, and ask for one approval:

> `plan.md` is ready. Shall I execute it?

Do not start until the operator answers. If they ask for changes, update the
plan and ask once more. If they approve, proceed immediately without further
stops.

### 5. Execute and report

Execute the plan, verify as planned, and report once when finished. Done when
every step has run and the verification has passed.

When using either fan-out approach, write each worker's brief before dispatching
any of them. See below.

## Skills you cannot invoke

Some harnesses let a skill opt out of model invocation, so the agent never sees
its description. Claude Code spells this `disable-model-invocation: true`. The
consequence is quiet and worth stating plainly: **you cannot suggest these, and
the operator has to remember them unaided.** Planning skills are the common
case, because an interactive workflow is exactly the kind a harness marks this
way.

At step 2, check whether the operator has any. Read the frontmatter of the
installed skills with your ordinary file tools, looking for that field. Common
locations are `~/.claude/skills`, `~/.claude/plugins`, `~/.codex/skills`,
`~/.config/opencode/skills`, and a `.claude/skills` or `.agents/skills` folder
in the project.

A hidden skill whose description matches the problem goes in the plan's
**Operator input** line, with the exact command to type. Then wait: running the
work yourself when a better tool was one keystroke away is the outcome to avoid.

[`references/packs.md`](references/packs.md) lists which packs ship them.

## Choosing between the two fan-outs

Default to in-session. Separate sessions cost the operator a thing to watch, so
spend that only when the work runs tens of minutes, when they want to follow it
on their own schedule, or when one stuck worker must not freeze the rest.

## Briefing a worker

A worker inherits none of your session. Whatever you leave out of its brief, it
invents. Structure every worker prompt around five fields:

- **Scope.** Context and tool bounding. Define what it may read, what it may
  write, what it may call, and what is explicitly off limits.
- **Hunt for.** Failure mode enumeration. Name the specific failure patterns
  to find. A worker told to "audit error handling" greps for `catch` blocks; a
  worker told to look for unhandled promise rejections, swallowed errors, and
  missing retry ceilings must reason about code paths.
- **Must hold.** Verifiable invariants and guardrails. State assertions that a
  check can falsify.
- **Return.** Structured output schema. Define the exact markdown fields and an
  explicit empty-state response (e.g. `NO_FINDINGS_DETECTED`) to prevent
  hallucinated findings.
- **Order.** Execution topology and dependency staging. Settle phase sequence
  before dispatching concurrent workers.

You cannot fill in **Hunt for** from a standing start. If you cannot name the
failures, you are not ready to dispatch, and the fix is to read enough of the
code yourself to name three.

Field detail, return schemas, and the critic pass:
[`references/dispatch.md`](references/dispatch.md).

## When one shot is the wrong shape

- **Contradictory requirements.** Two specs that cannot both hold. Write the
  conflict down in one sentence and ask the operator which wins before
  planning.
- **Novel research.** When the work is finding out what is true rather than
  applying what is known. State what question needs answering first.
- **Tasks that are really loops.** "Do this for each repo in the org." Run one,
  verify it, and only then script the loop.

Three runs at the same task means the task wants a tool. Say so once the run is
finished, rather than turning this one into that.

For a fan-out, that tool is an agent definition: the same five fields written to
a file the harness loads, instead of retyped into a prompt each time. Lifespan is
the difference that matters. A brief is discarded, while a definition gets read,
edited, and maintained.

Repetition triggers a definition. Defining an agent for a one-off task creates
maintenance overhead without reuse. Writing one:
[`references/dispatch.md`](references/dispatch.md).

