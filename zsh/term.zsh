tab_title() {
  if $(git rev-parse --is-inside-work-tree 2>/dev/null); then
    echo -ne "\e]1;$(basename $(git rev-parse --show-toplevel))\a";
  else
    echo -ne "\e]1;${PWD##*/}\a";
  fi
}

precmd() {
  tab_title
}
