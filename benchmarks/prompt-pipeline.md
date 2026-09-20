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

## 5.0.1 evaluation: limited pilot gain

The only skill revision asks for precise shared-file references instead of copied
source, fixture data and whole contracts; task-proportional structure; and changed
paths rather than full-file returns. The skill-creator guidance favored this narrow
correction over adding another execution workflow. The tested candidate hash is
`413026430e8f759f5dd7e832f2680488b001da6b2e88e7218ee813eb60d9108d`.

The new synthetic smoke comparison passed all eight pipelines, with no measured
quality advantage for 5.0.0 over direct execution or a generic improver. The
companion then froze RELEASE-GATE.md before any candidate calls: compare 5.0.0
with 5.0.1 on two task families, two repetitions each, alternating order, with a
10% total pipeline cost reduction required and savings in both repetitions.

| Paired pipelines | 5.0.0 | 5.0.1 candidate |
|---|---:|---:|
| Implementations passed | 4/4 | 4/4 |
| Reported cost, both stages | $0.5345656 | $0.4938370 |
| Total stage seconds | 211.56 | 190.62 |

Observed cost savings were **7.619%**, present in both repetitions, but below the
registered 10% release threshold. Pagination cost 24.3% less; retention cleanup
cost 22.2% more. The candidate also passed missing-policy and conflicting-policy
clarification probes and a single-file version update. All scope, isolation,
runtime and resource checks passed, with zero rescue turns. The cost gate failed;
its threshold has not been lowered after observing results.

Source-based, unblinded review found no material candidate task/authority change
or invented business decision. It still sometimes repeated contracts and requested
full-file returns, so the concision guidance was only partially followed. One
baseline prompt invented a confused double-fetch diagnosis; this is a diagnostic
finding, not a substitute superiority measure. Independent blinded review was not
performed, and this author review is not presented as an independent score.

Total new evaluation: 19 pipelines, 32 Claude Code calls, **$2.0135056** reported.
The same pinned model/effort as v2 was used. These are known synthetic families;
the variant changes data, not the task distribution. This small pilot establishes
neither statistical significance nor an advantage over direct/generic execution.

The companion's RELEASE-RESULTS.md records the full decision and review. Tracked
evidence/synthetic-smoke-v1/summary.json and evidence/release-501-v1/summary.json
retain exact handoffs, grades, hashes and accounting. Raw traces and projects
remain under runs/; no evidence was deleted. At evaluation time, all 49 local tests
passed, as did static package checks and the skill-creator validator. `skills-ref`
remains unavailable.

## Release decision and security review

Experiments stopped after the registered comparison and regression probes. The
operator subsequently approved shipping the smaller measured gain, with its
limitations stated, after a security review. This is an explicit acceptance of
a result below the original threshold, not a claim that the 10% gate passed.

Version 5.0.2 updates release documentation and synchronizes the three version
fields. Its skill instructions and reference files are unchanged from the tested
5.0.1 candidate; only SKILL.md's version metadata differs. No additional paid
evaluation was run for this documentation-only update.

Security review found no release-blocking issue in the Markdown-only skill:
no executables, hooks, MCP registrations or added tool grants ship with it.
Credential-pattern checks found no matches in the candidate tree or its four
unmerged commits. This was a source review, not an adversarial prompt-injection
test, a comprehensive secret scan, or an audit of linked third-party packs.

The review found a cancellation defect in the separate, unpublished benchmark
runner: interrupting its parent could leave Claude running. Companion commit
`a61a565` fixes owned-process-group cleanup for interruption, termination signals,
timeouts and exceptions. It preserves partial cost records, marks missing cost
unknown, and stops further paid calls after unknown cost or reported overspending.
All 63 local tests pass, including real local subprocess tests; no paid calls
were used for that fix. The runner remains a trusted local tool, not a sandbox;
parent SIGKILL and already-accepted provider requests remain limitations.

The executable runner and its fixes are not included in this plugin. Prior
protocols, recorded results and raw evidence remain intact in the companion.
