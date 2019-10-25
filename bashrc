for f in $HOME/.bash/*.sh; do
  source "$f"
done

# Use a .localrc for system specific settings
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
