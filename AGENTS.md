# Agent Guide

Entry contract for any agent working in this repository, following the
[AGENTS.md](https://agents.md) open standard. Harnesses that read `AGENTS.md`
(Codex, Gemini CLI, opencode, Cursor, Ona and others) get this file; the skill
itself is at [`skills/one-shot/SKILL.md`](skills/one-shot/SKILL.md) and works on
any [Agent Skills](https://agentskills.io) harness.

## What this repo is

A skills pack, published as the plugin `orie` so its skills reach a session as
`/orie:<name>`. One skill so far: `one-shot`, which chooses how to attack a
problem instead of defaulting to doing it inline.

Adding a skill means one new directory under `skills/`, named the same as its
`name:` field, and one row in the README. Nothing else.

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

## Bump the version for every content change

Plugin updates are keyed on the version in `.claude-plugin/`, not on the commit.
Ship a doc fix without bumping and `claude plugin update` answers "already at
the latest version" while serving the old files. Bump `plugin.json`,
`marketplace.json` and `SKILL.md`'s `metadata.version` together; they are
asserted to match below.

## Verify a change

CI runs these on every pull request that touches `skills/` or `.claude-plugin/`,
plus a check that each skill's `name` matches its directory and that the README
mentions it. No API key, no model, a few seconds. They read the skill; nothing
in CI runs it.

```bash
skills-ref validate skills/one-shot      # frontmatter and naming
test ! -e skills/one-shot/scripts        # no executables ship here

python3 - <<'V'                          # the three versions agree
import json, re
a = json.load(open(".claude-plugin/plugin.json"))["version"]
b = json.load(open(".claude-plugin/marketplace.json"))["plugins"][0]["version"]
c = re.search(r'version: "(.*)"', open("skills/one-shot/SKILL.md").read()).group(1)
assert a == b == c, (a, b, c)
print("versions agree:", a)
V
```

## Voice

Plain, direct, brief. Lead with the answer. No filler, no enthusiasm markers, no
emoji. Use verbs, not noun phrases.
