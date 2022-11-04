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

# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# mkdir $HOME/.nvm
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
# nvm install 'lts/*'
curl -fsSL https://fnm.vercel.app/install | bash

#git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
#$HOME/.tmux/plugins/tpm/bin/install_plugins

if [[ $platform == 'macos' || $platform == 'linux' ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ $platform == 'linux' ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi

  brew install fzf

  brew install bat
  brew install btop
  brew install exa
  brew install fd
  brew install ffmpeg
  brew install fish
  brew install git
  brew install git-delta
  brew install lazygit
  brew install neovim
  brew install ripgrep
  brew install rlwrap # needed for ~/bin/cht
  brew install tmux
  brew install tree
  brew install zoxide

  if [[ $platform == 'macos' ]]; then
	  brew install --cask alacritty
	  brew install --cask google-drive
	  brew install --cask pixel-picker
	  brew install --cask spotify
	  brew install --cask telegram
	  brew install --cask typora
	  brew install --cask visual-studio-code
    brew install --cask raycast
    brew install --cask shottr
    brew install scrcpy

	  brew tap homebrew/cask-fonts 
	  brew install --cask font-hack-nerd-font
    
    defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -int 0
    defaults write com.apple.dock showhidden -bool TRUE
    defaults write com.apple.screencapture type jpg
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    killall Dock
  fi

  brew install mackup
  cp $HOME/c/dotfiles/Mackup/.mackup.cfg $HOME/.mackup.cfg
  mackup -v restore

  $(brew --prefix)/opt/fzf/install

  chmod +x $HOME/c/dotfiles/Mackup/bin/*
fi





