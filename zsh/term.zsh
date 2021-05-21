function set_win_title() {
  if [ "$PWD" = "$HOME" ]; then
    echo -ne "\033]0; ~ \007"
  elif $(git rev-parse --is-inside-work-tree 2>/dev/null); then
    echo -ne "\033]0; $(basename $(git rev-parse --show-toplevel)) \007"
  else
    echo -ne "\033]0; $(basename "$PWD") \007"
  fi
}

precmd_functions+=(set_win_title)
