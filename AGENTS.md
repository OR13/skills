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
  not a product name. Vendor-specific facts belong in
  `skills/one-shot/scripts/blind-spots.sh`, where they sit in a list that is
  cheap to extend.
- **Frontmatter stays strictly to the [spec](https://agentskills.io/specification):**
  `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`.
  A field outside that list breaks a harness somewhere. Client-specific values
  go under `metadata`.
- **Discover, never hardcode.** A list of hidden skills goes stale on the next
  package upgrade. The script probes the filesystem, and that is the point of it.
- **Keep `SKILL.md` under 500 lines** and its body under roughly 5000 tokens, per
  the spec. Detail goes in `references/`.
- **Point at packs, never vendor them.** `references/packs.md` links to other
  people's work under their own licenses.

## Verify a change

```bash
skills-ref validate skills/one-shot      # frontmatter and naming
skills/one-shot/scripts/blind-spots.sh --roots
skills/one-shot/scripts/blind-spots.sh --all --json | python3 -m json.tool >/dev/null
```

The last one is the real test of the script: valid JSON out means the frontmatter
parser survived every SKILL.md on the machine, including malformed ones.

## Voice

Plain, direct, brief. Lead with the answer. No filler, no enthusiasm markers, no
emoji. Use verbs, not noun phrases.
