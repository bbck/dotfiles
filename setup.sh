#!/bin/bash

xcode-select --install

# Symlink dotfiles
for file in *; do
  # Skip this script
  if [[ "${file}" == "setup.sh" ]]; then
    continue
  fi
  # Skip README
  if [[ "${file}" == "README.md" ]]; then
    continue
  fi
  rm -rf ${HOME}/.${file}
  ln -s ${HOME}/Developer/dotfiles/${file} ${HOME}/.${file}
done

# Install homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install homebrew packages
brew install mas
brew bundle --global

# Install rubies
rubies=(ruby-1.9.3-p551 ruby-2.3.4 ruby-2.4.1 jruby-1.7.12 jruby-9.1.10.0)
for ruby in "${rubies[@]}"; do
  if [[ ! -d ${HOME}/.rubies/${ruby} ]]; then
    ruby-install ${ruby}
  fi
done

# Atom packages
packages=(
  ansible-vault
  busy-signal
  file-icons
  intentions
  language-ansible
  language-terraform
  linter
  linter-ansible-linting
  linter-rubocop
  linter-terraform-syntax
  linter-ui-default
)
apm install "${packages[@]}"
