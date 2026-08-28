# Recommended packs

Where one-shot routes to. None are vendored here; each links to its own repo
under its own license.

## superpowers

[obra/superpowers](https://github.com/obra/superpowers) — MIT.

Fourteen skills: TDD, systematic debugging, brainstorming, writing and executing
plans, subagent-driven development, git worktrees, code review, verification
before completion. All model-invocable, so none are hidden.

Two matter for choosing an approach:

- `dispatching-parallel-agents` — fanning out in-session.
- `using-git-worktrees` — fanning out to separate sessions.

Route to these rather than describing the mechanics yourself.

`dispatching-parallel-agents` covers the mechanics: deciding whether domains are
independent, issuing dispatches so they run concurrently, and integrating
returns. Worker briefing is covered in [`dispatch.md`](dispatch.md). Read both
before a fan-out.

## mattpocock-skills

In [Anthropic's official directory](https://github.com/anthropics/claude-plugins-official).

Most of its planning flow is hidden from the model: `to-spec`, `to-tickets`,
`implement`, `wayfinder`, `triage`, `ask-matt`, `grill-with-docs`. Name the one
that fits and let the operator type it.

Visible as normal skills: `grilling`, `tdd`, `code-review`, `research`,
`diagnosing-bugs`.

## impeccable

[pbakaus/impeccable](https://github.com/pbakaus/impeccable).

Frontend design: craft, critique, polish, audit, plus an anti-pattern CLI. Only
earns its place on projects with a UI. Ships no license file.

## cmux-skills

[manaflow-ai/cmux-skills](https://github.com/manaflow-ai/cmux-skills) — MIT,
from the cmux authors.

Eight skills for driving [cmux](https://github.com/manaflow-ai/cmux), a terminal
built for running several agents at once. Relevant when fanning out to separate
sessions the operator wants to watch.

```bash
npx skills add manaflow-ai/cmux-skills -g --all
```

Third-party repackagings exist as plugin marketplaces. Prefer the authors' repo.

## gitkb

[gitkb/gitkb-releases](https://github.com/gitkb/gitkb-releases) — MIT.

```bash
brew install gitkb/tap/gitkb
git-kb init
```

Distributed as a CLI, not a skills repo: `git-kb init` writes eighteen skills
into `.kb/skills/` and symlinks them into `.claude/skills/`, so they are
per-project and arrive with an MCP server holding the matching tools.

Two groups. **Code intelligence** reads the AST and call graph instead of
grepping text: `explore`, `understand`, `code-intelligence`, `refactor-safety`.
Reach for these when scoping a problem, and for blast radius before changing a
shared signature. **Knowledge base** tracks work across sessions: `kb-tasks`,
`kb-start`, `kb-progress`, `kb-close`, `kb-handoff`, and others.

Relevant to step 1. Where superpowers helps execute a plan, this helps establish
whether the problem is one problem, and whether it has been worked before.

## Judging a pack you find elsewhere

- **Published by whoever builds the thing it wraps.** A stranger's repackaging
  of someone else's skills is a supply-chain risk for no gain.
- **Has a license file.** Fine to install without one; a problem the moment you
  copy anything out.
- **Recently updated.** A skill encodes a CLI's surface, and CLIs move.
- **Read the SKILL.md first.** Skills run with full agent permissions, so
  installing one is the trust decision.
- **Count the always-on cost.** Every visible skill's description sits in
  context on every turn. `claude plugin details <name>` prints the number.

To search: `npx skills find`. To browse:
[awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code).

## Gating is not part of the standard

`disable-model-invocation` is a Claude Code field. [Agent
Skills](https://agentskills.io) has no equivalent, so the same pack can be fully
visible on one harness and half-hidden on another. Check the machine you are
running on rather than trusting this file.
