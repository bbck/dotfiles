# Cache completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.cache/zsh

# Activate completions
autoload -Uz compinit
compinit
