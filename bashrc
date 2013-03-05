source ~/.bash/aliases
source ~/.bash/boxen
source ~/.bash/completion
source ~/.bash/git-prompt
source ~/.bash/prompt

# Use a .localrc for system specific settings
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
