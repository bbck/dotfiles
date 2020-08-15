#!/bin/sh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --info=inline "\
"--color=bg+:#ebdbb2,bg:#fbf1c7,spinner:#427b58,hl:#076678 "\
"--color=fg:#665c54,header:#076678,info:#b57614,pointer:#427b58 "\
"--color=marker:#427b58,fg+:#3c3836,prompt:#b57614,hl+:#076678"
export FZF_COMPLETION_TRIGGER=",,"

if [ -f /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# Unfortuantly the FZF_COMPLETION_TRIGGER override does not work on zsh
# https://github.com/junegunn/fzf/issues/2026#issuecomment-626318466
_fzf_complete_c() {
  FZF_COMPLETION_TRIGGER='' _fzf_complete -- "$@" < <(
    fd --type d --exact-depth 2 . $PROJECTS | cut -d "/" -f 5- #TODO: Make this portable
  )
}
