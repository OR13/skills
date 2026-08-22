#!/usr/bin/env bash
# Find installed skills the agent cannot invoke on its own.
#
# A skill is a "blind spot" when the harness hides it from the model: the model
# never sees its description, so it can neither load nor suggest it. Only the
# operator can reach it, by typing its name. This script finds those skills so
# a router can name them at the right moment.
#
# Portable across harnesses. Roots are scanned in this order:
#   1. paths given as arguments
#   2. $ONESHOT_SKILL_ROOTS  (colon-separated)
#   3. a built-in list of common locations
set -uo pipefail

usage() {
  cat <<'USAGE'
blind-spots.sh [--all] [--json] [--roots] [PATH ...]

  (no flags)  list skills the model cannot invoke
  --all       list every skill found, marking each hidden or visible
  --json      emit JSON instead of text
  --roots     print the roots that would be scanned, then exit
  -h, --help  this message

Environment:
  ONESHOT_SKILL_ROOTS   colon-separated extra roots to scan
USAGE
}

MODE=hidden
FORMAT=text
ROOTS=()

while [ $# -gt 0 ]; do
  case "$1" in
    --all)      MODE=all ;;
    --json)     FORMAT=json ;;
    --roots)    MODE=roots ;;
    -h|--help)  usage; exit 0 ;;
    -*)         printf 'unknown flag: %s\n\n' "$1" >&2; usage >&2; exit 2 ;;
    *)          ROOTS+=("$1") ;;
  esac
  shift
done

if [ ${#ROOTS[@]} -eq 0 ] && [ -n "${ONESHOT_SKILL_ROOTS:-}" ]; then
  IFS=: read -r -a ROOTS <<< "$ONESHOT_SKILL_ROOTS"
fi

if [ ${#ROOTS[@]} -eq 0 ]; then
  ROOTS=(
    "$HOME/.claude/skills"          "$HOME/.claude/plugins/cache"
    "$HOME/.codex/skills"           "$HOME/.config/opencode/skills"
    "$HOME/.gemini/skills"          "$HOME/.cursor/skills"
    "$HOME/.config/goose/skills"    "$HOME/.amp/skills"
    "./.claude/skills"              "./.agents/skills"
    "./.codex/skills"               "./skills"
  )
fi

if [ "$MODE" = roots ]; then
  for r in "${ROOTS[@]}"; do
    [ -d "$r" ] && printf 'found   %s\n' "$r" || printf 'absent  %s\n' "$r"
  done
  exit 0
fi

# Read one frontmatter scalar. Handles plain, 'single' and "double" quoting,
# and stops at the closing --- so body text never leaks in.
fm() {
  awk -v key="$2" '
    NR==1 && $0 !~ /^---[[:space:]]*$/ { exit }
    NR>1 && /^---[[:space:]]*$/        { exit }
    NR>1 {
      if (index($0, key ":") == 1) {
        v = substr($0, length(key) + 2)
        sub(/^[[:space:]]+/, "", v); sub(/[[:space:]]+$/, "", v)
        if (v ~ /^".*"$/ || v ~ /^\x27.*\x27$/) v = substr(v, 2, length(v) - 2)
        print v; exit
      }
    }
  ' "$1"
}

# Gating conventions, one per harness that has one. Extend as others appear.
is_hidden() {
  grep -qiE '^[[:space:]]*(disable-model-invocation|user-invocable-only)[[:space:]]*:[[:space:]]*true' "$1"
}

first=1
[ "$FORMAT" = json ] && printf '['

found=0
for root in "${ROOTS[@]}"; do
  [ -d "$root" ] || continue
  while IFS= read -r skill; do
    name=$(fm "$skill" name)
    [ -n "$name" ] || continue
    if is_hidden "$skill"; then state=hidden; else state=visible; fi
    [ "$MODE" = hidden ] && [ "$state" = visible ] && continue
    found=$((found + 1))
    desc=$(fm "$skill" description)
    if [ "$FORMAT" = json ]; then
      esc() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }
      [ $first -eq 0 ] && printf ','
      first=0
      printf '{"name":"%s","state":"%s","path":"%s","description":"%s"}' \
        "$(esc "$name")" "$state" "$(esc "$skill")" "$(esc "$desc")"
    else
      [ "$MODE" = all ] && printf '%-8s' "$state"
      printf '%s\n' "$name"
      [ -n "$desc" ] && printf '         %s\n' "$desc"
      printf '         %s\n\n' "$skill"
    fi
  done < <(find "$root" -name SKILL.md -type f 2>/dev/null | sort)
done

if [ "$FORMAT" = json ]; then
  printf ']\n'
elif [ "$found" -eq 0 ]; then
  echo "No hidden skills found. Every installed skill is one the model can reach itself."
fi
