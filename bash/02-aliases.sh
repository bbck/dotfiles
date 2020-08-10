#!/bin/bash

# Quick cd to project directory
function c { cd ~/Developer/$1; }

# Search bash history
alias h='history | grep '

# Color aliases
alias ls='ls -G'
alias grep='grep --colour=auto'

# Safe aliases
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Long listing
alias ll='ls -lah'

# bundle exec aliases
alias rails="bundle exec rails"
alias rake="bundle exec rake"
alias kitchen="bundle exec kitchen"
alias knife="bundle exec knife"

# Switch to ruby version in projects
function crb { chruby $(cat .ruby-version); }

# Short aliases
alias r='rails'
alias bi='bundle install --binstubs'
alias a='atom .'
alias aa='atom -a .'
alias tf='terraform'
alias k='kubectl'

# Pretty JSON and XML
alias json='python -mjson.tool'
alias xml='xmllint --format -'

# Implement shuf command on OS X
alias shuf="ruby -e 'puts ARGF.readlines.shuffle'"

# Flush DNS cache on OS X
alias flush='sudo killall -HUP mDNSResponder'

# Print latest version of a cookbook on chef server
function cver { knife cookbook show $1 | awk '{print $2}'; }

# SSH to AWS by name
function ec2ssh() {
  ssh `aws-vault exec $AWS_DEFAULT_PROFILE -- aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" "Name=instance-state-name,Values=running" | jq -r .Reservations[0].Instances[0].PrivateIpAddress` $2 $3 $4 $5 $6 $7 $8 $9
}

function asgssh() {
  if [ "$INDEX" == "" ]; then
    INDEX=0
  fi
  ssh `aws-vault exec $AWS_DEFAULT_PROFILE --  aws ec2 describe-instances --filters "Name=tag:aws:autoscaling:groupName,Values=$1" "Name=instance-state-name,Values=running" | jq -r .Reservations[0].Instances[$INDEX].PrivateIpAddress` $2 $3 $4 $5 $6 $7 $8 $9
}

# AWS account switch
function awsacct() {
  export AWS_DEFAULT_PROFILE=$1

  # export any account vars in ~/.aws/env.d
  if [ -f "$HOME/.aws/env.d/$1" ]; then
    set -a
    source $HOME/.aws/env.d/$1
    set +a
  fi

  awsacct_alias_tools
}

awsacct_tools=(ansible ansible-playbook aws eksctl kops packer pry terraform)
function awsacct_alias_tools() {
  for i in ${awsacct_tools[@]}; do
    alias $i="aws-vault exec --assume-role-ttl=60m $AWS_DEFAULT_PROFILE -- $i"
  done
}
