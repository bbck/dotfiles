#!/bin/bash
set -Eeuo pipefail

# shellcheck disable=SC2164
cd "$(dirname "${BASH_SOURCE[0]}")"
DOTFILES_ROOT=$(pwd -P)

# Install Xcode command line developer tools
if [ ! "$(xcode-select --print-path 2>/dev/null)" ]; then
  echo "Installing Xcode command line developer tools"
  xcode-select --install
fi

# Symlink dotfiles
find "$DOTFILES_ROOT" -name '*.symlink' |
  while read -r src; do
    dst="$HOME/.$(basename "${src%.*}")"
    echo "Installing $dst"
    ln -sf "$src" "$dst"
  done

# TODO: Need a better system for ~/.config
mkdir -p "${HOME}/.config"

# nvim config
echo "Installing ${HOME}/.config/nvim"
ln -sf "${DOTFILES_ROOT}/nvim" "${HOME}/.config/"

# bat config
echo "Installing ${HOME}/.config/bat"
ln -sf "${DOTFILES_ROOT}/bat" "${HOME}/.config/"

# Install homebrew
if ! type brew &>/dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install homebrew packages
brew install mas --quiet
brew bundle --global
