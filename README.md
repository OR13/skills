# skills

Orie Steele's agent skills. One so far.

## one-shot

You know what you want, but turning it into a prompt an agent can finish without
repeated correction takes work. one-shot does that preparation: give it a simple
request, and it develops a grounded execution prompt using the available project
context, requirements and checks.

## Why one shot

The aim is one autonomous execution attempt from a well-prepared prompt.
Investigation, testing and repairs can happen inside that attempt. Preparing
the prompt may require a business decision from you; the skill does not invent
one to make the handoff look ready. A longer prompt is not automatically better,
and a ready prompt is not proof that the resulting implementation will work.

## What it does

1. **Grounds the request** in relevant project instructions, artifacts and checks.
2. **Resolves uncertainty** by discovering facts and batching essential questions.
3. **Develops the prompt** with outcome, context, constraints and completion evidence.
4. **Checks the handoff** for missing context, invented requirements and scope changes.
5. **Returns the prompt**, or hands it to an executor if execution was also requested.

For example: `/orie:one-shot turn "fix the retry bug" into an execution prompt`.
The skill inspects the project to make that request actionable; it does not
silently implement the fix. Prompt preparation and execution are separate stages.

## Install

A skill is a folder with a `SKILL.md`. Every harness below reads that same
folder; only the path differs.

```bash
git clone https://github.com/OR13/skills.git or13-skills
SKILL="$PWD/or13-skills/skills/one-shot"
```

### Claude Code

```
/plugin marketplace add OR13/skills
/plugin install orie@or13-skills
```

Reaches a session as `/orie:one-shot`. Or skip the plugin and symlink it, which
gives you a bare `/one-shot`:

```bash
ln -s "$SKILL" ~/.claude/skills/one-shot
```

### Antigravity CLI

Reads `.agents/skills/` in the project, and cannot read a Claude Code plugin, so
the folder is the only route:

```bash
ln -s "$SKILL" .agents/skills/one-shot
```

### opencode

```bash
ln -s "$SKILL" ~/.config/opencode/skills/one-shot   # global
ln -s "$SKILL" .opencode/skills/one-shot            # or per-project
```

A symlink means `git pull` in the clone updates every harness at once.

## What you are installing

Three markdown files. No scripts, no install step, no network calls, nothing that
runs on its own. Read them before you install; they are short, and skills run
with your agent's full permissions, so reading them is the whole security model.

```
skills/one-shot/
├── SKILL.md                 developing and checking an execution prompt
└── references/
    ├── dispatch.md          optional coordination instructions for the prompt
    └── packs.md             which packs are worth having
```

## Recommended skills

An execution prompt may reference a fitting installed workflow. None of these
packs are required. Check actual local capabilities before naming a command;
these links do not establish that a pack is installed or available.

[`references/packs.md`](skills/one-shot/references/packs.md) covers what each
adds and how to judge one you find elsewhere.

| Pack | Why |
|---|---|
| [superpowers](https://github.com/obra/superpowers) | Optional execution workflows. |
| [mattpocock-skills](https://github.com/anthropics/claude-plugins-official) | The planning flow, and most of it is invisible to your agent. |
| [impeccable](https://github.com/pbakaus/impeccable) | Frontend design. UI projects only. |
| [cmux-skills](https://github.com/manaflow-ai/cmux-skills) | Driving agents in panes you can watch. |
| [gitkb](https://github.com/gitkb/gitkb-releases) | Call-graph code intelligence, and tasks that outlive a session. |

Nothing here is vendored. one-shot links to them under their own licenses.

## Prompt pipeline benchmark

Version 5.0.0 restores the intended purpose: simple request to execution-ready
prompt. The companion compares direct execution, generic prompt improvement,
and one-shot prompt development, followed by a fresh executor. Builders may
inspect context but cannot implement. Only the generated prompt crosses the
handoff; the executor starts from the original fixture. Both stages' costs
count. See [benchmarks/prompt-pipeline.md](benchmarks/prompt-pipeline.md).

## Earlier execution benchmark

The execution pilot compares completed work with and without an explicitly
loaded skill. It checks real files and behavior, keeps the full traces, and
reports cost and operator interruptions. Strategy labels do not earn points.

The runnable benchmark lives in a separate local companion, `../one-shot-bench`,
so installing this pack still ships only markdown. See
[`benchmarks/execution.md`](benchmarks/execution.md) for the protocol, commands,
and recorded results. The companion has not been published.

The [4.6.0 review](benchmarks/skill-review.md) records the harder three-arm
comparison: revised skill 12/12, original 10/12, no skill 12/12, plus 3/3 revised
regressions. Those experiments measured direct execution, not prompt development,
and do not validate the purpose of 5.0.0 or establish an advantage over no skill.

## License

Apache-2.0. See [LICENSE](LICENSE).
