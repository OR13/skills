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
approach, writes a five-line plan, asks you **once** if it needs anything, and
runs to the end.

## Why one shot

Because the expensive failure is not a bad execution. It is a competent
execution of the wrong approach: forty minutes of careful work in one session on
something that wanted five parallel workers, or an elaborate fan-out for
something that wanted one search.

The name is the promise. One problem in, one considered attempt out, at most one
interruption. If nothing needs your input, zero.

## What it does

1. **Confirms it is one problem.** If not, it names the parts and recommends which to run first.
2. **Weighs four approaches** — hand back to you, fan out in-session, fan out to separate sessions, or straight through. Most sessions default to the last without weighing the others. That is the failure this exists to stop.
3. **Writes a five-line plan** — problem, approach, steps, verification, what it needs from you.
4. **Stops once**, and only if it needs something you must type, or the plan crosses a line you drew.
5. **Runs to the end.**

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

Two markdown files. No scripts, no install step, no network calls, nothing that
runs on its own. Read both before you install; they are short, and skills run
with your agent's full permissions, so reading them is the whole security model.

```
skills/one-shot/
├── SKILL.md              the routine, ~110 lines
└── references/packs.md   which packs are worth having
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

Nothing here is vendored. one-shot links to them under their own licenses.

## License

Apache-2.0. See [LICENSE](LICENSE).
