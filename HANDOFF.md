# Handoff: one-shot skill — improving the skill and the tests together

For whoever picks this up next. Written after a day of measurement that produced
a clear negative result and a strong suspicion that the tests, not just the
skill, are what needs work.

Repo: `github.com/OR13/skills`. Entry contract is `AGENTS.md` — read it first;
it governs frontmatter, the markdown-only rule, and the version-bump discipline.

---

## 1. Where things stand

**`main` is green and safe.** It holds one-shot 4.3.0 plus a CI workflow
(`.github/workflows/checks.yml`) asserting the repo's invariants. Merged, working,
no secrets, runs in ~5s.

**Nothing else is merged, and nothing else should be** until the measurement
question is resolved.

| Branch | Pushed | PR | State |
|---|---|---|---|
| `main` | yes | — | 4.3.0 + CI. The baseline everything is measured against. |
| `lenses` | yes | #2 | 4.5.0: grounding requirement in `Hunt for`, bounded critic pass. Unproven. |
| `evals-ci` | yes | #3 | Eval suite measuring brief-writing craft. Measures the wrong thing; held. |
| `approach-fixes` | **no** | — | 4.4.0: well-formedness gate, dependency check, threshold table. Measured Δ +0.000. |
| `evals-approach` | **no** | — | Pre-registration + the trap suite. **The most valuable artefact here.** |

Two branches are local-only. Push them before doing anything else or the work is
lost with the worktrees.

---

## 2. The headline result

**On Opus 5, one-shot does not measurably improve approach selection, and costs
about 1.6× in tokens and 2.7× in turns.**

Measured skill-vs-no-skill (ablation arms, identical prompts, deterministic
grading):

| Model | Fires unprompted | Δ accuracy | Notes |
|---|---|---|---|
| Opus 5, 4.3.0 | yes | +0.160, then +0.060 | two identical runs, 50 each |
| Opus 5, 4.4.0 | yes | **+0.000** | after fixes aimed at the failing cases |
| Sonnet 5, 4.4.0 | 16/50 | +0.060 raw, **+0.022 controlled** | see §4 |
| Haiku 4.5, 4.4.0 | **0/50** | n/a | never invokes it; 3/3 when told to |

Three independent methods agree on the Opus result: a blind pairwise read
(11–7 *against* 4.5.0), the trap suite, and a deliberate improvement attempt
that moved the number not at all.

**The one positive finding, consistent across models:** the `hidden-skill-fits`
case — where the skill tells the model about an installed command it cannot
invoke and cannot know about. +0.60 on Opus; on Sonnet, 0.67 when the skill
fired versus 0.00 when it did not. That is the only case anywhere with a real
within-arm gap.

The working hypothesis worth testing: **a skill's value to a frontier model is
inversely proportional to how well the model could have derived it.** Telling
Opus to "consider four approaches" is worth ~0. Telling it what is installed on
this machine is worth something, because that is not in any weights.

---

## 3. Five measurement attempts, and why four failed

Do not repeat these. Each cost real money to discover.

| # | Method | Failure |
|---|---|---|
| 1 | `llm` graders, prose criteria | Failed responses that plainly met the criteria. One grader checking for the *absence* of persona language failed six responses containing none. |
| 2 | regex on the skill's own vocabulary | Circular. The skill instructs "Asserted at", the grader greps "Asserted at". Measures obedience, not quality. |
| 3 | blind pairwise judging, order-swapped | Methodologically sound (position bias low, 8/9 order-consistent) but 18 judgements is noise. Came out 11–7 against the change. |
| 4 | declared label, unambiguous cases | Ceiling effect. **Zero** wrong answers in either arm; every failure was a *missing* label. The measured delta was format compliance. |
| 5 | declared label, trap cases | Works. Current suite. See §4. |

**Two arms silently degenerated into baselines and were nearly reported as
findings.** Once when the graders judged nothing useful, once when Haiku never
invoked the skill (50 runs at exactly 1 turn each, identical cost to baseline).
Both were caught by looking at turn counts and cost, not by the scores.

---

## 4. The current suite (`evals-approach` branch, `evals-trap/`)

Ten cases where **surface cues point at a different approach than the correct
one**, so a frontier model answering on instinct can get them wrong. Balanced
five and five, so a skill that merely biases toward delegation cannot score well:

- *delegating is the trap*: `hidden-dependency`, `mechanical-codemod`,
  `sequential-chain`, `vague-goal`, `unknown-feasibility`
- *failing to delegate is*: `eight-independent-audits`, `pii-scan-monorepo`,
  `major-bump-away`, `hidden-skill-fits`, `three-repos-tests`

`evals-trap/PRE-REGISTRATION.md` fixes the ground truth, hypothesis and decision
rule, committed before the first run. **Keep that discipline.** If you change the
cases, write a new pre-registration rather than editing the old one.

Three graders per case, all deterministic:

- `approach-choice` — regex on a declared `APPROACH: X` line
- `declared-any-label` — compliance, reported separately from accuracy
- `skill-fired` — `tool_used: Skill`; non-negotiable, see §3

Run it:

```bash
claude plugin eval . --eval-dir evals-trap --runs 5 -j 5 \
  --ablation with-without --trust-plugin --no-publish --threshold 0 \
  --output-dir /tmp/out
# add --model claude-sonnet-5 or claude-haiku-4-5-20251001 to change tier
```

100 runs, ~15 min, ~$16 on Opus, ~$2.50 on Haiku.

**Analysis matters as much as the run.** The printed Δ is raw. Always also
compute, within the with-arm, accuracy when the skill fired versus when it did
not — that controls for everything the raw delta does not. On Sonnet the raw
+0.060 became +0.022 under that control.

---

## 5. Why the tests are probably still wrong

The operator's instinct, which I share:

1. **Approach selection may be the wrong outcome to measure.** It is what the
   skill *says* it does, but both frontier models already do it well
   (0.72–0.88 unaided). Little headroom, so little to detect.
2. **Nothing tests execution.** Every case stops at "what would you do?". Nobody
   cares about the declaration; they care whether the work comes out better.
   The decisive design is: seed a repo with planted defects, let the agent
   actually run, grade on defects found, false positives, tests green, and cost.
   The harness supports it (`scaffold_script`, `Bash`/`Edit`, a verification
   command). Expensive, slow, and the only thing that could justify the skill to
   an Opus user.
3. **Underpowered.** 10 cases × 5 runs gave +0.160 and +0.060 on *identical*
   configurations. Detecting a +0.10 effect at p<0.05 needs ~300 runs per arm.
   Prefer more cases over more runs per case — runs cluster within a case.
4. **`scaffold_script` never delivered fixtures** to the agent's working
   directory. Every case describes its repo in prose and the agent notices the
   cwd is empty. Both arms face it equally so comparisons hold, but no case
   tests grounding against files actually read. Worth solving.
5. **Consistency is unmeasured.** A skill can be valuable by removing a bad tail
   rather than lifting a mean. Worst-of-N and all-runs-agree are computed but
   were never made a primary metric.
6. **Cost is not scored.** 1.6× for Δ +0.000 should count as a regression. It
   currently reads as a tie.

---

## 6. Leads for the skill

Ordered by the evidence behind them.

1. **Lean into what only a skill can know.** The hidden-skill case is the only
   thing that measurably works. A much smaller one-shot — *check what is
   installed, surface what the operator can invoke and you cannot, get out of
   the way* — is the narrow version with support across three models.
2. **Fix autonomous invocation.** Haiku never triggers on the `description`,
   Sonnet only 32% of the time. A skill that does not fire has zero value
   whatever its body says. `description` is the only part a model sees before
   deciding to load. Firing rate is a clean binary with no judge and no
   ground-truth argument — the best-posed problem in this whole area.
3. **`hidden-dependency` is the case the skill handles worst** (0.40/0.40 even
   after a dependency check written specifically for it). Either the guidance is
   not landing or the case is mis-specified. Worth reading transcripts.
4. **The threshold table may have hurt.** `major-bump-away` went to −0.20 in
   4.4.0; plausibly the table pulls toward in-session fan-out when separate
   sessions are correct. Unconfirmed.
5. **Unsupported but not disproven:** the four-approach taxonomy, the five-line
   plan, the five briefing fields, everything in #2 and #3. Not shown to change
   what a frontier model does. Treat as hypotheses.

---

## 7. Harness gotchas

- Grader `type` is one of `regex`, `tool_order`, `tool_used`, `file_exists`,
  `llm`, `baseline`. Discovered by sending an invalid type and reading the error.
- `regex` graders match the **final message only**, not the transcript. An answer
  spread across messages fails graders the work satisfied. Every prompt asks for
  one self-contained final message because of this.
- Regex is the **JavaScript** engine: inline `(?is)` throws. Use the `flags:` key.
- `regex` graders do **not** retain the response, so you cannot distinguish a
  wrong answer from a missing one after the fact. Hence `declared-any-label`.
- `--eval-dir` must be **relative inside the plugin** being tested. To test two
  versions, copy the suite into each checkout.
- `--ablation with-without` gives the no-plugin baseline arm and is the single
  most useful flag here. `--ablation none` halves cost when you do not need it.
- `claude -p --bare` is mangled by the cmux shim; plain `claude -p` works.
- Unit-test every regex against adversarial strings before spending on a run. The
  one that matters: a response echoing the instruction template
  (`APPROACH: X / where X is one of ...`) must not count as a correct answer.

---

## 8. Costs

About $60 of evals across the day. Per run: Opus ~$0.20 with skill, ~$0.13
without; Sonnet ~$0.07; Haiku ~$0.024. A full 100-run ablation is ~$16 on Opus,
~$7 on Sonnet, ~$2.50 on Haiku.

Cheap enough to iterate. Expensive enough that unit-testing the graders first
pays for itself immediately.

---

## 9. First three things to do

1. Push `approach-fixes` and `evals-approach`. They are local-only.
2. Decide whether approach selection is the right outcome at all, or whether to
   build the execution-based eval in §5.2. This is the fork in the road.
3. Test `description` variants against firing rate on Haiku and Sonnet. Cheap,
   binary, no judge, and if it fails nothing else about the skill matters.

Do not merge #2 or #3 on current evidence. `main` is a good place to be.
