if command -v lxqt-openssh-askpass &>/dev/null; then
    export SUDO_ASKPASS="$(command -v lxqt-openssh-askpass)"
fi
