# Briefing and defining workers

Two artifacts, one structure.

A brief consists of five fields typed into a prompt for a single dispatch. A
definition writes those same five fields to a file the harness loads every time.
Start with the brief every time. Promote it to a definition only after writing
the same brief three times.

## The five fields

### Scope

What the worker may read, what it may write, what it may call, and what is off
limits. Write all four. A worker given a goal and no boundary will fix the
neighbouring file, rename something you depend on, or start a server.

State the out-of-bounds list explicitly rather than assuming it follows from the
in-bounds list. "Read `src/queue/`, edit only `src/queue/`, do not touch the
migration files or the CI config" is a scope. "Work on the queue" is a wish.

### Hunt for

The specific failures to look for, named by you.

This is the field that decides whether you get a review or a text search, and it
is the one most often left out. A worker with a goal and no named failures falls
back to pattern matching, because pattern matching always returns something.

Compare:

> Audit the background job handling.

against:

> In `src/jobs/`, look for three things. Handlers that are not safe to run
> twice on the same input. Retry paths with no attempt ceiling and no place a
> permanently failing job comes to rest. Work started inside a request handler
> that outlives the request.

The second one cannot be answered by grep. It forces the worker to read the code
and reason about it, which is what you were paying for.

You cannot fill this field in from a standing start. If you cannot name three
failures, you do not yet understand the problem well enough to delegate it, and
the fix is to go read enough of the code yourself to name them.

### Must hold

Constraints a check can fail.

The test is simple: could a result be shown to violate this? "No public function
signature changes" passes the test. A phrase like "follows the existing
conventions" cannot be tested. An unfalsifiable constraint is an absent
constraint, and the worker will report compliance every time.

Useful shapes: a command that must still exit zero, a file that must not appear
in the diff, a count that must not increase, a runtime ceiling.

### Return

The exact shape of the answer.

For one or two workers, prose is fine and cheaper. At three or more you become
the thing merging the results, and unstructured returns spend your context on
reconciliation instead of judgement. Fix the fields and their order so the
returns stack.

A shape that works for review work:

```markdown
### <short title>
- **Location:** path, with line numbers
- **What is wrong:** one sentence
- **Why it matters:** the failure it causes, not a restatement
- **Proposed change:** specific enough to disagree with
- **How to check it:** the command or assertion that would catch a regression
```

Two rules regardless of shape. Say what an empty result looks like, or workers
will manufacture findings to avoid returning nothing. Say what goes in each
field, or "Why it matters" will come back as "this is bad practice".

### Order

Which phase the worker belongs to, when the work is phased.

Phasing is worth it when a later phase would otherwise invalidate an earlier
one: writing the interface down before implementing it, or writing the check
before the change it checks. Settle the order before dispatch, because
reordering during result review discards work.

This skill does not own your phase order. Your project has a rule about it
already. Name that rule in the plan so every worker reads the same one.

## The critic pass

Run one worker whose only job is to reject.

**When.** Three or more workers proposing changes, or any single proposal you
cannot check mechanically. Below that it is ceremony: read the two results
yourself.

**What it hunts for.** Over-engineering has recognisable shapes, so name them.
An abstraction with exactly one implementation. A layer that only forwards
calls. A configuration option nobody will set. A public surface widened to serve
one private caller. A change that cannot be undone in one commit.

**What it must hold.** The critic gets a falsifiable constraint of its own: it
must name at least one thing it would cut, and say what breaks if the cut is
wrong. A critic that returns approval without a candidate for deletion has
failed its dispatch.

**Where it should come from.** If a review skill is already installed, route to
it instead of describing a reviewer from scratch. The named failure list and
deletion requirement drive the review regardless of worker persona.

## Promoting a brief to a definition

Same five fields, different home and different lifespan.

Promote only after writing the exact brief three times.

**What changes when it goes in a file.**

- It gains a name and a description. The description is what the harness matches
  against when choosing, so write retrieval text for harness routing rather than
  a summary for a human reader.
- **Scope stops being advice and becomes mechanical.** Most harnesses let a
  definition carry a tool allowlist, and the portable spelling in the
  [Agent Skills](https://agentskills.io/specification) frontmatter is
  `allowed-tools`. A boundary the harness enforces is worth more than a
  paragraph asking politely. Put the boundary there and keep the prose version
  too, so a reader knows why.
- **It starts costing something on every turn.** A definition the harness lists
  for selection spends its description continuously, whether or not it is ever
  chosen. This is the same economics as a skill. Unused definitions consume
  context on every turn; delete definitions that are no longer chosen.
- **It has no tests.** Nothing fails when a definition goes stale, and it will
  go stale, because it encodes paths and tool names that move. The only thing
  keeping it true is somebody reading it, so review it when you touch the code
  it describes.

**Keep it narrow.** A definition that matches everything gets selected for
everything, and then it is a second general assistant with a worse prompt. If
you cannot say what it should *not* be picked for, it is not ready.

**Where definitions live varies by harness.** Harnesses may read
`.claude/agents/<name>.md`, `.agents/<name>.md`, or have no definition support.
Check the local harness configuration rather than assuming a universal path.

---

The five fields structure multi-agent orchestration prompts to be reproducible.
The wording, structure, and examples here are this skill's own.

