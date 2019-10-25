function awsacct_prompt() {
  if [ "$AWS_DEFAULT_PROFILE" != "default" ]; then
    echo " (${AWS_DEFAULT_PROFILE})"
  fi
}

function tab_title() {
  if $(git rev-parse --is-inside-work-tree 2>/dev/null); then
    echo -ne "\033];$(basename $(git rev-parse --show-toplevel))\007";
  else
    echo -ne "\033];$(basename $(pwd))\007";
  fi
}

function current_ruby() {
  echo "${RUBY_ROOT##*/}"
}

function current_k8s_context() {
  kubectl config current-context
}

function current_awsacct() {
  echo "${AWS_DEFAULT_PROFILE}"
}

# See https://www.iterm2.com/3.3/documentation-scripting-fundamentals.html
function iterm2_print_user_vars() {
  iterm2_set_user_var rubyVersion $(current_ruby)
  iterm2_set_user_var k8sContext $(current_k8s_context)
  iterm2_set_user_var awsAccount $(current_awsacct)
}

precmd_functions+=(tab_title)

if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
  source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
  PS1='\[\e[1m\]\u@\h\[\e[0m\] \w\[\e[96m\]$(awsacct_prompt)\[\e[33m\]$(__git_ps1 " (%s)")\[\e[39m\] \$ '
else
  PS1='\[\e[1m\]\u@\h\[\e[0m\] \w\[\e[96m\]$(awsacct_prompt)\[\e[39m\] \$ '
fi

# Manage bash history
# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
function save_history() { history -n; history -w; history -c; history -r; }
shopt -s histappend
precmd_functions+=(save_history)

if [ -f $HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh ]; then
  source $HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh
fi