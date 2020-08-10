#!/bin/bash

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

# Custom fzf completion for c alias
_fzf_complete_c() {
  FZF_COMPLETION_TRIGGER=''
  _fzf_complete "--multi --reverse" "$@" < <(
    find "$HOME/Developer" -maxdepth 2 -mindepth 2 -type d -exec basename {} \;
  )
}

# Enable completion on aliases
complete -F _fzf_complete_c -o default -o bashdefault c
complete -F __start_kubectl k
