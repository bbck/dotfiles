alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'

kj() { kubectl "$@" -o json | jq; }
ky() { kubectl "$@" -o yaml | yh; }
