__fzf_opts=()
__fzf_opts+="--height=40%"
# Colors from kanagawa-paper
# https://github.com/thesimonho/kanagawa-paper.nvim/blob/master/extras/fzf/kanagawa-paper-ink.rc
__fzf_opts+="--color=bg:-1,bg+:#2A2A37,fg:-1,fg+:#DCD7BA,hl:#938AA9,hl+:#c4746e"
__fzf_opts+="--color=header:#b6927b,info:#658594,pointer:#7AA89F"
__fzf_opts+="--color=marker:#7AA89F,prompt:#c4746e,spinner:#8ea49e"

export FZF_DEFAULT_OPTS="${__fzf_opts[@]}"

# CTRL-R - Paste the selected command from history into the command line
# Better formatted with age of history commands, inspired by 
# https://tratt.net/laurie/blog/2025/better_shell_history_search.html
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  
  local now=$(date +%s)
  local awk_filter='
BEGIN { now = '"$now"' }
{
  ts = int($2)
  delta = now - ts
  delta_days = int(delta / 86400)
  delta_hours = int(delta / 3600)
  
  if (delta < 0) { 
    $2 = "+" (-delta_days) "d" 
  }
  else if (delta < 3600) { 
    $2 = int(delta / 60) "m"
  }
  else if (delta < 86400) { 
    $2 = delta_hours "h" 
  }
  else if (delta_days < 7) { 
    $2 = delta_days "d" 
  }
  else if (delta_days < 30) { 
    $2 = int(delta_days / 7) "w" 
  }
  else if (delta_days < 365) { 
    $2 = int(delta_days / 30) "mo" 
  }
  else { 
    $2 = int(delta_days / 365) "y" 
  }
  
  line = $0; $1 = ""; $2 = ""
  if (!seen[$0]++) print line
}'

  selected=( $(fc -rli -t '%s' 1 | sed -E "s/^ *//" | awk "$awk_filter" |
    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} --with-nth=2.. --scheme=history --bind=ctrl-r:toggle-sort --highlight-line --query=${(qqq)LBUFFER} --no-multi" \
    fzf-tmux -d 40%) )
  local ret=$?
  
  if [[ -n "$selected" ]]; then
    num=$selected[1]
    if [[ -n "$num" ]]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
