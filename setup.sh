#!/bin/bash -eux

# Install Xcode command line developer tools
if ! xcode-select --print-path &> /dev/null; then
  xcode-select --install
fi

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
  rm -rf "${HOME}/.${file}"
  ln -s "${PWD}/${file}" "${HOME}/.${file}"
done

# Install homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install homebrew packages
brew install mas
brew bundle --global
