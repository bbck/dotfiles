source ~/.bash/prompt
source ~/.bash/iterm2
source ~/.bash/aliases
source ~/.bash/boxen
source ~/.bash/completion
source ~/.bash/exports

# Use a .localrc for system specific settings
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
