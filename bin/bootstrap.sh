#!/usr/bin/env bash

cd ~ & mkdir c && cd c
git clone git@github.com:maxpaulus43/dotfiles.git

brew install bash
brew install fzf
brew install git
brew install lazygit
brew install mackup
brew install neovim
brew install ripgrep
brew install tmux
brew install tree

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='macos'
fi

cp ~/c/dotfiles/mackup/.mackup.cfg ~/.mackup.cfg
mackup restore

mkdir ~/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
nvm install 'lts/*'

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

if [[ $platform == 'macos' ]]; then
  brew install --cask alacritty
  brew install --cask spotify
  brew install --cask visual-studio-code
  brew install --cask pixel-picker
  brew install --cask google-drive
  brew install --cask typora
  brew install --cask telegram
  brew tap homebrew/cask-fonts 
  brew install --cask font-hack-nerd-font
fi



