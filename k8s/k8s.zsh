#!/bin/sh

alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'

kj() { kubectl "$@" -o json | jq; }
ky() { kubectl "$@" -o yaml | yh; }
compdef kj=kubectl
compdef ky=kubectl

# kubeconfig per session
file="$(mktemp -t KUBECONFIG)"
cp "${KUBECONFIG:-$HOME/.kube/config}" "$file"
export KUBECONFIG="${file}"
