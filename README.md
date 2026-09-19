# skills

Orie Steele's agent skills. One so far.

## one-shot

**There are more good ways to point an agent at a problem than anyone has time
to keep up with.** Fan out to subagents, or one worktree per task. Write a spec
first, or tickets, or neither. Grill the plan before building. Test-drive it.
Send it to a background session and read the summary later.

Each of those is right sometimes. Knowing which is right *now* has quietly
become a specialist skill, and it is not the skill most people are trying to
practise. They have a problem and want it handled well the first time.

one-shot is the skill that makes that choice. Give it a problem: it picks the
approach, asks for missing decisions together when needed, and carries the work
through verification.

## Why one shot

Because the expensive failure is not a bad execution. It is a competent
execution of the wrong approach: forty minutes of careful work in one session on
something that wanted five parallel workers, or an elaborate fan-out for
something that wanted one search.

The name is the aim. One problem in, one considered attempt out, with no
interruption when the agent has what it needs. Investigation and corrections
are part of that attempt. A new blocker is reported, never concealed to keep
the count down.

## What it does

1. **Establishes the outcome** from your request and the relevant artifacts.
2. **Chooses an approach** — direct work, workers in-session, separate sessions, or a fitting installed workflow.
3. **Plans in proportion to the task**, with ownership for shared work and checks for completion.
4. **Batches missing decisions** and proceeds under authorization already given.
5. **Integrates and verifies**, correcting failures within scope and reporting remaining limitations.

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
├── SKILL.md                 the routine
└── references/
    ├── dispatch.md          briefing and reviewing workers
    └── packs.md             which packs are worth having
```

## Recommended skills

one-shot is a router, and a router is worth more the better its destinations.
None of these are required; without them it has less to point at.

[`references/packs.md`](skills/one-shot/references/packs.md) covers what each
adds and how to judge one you find elsewhere.

| Pack | Why |
|---|---|
| [superpowers](https://github.com/obra/superpowers) | The execution skills. Install this first. |
| [mattpocock-skills](https://github.com/anthropics/claude-plugins-official) | The planning flow, and most of it is invisible to your agent. |
| [impeccable](https://github.com/pbakaus/impeccable) | Frontend design. UI projects only. |
| [cmux-skills](https://github.com/manaflow-ai/cmux-skills) | Driving agents in panes you can watch. |
| [gitkb](https://github.com/gitkb/gitkb-releases) | Call-graph code intelligence, and tasks that outlive a session. |

Nothing here is vendored. one-shot links to them under their own licenses.

## Execution benchmark

The execution pilot compares completed work with and without an explicitly
loaded skill. It checks real files and behavior, keeps the full traces, and
reports cost and operator interruptions. Strategy labels do not earn points.

The runnable benchmark lives in a separate local companion, `../one-shot-bench`,
so installing this pack still ships only markdown. See
[`benchmarks/execution.md`](benchmarks/execution.md) for the protocol, commands,
and recorded results. The companion has not been published.

The [4.6.0 review](benchmarks/skill-review.md) records the harder three-arm
comparison: revised skill 12/12, original 10/12, no skill 12/12, plus 3/3 revised
regressions. This supports a narrow improvement over the original, not an
advantage over no skill or a general one-shot guarantee.

## License

Apache-2.0. See [LICENSE](LICENSE).
