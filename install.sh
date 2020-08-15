#!/bin/sh

# shellcheck disable=SC2164
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Install Xcode command line developer tools
if [ ! "$(xcode-select --print-path 2>/dev/null)" ]; then
  echo "Installing Xcode command line developer tools"
  xcode-select --install
fi

# Install homebrew
if [ ! -x /usr/local/bin/brew ]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install homebrew packages
brew install mas
brew bundle --global

# Symlink dotfiles
find "$DOTFILES_ROOT" -name '*.symlink' |
  while read -r src; do
    dst="$HOME/.$(basename "${src%.*}")"
    echo "Installing $dst"
    ln -sf "$src" "$dst"
  done
