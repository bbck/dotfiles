source ~/.vim/bundle/gruvbox/gruvbox_256palette.sh
source ~/.bash/prompt
source ~/.bash/aliases
source ~/.bash/chruby
source ~/.bash/completion
source ~/.bash/exports
source ~/.bash/iterm2

# Use a .localrc for system specific settings
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
