# Briefing and defining workers

Two artifacts, one structure.

A brief consists of five fields typed into a prompt for a single dispatch. A
definition writes those same five fields to a file the harness loads every time.
Start with the brief every time. Promote it to a definition only after writing
the same brief three times.

## Terminology: execution vs in-context learning

In machine learning and prompt engineering literature, **one-shot prompting**
means providing a single demonstration example (exemplar) in the context window
before asking for a completion.

In this skill, **one-shot execution** refers to single-checkpoint task
delegation: choosing an approach, taking at most one human approval gate, and
running autonomously to completion without conversational thrash.

## The five fields

Structuring worker prompts around five core context engineering components
prevents drift and makes dispatches reproducible.

### Scope

Context and tool bounding: what the worker may read, write, call, and what is
off limits.

State both positive permissions and explicit negative boundaries. A worker
given a goal without explicit boundaries will edit adjacent files, modify shared
interfaces, or invoke destructive tools.

"Read `src/queue/`, edit only `src/queue/`, do not touch migration files or CI
config" provides a bounded context. "Work on the queue" is an unconstrained
prompt.

### Hunt for

Failure mode enumeration: the specific failure patterns to look for, named by
you.

This field separates reasoned analysis from superficial text search. A worker
instructed to "audit error handling" defaults to grepping for `catch` blocks and
reporting syntax counts.

Compare:

> Audit the background job handling.

against:

> In `src/jobs/`, check for three specific failure modes:
> 1. Handlers that are not idempotent when retried on identical input.
> 2. Retry paths lacking an attempt ceiling or dead-letter destination.
> 3. Asynchronous work initiated within a request handler that outlives the
> request lifecycle.

The second prompt requires semantic reasoning over the code.

You cannot draft this field from a standing start. If you cannot name three
concrete failure modes — and for each, the property of the system it threatens
and where in this repository that property is asserted, such as a test name, a
CI gate, an ADR, or the spec clause — inspect the code first before delegating.

A failure mode with nothing behind it is a guess. State it as a guess or drop
it. Criteria you look up beat criteria you recall: a model's recollection of
what good looks like in a domain aligns poorly with what the people working in
it actually write down.

One item, grounded:

> - **Failure mode:** a retry path with no attempt ceiling.
>   **Property:** the job queue drains under load.
>   **Asserted at:** `test_queue_drains_under_backpressure`, and the 30s ceiling
>   in `.github/workflows/ci.yml`.

Where to look, in order: this repository, then the specification the work
implements, then a canonical text cited by title only — never by a chapter or
section you have not opened. If none of the three yields anything, there is no
grounding for that failure mode, and saying so in the plan beats inventing one.

### Must hold

Verifiable invariants and guardrails: constraints a check can falsify.

A constraint must be testable against execution output or diffs. "Public
function signatures remain unchanged" is falsifiable. "Follows existing
conventions" is subjective and unfalsifiable; workers will report compliance
regardless of output.

Effective invariant shapes: a command that must exit zero, specific files
forbidden from appearing in the diff, a metric ceiling, or a runtime threshold.

### Return

Structured output schema: the exact shape and field schema of the response.

Unstructured prose increases context reconciliation costs during fan-outs.
Enforce a uniform markdown schema so downstream synthesis is mechanical.

A standard schema for review findings:

```markdown
### <short title>
- **Location:** path, with line numbers
- **What is wrong:** one sentence
- **Why it matters:** the specific failure mode triggered
- **Proposed change:** concrete patch or replacement
- **How to check it:** command or assertion that verifies the fix
```

Specify the empty-state contract explicitly: state what to return if no issues
are found (e.g., "Return `NO_FINDINGS_DETECTED`"). Without an explicit null
case, workers often hallucinate findings to satisfy the output schema.

A judge returns more than a finder does, because its job is to settle whether a
finding survives:

```markdown
### <short title>
- **Location:** path, with line numbers
- **Lens:** the property at risk, and the artifact that asserts it
- **What is wrong:** one sentence
- **Evidence:** the command, diff line, or spec clause that shows it — not an
  argument that it is probably true
- **Counterfactual:** what the fix changes, and the check that passes after and
  fails before
- **Verdict:** KILL or KEEP, with the reason
```

Do not report a requirement the spec does not state. Inventing unstated
constraints, rather than style nitpicking, is what turns a reviewer into a
source of noise.

### Order

Execution topology and dependency staging.

When tasks are interdependent, define phase ordering before dispatch. Staging
interface design before implementation, or test creation before code
modification, prevents downstream rework.

Name the ordering constraint in the plan so every concurrent worker shares the
same dependency model.

## The critic pass (Evaluator-Optimizer)

Deploy a dedicated evaluation worker whose sole directive is verification and
pruning.

**When it fires.** Three or more workers proposing changes, or any complex
proposal requiring non-mechanical verification. Below that threshold, review the
diffs directly.

**How many judges.** One by default. Two at most, ever. Panels correlate: judges
drawn from different families still make the same mistakes on the same items, so
a third judge buys agreement rather than coverage, and no aggregation rule
recovers what the correlation cost.

**What makes two judges two.** They must consult different evidence, not read
different prompts. One reads the diff; the other runs the system and reads what
it emits. Two judges with the same evidence and different adjectives are one
judge billed twice.

**Cold start.** Dispatch every judge with no production history — the artifact
and the lens, nothing else. A session that reviews work it just produced is
anchored to its own reasoning, and a second pass in the same session does not
undo that.

**Kill mandate.** A judge's return is primarily which candidate findings die,
and why. It must name at least one finding to drop, or return
`NO_FINDINGS_DETECTED`. Agreement between agents is not correctness, and the
failure that discredits automated review is volume, not blindness.

**Target failure modes.** Identify common over-engineering patterns:
abstractions with single implementations, passthrough layers, unused
configuration knobs, broadened public API surface for a single consumer, or
changes that cannot be reverted in a single commit.

**You own the merge.** Two judges return two lists, never a verdict. Resolve
every finding they disagree on before reporting, and say which judge you
overrode and why. Do not stage a debate round between them: they converge on
each other rather than on the answer.

**Skill routing.** If a dedicated code review skill is installed, route to it
rather than synthesizing a reviewer prompt.

## Promoting a brief to a definition

The same five fields apply whether prompting a transient subagent or persisting
a reusable agent definition.

Promote a brief to a definition only after running the same brief three times.

**Definition considerations:**

- **Routing metadata:** Provide a descriptive name and summary. The harness uses
  this text for semantic routing and tool selection.
- **Enforced tool bounding:** Use harness-level tool allowlists (such as
  `allowed-tools` in Agent Skills frontmatter) to enforce operational boundaries
  mechanically rather than relying solely on prompt instructions.
- **Context overhead:** Installed agent definitions consume context budget
  across turns. Prune unused definitions periodically.
- **Maintenance:** Agent definitions contain paths and tool names that drift
  over time. Treat definitions like code: review them when refactoring related
  subsystems.

**Keep scope narrow.** A definition with overly broad matching criteria acts as
an unspecialized assistant with degraded prompt efficiency.

**Harness storage.** Definitions typically live in `.claude/agents/<name>.md` or
`.agents/<name>.md`. Consult local harness documentation for the exact path.

---

The five fields structure multi-agent orchestration prompts to be reproducible.
The wording, structure, and examples here are this skill's own.

