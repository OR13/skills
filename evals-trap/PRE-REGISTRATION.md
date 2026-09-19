# Pre-registration: does one-shot make Opus 5 better at choosing an approach?

Written and committed **before any run of this suite**. Nothing below is revised
after seeing results; if the result contradicts the hypothesis, the hypothesis
was wrong.

## Question

Does installing one-shot improve Claude Opus 5's choice of how to attack a
problem, against the same model with no skill installed?

## Why the previous four attempts failed

| Attempt | Method | Why it gave no usable answer |
|---|---|---|
| 1 | `llm` graders, prose criteria | Failed responses that plainly met the criteria |
| 2 | regex on the skill's own vocabulary | Circular: measured obedience, not quality |
| 3 | blind pairwise judging | 18 judgements, 11–7, statistically noise |
| 4 | declared label, unambiguous cases | Ceiling: **zero** wrong answers in either arm |

Attempt 4 is the important one. Both arms answered correctly on every run where
they answered at all, so the measured delta was format compliance. This suite
exists to remove that ceiling.

## Design

Ten cases, each built so that the **surface cues point at a different approach
than the correct one**. A frontier model answering on instinct should be able to
get these wrong; that is the point.

Balanced deliberately, five each way, so a skill that simply biases toward
delegation cannot score well:

| Correct answer is NOT to delegate | Correct answer IS to delegate |
|---|---|
| `hidden-dependency` (looks parallel, shares a regenerated file) | `eight-independent-audits` |
| `mechanical-codemod` (200 files, one transform) | `pii-scan-monorepo` |
| `sequential-chain` (each layer blocks the next) | `major-bump-away` (hours, away, isolation) |
| `vague-goal` (no target defined) | `hidden-skill-fits` (hand back) |
| `unknown-feasibility` (research, not application) | `three-repos-tests` |

## Measurement

Both arms get **byte-identical prompts**, including the instruction to end with
`APPROACH: X`. Neither arm's advantage can come from the skill supplying that
format, because the prompt supplies it.

Grading is a regex on the declared label. No model judges anything.

- **Primary metric:** mean per-case accuracy, with skill minus without.
- **Compliance is reported separately.** A run that emits no label is recorded
  as non-compliant and reported, not silently counted as a wrong answer. If
  compliance differs between arms, the accuracy figure is computed over
  compliant runs only, and both numbers are published.
- **Secondary metric:** consistency — the fraction of cases where all five runs
  in an arm agree. A skill can be valuable by making a good answer reliable.

## Hypothesis

One-shot improves mean accuracy by **at least 0.15** (i.e. roughly one and a
half cases out of ten).

## Decision rule, fixed in advance

| Delta | Verdict |
|---|---|
| ≥ +0.15 | the skill demonstrably helps |
| +0.05 to +0.15 | a real but small effect; report the size honestly |
| −0.05 to +0.05 | **not better** — say so plainly |
| < −0.05 | the skill actively hurts |

## Commitments

- No case is added, removed or reworded after the first run.
- No ground truth is revised after seeing which way a case went.
- The pre-registered primary metric is reported whatever it says.
- If the verdict is "not better", that is the finding, and the next step is
  proposing changes — not rerunning until a number looks better.

## Sample

10 cases × 5 runs × 2 arms = 100 runs. At recent per-run costs, roughly $15.
