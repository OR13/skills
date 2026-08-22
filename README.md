# one-shot

**Your agent cannot see all of your skills.** On the machine this was built on,
20 of 111 installed skills were invisible to the model. It could not load them,
and it could not suggest them. Only a human typing their names could reach them.

One-shot is the skill that closes that gap. Given a problem, it picks the best
agentic attack on it, takes **one** approval, and runs to the end.

```
skills/one-shot/scripts/blind-spots.sh
```

Run that now. Every skill it prints is one your agent has never once offered you.

## Why this exists

Some harnesses let a skill opt out of model invocation. Claude Code spells it
`disable-model-invocation: true`. It is a reasonable choice for an interactive
workflow you would always start yourself, and it has one consequence nobody
mentions: the agent never reminds you the skill exists, because the agent cannot
see it either.

So you install a good planning pack, use it twice, and forget it. The tool that
would remind you is the tool that was hidden.

One-shot is model-invocable on purpose. It is the one skill the agent can reach
that knows about the ones it cannot.

## What it does

1. **Confirms it is one problem.** If not, it names the parts and recommends which to run first.
2. **Checks two blind spots** — skills the harness hides, and fan-out patterns that have no skill description to match on.
3. **Writes a five-line plan** — problem, pattern, steps, verification, operator input.
4. **Stops once**, at the top, and only if the plan needs something you must type, or crosses a line you drew.
5. **Runs to the end.** No further interruptions.

One interruption per run, maximum. Zero when nothing is hidden and nothing is
risky. That is what makes it *one* shot.

## Install

One-shot is an [Agent Skills](https://agentskills.io) folder. That is an open
format, originally from Anthropic, supported by roughly forty-five harnesses.
**The skill is the same folder everywhere. Only the install path changes.**

### Any Agent Skills harness

Copy or symlink the skill folder into wherever your harness reads skills from:

```bash
git clone https://github.com/OR13/one-shot.git
ln -s "$PWD/one-shot/skills/one-shot" ~/.claude/skills/one-shot      # Claude Code
ln -s "$PWD/one-shot/skills/one-shot" ~/.codex/skills/one-shot       # Codex
ln -s "$PWD/one-shot/skills/one-shot" ~/.config/opencode/skills/one-shot
ln -s "$PWD/one-shot/skills/one-shot" ~/.gemini/skills/one-shot
ln -s "$PWD/one-shot/skills/one-shot" ~/.cursor/skills/one-shot
```

Not sure where yours reads from? `skills/one-shot/scripts/blind-spots.sh --roots`
prints the locations it knows about and marks which exist on your machine.

A symlink means `git pull` updates every harness at once.

### Claude Code, as a plugin

```
/plugin marketplace add OR13/one-shot
/plugin install one-shot@one-shot
```

This repo ships `.claude-plugin/` manifests so the plugin route works. They are a
distribution wrapper, not a dependency: delete them and the skill still works
everywhere via the folder above.

### Per-project

Commit the folder to `.agents/skills/one-shot/` or `.claude/skills/one-shot/` in
a project, and it applies only there.

## Dependencies

**None are required.** One-shot works alone; it just has less to point at.

`scripts/blind-spots.sh` needs `bash` and `find`, both already present anywhere a
coding agent runs.

The packs that make it worth having are listed in
[`skills/one-shot/references/packs.md`](skills/one-shot/references/packs.md),
with what each one adds and why. Short version:

| Pack | Why |
|---|---|
| [superpowers](https://github.com/obra/superpowers) | The execution skills. Install this first. |
| [mattpocock-skills](https://github.com/anthropics/claude-plugins-official) | The planning flow, and the reason one-shot exists: most of it is hidden from the model. |
| [impeccable](https://github.com/pbakaus/impeccable) | Frontend design. Optional, UI projects only. |

None are vendored here. One-shot points at them.

## Portability

The skill body names no vendor. It says "the harness", "subagents", "worktrees",
never a product. The one Claude-Code-specific fact, the
`disable-model-invocation` field, lives inside the discovery script as one
pattern in a list, and the script probes the filesystem rather than trusting a
hardcoded answer. When another harness ships its own gating convention, that is a
one-line change in `is_hidden()`.

Frontmatter is strictly the Agent Skills spec: `name`, `description`, `license`,
`compatibility`, `metadata`. No vendor extensions. Validate with:

```bash
skills-ref validate skills/one-shot
```

## License

Apache-2.0. See [LICENSE](LICENSE).
