# Agent Guide

Entry contract for any agent working in this repository, following the
[AGENTS.md](https://agents.md) open standard. Harnesses that read `AGENTS.md`
(Codex, Gemini CLI, opencode, Cursor, Ona and others) get this file; the skill
itself is at [`skills/one-shot/SKILL.md`](skills/one-shot/SKILL.md) and works on
any [Agent Skills](https://agentskills.io) harness.

## What this repo is

One skill. It routes a problem to the right agentic pattern, and its whole
premise is that an agent cannot see every skill installed on the machine.

## Rules for changing it

- **Portability first.** The skill body names no vendor. Write "the harness",
  not a product name. Where a vendor-specific fact is unavoidable, such as the
  `disable-model-invocation` field, name it as one harness's spelling of a
  general idea rather than as the rule.
- **Frontmatter stays strictly to the [spec](https://agentskills.io/specification):**
  `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`.
  A field outside that list breaks a harness somewhere. Client-specific values
  go under `metadata`.
- **Ship no executables.** The repo is markdown only, and the README says so as
  its security story. A skill runs with the agent's full permissions, so asking
  a stranger to run a bundled script as step one is the wrong first impression.
  Anything the skill needs discovered, it discovers with the agent's own tools.
- **Lead with the human problem, not the mechanism.** The reason this exists is
  that choosing an agentic approach has become a specialist job. The
  hidden-skill flag is a supporting detail, not the pitch.
- **Keep `SKILL.md` under 500 lines** and its body under roughly 5000 tokens, per
  the spec. Detail goes in `references/`.
- **Point at packs, never vendor them.** `references/packs.md` links to other
  people's work under their own licenses.

## Verify a change

```bash
skills-ref validate skills/one-shot      # frontmatter and naming
test ! -e skills/one-shot/scripts        # no executables ship here
```

## Voice

Plain, direct, brief. Lead with the answer. No filler, no enthusiasm markers, no
emoji. Use verbs, not noun phrases.
