# Packs worth installing

One-shot is a router. A router is worth having when there is somewhere good to
route to. These are public, reputable, and verified by reading their repositories
rather than by reading articles about them. Star counts were checked on
2026-08-22.

Nothing here is vendored into this repo. One-shot points at these packs; it does
not redistribute them.

## The execution pack

**[obra/superpowers](https://github.com/obra/superpowers)** — 276k stars, MIT.
Fourteen skills covering TDD, systematic debugging, brainstorming, writing plans,
subagent-driven development, git worktrees, and verification before completion.

Install this. It is the single biggest upgrade available, and one-shot is a
complement to it rather than a rival: every superpowers skill is model-invocable,
so none of them is a blind spot. Two are worth knowing because one-shot routes to
the same ground:

- `dispatching-parallel-agents` — blind spot two, in-session.
- `using-git-worktrees` — blind spot two, out-of-session. One-shot points here
  instead of owning the mechanics.

## The planning pack

**[mattpocock-skills](https://github.com/anthropics/claude-plugins-official)**,
in Anthropic's official directory — 34k stars for the directory.

This is the pack that makes one-shot necessary. It ships its planning flow as
skills the model cannot invoke: `to-spec`, `to-tickets`, `implement`,
`wayfinder`, `triage`, `ask-matt`, `grill-with-docs`. An agent cannot see or
suggest any of them. Run `scripts/blind-spots.sh` after installing and they all
appear.

Also ships `grilling`, `tdd`, `code-review`, `research`, `diagnosing-bugs` and
others as normal model-invocable skills.

## The design pack

**[pbakaus/impeccable](https://github.com/pbakaus/impeccable)** — 62k stars.
Frontend design quality: craft, critique, polish, audit, plus an
anti-pattern CLI. Optional, and only earns its place on projects with a UI.

No license file at the time of writing. That does not affect pointing at it, but
check before vendoring anything from it.

## The terminal pack

**[manaflow-ai/cmux-skills](https://github.com/manaflow-ai/cmux-skills)** — MIT,
from the cmux authors, synced from the main repo. Eight skills for driving
[cmux](https://github.com/manaflow-ai/cmux), a macOS terminal built for running
several coding agents at once: `cmux-cli`, `cmux-workspace`, `cmux-browser`,
`cmux-config`, `cmux-ref`, `cmux-artifact`, `cmux-sidebar-builder`,
`cmux-freestyle`.

Relevant to blind spot two. If you run agents in panes you can watch, these are
the mechanics of the out-of-session half, the same way superpowers'
`using-git-worktrees` is the mechanics of isolation. One-shot decides *whether*
to spawn; these decide *how*.

Installed with the skills CLI rather than a plugin marketplace:

```bash
npx skills add manaflow-ai/cmux-skills -g --all
```

Third-party repackagings of these skills exist as Claude Code marketplaces.
Prefer the source: it is the authors' own repo, it is MIT, and it is the one
that gets the weekly sync.

## Adjacent, and how to judge one

The packs above are the ones I use. The ecosystem is large and mostly unvetted,
so here is the filter rather than a longer list:

- **Published by whoever builds the thing it wraps.** A cmux pack from manaflow,
  a Next.js pack from Vercel. A stranger's repackaging of someone else's skills
  is a supply-chain risk for no gain.
- **Has a license file.** Several popular packs do not. That is fine for
  installing, and a problem the moment you copy anything out.
- **Recently updated.** A skill encodes a CLI's surface, and CLIs move.
- **Read the SKILL.md before installing.** Skills run with full agent
  permissions. The install is the trust decision.
- **Count the always-on cost.** Every model-invocable skill's description sits
  in context on every turn, forever. `claude plugin details <name>` prints the
  number. Fourteen skills you never use is a permanent tax.

Two useful catalogues for looking: [`npx skills find`](https://github.com/vercel-labs/skills)
searches the ecosystem interactively, and the index below is hand-curated.

## The index

**[hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)**
— 53k stars. The curated list. Where to look when none of the above fits, and
where to submit a plugin so people find it.

## What the format buys you

Every pack above uses [Agent Skills](https://agentskills.io), an open format
originally from Anthropic and now supported by roughly forty-five harnesses,
including Codex, Gemini CLI, Cursor, Copilot, VS Code, opencode, Goose, and Amp.
A skill is a folder with a `SKILL.md`, so the same folder works everywhere.

The gap is model-invocation gating. `disable-model-invocation` is a Claude Code
field, not part of the standard, so the same pack can have blind spots on one
harness and none on another. That is why `scripts/blind-spots.sh` probes the
filesystem instead of trusting a list.
