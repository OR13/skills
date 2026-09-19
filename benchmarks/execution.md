# Execution benchmark

The benchmark runs Claude Code against real fixture files and grades the
resulting artifacts outside the agent's workspace. It does not reward declaring
an approach, copying a plan format, or merely claiming the skill was loaded.

The companion is a separate local git repository at `../one-shot-bench`.
Executable fixtures and the runner are not part of this markdown-only plugin.
The companion README describes its runtime dependencies and the trusted-local
execution boundary. It is not yet published or available through this plugin.

## Pilot protocol

The companion's `PROTOCOL.md` was committed before task execution. Its v2 and v3
amendments were each committed before their corresponding runs; the original
protocols and unsuccessful trials are preserved. The pilot freezes one-shot
4.3.0 from main, model `claude-sonnet-5`, medium effort, one repetition per arm,
and a fixed randomized schedule. That pilot bumped the pack to 4.3.1 for
documentation only. The subsequent 4.6.0 candidate is described in
[skill-review.md](skill-review.md) and tested under HARD-PROTOCOL.md in the
companion repository.

Both arms have the same tools, task, and fresh fixture. The v3 treatment includes
the exact frozen skill body in the prompt, with a copy of its references
available in the workspace. Native automatic skill loading is disabled in both
arms, along with unrelated plugins, hooks and MCP. Matching the injected text
to the frozen file verifies delivery, not instruction compliance.

The simulated operator can approve once if asked; it cannot offer grader hints
or change the task. Each run has a 300-second timeout and a $1 reported-cost
allowance; the batch launch ceiling is $10. An in-flight API call can overshoot
the CLI's dollar allowance. Cost is CLI-reported, not a billing reconciliation.

| Case | Checked outcome |
|---|---|
| Smoke | Actual arithmetic fix, including empty and negative inputs |
| Shared codegen | Three working encoders, shared schema, reproducible generated output |
| Config migration | Eight exact conversions, unrelated nested keys preserved |
| Logging audit | Both planted violations, no findings on clean controls |

Protected files must remain unchanged. Recovered permission denials are reported
as diagnostics and contribute to cost; they do not fail a correct artifact.
Original broken fixtures and plausible
wrong fixes must fail each grader; known correct artifacts must pass. Raw CLI
streams, prompts, initial/final hashes, artifacts and source snapshots are
retained under the companion's ignored `runs/` directory.

## Run

From the companion directory:

```sh
python3 -m unittest -v
python3 bench.py run --skill-source ../skills/skills/one-shot --label smoke-v1 --cases smoke
python3 bench.py run --skill-source ../skills/skills/one-shot --label pilot-v3 --cases shared-codegen,config-migration,logging-audit
python3 bench.py report runs/pilot-v3
```

Labels cannot be overwritten. For another experiment, register the changes and
use a new label. The recorded source hash, rather than the live checkout, defines
what was tested. `--skill-source` must point to a folder containing `SKILL.md`.
The smoke run used the original file-read delivery; reproducing it exactly
requires its frozen source under `runs/smoke-v1/source/`.

## Harness failures retained

- v1: a text-valued status event broke the parser after the first task. Its
  artifact and raw stream survived; its cost was recovered and the run remains
  invalid. The parser now handles this event and journals process results.
- v2: Claude attempted to read the skill through a denied shell command and
  continued without loading it. The treatment check caught this, and the batch
  stopped. v3 supplies the body verbatim to test its effect independently of
  invocation reliability. The v2 run is not reclassified as a skill success.

## Interpretation

The completed v3 pilot passed 3/3 tasks in both arms. With the skill supplied,
reported cost was $0.2192; without it, $0.1765. Both original smoke trials passed.
The companion's `RESULTS.md` records the full comparison, all retained failures,
source hashes, and links to raw traces. All 11 local grader/harness tests passed.
Total reported cost including setup probes and unsuccessful attempts was about
$0.82. These are CLI-reported costs, not a billing reconciliation.

This establishes that the benchmark executes and checks real work. It does not
establish a skill advantage. That documentation-only pilot did not change the
skill body; the later 4.6.0 revision and harder comparison are recorded in
[skill-review.md](skill-review.md).

This small development pilot can establish that execution and grading work.
It cannot establish that one-shot improves general task performance. Automatic
invocation, long-running fan-out, genuine installed-skill discovery and tasks
requiring clarification need separate cases. Add those on a development split,
then freeze the candidate and test unseen task instances before claiming a gain.

The earlier approach-label results remain historical evidence. This protocol
does not revise their cases, ground truth or pre-registration.

Claude Code 2.1.278's local `plugin eval --help` documents that `--scaffold` is
required to execute scaffold scripts; `--trust-plugin` alone does not do it.
That is a likely explanation for the earlier empty working directories, not a
reproduction of the earlier failure. This companion explicitly creates and
checks each fixture directory before launching the agent.
