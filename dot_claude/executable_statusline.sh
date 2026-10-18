#!/bin/bash
# Claude Code status line: git branch, model and effort level, separated by
# dim dots. Reads the status line JSON from stdin.
set -uo pipefail

# Colors, as ANSI SGR codes
default_branch_color='1;33' # bold yellow
branch_color='1;35'         # bold purple
detached_color='1;31'       # bold red
model_color='36'            # cyan
effort_color='2'            # dim
sep_color='2'               # dim

input="$(cat)"
json() { jq -r "$1 // empty" <<<"$input" 2>/dev/null; }

dir="$(json '.workspace.current_dir')"
model="$(json '.model.display_name')"
effort="$(json '.effort.level')"

git=(git -C "${dir:-$PWD}" --no-optional-locks)
branch="" detached=""
# Outside a repo this fails and both stay empty
if branch="$("${git[@]}" branch --show-current 2>/dev/null)" && [ -z "$branch" ]; then
  # Detached HEAD has no branch name; show the short commit instead
  detached="$("${git[@]}" rev-parse --short HEAD 2>/dev/null)"
fi

sep=$' \e['"${sep_color}m·"$'\e[0m '
out=""
add() { out+="${out:+$sep}"$'\e['"$1m$2"$'\e[0m'; }

case "$branch" in
  "") ;;
  master | main) add "$default_branch_color" "$branch" ;;
  *) add "$branch_color" "$branch" ;;
esac
[ -n "$detached" ] && add "$detached_color" "@$detached"
[ -n "$model" ] && add "$model_color" "$model"
[ -n "$effort" ] && add "$effort_color" "$effort"

printf '%s' "$out"
