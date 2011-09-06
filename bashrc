source ~/.bash/aliases
source ~/.bash/bundle_exec
source ~/.bash/completion
source ~/.bash/prompt
source ~/.bash/rbenv

# Use a .localrc for system specific settings
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
