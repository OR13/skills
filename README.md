# one-shot

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

## The part nobody mentions

Some harnesses let a skill opt out of model invocation. It is a sensible option
for an interactive workflow you would always start yourself, and it has a
consequence that is easy to miss: **the agent cannot see that skill either, so
it never reminds you the skill exists.**

Planning skills tend to be marked this way, because they are exactly that kind
of workflow. So the tools that would help you frame the work are the ones your
agent is structurally unable to suggest. You install a good planning pack, use
it twice, and forget it.

one-shot is model-invocable on purpose. It is the one skill your agent can reach
that knows to look for the ones it cannot, and to hand the keyboard back when
one of them fits better than anything it could do itself.

## Install

one-shot is an [Agent Skills](https://agentskills.io) folder — an open format,
originally from Anthropic, supported by roughly forty-five harnesses. **The
folder is the same everywhere. Only the path changes.**

### Any Agent Skills harness

```bash
git clone https://github.com/OR13/one-shot.git
ln -s "$PWD/one-shot/skills/one-shot" ~/.claude/skills/one-shot      # Claude Code
ln -s "$PWD/one-shot/skills/one-shot" ~/.codex/skills/one-shot       # Codex
ln -s "$PWD/one-shot/skills/one-shot" ~/.config/opencode/skills/one-shot
ln -s "$PWD/one-shot/skills/one-shot" ~/.gemini/skills/one-shot
ln -s "$PWD/one-shot/skills/one-shot" ~/.cursor/skills/one-shot
```

A symlink means `git pull` updates every harness at once.

### Claude Code, as a plugin

```
/plugin marketplace add OR13/one-shot
/plugin install one-shot@one-shot
```

The `.claude-plugin/` manifests are a distribution wrapper, not a dependency.
Delete them and the skill still works everywhere via the folder above.

### Per-project

Commit the folder to `.agents/skills/one-shot/` or `.claude/skills/one-shot/`
and it applies only there.

## What you are installing

Two markdown files. No scripts, no install step, no network calls, nothing that
runs on its own. Read both before you install; they are short, and skills run
with your agent's full permissions, so reading them is the whole security model.

```
skills/one-shot/
├── SKILL.md              the routine, ~110 lines
└── references/packs.md   which packs are worth having
```

## Dependencies

**None required.** one-shot works alone; it just has less to point at.

The packs that make it worth having are in
[`references/packs.md`](skills/one-shot/references/packs.md), with what each adds
and how to judge one you find elsewhere. Short version:

| Pack | Why |
|---|---|
| [superpowers](https://github.com/obra/superpowers) | The execution skills. Install this first. |
| [mattpocock-skills](https://github.com/anthropics/claude-plugins-official) | The planning flow, and most of it is invisible to your agent. |
| [impeccable](https://github.com/pbakaus/impeccable) | Frontend design. Optional, UI projects only. |
| [cmux-skills](https://github.com/manaflow-ai/cmux-skills) | Driving agents in panes you can watch. Optional. |

None are vendored here. one-shot points at them.

## Portability

The skill names no vendor. It says "the harness", "subagents", "worktrees".
Frontmatter is strictly the Agent Skills spec: `name`, `description`, `license`,
`metadata`. No vendor extensions. Validate with:

```bash
skills-ref validate skills/one-shot
```

## License

Apache-2.0. See [LICENSE](LICENSE).
