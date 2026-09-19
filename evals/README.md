# Evals

A regression gate for the one-shot skill. Three scenarios, graded
deterministically, run in CI on any change to `skills/`, `evals/` or
`.claude-plugin/`.

## Running it

```bash
claude plugin eval . --eval-dir evals --tag ci --ablation none \
  --trust-plugin --no-publish --threshold 1.0
```

Roughly $1.60 and eight minutes. Add `--runs 3` when tuning a grader; variance
across runs is real and one run will not show it.

## What it checks

Each case gives the agent a tangled problem and reads what it produces. No case
writes to disk; the repositories are described in the prompt.

| Case | Asks for | Guards |
|---|---|---|
| `grounded-hunt-for` | a plan and worker briefs for a payments audit | failure modes tied to this repo's ADRs, tests and CI ceiling; the five fields; an explicit empty-state contract |
| `judge-discipline` | a verification setup over four proposed diffs | at most two judges; the kill mandate; the dispatcher owning the merge; cold-start dispatch |
| `thin-grounding` | a review brief for a repo with no tests, ADRs or CI | criteria falling back to the specification; an explicit empty-state contract |

## Why the graders are regexes

An earlier version used `llm` graders written as prose criteria. They failed
responses that plainly met them — one grader checking for the *absence* of
persona language failed six responses that contained none. Prose criteria with
no explicit verdict contract are not reliable enough to block a merge.

Every pattern here was tuned against recorded responses from both 4.3.0 and
4.5.0, and each one is either a **floor** (both versions pass; it catches a
future regression) or a **discriminator** (4.3.0 fails, 4.5.0 passes; it pins a
behaviour the change introduced). The judge-discipline patterns are the sharpest:
all three went 0/3 to 3/3.

`tool_used: Skill` confirms the skill fired at all. Without it a case can pass on
the base model's own instincts and prove nothing about the skill.

## Known gaps

- Patterns match phrasing, so a response that does the right thing in unusual
  words can fail. `grounded-in-artifacts` is deliberately loose for that reason.
- Naming a *missing* artifact is correct behaviour and no pattern rewards it yet.
- `names-the-gap` for `thin-grounding` passed only 2 of 3 runs on 4.5.0 and is
  left out rather than made a flaky gate.
- Nothing here tests grounding against files actually read; `scaffold_script`
  did not deliver fixtures to the agent's working directory.
