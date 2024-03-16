export HOMEBREW_AUTO_UPDATE_SECS=86400

eval "$(/opt/homebrew/bin/brew shellenv)"

# homebrew completions
export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
