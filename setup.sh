#!/bin/bash

xcode-select --install

for file in *; do
  # Skip this script
  if [[ "${file}" == "setup.sh" ]]; then
    continue
  fi
  rm -rf ${HOME}/.${file}
  ln -s ${HOME}/Developer/dotfiles/${file} ${HOME}/.${file}
done

if [[ ! -x /usr/local/bin/brew ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew bundle --global

# Install rubies
for ruby in "ruby-2.3.3" "ruby-1.9.3-p551" "jruby-1.7.12"; do
  if [[ ! -d ${HOME}/.rubies/${ruby} ]]; then
    ruby-install ${ruby}
  fi
done
