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
