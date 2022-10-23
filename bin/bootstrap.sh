#!/usr/bin/env bash

cd $HOME & mkdir c && cd c && git clone https://github.com/maxpaulus43/dotfiles.git && cd $HOME

platform='unknown'
unamestr=$(uname)

if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='macos'
fi

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir $HOME/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
nvm install 'lts/*'

#git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
#$HOME/.tmux/plugins/tpm/bin/install_plugins

if [[ $platform == 'macos' || $platform == 'linux' ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ $platform == 'linux' ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi

  brew install fzf
  brew install git
  brew install lazygit
  brew install neovim
  brew install ripgrep
  brew install tmux
  brew install tree
  brew install ffmpeg
  brew install zoxide

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

  brew install mackup
  cp $HOME/c/dotfiles/Mackup/.mackup.cfg $HOME/.mackup.cfg
  mackup -v restore

  chmod +x $HOME/c/dotfiles/Mackup/bin/*
fi





