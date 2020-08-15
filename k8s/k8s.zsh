#!/bin/sh

alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'

# kubeconfig per session
file="$(mktemp -t KUBECONFIG)"
cp "${KUBECONFIG:-$HOME/.kube/config}" "$file"
export KUBECONFIG="${file}"
