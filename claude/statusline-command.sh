#!/bin/sh
# Claude Code status line — quiet, single line, Claude Light palette
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
dir=$(basename "$cwd")
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

O='\033[38;2;217;119;87m'   # Claude orange
M='\033[38;2;135;134;127m'  # muted grey
B='\033[1m'; R='\033[0m'

out="${O}✻${R} ${B}${dir}${R}"

# Git branch (skip locking)
if branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null); then
  out="${out} ${M}${branch}${R}"
fi

out="${out} ${M}· ${model}"
[ -n "$used" ] && out="${out} · $(printf '%.0f' "$used")%"
printf "%b" "${out}${R}"
