# Still using helm v3
if command -v brew &>/dev/null; then
  export PATH="$(brew --prefix)/opt/helm@3/bin:$PATH"
fi
