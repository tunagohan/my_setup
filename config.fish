# encoding
set -x LANG ja_JP.UTF-8
# direnv
eval (direnv hook fish)
set -x EDITOR vim
# rbenv
set -x PATH ~/.rbenv/bin $PATH
eval (rbenv init - | source)
# alias
alias vi 'vim'
alias ls 'ls -l'
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths
