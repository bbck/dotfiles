eval "$(/opt/homebrew/bin/brew shellenv)"

# homebrew completions
export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
