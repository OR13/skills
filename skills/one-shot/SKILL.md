---
name: one-shot
description: "One shot a problem: pick the best agentic attack on it, take one approval, then run to the end. Use when the operator describes a tangled problem instead of giving an instruction, asks how to approach or tackle something, or when the work spans many files, has no spec yet, or splits into independent parts. Routes to the skills the harness hides from the model, and to the fan-out patterns that have no skill description to match on."
license: Apache-2.0
compatibility: Requires bash and find for scripts/blind-spots.sh. Everything else is harness-agnostic.
metadata:
  author: Orie Steele
  version: "2.0.0"
  homepage: https://github.com/OR13/one-shot
---

# One-Shot

Take one problem. Set up one run that finishes it. Spend at most **one stop** of
the operator's attention, at the top.

This skill covers your blind spots and nothing else. The harness already lists
most skills with their own descriptions, and you reach for those as normal. It
hides exactly two things, and those two are the whole content below.

## Run

### 1. Confirm it is one problem

Done when you can state the problem in one sentence with one finished state.

Several problems: name each part, recommend which to one shot now, and state what
the rest are waiting on. Then carry that one part into step 2. A recommendation
is the deliverable here; handing back a list is not.

### 2. Check the blind spots

Walk both sections below. Done when both have been considered.

### 3. Write the plan

Five lines, no more:

- **Problem** — the one sentence from step 1.
- **Pattern** — in-session fan-out, out-of-session workers, or straight through.
- **Steps** — what runs, in order or in parallel.
- **Verification** — how the result gets checked, and by whom.
- **Operator input** — anything only the operator can type, or nothing.

### 4. Take the stop, once

Two conditions earn a stop:

- The plan needs a hidden skill. Only the operator can run it.
- The plan publishes something, spends money, touches a credential, or crosses a
  boundary the operator set.

Either one: show the plan, name exactly what you need, and wait.

Neither one: state the plan in two lines and start. Zero stops is the good
outcome; the operator is busy.

### 5. Run to the end

Execute the plan, verify as planned, and report once when finished. Done when
every step of the plan has run and the verification has passed.

## Blind spot one: skills you cannot invoke

Some harnesses let a skill opt out of model invocation. Claude Code spells it
`disable-model-invocation: true`. Such a skill is absent from your skill list:
you can neither load it nor suggest it through the normal path. The operator
types its name; you wait.

Discover them rather than assuming a list, because every machine differs and a
package upgrade changes the answer:

```
scripts/blind-spots.sh          # skills the model cannot invoke
scripts/blind-spots.sh --all    # every installed skill, marked hidden or visible
scripts/blind-spots.sh --roots  # where it looked
```

Run it once at step 2 and read the descriptions it prints. A hidden skill whose
description matches the problem goes in the plan's **Operator input** line, with
the exact command to type.

Planning skills are the common case: turning a conversation into a spec,
splitting a plan into tickets, mapping work too large for one session. These are
the ones an operator means when they say they keep forgetting to use their own
tools. See [`references/packs.md`](references/packs.md) for the packs that ship
them.

## Blind spot two: patterns that are not skills

No description exists anywhere for these, so nothing prompts you toward them.

**In-session fan-out. The default.** Independent subtasks that finish inside this
session, using whatever subagent or workflow primitive the harness gives you. You
review the results before the operator ever sees them, so their attention is
spent once, on the answer.

**Out-of-session workers.** A separate agent session per subtask, isolated in its
own git worktree. Reach for this when the work runs tens of minutes, when the
operator wants to watch it, or when one stuck worker must not freeze the rest.
Being able to watch costs the operator attention, so treat it as a cost.

Prefer in-session until one of those three reasons applies.

## When one shot is the wrong shape

- **Contradictory requirements.** Two specs that cannot both hold. Write the
  contradiction down and hand it to the operator. One shot resolves approach,
  not conflicts of authority.
- **A single lookup.** One search, one API call, one file read. Run the command.

## Building instead of running

Three runs at the same task means the task wants a tool. Write it to `scripts/`
in a skill of its own, with a `--help` flag. That is separate work from the one
shot in front of you: finish this run, then propose the tool.
