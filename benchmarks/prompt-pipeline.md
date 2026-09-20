# Prompt-development benchmark

Version 5.0.0 changes the deliverable from execution to an execution-ready
prompt. The earlier direct-execution results do not measure this purpose.

The separate local companion `../one-shot-bench` owns executable fixtures and
the runner. This plugin remains Markdown-only. Its PROMPT-PROTOCOL.md and v2
amendment freeze the experiment before paid calls:

1. Direct: simple request to executor.
2. Generic: simple request to a generic prompt improver, then a fresh executor.
3. One-shot: simple request to the skill-guided builder, then a fresh executor.

Builders inspect a copy of the original project with read-only tools. They
return a prompt, not a patch. The executor receives only that prompt and the
common environment restrictions, in a fresh session with the original project
state. It does not receive the skill or builder history. Hidden graders remain
outside both workspaces. Both stages count toward pipeline time and cost.

The primary result is independently verified completion without a rescue turn,
within scope and the registered resource budget. Generated wording, length,
headings and strategy labels do not earn points. Prompt readiness and scope
fidelity are reviewed separately from task completion.

This pilot reuses three known synthetic task families with simple user prompts.
It tests the new pipeline and repeatability, not generalization to unseen
projects, automatic skill invocation or tasks requiring operator clarification.
No skill improvement claim follows merely from all candidate trials passing.

The first campaign stopped after finding that the audit fixture did not expose
the report schema enforced by its grader. v2 supplies that schema in project
documentation to all arms and extracts the exact handoff JSON even when wrapped
in commentary. The skill itself was not tuned after those observations. The
invalid attempt's artifacts and $0.3946 reported spend remain preserved.

## Completed v2 pilot

Claude Code 2.1.278, `claude-sonnet-5`, medium effort: 18 pipelines / 30 model
calls, with two repeats per family and pipeline. All original artifact, scope
and stage-isolation checks passed. Builders made no implementation changes.

| Pipeline | Registered checks passed | Total reported USD |
|---|---:|---:|
| Direct simple request | 6/6 | 1.0829 |
| Generic prompt improver | 6/6 | 1.5761 |
| One-shot 5.0.0 builder | 6/6 | 1.6184 |

Both stages count. One-shot cost 49.4% more than direct execution and 2.7% more
than generic improvement. Total v2 cost was $4.2774; including setup, $4.6720.
This validates the handoff, not a performance advantage over the controls.

Unblinded review of every generated prompt found process over-prescription in
both builder arms and factual/evidence-threshold concerns in some one-shot
prompts. A generic configuration prompt supplied incorrect mixed-null alias
semantics. An additional post-campaign check found that error in its saved
implementation; the other five configuration artifacts passed. Original scores
are unchanged. This exploratory observation is not a superiority test.

The companion's PROMPT-RESULTS.md, PROMPT-REVIEW.md and tracked evidence/prompt-v2
retain results, all prompt strings, reviews and the separate diagnostic. Raw
streams and artifacts remain under runs/prompt-v2. The companion's 31 local
tests pass. Its v3 protocol adds the missed boundary case to future grading;
no new live v3 campaign has run. Native invocation and real-project holdouts
remain untested. The 5.0.0 skill bytes are unchanged from before the first run.

The skill-creator guidance shaped the revision: a specific prompt deliverable,
read-only preparation, preserved intent and authority, and outcome-based tests
instead of scoring prompt length or formatting. Static package checks pass
with its validator; versions agree at 5.0.0 and the skill remains Markdown-only.
`skills-ref` is unavailable locally, so its validator was not run.
