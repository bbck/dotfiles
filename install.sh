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

# Install homebrew
if [ ! -x /usr/local/bin/brew ]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install homebrew packages
brew install mas --quiet
brew bundle --global

# Setup tools managed with asdf
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git || true
asdf plugin-add python https://github.com/danhper/asdf-python.git || true
asdf plugin-add java https://github.com/halcyon/asdf-java.git || true
asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git || true
asdf plugin-add istioctl https://github.com/appfolio/asdf-istioctl.git || true
asdf plugin-add kops https://github.com/Antiarchitect/asdf-kops.git || true
asdf install
