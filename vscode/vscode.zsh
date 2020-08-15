vsc() {
  if $(git rev-parse --is-inside-work-tree 2>/dev/null); then
    code $(git rev-parse --show-toplevel)
  else
    code $PWD
  fi
}
