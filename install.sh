#!/bin/bash

set -e
set -o pipefail

function log() {
  message="$*"
  echo "$(date '+%Y/%m/%d %H:%M:%S'): $message"
}

log "インストールを実行します"

# Command Line Tools for Xcode install
log "Xcodeをインストール"
xcode-select --install
log "完了"

# HomeBrew install
log "Home Brewをインストール"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew --version
log "完了"

# Git install
log "Gitをインストール"
brew install git
git --version
log "完了"

# Github setting
log "Gitの設定を行います"
echo -n "[Global settting] Github Username : "
read github_username
git config --global user.name $github_username

echo -n "[Global settting] Github Email : "
read github_email
git config --global user.email $github_email

git config --global credential.helper osxkeychain
log "完了"

# rbenv install
log "rbenvをインストール"
brew install rbenv ruby-build
rbenv --version
log "完了"

# ruby install and setting
log "rubyの安定最新版をインストール"
rbenv install -l
echo -n "Choose Ruby version : "
read ruby
rbenv install $ruby
rbenv rehash
rbenv versions
rbenv global $ruby
ruby -v
log "完了"

# direnv install
log "direnvをインストール"
brew install direnv

# git-now install
log "git-nowをインストール"
brew install git-now

# heroku install
log "herokuをインストール"
brew install heroku
heroku login

# ssh-key setting
log "ssh-keyを設定"
echo -n "ssh key phrase <user email> : "
read ssh_key_phrase
ssh-keygen -t rsa -b 4096 -C $ssh_key_phrase

################################################################################
#### Shell Setting #### Shell Setting #### Shell Setting #### Shell Setting ####
################################################################################

# Fish Shell install
log "fish shellをインストール"
brew install fish
fish --version
log "完了"

# Fish shell setting
log "Fish shellの設定"
## changed login shell
log "login shell setting"
sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"
chsh -s /usr/local/bin/fish
## fisherman install
log "fisherman install"
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
## add config
log "copy config.fish"
cp config.fish ~/.config/fish/
## plugin
log "plugin install"
fisher oh-my-fish/plugin-expand
fisher gitignore
fisher spin
## fish theme setting
log "theme install"
fisher omf/theme-bobthefish
## powerfonts
log "powerline fonts install"
git clone https://github.com/naver/d2codingfont.git
unzip d2codingfont/D2Coding-Ver1.3-20171129.zip
cp d2codingfont/D2Coding-Ver1.3-20171129/D2Coding-Ver1.3-20171129.ttf ~/Library/Fonts/
rm -rf d2codingfont
## Dracula theme
log "Dracula theme install"
git clone https://github.com/dracula/iterm.git
open ./iterm/Dracula.itermcolors
## auto complete
log "completions start"
fish_update_completions
log "完了"

log "全て完了しました"
