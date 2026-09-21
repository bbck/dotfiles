#!/bin/bash
# Merges settings into ~/.claude/settings.json
set -euo pipefail

settings="$HOME/.claude/settings.json"
mkdir -p "$(dirname "$settings")"
[ -f "$settings" ] || echo '{}' > "$settings"

desired='{
  "model": "opus",
  "theme": "auto",
  "permissions": {
    "deny": [
      "Bash(op document:*)",
      "Bash(op inject:*)",
      "Bash(op item get:*)",
      "Bash(op item share:*)",
      "Bash(op read:*)",
      "Bash(op run:*)",
      "Read(~/.config/op/**)"
    ],
    "ask": [
      "Bash(git commit*)",
      "Bash(op:*)"
    ]
  },
  "feedbackDrafts": "off",
  "awaySummaryEnabled": false,
  "agentPushNotifEnabled": true
}'

tmp="$(mktemp)"
jq --argjson desired "$desired" '. * $desired' "$settings" > "$tmp"
mv "$tmp" "$settings"
