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
brew bundle --global

# Install rubies
rubies=(ruby-1.9.3-p551 ruby-2.3.3 jruby-1.7.12)
for ruby in "${rubies[@]}"; do
  if [[ ! -d ${HOME}/.rubies/${ruby} ]]; then
    ruby-install ${ruby}
  fi
done

# Atom packages
packages=(
  busy-signal
  intentions
  linter
  linter-rubocop
  linter-ui-default
)
apm install "${packages[@]}"
