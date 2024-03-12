alias cat="bat"
alias ls="eza --classify --icons --group-directories-first --git --group"
alias la="ls --all"
alias ll="la --long"
alias lx="ll --extended"
alias tree="ls --tree"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

# Use `bat` as man pager
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
