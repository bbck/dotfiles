#!/bin/bash

export AWS_SESSION_TOKEN_TTL=12h
export AWS_CHAINED_SESSION_TOKEN_TTL=12h
export AWS_ASSUME_ROLE_TTL=1h

# List of commands that should always run with aws-vault
aws_tools=(
  ansible
  ansible-playbook
  aws
  eksctl
  kops
  kubectl
  packer
  pry
  terraform
)

function _awsacct_alias_tools() {
  for i in "${aws_tools[@]}"; do
    alias $i="aws-vault exec $AWS_DEFAULT_PROFILE -- $i"
  done
}

# Switches the active AWS profile
function awsacct() {
  export AWS_DEFAULT_PROFILE=$1

  # export any account vars in ~/.aws/env.d
  if [ -f "$HOME/.aws/env.d/$1" ]; then
    set -a
    source $HOME/.aws/env.d/$1
    set +a
  fi

  _awsacct_alias_tools
}
