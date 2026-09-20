# One-shot 4.6.0 review

Historical direct-execution experiment. The operator subsequently clarified that
one-shot should develop a prompt for another agent, not primarily execute the
task itself. Version 5.0.0 and [prompt-pipeline.md](prompt-pipeline.md) implement
and test that purpose. The observations below remain intact, but do not validate
prompt-development effectiveness.

Reviewed and tested 2026-09-19. The revised skill meets the registered development
rule against 4.3.0, but does not outperform the no-skill arm. The 4.3.0 baseline
remains frozen in the companion benchmark's snapshots and tracked baseline.

## Basis

The [Agent Skills authoring guidance](https://agentskills.io/skill-creation/best-practices)
recommends concise procedures, detail proportional to fragility, and revision
based on real execution. Its [evaluation guide](https://agentskills.io/skill-creation/evaluating-skills)
calls for varied cases and comparisons against no skill. These support removing
unconditional process steps and measuring the resulting work.

[Anthropic's skill guidance](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
emphasizes conserving context, setting appropriate freedom, and testing on the
models intended to use the skill. Its [long-running-agent report](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
describes premature completion and missing end-to-end checks. It also cautions
against attempting too much in one session. Those findings motivate bounded
scope and verifiable completion here; they do not prove this skill works.

## Decisions

| Original instruction | Candidate change | Reason and evaluation |
|---|---|---|
| Always stop for approval | Ask only for missing decisions or new authority; batch questions | Conflicted with README and existing authorization; measure actual exchanges |
| Always write five lines / plan.md | Brief inline plan when useful | Simple live tasks skipped the format while succeeding; format is not an outcome |
| Inspect hidden skills on every task | Discover only when a relevant capability may be missing | Avoid irrelevant and denied filesystem scans; invocation remains a separate experiment |
| Worker knows none of the session | Check harness inheritance; supply needed context | Original statement was not portable across harnesses |
| Name three failure modes before delegating | Use grounded questions; no quota | Quotas can invent concerns without improving task coverage |
| Critic must propose deletion | Allow all valid findings or no findings | Deletion is not a correctness criterion |
| Shared-work guidance implicit | Give shared outputs an owner and verify integration | Supports valid mixed parallel/sequential approaches |
| Execute plan and report | Check original requirements, regressions and final state; correct failures | Targets incomplete work that passes only a narrow example |
| Three repetitions mandate a definition | Consider reusable tools when reuse justifies maintenance | Avoid unrelated artifact creation |
| Many-files/no-spec description catchall | Explicit end-to-end delegation triggers and a simple-task boundary | Scope clarification; trigger precision is not measured by body injection |

The four approaches and worker briefing fields remain useful organizational
options. The benchmark does not require their names or a specific topology.
The candidate adds no case-specific answer, failure location, or expected test
value. The body plus dispatch guide is about 35% shorter by word count. The
skill-creator guidance informed the removal of generic ritual and the focus on
scoped instructions and observed outcomes; the campaign tests the revision as
a whole, not the causal effect of individual instructions.

## Measurement

The companion's HARD-PROTOCOL.md freezes harder fixtures, external graders,
original/revised/no-skill arms, repeat count, budget and decision rule before
paid runs. Parameter variants are tested after the candidate is frozen. These
are synthetic development tasks, not independent evidence across real projects.
Record all failures and costs; do not tune against a variant and still call it
held out. The previous easy cases remain regression checks.

## Result

Claude Code 2.1.278 with `claude-sonnet-5`, medium effort, completed all 39
scheduled trials. Both development repetitions passed all four families in
every arm. The related parameter variants produced two original-skill failures.

| Arm | Hard tasks passed | Reported USD |
|---|---:|---:|
| No skill | 12/12 | 1.9531 |
| Original 4.3.0 | 10/12 | 2.1012 |
| Revised 4.6.0 | 12/12 | 2.2002 |

The revised skill also passed 3/3 previous regression tasks. All scope and
decision-boundary checks passed. All nine necessary operator replies supplied
business choices; none was an avoidable approval. No workers were invoked.

The original accepted February 31 and, in another task, a boolean timeout.
Both implementations passed their own tests. Independent contract checks caught
the gaps; saved candidate and no-skill artifacts reject both inputs. No artifact
was repaired or excluded. The companion's HARD-RESULTS.md and tracked
evidence/hard-v1 scorecard record the full results; raw traces remain locally in
runs/hard-v1. Total campaign reported cost was $6.4555. The companion's 21 local
tests pass; credential-free CI is configured, not yet run remotely.

Retain 4.6.0 as a smaller revision with a narrow measured improvement over
4.3.0 under the registered rule. Do not claim a benefit over no skill, lower
cost, statistical significance or general reliability. Native invocation,
coordination and unseen real-project tasks still need separate evaluation.
The tested skill/reference bytes remain unchanged after the campaign.

Local package checks: the skill-creator validator passes; all three versions
agree at 4.6.0; naming, README presence, line count and Markdown-only checks pass.
`skills-ref` was not installed locally, so its validator was not run here.
